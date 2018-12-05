//
//  BMShareInstance.m
//  BaiSi
//
//  Created by developershang on 2017/8/15.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMShareInstance.h"
#import "FMDB.h"
static BMShareInstance *_shareInstance;

@interface BMShareInstance (){
    FMDatabase *_db;
    
}

@end


@implementation BMShareInstance

/** 保证对象只有一个 */
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [super allocWithZone:zone];
    });
    return _shareInstance;
    
}

/** 操作其他 eg:蓝牙 */
+(instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[BMShareInstance alloc] init];
    });
    return _shareInstance;
    
}

/** 操作数据库 FMDB */
+(instancetype)shareDataBase{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[BMShareInstance alloc] init];
        // 初始化数据库
        [_shareInstance initDataBase];
        
    });
    return _shareInstance;
    
}



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
    NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS t_topic (id integer PRIMARY KEY AUTOINCREMENT,topic_id text NOT NULL,topic_type text NOT NULL, topic_dic blob NOT NULL);";
    [_db executeUpdate:sqlStr];
    [_db close];
    
}


// 保存数据
- (void)saveTopicArr:(NSArray *)TopicArr{
    [_db open];

    //1.每次保存之前清除数据库之前的数据
    [_db executeUpdate:@"DELETE FROM t_topic"];
    
    // 保存最新的数据
    for (NSDictionary *topic in TopicArr) {
 
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:topic];
        [_db executeUpdate:@"INSERT INTO t_topic (topic_id, topic_type, topic_dic) VALUES (?,?,?);",
         topic[@"t"],topic[@"type"], data];
    }

    [_db close];
    
    
}

// 获取数据
- (NSArray *)getAllTopics{
    
    [_db open];
    
    NSMutableArray *muArr = [NSMutableArray array];
    
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM t_topic;"];
    
    while ([resultSet next]) {
        
        NSData *data =  [resultSet objectForColumnName:@"topic_dic"];
        
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        [muArr addObject:dic];
        
    }
    
    [_db close];
    
    return muArr;
    
    
}


- (NSArray *)getTopicWithParm:(NSDictionary*)params andSinceID:(NSString*)since_id{
    
    NSMutableArray *muArr = [NSMutableArray array];
    
    if (since_id.length == 0) {

    [_db open];
    
    FMResultSet *resultSet = nil;
   
    if (![params[@"type"] isEqual: [NSNumber numberWithInteger:1]]) {
        
        resultSet = [_db executeQuery:@"SELECT * FROM t_topic WHERE topic_type = ?;",params[@"type"]];
        
    }else{
        
        resultSet = [_db executeQuery:@"SELECT * FROM t_topic;"];
    }

    while ([resultSet next]) {
        
      NSData *data =  [resultSet objectForColumnName:@"topic_dic"];
        
      NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
      [muArr addObject:dic];
        
    }
    
    [_db close];
    }
    
    
    return muArr;
    
}








@end
