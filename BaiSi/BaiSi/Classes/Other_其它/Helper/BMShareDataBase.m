//
//  BMShareDataBase.m
//  BaiSi
//
//  Created by developershang on 2017/8/14.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMShareDataBase.h"
#import "FMDB.h"
#import "BMTopic.h"
static BMShareDataBase *_shareDataBase;


@interface BMShareDataBase()<NSCopying,NSMutableCopying>{
    
    FMDatabase *_db;
}

@end

@implementation BMShareDataBase

#pragma mark - 数据库管理

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareDataBase = [super allocWithZone:zone];

    });
    
    return _shareDataBase;
}

+(instancetype)sharedDataBase{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareDataBase = [[BMShareDataBase alloc] init];
        
        [_shareDataBase initDataBase];
        
    });

    return _shareDataBase;
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}




#pragma mark - 初始化数据库

// 初始化数据库
- (void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 1.文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"topic.sqlite"];
    
    // 2.实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:filePath];
    
    // 3.打开数据库
    [_db open];
    
    // 4.初始化数据表
    NSString *personSql = @"create table if not exists t_topic(id integer primary key autoincrement,topic_id text, name text,ding integer,cai integer,share integer,comment integer);";
    
    NSString *carSql = @"CREATE TABLE 't_student' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'own_id' VARCHAR(255),'car_id' VARCHAR(255),'car_brand' VARCHAR(255),'car_price'VARCHAR(255)) ";
    
     [_db executeUpdate:personSql];
     [_db executeUpdate:carSql];
     [_db close];
    
}

#pragma mark - 数据库的操作 面向model的存储，
//读取便于将来数据库的维护

/**  添加topic到数据库 */
- (void)addTopic:(BMTopic *)topic{
  
    [_db open];
    // 这里用的是问号 后面是的对象 不确定的参数用问号来占位
    [_db executeUpdate:@"INSERT INTO t_topic (topic_id,name,ding,cai,share,comment)VALUES(?,?,?,?,?)",topic.ID,topic.name,topic.ding,topic.cai,topic.repost, topic.comment];
//  [_db executeUpdateWithFormat:@"INSERT INTO t_topic (topic_id,topic)VALUES(%@,%@)",topic.ID,topic];
    [_db close];
    
}

/**  从数据库中删除topic */
- (void)deleteTopic:(BMTopic *)topic{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM person WHERE person_id = ?",topic.ID];
    
    [_db close];
}


/**  更新topic */
- (void)updateTopic:(BMTopic*)topic{
    [_db open];
    [_db executeUpdate:@"UPDATE 't_topic' SET name = ?  WHERE topic_id = ? ",topic.name,topic.ID];
    [_db executeUpdate:@"UPDATE 't_topic' SET ding = ?  WHERE topic_id = ? ",topic.ding,topic.ID];
    [_db executeUpdate:@"UPDATE 't_topic' SET cai = ?  WHERE topic_id = ? ",topic.cai,topic.ID];
    [_db close];
}

/**  根据条件查找 */
- (NSMutableArray*)topicWithTopicID:(NSInteger)topic_id{
    
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM t_topic WHERE topic_id = ?",topic_id];
    
    while ([res next]) {
        BMTopic *topic = [[BMTopic alloc] init];
        topic.ID = [res stringForColumn:@"topic_id"];
        topic.name = [res stringForColumn:@"name"];
        topic.ding = [[res stringForColumn:@"ding"] integerValue];
        topic.cai = [[res stringForColumn:@"cai"] integerValue];
        topic.repost = [[res stringForColumn:@"share"] integerValue];
        topic.comment = [[res stringForColumn:@"comment"] integerValue];
        [dataArray addObject:topic];
    }
    
    [_db close];
    
    return dataArray;
    
}

/**  获取所有的topics */
- (NSMutableArray *)getAllTopics{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM t_topic"];
    
    while ([res next]) {
        BMTopic *topic = [[BMTopic alloc] init];
        topic.ID = [res stringForColumn:@"topic_id"];
        topic.name = [res stringForColumn:@"name"];
        topic.ding = [[res stringForColumn:@"ding"] integerValue];
        topic.cai = [[res stringForColumn:@"cai"] integerValue];
        topic.repost = [[res stringForColumn:@"share"] integerValue];
        topic.comment = [[res stringForColumn:@"comment"] integerValue];
        [dataArray addObject:topic];
    }
    
    [_db close];
    
    return dataArray;
    
}


@end













