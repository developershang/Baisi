//
//  UIView+BMExtension.h
//  BaiSi
//
//  Created by developershang on 2017/5/18.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BMExtension)

@property (nonatomic, assign)CGFloat bm_x;
@property (nonatomic, assign)CGFloat bm_y;
@property (nonatomic, assign)CGFloat bm_width;
@property (nonatomic, assign)CGFloat bm_height;
@property (nonatomic, assign)CGFloat bm_centerX;
@property (nonatomic, assign)CGFloat bm_centerY;
@property (nonatomic, assign)CGFloat bm_rightX;
@property (nonatomic, assign)CGFloat bm_bottomY;
+ (instancetype)viewFromXib;
- (BOOL)intersectWithView:(UIView *)view;
- (UIViewController *)getCurrentVC;
@end
