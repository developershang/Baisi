//
//  BMTopicVideoView.m
//  BaiSi
//
//  Created by developershang on 2017/6/21.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMTopicVideoView.h"
#import "BMTopic.h"
#import "BMSeeBigPicController.h"
@interface BMTopicVideoView ()
/**占位图*/
@property (weak, nonatomic) IBOutlet UIImageView *placeholer;
/**播放次数Label*/
@property (weak, nonatomic) IBOutlet UILabel *playLabel;
/**时长Label*/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/**播放按钮*/
@property (weak, nonatomic) IBOutlet UIButton *playButton;
/**视频图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation BMTopicVideoView


- (void)awakeFromNib{
    [super awakeFromNib];
    // xib 设置的注意这个会随父控件改变宽度高度 导致设置的不生效 所以得设置一下
    // 类名记得更改 否则次方法不调用
    self.autoresizingMask = UIViewAutoresizingNone;
    self.playLabel.hidden = YES;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
    
}

- (void)setTopic:(BMTopic *)topic{
    
    _topic = topic;
 
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.small_image]];
}
- (void)seeBig{
    
    BMSeeBigPicController *bigPicVC = [[BMSeeBigPicController alloc] init];
    bigPicVC.topic = self.topic;
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:bigPicVC animated:YES completion:nil];
    
}
- (IBAction)VedioAction:(UIButton *)sender {

    
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    AVPlayer *player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.topic.videouri]];
    controller.player = player;
    [controller.player play];
    [self.getCurrentVC presentViewController:controller animated:YES completion:nil];

    
}


@end
