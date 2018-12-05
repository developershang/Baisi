//
//  BMTopicController.m
//  BaiSi
//
//  Created by developershang on 2017/5/27.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMTopicController.h"
#import "BMTopic.h"
#import "BMTopicCell.h"
#import "BMCommentController.h"
@interface BMTopicController ()

@property (nonatomic, strong)NSMutableArray<BMTopic *>*topics;
@property (nonatomic, strong)NSString *maxtime;
@property (nonatomic, strong)NSString *since_id;
@property (nonatomic, weak)BMHTTPSessionManager *manager;

@end


@implementation BMTopicController


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
    //3. 监听tabbar重复点击通知
    [self setupNoti];
    
    
}


- (void)setupNoti{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiAction:) name:BMTabbarButtonDidRepeatClickNotifiction object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareAction:) name:BMMaincellShareButtonDidClickNotifiction object:nil];
    
}

- (void)setupTabview{
    
    self.tableView.backgroundColor = BMColor(230, 230, 230);
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
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    // 获取数据
    NSArray *arr = [[BMShareInstance shareDataBase] getTopicWithParm:params andSinceID:self.maxtime];
    
    if (arr.count != 0 ) {
        
        self.topics = [BMTopic mj_objectArrayWithKeyValuesArray:arr];
        self.maxtime = [NSString stringWithFormat:@"%@", arr.firstObject[@"t"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        
    }else{
        
        [self.manager GET:BMCommonURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            self.maxtime = responseObject[@"info"][@"maxtime"];
            self.topics = [BMTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [[BMShareInstance shareDataBase] saveTopicArr:responseObject[@"list"]];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
        }];
        
        
    }

 
}


- (void)loadMoreTopics{
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    
    __weak   typeof(self) weakSelf = self;
    [SVProgressHUD show];
    [self.manager GET:BMCommonURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *arr = [BMTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.topics addObjectsFromArray:arr];
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
        if (error.code == NSURLErrorCancelled)return ;
        [SVProgressHUD showErrorWithStatus:@"网络问题 请检查网络..."];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    
}


#pragma mark - 这里的情况处理需要分种情况考虑
- (void)dealloc{
    
    [self.manager invalidateSessionCancelingTasks:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
    
    return topic.cellHeight ;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    BMCommentController *commentVC = [[BMCommentController alloc] init];
    commentVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
    
    
}


#pragma mark - 重复点击通知事件


- (void)notiAction:(NSNotification *)noti{
    
    NSLog(@"---%@",self.class);
    // 1.查看是否在window上
    if (self.view.window == nil) return;
    
    //2. 查看是否与window 有交叉
    
//    NSLog(@"11:%@-",NSStringFromCGRect(self.view.frame));
//    NSLog(@"22:%@-",NSStringFromCGRect([UIApplication sharedApplication].keyWindow.frame));
//    if (CGRectIntersectsRect(self.view.frame, [UIApplication sharedApplication].keyWindow.bounds)== NO) return;
    NSLog(@"%@--",[UIApplication sharedApplication].keyWindow);
    if (![self.view intersectWithView:[UIApplication sharedApplication].keyWindow]) return;
    
    //3.刷新
    [self.tableView.mj_header beginRefreshing];
    
    
    
}

- (void)shareAction:(NSNotification *)noti{
    
    BMTopic *topic = (BMTopic *)noti.object;
    
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        NSString* thumbURL =  topic.large_image;
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:topic.name  descr:topic.text thumImage:thumbURL];
        //设置网页地址
        switch (topic.type) {
            case BMTopicTypeAll:{
                shareObject.webpageUrl = @"www.baidu.com";

            }break;
                
            case BMTopicTypePic:{
                shareObject.webpageUrl = topic.large_image;

            }break;
                
            case BMTopicTypeWord:{
                shareObject.webpageUrl = @"www.baidu.com";
                
            }break;
                
            case BMTopicTypeVedio:{
                shareObject.webpageUrl = topic.videouri;
   
                
            }break;
            case BMTopicTypeVoice:{
                shareObject.webpageUrl = topic.voiceuri;
 
            }break;
                
            default:
                break;
        }
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {

            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
        
        
    }];
    

    
}

- (void)alertWithError:(NSError *)error{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

@end
