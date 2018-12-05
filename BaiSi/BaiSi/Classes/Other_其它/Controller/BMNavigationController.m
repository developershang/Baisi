//
//  BMNavigationController.m
//  BaiSi
//
//  Created by developershang on 2017/5/17.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMNavigationController.h"

@interface BMNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}


+(void)initialize{
    
    [self setupNavigationBarTheme];
    
    [self setupBarButtonItemTheme];
}


/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme{
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置文字属性 中间标题的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [appearance setTitleTextAttributes:textAttrs];
    
    //背景色 可以隐藏阴影
    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
   
  // [appearance setShadowImage:[UIImage imageNamed:@"navigationBarShdowImage"]];
    //appearance.clipsToBounds = YES;
    [appearance setShadowImage:[[UIImage alloc] init]];
}



/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    /**设置背景**/
// 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
//    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
   
    if (self.childViewControllers.count == 1) {
       viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
     if (self.childViewControllers.count > 1) {
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBtn sizeToFit];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
    }

 
}

- (void)back{
    
    [self popViewControllerAnimated:YES];
}

// 滑动手势的设置
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (self.childViewControllers.count > 1) {
        
        return YES;
    }
    
    return NO;
}


@end
