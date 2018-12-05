//
//  BMTabBar.h
//  BSBDJ
//
//  Created by developershang on 2017/5/16.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMTabBar;

@protocol BMTabBarDelegate <NSObject>

 -(void)tabbar:(BMTabBar *)tabbar buttonClick:(UIButton *)button;

@end

@interface BMTabBar : UITabBar

@property (nonatomic, assign)id<BMTabBarDelegate>delegata;

@end
