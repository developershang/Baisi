//
//  BMMeController.m
//  BaiSi
//
//  Created by developershang on 2017/5/17.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMMeController.h"
#import "BMMeCell.h"
#import "BMMeFooterView.h"
#import "BMMeSquare.h"
#import "BMWebViewController.h"
#import <SafariServices/SafariServices.h>
#import "BMMeSettingController.h"
@interface BMMeController ()<UITableViewDelegate,UITableViewDataSource,BMMeFooterViewdelegate>

@property(nonatomic, weak)UITableView *table;
@end

@implementation BMMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavigationBar];
    
    [self setupView];
    
}




- (void)setNavigationBar{
    
    self.navigationItem.title = @"我";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImageName:@"mine-setting-icon" highLightImage:@"mine-setting-icon-click" target:self action:@selector(tagClick:)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImageName:@"mine-moon-icon" highLightImage:@"mine-moon-icon-click" target:self action:@selector(tagClick:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
}

- (void)tagClick:(UIBarButtonItem *)item{
    
    BMFuncLog;
    BMMeSettingController * vc = [[BMMeSettingController alloc] init];
   
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)setupView{
    

    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table.backgroundColor = BMColor(210, 210, 210);
    self.table = table;
 
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, table.bm_width, 15)];
    headerView.backgroundColor = BMColor(210, 210, 210);
    table.tableHeaderView = headerView;
    
    BMMeFooterView *footerView =[[BMMeFooterView alloc] init];
    footerView.delegate = self;
    table.tableFooterView = footerView;
    
    table.sectionHeaderHeight = 0;
    table.sectionFooterHeight = BMMargin;

    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
  
}

- (void)aaa{
    NSLog(@"dddd");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMMeCell *cell = [BMMeCell dequeueCellWithtableView:tableView];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else{
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    }

    return cell;
}




- (void)footerView:(BMMeFooterView *)footerView didClickButtonModel:(BMMeSquare *)model{
    
    NSLog(@"%@-%@",model.name,model.url);
   
    if ([model.url hasPrefix:@"http://"]) {
        
       // SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:model.url]];
        
        BMWebViewController *webViewVC = [[BMWebViewController alloc] init];
        webViewVC.url = [NSURL URLWithString:model.url];
        [self.navigationController pushViewController:webViewVC animated:YES];
        
        //[self presentViewController:safariVC animated:YES completion:nil];
    }
    
    
    
}

@end


















