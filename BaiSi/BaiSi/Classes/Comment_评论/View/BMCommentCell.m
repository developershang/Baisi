//
//  BMCommentCell.m
//  BaiSi
//
//  Created by developershang on 2017/6/27.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMCommentCell.h"
#import "BMComment.h"
#import "BMUser.h"
@interface BMCommentCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@property (weak, nonatomic) IBOutlet UILabel *DistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *caiCountLabel;
@end

@implementation BMCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.usernameLabel.textColor = BMColor(71, 116, 166);
    self.DistanceLabel.layer.masksToBounds = YES;
    self.DistanceLabel.layer.cornerRadius = 3;
}



- (void)setComment:(BMComment *)comment{
    
    _comment = comment;
    self.usernameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    self.caiCountLabel.text = [NSString stringWithFormat:@"%zd",arc4random_uniform(100)];
    
    UIImage *placeholder = [UIImage circleImage:@"defaultUserIcon"];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (image == nil) return;
        
        self.profileImageView.image = [image circleImage];
    }];
    
    NSString *sexImageName = [comment.user.sex isEqualToString:@"m"] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image =  [UIImage imageNamed:sexImageName];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
    
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 0.8;
    [super setFrame:frame];
 
}

@end


