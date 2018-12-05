//
//  BMTopic.h
//  BaiSi
//
//  Created by developershang on 2017/6/10.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BMComment;

@interface BMTopic : NSObject


/** id */
@property (nonatomic, copy) NSString *ID;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong)NSArray<BMComment*>*top_cmt;
/** 帖子类型 */
@property (nonatomic, assign)BMTopicType type;
/** 图片宽度 */
@property (nonatomic, assign)CGFloat width;
/** 图片高度 */
@property (nonatomic, assign)CGFloat height;
/** 是否是认证用户 */
@property (nonatomic, assign)CGFloat jie_v;

/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;
/** 是否为gif动画图片 */
@property (nonatomic, assign) BOOL is_gif;


/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;



/** 视频路径 */
@property (nonatomic, copy) NSString *videouri;

/** 音频路径 */
@property (nonatomic, copy) NSString *voiceuri;


// 额外的属性 根据内容算高度

/** cell高度属性 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentF;
/** 是否为超长图 */
@property (nonatomic, assign, getter = isbigPic) BOOL bigPic;
@end
