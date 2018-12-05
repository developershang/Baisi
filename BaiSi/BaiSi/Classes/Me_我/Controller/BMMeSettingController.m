//
//  BMMeSettingController.m
//  BaiSi
//
//  Created by developershang on 2017/5/19.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMMeSettingController.h"
#import "BMMeCell.h"
#import "BMTestCell.h"




@interface BMMeSettingController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BMMeSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = BMRandomColor;
     self.navigationItem.title = @"设置";

    [self setupView];

}

- (void)setupView{
    
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table.sectionHeaderHeight = 0;
    table.sectionFooterHeight = BMMargin;
    table.contentInset = UIEdgeInsetsMake(BMMargin - 35, 0, 0, 0);
    table.backgroundColor = BMColor(210, 210, 210);
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 30;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
 
    if (indexPath.row == 0) {
        
      BMMeCell*  cell = [BMMeCell dequeueCellWithtableView:tableView];
        
    if ([cell.accessoryView isKindOfClass:[UIActivityIndicatorView class]]) {
        UIActivityIndicatorView *loadingView = (UIActivityIndicatorView*)cell.accessoryView;
        [loadingView startAnimating];
        NSLog(@"正在刷新数据");
  
            
    }else if( cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator){
    
        
    }else{
            NSLog(@"-->%@", cell.accessoryView);
            cell.textLabel.text = @"清除缓存(正在计算...)";
            cell.userInteractionEnabled = NO;
            UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            cell.accessoryView = loadingView;
            [loadingView startAnimating];
            // 这里是多线程处理的方式
            __weak typeof(cell) weakCell = cell;
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                [NSThread sleepForTimeInterval:3.0];
                
                unsigned long long size = testPath.fileSize;
                size += [SDImageCache sharedImageCache].getSize;
                // 定义弱引用指针 优化内存管理 如果用户点击回去 则直接回收内存 所以block 中打印weakCell 为空
                if (weakCell == nil) return ;
                
                NSString *sizeText = nil;
                if (size >  1000.0 * 1000.0 *1000.0) {
                    sizeText = [NSString stringWithFormat:@"%.2fGB", size / (1000.0 * 1000.0 * 1000.0)];
                }else if (size >  1000.0 * 1000.0) {
                    sizeText = [NSString stringWithFormat:@"%.2fMB", size / (1000.0 * 1000.0)];
                }else if (size >  1000.0 ) {
                    sizeText = [NSString stringWithFormat:@"%.2fKB", size / (1000.0)];
                }else{
                    sizeText = [NSString stringWithFormat:@"%zdB", size];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakCell.userInteractionEnabled = YES;
                    weakCell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%@)",sizeText];
                    weakCell.accessoryView = nil;
                    weakCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    NSLog(@"cell = %@",weakCell);
                    
                });
                
            });

        }
        
        return cell;
        
    }else{
        
       BMTestCell*  cell = [BMTestCell dequeueCellWithtableView:tableView];
       cell.textLabel.text = @"测试...";
       return cell;
        
    }
    
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [SVProgressHUD showWithStatus:@"清除缓存..." maskType:SVProgressHUDMaskTypeBlack];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                NSFileManager *mgr = [NSFileManager defaultManager];
                [mgr removeItemAtPath:testPath error:nil];
                [mgr createDirectoryAtPath:testPath withIntermediateDirectories:YES attributes:nil error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    BMMeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(0B)"];
                    [SVProgressHUD dismiss];
                    
                });
                
                
                
            });
            
            
            
            
            
            
            
        }];
        
        
    }else{
        [tableView reloadData];
    }
    
   
    
    
}

-(void)dealloc{
    BMFuncLog;
}

@end

