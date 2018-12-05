//
//  BMTopicVoiceView.m
//  BaiSi
//
//  Created by developershang on 2017/6/21.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMTopicVoiceView.h"
#import "BMTopic.h"
#import "BMSeeBigPicController.h"
@interface BMTopicVoiceView ()
/**占位图*/
@property (weak, nonatomic) IBOutlet UIImageView *placeholer;
/**播放次数Label*/
@property (weak, nonatomic) IBOutlet UILabel *playLabel;
/**时长Label*/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/**播放按钮*/
@property (weak, nonatomic) IBOutlet UIButton *playButton;
/**音频图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation BMTopicVoiceView


- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
}


- (void)setTopic:(BMTopic *)topic{
    
    _topic = topic;

    self.playLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.small_image]];
}
- (void)seeBig{
    
    BMSeeBigPicController *bigPicVC = [[BMSeeBigPicController alloc] init];
    bigPicVC.topic = self.topic;
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:bigPicVC animated:YES completion:nil];
    
}
@end
