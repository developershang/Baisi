//
//  AppDelegate+BMShare.m
//  BaiSi
//
//  Created by developershang on 2017/7/17.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "AppDelegate+BMShare.h"
@implementation AppDelegate (BMShare)


- (void)confitUShareSettings
{

    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}


- (void)configUSharePlatforms
{
 
    // 注册分享到微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:@"wxb90873c3e73bd783"
                                       appSecret:@"ba6b1b5763aa3b658e309ae8f75bbb17"
                                     redirectURL:@"http://www.umeng.com/social"];
    
    
     // 注册分享到QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:@"1105337833"
                                       appSecret:nil
                                     redirectURL:@"http://mobile.umeng.com/social"];
    
    
    // 注册分享到Ali
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_AlipaySession
//                                          appKey:@""
//                                       appSecret:@""
//                                     redirectURL:nil];
    
    
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ)]];

}


@end



