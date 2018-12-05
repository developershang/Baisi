//
//  BMHTTPSessionManager.h
//  BaiSi
//
//  Created by developershang on 2017/6/13.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface BMHTTPSessionManager : AFHTTPSessionManager

+(instancetype)shareInstance;

@end
