//
//  BMItem.h
//  BaiSi
//
//  Created by developershang on 2017/6/26.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMItem : NSObject
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
@end
