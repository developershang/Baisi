
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    /** 全部 */
    BMTopicTypeAll = 1,
    /** 图片 */
    BMTopicTypePic = 10,
    /** 段子 */
    BMTopicTypeWord = 29,
    /** 音频 */
    BMTopicTypeVoice = 31,
    /** 视频 */
    BMTopicTypeVedio = 41,
    
} BMTopicType;

/** 通用间距*/
extern CGFloat const BMMargin;
/** 通用间距*/
extern CGFloat const BMCellSeperateMargin;
/** 公共的URL*/
extern NSString * const BMCommonURL;

/** tabbar重复复点击*/
extern NSString * const BMTabbarButtonDidRepeatClickNotifiction;


/** Maincell分享点击通知*/
extern NSString * const BMMaincellShareButtonDidClickNotifiction;

/** Maincell视频播放点击通知*/
extern NSString * const BMMaincellVideoPlayButtonDidClickNotifiction;


