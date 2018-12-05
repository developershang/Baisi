//
//  BMRefreshNormalHeader.m
//  BaiSi
//
//  Created by developershang on 2017/6/12.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMRefreshNormalHeader.h"

@interface BMRefreshNormalHeader ()
@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation BMRefreshNormalHeader

- (void)prepare{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.stateLabel.textColor = [UIColor orangeColor];
    
    
    [self setTitle:@"Idle loadData" forState:MJRefreshStateIdle];
    [self setTitle:@"Pull loadData" forState:MJRefreshStatePulling];
    [self setTitle:@"Loading loadData..." forState:MJRefreshStateRefreshing];
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baidu"]];
    [self addSubview:imgView];
     self.imageView = imgView;
     
}



- (void)placeSubviews{
    [super placeSubviews];
    
    self.imageView.bm_x = 0;
    self.imageView.bm_y = -100;
    self.imageView.bm_width = self.bm_width;
    self.imageView.bm_height = 100;
    
}

@end
