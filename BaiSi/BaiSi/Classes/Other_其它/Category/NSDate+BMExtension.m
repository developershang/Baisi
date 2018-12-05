//
//  NSDate+BMExtension.m
//  BaiSi
//
//  Created by developershang on 2017/6/15.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "NSDate+BMExtension.h"

@implementation NSDate (BMExtension)


/**
 *  是否是今年
 */


- (BOOL)isthisYear{
    
    //创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //获取当前时间的日历时间
    NSCalendarUnit uint = NSCalendarUnitYear;
    NSDateComponents *nowCom = [calendar components:uint fromDate:[NSDate date]];
    
    //获取传过来的日历时间
    NSDateComponents *selfCom = [calendar components:NSCalendarUnitYear fromDate:self];
    
    //判断是否为同一年
    return  selfCom.year == nowCom.year;
    
}

/**
 *  是否是昨天
 */
- (BOOL)isYesterday{
    
    
    //设置时间格式 目的转化为yyyy--MM--dd 00:00:00便于比较
    //date :2015-10-31 18:33:23 -> 2015-10-30 00:00:00
    //self :2015-11-01 05:33:23 -> 2015-11-01 00:00:00
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy--MM--dd"];
    
    
    // 2015-10-30
    NSString *selfStr = [formatter stringFromDate:self];
    //2015-11-01
    NSString *nowStr = [formatter stringFromDate:[NSDate date]];
    
    //2015-10-30 00:00:00
    NSDate *selfDate  = [formatter dateFromString:selfStr];
    //2015-11-01 00:00:00
    NSDate *nowDate  = [formatter dateFromString:nowStr];
    
    
    
    //创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //获取当前时间的日历时间
    NSCalendarUnit uint = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *component = [calendar components:uint fromDate:selfDate toDate:nowDate options:0];
    
    
    //判断是否为同一年
    return  component.year == 0 && component.month == 0 && component.day == 1;
}

/**
 *  是否是今天
 */
- (BOOL)isToday{
    
    
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy--MM--dd"];
    NSString *selfStr = [formatter stringFromDate:self];
    NSString *nowStr = [formatter stringFromDate:[NSDate date]];
    
    return [selfStr isEqualToString:nowStr];
    
    
}

/*
 //创建日历对象
 NSCalendar *calendar = [NSCalendar currentCalendar];
 
 //获取传过来日期日历
 NSDateComponents *nowComs = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay fromDate:self];
 //获取当前系统日期日历
 NSDateComponents *selfComs = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay fromDate:[NSDate date]];
 
 
 return nowComs.year == selfComs.year && nowComs.month == selfComs.month && nowComs.day ==selfComs.day;
 
 */

@end
