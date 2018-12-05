//
//  BMComment.h
//  BaiSi
//
//  Created by developershang on 2017/6/15.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BMUser;

@interface BMComment : NSObject
/** 评论内容 */
@property (nonatomic, copy)NSString *content;
/** 用户 */
@property (nonatomic, strong)BMUser *user;
/** id */
@property (nonatomic, copy) NSString *ID;
/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;

/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
