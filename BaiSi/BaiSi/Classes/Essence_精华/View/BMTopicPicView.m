//
//  BMTopicPicView.m
//  BaiSi
//
//  Created by developershang on 2017/6/21.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMTopicPicView.h"
#import "BMTopic.h"
#import "DALabeledCircularProgressView.h"
#import "BMSeeBigPicController.h"
@interface BMTopicPicView()


/**gif标识*/
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/**占位图*/
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**点击查看大图*/
@property (weak, nonatomic) IBOutlet UIButton *clickButton;
/**进度条*/
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation BMTopicPicView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.progressView.roundedCorners = 5;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
    [self.clickButton addTarget:self action:@selector(seeBig) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setTopic:(BMTopic *)topic{
    
    _topic = topic;
    

//    if ([topic.large_image.lowercaseString hasSuffix:@"gif"]);
//    if ([topic.large_image.pathExtension.lowercaseString isEqualToString:@"gif"]);
    self.placeholderView.hidden = YES;
    self.gifView.hidden = !topic.is_gif;
    self.clickButton.hidden = !topic.isbigPic;
    
    if (topic.isbigPic) {
        self.clickButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.clipsToBounds = YES;
        
        
    }else{
        self.clickButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.clipsToBounds = NO;
    }

    /*
 //网络状态判断
 AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
//    
//    if (status == AFNetworkReachabilityStatusReachableViaWWAN) {// 手机网络
//        
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.small_image]];
//        
//    }else if(status == AFNetworkReachabilityStatusReachableViaWiFi){//WiFi网络
//        
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
//    }else{
//        
//        self.imageView.image = nil;
//    }


   */

        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            self.progressView.hidden = NO;
            CGFloat progress = 1.0 * receivedSize / expectedSize;
            self.progressView.progress = progress;
            
            NSString *value = [NSString stringWithFormat:@"%0.f%%",progress *100];
            self.progressView.progressLabel.text = value;

        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            self.progressView.hidden = YES;
        }];
    
    
    
}


- (void)seeBig{
    
    BMSeeBigPicController *bigPicVC = [[BMSeeBigPicController alloc] init];
    bigPicVC.topic = self.topic;
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:bigPicVC animated:YES completion:nil];
    
}

@end
