//
//  NSObject+BMExtension.m
//  BaiSi
//
//  Created by developershang on 2017/8/15.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "NSObject+BMExtension.h"
#import <objc/runtime.h>
@implementation NSObject (BMExtension)

// 编码
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    //定义一个变量用于接收成员列表个数
    unsigned int count = 0;
    //获取成员列表数组
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    //遍历成员变量数组
    for (int i = 0; i < count; i++) {
        //取得成员变量ivar
        Ivar ivar = ivars[i];
        //通过成员变量ivar装换成属性key
        NSString *key =[NSString stringWithUTF8String:ivar_getName(ivar)];
        //通过key拿到对应的Value
        id value = [self valueForKey:key];
        //根据编码归档值
        [aCoder encodeObject:value forKey:key];
        
    }
    free(ivars);
    
    
    
}

// 解码
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [self init];
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        id value = [aDecoder decodeObjectForKey:key];
        
        [self setValue:value forKey:key];
        
    }
    
    free(ivars);
    
    
    
    
    return self;
}


@end
