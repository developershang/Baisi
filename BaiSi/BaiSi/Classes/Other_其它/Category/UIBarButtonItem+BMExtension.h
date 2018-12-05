//
//  UIBarButtonItem+BMExtension.h
//  BaiSi
//
//  Created by developershang on 2017/5/17.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BMExtension)

+(instancetype)itemWithImageName:(NSString *)image
                       highLightImage:(NSString *)highImage
                               target:(id)target
                               action:(SEL)action;
@end
