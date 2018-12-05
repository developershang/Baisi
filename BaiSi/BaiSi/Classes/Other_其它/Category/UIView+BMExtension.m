//
//  UIView+BMExtension.m
//  BaiSi
//
//  Created by developershang on 2017/5/18.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "UIView+BMExtension.h"

@implementation UIView (BMExtension)


/**
 <#Description#>
 */
- (void)setBm_x:(CGFloat)bm_x{
   
    CGRect rect = self.frame;
    rect.origin.x = bm_x;
    self.frame = rect;
    
}
- (CGFloat)bm_x{
    
    return self.frame.origin.x;
    
}



- (void)setBm_y:(CGFloat)bm_y{
    CGRect rect = self.frame;
    rect.origin.y = bm_y;
    self.frame = rect;
}
- (CGFloat)bm_y{
    return self.frame.origin.y;
}


- (void)setBm_width:(CGFloat)bm_width{
    
    CGRect rect = self.frame;
    rect.size.width = bm_width;
    self.frame = rect;
    
    
}
- (CGFloat)bm_width{
    return self.frame.size.width;
}


- (void)setBm_height:(CGFloat)bm_height{
    
    CGRect rect = self.frame;
    rect.size.height = bm_height;
    self.frame = rect;
}
- (CGFloat)bm_height{
    
    return self.frame.size.height;
}




- (void)setBm_centerX:(CGFloat)bm_centerX{
    
    CGPoint center = self.center;
    
    center = CGPointMake(bm_centerX, center.y);
    
    self.center = center;
}
- (CGFloat)bm_centerX{
    return self.center.x;
}


- (void)setBm_centerY:(CGFloat)bm_centerY{
    CGPoint center = self.center;
    
    center = CGPointMake(center.x, bm_centerY);
    
    self.center = center;
    
}
- (CGFloat)bm_centery{
    return self.center.y;
}


- (void)setBm_rightX:(CGFloat)bm_rightX{
   
    CGRect rect = self.frame;
    rect.origin.x =  bm_rightX - rect.size.width;
    self.frame = rect;
    
}
- (CGFloat)bm_rightX{

    return self.frame.size.width + self.frame.origin.x;
}

- (void)setBm_bottomY:(CGFloat)bm_bottomY{
    
    CGRect rect = self.frame;
    rect.origin.y =  bm_bottomY - rect.size.height;
    self.frame = rect;
    
}
- (CGFloat)bm_bottomY{
    
  return self.frame.origin.y + self.frame.size.height;
 
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result = nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        
        UIViewController * nav = (UIViewController *)nextResponder;
        
        result = nav.childViewControllers.lastObject;
        
    }else{
        
        result = nextResponder;
    }
    
    return result;
}

@end
