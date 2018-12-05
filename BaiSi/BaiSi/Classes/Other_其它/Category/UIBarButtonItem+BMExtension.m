//
//  UIBarButtonItem+BMExtension.m
//  BaiSi
//
//  Created by developershang on 2017/5/17.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "UIBarButtonItem+BMExtension.h"

@implementation UIBarButtonItem (BMExtension)

+(instancetype)itemWithImageName:(NSString *)image
                       highLightImage:(NSString *)highImage
                               target:(id)target
                               action:(SEL)action{
    
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
    
}
@end
