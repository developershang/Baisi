//
//  NSString+BMExtension.h
//  BaiSi
//
//  Created by developershang on 2017/5/19.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BMExtension)

/** 根据文件路径获取文件大小 */
+(unsigned long long)fileSizeForFile:(NSString *)filepath;

/** 根据文件路径获取文件大小 */
-(unsigned long long)fileSize;



/** 根据字体格式返回一个size*/
-(CGSize)stringSizeWithfont:(UIFont*)font;
/** 根据字体格式 宽度 返回一个给定宽度的自适应高度的size*/
-(CGSize)stringSizeWithfont:(UIFont*)font maxW:(CGFloat)maxW;

@end
