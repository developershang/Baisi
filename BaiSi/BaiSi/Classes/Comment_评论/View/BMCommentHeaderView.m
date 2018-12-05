//
//  BMCommentHeaderView.m
//  BaiSi
//
//  Created by developershang on 2017/6/27.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMCommentHeaderView.h"

@implementation BMCommentHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}
@end
