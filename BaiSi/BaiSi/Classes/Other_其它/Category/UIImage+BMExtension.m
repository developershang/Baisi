//
//  UIImage+BMExtension.m
//  BaiSi
//
//  Created by developershang on 2017/6/14.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "UIImage+BMExtension.h"

@implementation UIImage (BMExtension)

+(UIImage*)imageWithColor:(UIColor*)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *)circleImage{
    
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 绘制图片
    [self drawInRect:rect];
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)circleImage:(NSString *)name{
    
    
    return [[self imageNamed:name] circleImage];
}


@end
