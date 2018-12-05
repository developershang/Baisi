//
//  BMCommentController.m
//  BaiSi
//
//  Created by developershang on 2017/6/27.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMCommentController.h"
#import "BMTopic.h"
#import "BMRefreshNormalHeader.h"
#import "BMRefreshBackNormalFooter.h"
#import "BMComment.h"
#import "BMCommentCell.h"
#import "BMTopicCell.h"
#import "BMCommentHeaderView.h"
@interface BMCommentController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

/** 列表视图 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 底部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;

/** 网络管理类 */
@property(nonatomic, strong)BMHTTPSessionManager *mgr;

/** 热评数组 */
@property (nonatomic, strong)NSArray *hotArr;

/** 评论数组 */
@property (nonatomic, strong)NSMutableArray *commentArr;

/** 文本框 */
@property (weak, nonatomic) IBOutlet UITextField *textField;



@end

@implementation BMCommentController

#pragma mark - 懒加载

- (BMHTTPSessionManager *)mgr{
    if (_mgr == nil) {
        _mgr = [BMHTTPSessionManager manager];
    }
    return _mgr;
}

#pragma mark - 初始化

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupTableView];
    
    [self setupRefresh];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)setupTableView{
    
    self.navigationItem.title = @"评论";
    //每一组头部控件的高度
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.backgroundColor = BMColor(230, 230, 230);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BMCommentCell class]) bundle:nil] forCellReuseIdentifier:@"comment"];
    [self.tableView registerClass:[BMCommentHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    // 创建header
    UIView *header = [[UIView alloc] init];
    BMTopicCell *cell = [BMTopicCell viewFromXib];
    cell.cmtView.backgroundColor = BMRandomColor;
    self.topic.top_cmt = nil; // 去掉评论
    self.topic.cellHeight = 0.0f; // 重新计算cell高度
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    
    [header addSubview:cell];
     cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    // 设置header的高度
    header.bm_height = cell.bm_height + 0.618;
    // 设置header
    self.tableView.tableHeaderView = header;
    
}

- (void)setupRefresh{
    
    self.tableView.mj_header = [BMRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [BMRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];

}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark - 加载数据

- (void)loadNewComment{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    [self.mgr GET:BMCommonURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
           
            [self.tableView.mj_header endRefreshing];
            
            return ;
        }
        
        self.commentArr = [BMComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        self.hotArr = [BMComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    
  
}

- (void)loadMoreComment{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    BMComment *comment = self.commentArr.lastObject;
    params[@"lastcid"] = comment.ID;
    
    [self.mgr POST:BMCommonURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            
            [self.tableView.mj_header endRefreshing];
            
            return ;
        }
        
        NSArray *dataArr = [BMComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.commentArr addObjectsFromArray:dataArr];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}



#pragma mark - <UItableViewDelegate, UItableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    // 有热评 + 最新评论数据
    if (self.hotArr.count) return 2;
    // 没有热评 + 最新评论数据
    if (self.commentArr.count) return 1;
    // 数据为空
    return 0;


}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // 第0组 有最热评论
    if (section == 0 && self.hotArr.count) {
        
        return self.hotArr.count;
    }
    
    //其他情况
    return self.commentArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    
    if (indexPath.row == 0 && self.hotArr.count ) {
        
        cell.comment = self.hotArr[indexPath.row];
        
    }else{
        
         cell.comment = self.commentArr[indexPath.row];
    }

    return cell;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    if (section == 0) {
        
        header.textLabel.text = @"最热评论";
    }else{
        header.textLabel.text = @"最新评论";
    }
    return header;
}

#pragma mark - 键盘通知Action

- (void)KeyboardWillChangeFrame:(NSNotification *)noti{
    
    
    CGFloat keyboardY = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGFloat ScreenH = BMScreenHeight;
    
    self.bottomMargin.constant = ScreenH - keyboardY;
    // 执行动画
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        [self.view layoutIfNeeded];
        
    }];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMComment *comment = nil;
    if (indexPath.row == 0 && self.hotArr.count ) {
        
        comment = self.hotArr[indexPath.row];
        
    }else{
        
        comment = self.commentArr[indexPath.row];
    }
    
    
    return comment.cellHeight;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}


@end









