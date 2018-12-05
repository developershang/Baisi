//
//  BMTopic.m
//  BaiSi
//
//  Created by developershang on 2017/6/10.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMTopic.h"
#import "BMComment.h"
#import "BMUser.h"

@implementation BMTopic




/** 返回数据中的数组 */
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"top_cmt":[BMComment class]};
}

/** 返回数据中的属性名字的替换 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"small_image":@"image0",
             @"middle_image":@"image2",
             @"large_image":@"image1",
             @"ID":@"id"};
}


- (CGFloat)cellHeight{
 
    // 如果cell的高度已经计算过, 就直接返回
     if (_cellHeight) return _cellHeight;
      // 1.头像高度 8+30+10
     _cellHeight = 48;
 
     //2.文字
     CGSize size1 =[self.text stringSizeWithfont:BMContentLabelFont maxW:TopicContenLabelWidth];
     _cellHeight += size1.height + BMMargin;
 
 
     //3.中间内容
     if (self.type != BMTopicTypeWord) {
         // 图片、声音、视频帖子的图片高度
         if (self.width == 0) {
             self.width = 480;
         }
         CGFloat contentH = TopicContenLabelWidth *self.height/self.width;
         if (contentH >= [UIScreen mainScreen].bounds.size.height) {
             self.bigPic = YES;
             contentH = [UIScreen mainScreen].bounds.size.height * 0.5;
             
         }
         self.contentF = CGRectMake(BMMargin, _cellHeight, TopicContenLabelWidth, contentH);
         _cellHeight += contentH + BMMargin;
         
     }
 
     //4.点赞、踩、转发
     _cellHeight += 35 ;
 
     //5.最热评论
     if (self.top_cmt.count >0) {
 
         BMComment *comment = self.top_cmt.firstObject;
         NSString *username = comment.user.username;
         NSString *content =  comment.content;
         NSString *text = [NSString stringWithFormat:@"%@: %@",username,content];
 
         CGSize size1 =[text stringSizeWithfont:[UIFont systemFontOfSize:12] maxW:TopicContenLabelWidth];
         
         // 这里的 5 5 是最热评论的上下内容间距
         _cellHeight +=  size1.height + 5 + 5 + BMMargin;
 
     }
 
     //6. 分割线
     _cellHeight += BMCellSeperateMargin;
    
    return _cellHeight;

 
 }


/*
- (NSString *)created_at{
 
    //关于时间的知识小结
 
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //Sun May 08 11:30:03 +0800 2016
    //EEE MMM dd HH:mm:ss Z yyyy
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:_created_at];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_CN"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components: NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date toDate:[NSDate date] options:0];
    NSInteger hour = components.hour;
    NSInteger minute = components.minute;
    
    
    
    //是今年
    if ([date isthisYear]) {
        //是昨天
        if([date isYesterday]){
            [formatter setDateFormat:@"昨天 HH:mm"];
            NSString *timeStr = [formatter stringFromDate:date];
            return timeStr;
        }else if([date isToday]){
            if (hour) {
                return [NSString stringWithFormat:@"%ld小时前",(long)hour];
            }else if(minute){
                return [NSString stringWithFormat:@"%ld分钟前",(long)minute];
            }else{
                return @"刚刚";
            }
        }else{//几天前
            [formatter setDateFormat:@"MM-dd HH:mm"];
            NSString *timeStr = [formatter stringFromDate:date];
            return timeStr;
        }
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *timeStr = [formatter stringFromDate:date];
        return timeStr;
        
    }
    

    
    
    
    
}
*/

@end
