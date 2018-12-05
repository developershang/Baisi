//
//  AppDelegate.m
//  BaiSi
//
//  Created by developershang on 2017/5/12.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "AppDelegate.h"
#import "BMTabBarController.h"
#import "AppDelegate+BMShare.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, assign)NSUInteger lastSelectedIndex;
@end

@implementation AppDelegate

#pragma mark - <UITabBarControllerDelegate>

// tabbar 重复点击事件处理
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
    if (tabBarController.selectedIndex == self.lastSelectedIndex) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BMTabbarButtonDidRepeatClickNotifiction object:nil];
        BMFuncLog;
    }
    
    self.lastSelectedIndex = tabBarController.selectedIndex;
    
    
}






#pragma mark - <UIApplicationDelegate>


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置根控制器
    BMTabBarController *baseVC = [[BMTabBarController alloc] init];
    baseVC.delegate = self;
    self.window.rootViewController = baseVC;
    
    //3.成为主窗口并且显示
    [self.window makeKeyAndVisible];
    
    //4.注册分享
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"56c2f00d67e58e9926000f0e"];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
    return YES;
    
}


// 支持所有iOS系统  4_2, 9_0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// NS_AVAILABLE_IOS(9_0)
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// 2_0, 9_0
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
