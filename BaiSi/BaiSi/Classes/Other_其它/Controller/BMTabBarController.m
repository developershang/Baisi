//
//  BMTabBarController.m
//  BaiSi
//
//  Created by developershang on 2017/5/17.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMTabBarController.h"
#import "BMTabBar.h"
#import "BMEssenceController.h"//精华
#import "BMNewController.h"//新帖
#import "BMPublishController.h"//发帖
#import "BMFollowController.h"//关注
#import "BMMeController.h"//我的


#import "BMNavigationController.h"

@interface BMTabBarController ()<BMTabBarDelegate>
@property (nonatomic, strong)UIButton *publishBtn;
@end

@implementation BMTabBarController

#pragma mark - 1.懒加载发布按钮

- (UIButton *)publishBtn{
    
    if (_publishBtn == nil) {
        
        _publishBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, self.tabBar.frame.size.width / 5, self.tabBar.frame.size.height)];
        
        _publishBtn.center = CGPointMake(self.tabBar.frame.size.width *0.5, self.tabBar.frame.size.height *0.5);
        
        [_publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [_publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_clilk_icon"] forState:UIControlStateHighlighted];
        
        [_publishBtn addTarget:self action:@selector(publishAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //  _publishBtn.backgroundColor = BMRandomColor;
        
    }
    
    return _publishBtn;
    
}


#pragma mark - 2.添加自控制器并设置字体图片颜色

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置TabBarTheme
//    [self setupTabBarAttribute];
    
    
    //2.设置文字以及文字属性
    [self setupTabBaritemAttribute];
    
    
    //3.添加子控制器
    [self setupChildViewControllers];
    
    
    [self setupPublishButton];
    
    
    
    
}

//#pragma mark - 3.添加发布按钮
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.tabBar addSubview:self.publishBtn];
//}

- (void)setupTabBarAttribute{
    
    UITabBar *apprence = [UITabBar appearance];
    [apprence setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    [apprence setShadowImage:[UIImage imageNamed:@"navigationBarShdowImage"]];

}
/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupTabBaritemAttribute{
    
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
}



/**
 *  添加子控制器
 */
- (void)setupChildViewControllers{
    
    BMEssenceController *EssenceVC = [[BMEssenceController alloc] init];
    [self setupChildVC:EssenceVC title:@"精华" image:@"tabBar_essence_icon_27x27_" selectedIamge:@"tabBar_essence_click_icon_27x27_"];

    BMNewController *NewVC = [[BMNewController alloc] init];
    [self setupChildVC:NewVC title:@"最新" image:@"tabBar_new_icon_27x27_" selectedIamge:@"tabBar_new_click_icon_27x27_"];
    
 
    BMFollowController *followVC = [[BMFollowController alloc] init];
    [self setupChildVC:followVC title:@"败家姐" image:@"tabBar_friendTrends_icon_27x27_" selectedIamge:@"tabBar_friendTrends_click_icon_27x27_"];
    
    
    BMMeController *meVC = [[BMMeController alloc] init];
    [self setupChildVC:meVC title:@"我" image:@"tabBar_me_icon_27x27_" selectedIamge:@"tabBar_me_click_icon_27x27_"];


}


/**
 *  初始化一个子控制器
 *
 *  @param vc            子控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectImage 选中的图标
 */
- (void)setupChildVC:(UIViewController *)vc
              title:(NSString *)title
              image:(NSString *)image
      selectedIamge:(NSString *)selectImage{
    
//    vc.view.backgroundColor = BMRandomColor;
    //1.设置标题与图
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //2.添加子控制器
    BMNavigationController *navVC = [[BMNavigationController alloc] initWithRootViewController:vc];
 
    [self addChildViewController:navVC];
}


/**
 设置发布按钮
 */
- (void)setupPublishButton{
    
    BMTabBar *tabbar = [[BMTabBar alloc] init];
    tabbar.delegata = self;
    [self setValue:tabbar forKey:@"tabBar"];
    
}


#pragma mark - -------发布事件------- 



- (void)tabbar:(BMTabBar *)tabbar buttonClick:(UIButton *)button{
    BMPublishController *publishVC = [[BMPublishController alloc] init];
    [self presentViewController:publishVC animated:YES completion:nil];

}

- (void)publishAction:(UIButton *)sender{
    BMPublishController *publishVC = [[BMPublishController alloc] init];
    [self presentViewController:publishVC animated:YES completion:nil];

}


@end
