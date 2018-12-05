//
//  BMItemViewController.m
//  BaiSi
//
//  Created by developershang on 2017/6/26.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMItemViewController.h"
#import "BMItemCell.h"
#import "BMItem.h"
@interface BMItemViewController ()
/** 网络请求 */
@property (nonatomic, strong)BMHTTPSessionManager *mgr;
/** 数据数组 */
@property (nonatomic, strong)NSArray *itemArr;

@end


@implementation BMItemViewController


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
    
    
    //1. 设置tableView
    self.navigationItem.title = @"推荐标签";
    self.tableView.rowHeight = 71;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BMItemCell class]) bundle:nil] forCellReuseIdentifier:@"itemCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BMColor(206, 206, 206);
    
    
    //2.加载数据
    [self loadNetData];
    
}

#pragma mark - 加载数据
- (void)loadNetData{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 定义一个弱引用 防止内存不能够及时释放
    __weak typeof(self) weakSelf = self;
    
    // 显示hub 消失的时候 1.请求成功 2.请求失败 3.页面消失(控制器销毁 跳转到下一个页面)
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    
    [self.mgr POST:BMCommonURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.618 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakSelf.itemArr = [BMItem mj_objectArrayWithKeyValuesArray:responseObject];
            
            [weakSelf.tableView reloadData];
            
            [SVProgressHUD dismiss];
            
        });
       
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试"];
        
    }];
    
}


// 视图即将消失时 隐藏
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}


// 及时取消所有网络请求
- (void)dealloc{
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}





#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BMItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    
    BMItem *item = self.itemArr[indexPath.row];
    
    cell.item = item;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}


@end
