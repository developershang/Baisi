//
//  BMShareInstance.h
//  BaiSi
//
//  Created by developershang on 2017/8/15.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMShareInstance : NSObject


+ (instancetype)shareInstance;

+ (instancetype)shareDataBase;

// 1.增加保存数据
- (void)saveTopicArr:(NSArray *)TopicArr;

// 2.删除数据
- (void)deleteTopicWithTopicId:(NSString *)topic_id;

// 3.修改保存数据数据
- (void)saveTopic:(NSDictionary *)Topic;

// 4.查询获取数据
- (NSArray *)getAllTopics;


- (NSArray *)getTopicWithParm:(NSDictionary*)params andSinceID:(NSString *)maxid;


@end
