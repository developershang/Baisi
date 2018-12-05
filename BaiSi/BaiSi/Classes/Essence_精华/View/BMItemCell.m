//
//  BMItemCell.m
//  BaiSi
//
//  Created by developershang on 2017/6/26.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMItemCell.h"
#import "BMItem.h"

@interface BMItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@end

@implementation BMItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)subscribtion:(UIButton *)sender {
    
    
}


- (void)setItem:(BMItem *)item{
    
    _item = item;
    
    // 头像
    UIImage *placeholder = [UIImage circleImage:@"defaultUserIcon"];
   [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:placeholder options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
      if (image == nil) return;
      self.iconView.image = [image circleImage];
       
   }];
    
    
    // 名字
    self.themeNameLabel.text = item.theme_name;
    
    // 订阅数
    if (item.sub_number >= 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", item.sub_number / 10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", item.sub_number];
    }
    
    
    
}


- (void)setFrame:(CGRect)frame{
    
    frame.size.height -=1;
    
    [super setFrame:frame];
    
}

@end
