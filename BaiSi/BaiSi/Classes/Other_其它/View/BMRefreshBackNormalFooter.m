//
//  BMRefreshBackNormalFooter.m
//  BaiSi
//
//  Created by developershang on 2017/6/12.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMRefreshBackNormalFooter.h"

@interface BMRefreshBackNormalFooter ()
@property (nonatomic, strong)UIImageView *imageView;

@end
@implementation BMRefreshBackNormalFooter

- (void)prepare{
    
    [super prepare];
    

    //- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;
    
    [self setTitle:@"Idle loadData" forState:MJRefreshStateIdle];
    [self setTitle:@"Pull loadData" forState:MJRefreshStatePulling];
    [self setTitle:@"Loading..." forState:MJRefreshStateRefreshing];
    self.stateLabel.textColor = [UIColor redColor];
    
   
    
    
    
    
    
    
}

- (void)placeSubviews{
    
    [super placeSubviews];
    

    
}
@end
