//
//  NSString+BMExtension.m
//  BaiSi
//
//  Created by developershang on 2017/5/19.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "NSString+BMExtension.h"

@implementation NSString (BMExtension)

+ (unsigned long long)fileSizeForFile:(NSString *)filepath{
    
    unsigned long long size = 0;
    
    // 1.创建文件管理
    NSFileManager *mgr = [NSFileManager defaultManager];
    //2.获取文件属性
    NSDictionary *attr = [mgr attributesOfItemAtPath:filepath error:nil];
    //3.根据文件属性判断是否是文件夹
    if ([attr.fileType isEqualToString:NSFileTypeDirectory]) {
        
        //3.1 是文件夹 管理遍历子路径
        NSArray *subpaths = [mgr subpathsAtPath:filepath];
        for (NSString *subpath in subpaths) {
            //3.1.1 获取全路径
            NSString *fullpath = [filepath stringByAppendingPathComponent:subpath];
            //3.1.2 管理根据全路径 得到属性得到大小相加
            NSDictionary *attr = [mgr attributesOfItemAtPath:fullpath error:nil];
            
            size += attr.fileSize;
            
        }
        
    }else{
        //3.2 是文件 直接得到大小
        size = [mgr attributesOfItemAtPath:filepath error:nil].fileSize;
    }
    
    
    return size;
}


- (unsigned long long)fileSize{
    
    unsigned long long size  = 0;
    // 1.文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirector = NO;
    //2.管理者判断是否是文件夹
    [mgr fileExistsAtPath:self isDirectory:&isDirector];
    //3.是否文件夹
    if (isDirector) {
 
        //3.1 管理者获取子路径数组
        NSArray *subpaths = [mgr subpathsAtPath:self];
        //NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        
        //3.2 遍历子路径 拼接获取全路径 计算文件大小
        for (NSString *subpath in subpaths) {
            
            NSString *fullpath = [self stringByAppendingPathComponent:subpath];
            NSDictionary *attr = [mgr attributesOfItemAtPath:fullpath error:nil];
            size += attr.fileSize;
            
        }
        
    }else{
         // 不是 则直接计算大小
        size = [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
    
    return size;
    
}

/** 根据字体格式返回一个size*/
-(CGSize)stringSizeWithfont:(UIFont*)font{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    return [self sizeWithAttributes:attrs];
    
    
}

/** 根据字体格式 宽度 返回一个给定宽度的自适应高度的size*/
-(CGSize)stringSizeWithfont:(UIFont*)font maxW:(CGFloat)maxW{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize size = CGSizeMake(maxW, MAXFLOAT);
    return  [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}


@end
