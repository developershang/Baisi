//
//  BMLoginViewController.m
//  BaiSi
//
//  Created by developershang on 2017/5/18.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMLoginViewController.h"

@interface BMLoginViewController ()

@end

@implementation BMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


// 控制器控制的状态栏颜色
// 如果设置则 默认设置
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


//设置状态栏的显示与否  默认显示
- (BOOL)prefersStatusBarHidden{
    
    return NO;
}


- (IBAction)QuickLoginAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101:{
            NSLog(@"QQ登录");
        }break;
        case 102:{
            NSLog(@"微博登录");
        }break;
        case 103:{
            NSLog(@"腾讯登录");
        }break;
            
        default:
            break;
    }
    
}

- (IBAction)BackAction:(UIButton *)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
