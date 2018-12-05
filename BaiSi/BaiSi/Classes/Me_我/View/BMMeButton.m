//
//  BMMeButton.m
//  BaiSi
//
//  Created by developershang on 2017/5/19.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMMeButton.h"

@implementation BMMeButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.bm_y = self.bm_height *0.12;
    self.imageView.bm_height = self.bm_height *0.5;
    self.imageView.bm_width = self.imageView.bm_height;
    self.imageView.bm_centerX = self.bm_width *0.5;
    
    
    self.titleLabel.bm_x = 0;
    self.titleLabel.bm_y = self.imageView.bm_bottomY;
    self.titleLabel.bm_height = self.bm_height - self.titleLabel.bm_y;
    self.titleLabel.bm_width = self.bm_width;

    
}

@end
