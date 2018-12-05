//
//  BMUser.h
//  BaiSi
//
//  Created by developershang on 2017/6/15.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMUser : NSObject

/**用户名*/
@property (nonatomic, copy)NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 m(male) f(female) */
@property (nonatomic, copy) NSString *sex;

@end
