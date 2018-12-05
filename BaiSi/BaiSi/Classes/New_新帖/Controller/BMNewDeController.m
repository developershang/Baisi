//
//  BMNewDeController.m
//  BaiSi
//
//  Created by developershang on 2017/6/16.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMNewDeController.h"
#import "BMTopic.h"
#import "BMTopicCell.h"
#import "BMCommentController.h"
@interface BMNewDeController ()
@property (nonatomic, strong)NSMutableArray<BMTopic *>*topics;
@property (nonatomic, strong)NSString *maxtime;
@property (nonatomic, weak)BMHTTPSessionManager *manager;
@end

@implementation BMNewDeController


#pragma mark - 1.懒加载

- (NSMutableArray *)topics{
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (BMHTTPSessionManager *)manager{
    
    if (_manager == nil) {
        
        _manager = [BMHTTPSessionManager shareInstance];
    }
    
    return _manager;
    
}


#pragma mark - 2.初始化


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置TableView
    [self setupTabview];
    //2.刷新数据
    [self setupRefresh];
    
}

- (void)setupTabview{
    
    self.tableView.backgroundColor = BMColor(240, 240, 240);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"BMTopicCell" bundle:nil] forCellReuseIdentifier:@"ReuseID"];
}

- (void)setupRefresh{
    
    //下拉刷新
    MJRefreshNormalHeader *bm_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    bm_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = bm_header;
    [bm_header beginRefreshing];
    
    
    //上拉加载
    MJRefreshBackNormalFooter *bm_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    bm_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = bm_footer;
    
    
}



#pragma mark - 3.加载数据


- (void)loadNewTopics{
    
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"newlist";
    params[@"c"] = @"data";
    params[@"type"] = @(self.topicType);
    [self.manager GET:BMCommonURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    
        [responseObject writeToFile:@"/Users/developershang/Desktop/PPP/dddd.plist" atomically:YES];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *arr = responseObject[@"list"];
        if (arr.count > 0) {
            
            self.topics = [BMTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            NSDictionary *data =@{@"data": [BMTopic mj_keyValuesArrayWithObjectArray:self.topics]};
     NSString *filePath = [NSString stringWithFormat:@"baisi%lu.plist",(unsigned long)self.topicType];
            BM_WritetoFile(data, filePath)
            
        }else{
             NSString *filePath = [NSString stringWithFormat:@"baisi%lu.plist",(unsigned long)self.topicType];
            NSDictionary *dic = BM_ReadFromFile(filePath);
            self.topics = [BMTopic mj_objectArrayWithKeyValuesArray:dic[@"list"]];
        }
        
        
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        NSDictionary *dic = BM_ReadFromFile(@"baisi.plist");
        self.topics = [BMTopic mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        [self.tableView reloadData];
        
        
        NSLog(@"请求失败1:%@--",error);
        [self.tableView.mj_header endRefreshing];
    }];
}


- (void)loadMoreTopics{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"newlist";
    params[@"c"] = @"data";
    params[@"type"] = @(self.topicType);
    params[@"maxtime"] = self.maxtime;
    
    [self.manager GET:BMCommonURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *arr = [BMTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:arr];
        NSDictionary *data =@{@"data": [BMTopic mj_keyValuesArrayWithObjectArray:self.topics]};
        
        NSString *filePath = [NSString stringWithFormat:@"baisi%lu.plist",(unsigned long)self.topicType];

        BM_WritetoFile(data, filePath)
        [self.tableView reloadData];
        
        
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *filePath = [NSString stringWithFormat:@"baisi%lu.plist",(unsigned long)self.topicType];
        NSDictionary *dic = BM_ReadFromFile(filePath);
        self.topics = [BMTopic mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        [self.tableView reloadData];
        NSLog(@"请求失败1.1:%@--",error);
        [self.tableView.mj_footer endRefreshing];
    }];

    
}


#pragma mark - 4.<UITableViewDataSource>


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.topics.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    BMTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseID"];
    BMTopic *topic = self.topics[indexPath.row];
    cell.topic = topic;
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMTopic *topic = self.topics[indexPath.row];
    
    return  topic.cellHeight ;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BMCommentController *commentVC = [[BMCommentController alloc] init];
    commentVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}

@end
