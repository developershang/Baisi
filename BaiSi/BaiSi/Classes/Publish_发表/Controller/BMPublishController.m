//
//  BMPublishController.m
//  BaiSi
//
//  Created by developershang on 2017/5/17.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMPublishController.h"

@interface BMPublishController ()

@end

@implementation BMPublishController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = BMRandomColor;

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
