//
//  BMFollowController.m
//  BaiSi
//
//  Created by developershang on 2017/5/17.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMFollowController.h"
#import "BMRecommonFollowController.h"
#import "BMLoginViewController.h"
@interface BMFollowController ()

@end

@implementation BMFollowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"关注";
    
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" highLightImage:@"friendsRecommentIcon-click" target:self action:@selector(tagClick:)];

    self.navigationItem.leftBarButtonItem = item;
    
    
    
    
}












- (void)tagClick:(UIBarButtonItem *)item{
    
    BMFuncLog;
    
    BMRecommonFollowController *attenationVC = [[BMRecommonFollowController alloc] init];
    [self.navigationController pushViewController:attenationVC animated:YES];
    
}

- (IBAction)LoginClick:(UIButton *)sender {
    
    
    BMLoginViewController *loginVC = [[BMLoginViewController alloc] init];
    
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end







