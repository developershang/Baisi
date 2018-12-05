//
//  BMTabBar.m
//  BSBDJ
//
//  Created by developershang on 2017/5/16.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMTabBar.h"


@interface BMTabBar ()

@property (nonatomic, strong)UIButton *publishBtn;

@end

@implementation BMTabBar

#pragma mark - 1.懒加载发布按钮

- (UIButton *)publishBtn{
    
    if (_publishBtn == nil) {
        _publishBtn = [[UIButton alloc] init];
        [_publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon_38x38_"] forState:UIControlStateNormal];
        [_publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon_38x38_"] forState:UIControlStateHighlighted];
        [_publishBtn addTarget:self action:@selector(publishAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_publishBtn];
    }
    
    return _publishBtn;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat BtnW = self.frame.size.width/5;
    CGFloat BtnH = self.frame.size.height;
    CGFloat BtnY = 0;
    NSInteger index = 0;
    
    for (UIView *sub in self.subviews) {
        if (![sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        sub.frame = CGRectMake(index *BtnW, BtnY, BtnW, BtnH);
        if (index >= 2) {
            sub.frame = CGRectMake(index *BtnW +BtnW, BtnY, BtnW, BtnH);
        }
        index ++;
    }
    
    self.publishBtn.frame = CGRectMake(0, 0, BtnW, BtnH);
    self.publishBtn.center = CGPointMake(self.frame.size.width *0.5, self.frame.size.height *0.5);
    
}

- (void)publishAction:(UIButton *)sender{
    
   
    
    if ([self.delegata respondsToSelector:@selector(tabbar:buttonClick:)]) {
         NSLog(@"发布事件");
        [self.delegata tabbar:self buttonClick:sender];
    }
    
}


@end
