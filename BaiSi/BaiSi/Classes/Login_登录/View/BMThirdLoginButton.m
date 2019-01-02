//
//  BMThirdLoginButton.m
//  BaiSi
//
//  Created by developershang on 2017/5/18.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMThirdLoginButton.h"

@implementation BMThirdLoginButton

- (void)awakeFromNib{
    
    [super awakeFromNib];
  //   self.backgroundColor = BMRandomColor;
  //  self.imageView.backgroundColor = BMRandomColor;
  //  self.titleLabel.backgroundColor = BMRandomColor;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.bm_y = 0;
    self.imageView.bm_centerX = self.bm_width *0.5;
    self.titleLabel.bm_x = 0;
    self.titleLabel.bm_y = self.imageView.bm_bottomY;
    self.titleLabel.bm_height = self.bm_height - self.imageView.bm_height;
    self.titleLabel.bm_width = self.bm_width;
    
    
}
@end
