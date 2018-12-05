//
//  UIImage+BMExtension.h
//  BaiSi
//
//  Created by developershang on 2017/6/14.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BMExtension)

/**
  根据颜色生成图片
 */
+(UIImage*)imageWithColor:(UIColor*)color;


- (UIImage *)circleImage;
/**
    生成圆形图片
 */
+ (UIImage *)circleImage:(NSString *)name;

@end
