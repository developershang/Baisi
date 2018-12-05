//
//  BMTopicCell.m
//  BaiSi
//
//  Created by developershang on 2017/6/12.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMTopicCell.h"
#import "BMTopic.h"
#import "BMComment.h"
#import "BMUser.h"



#import "BMTopicPicView.h"
#import "BMTopicVoiceView.h"
#import "BMTopicVideoView.h"
#import "BMCommentController.h"
@interface BMTopicCell ()<UIAlertViewDelegate>


/**Topic头像*/
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

/**Topic名字*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**vip内容*/
@property (weak, nonatomic) IBOutlet UIImageView *vipView;
/**皇冠vip内容*/
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;


/**Topic时间*/
@property (weak, nonatomic) IBOutlet UILabel *creatAtLabel;

/**Topic内容*/
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
/**按钮工具条*/
@property (weak, nonatomic) IBOutlet UIView *bottomview;


/**最热评论内容*/
@property (weak, nonatomic) IBOutlet UILabel *cmtLabel;

/**底部ding*/
@property (weak, nonatomic) IBOutlet UIButton *ding;
/**底部cai*/
@property (weak, nonatomic) IBOutlet UIButton *cai;
/**底部repost*/
@property (weak, nonatomic) IBOutlet UIButton *share;
/**底部common*/
@property (weak, nonatomic) IBOutlet UIButton *common;
/**最热评论文本上间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopConstraint;
/**最热评论文本下间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottomConstraint;
/**CmtView下间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CmtConstraint;

/**图片视图*/
@property (nonatomic, weak)BMTopicPicView *picView;
/**语音视图*/
@property (nonatomic, weak)BMTopicVoiceView *voiceView;
/**视频视图*/
@property (nonatomic, weak)BMTopicVideoView *videoView;


@end

@implementation BMTopicCell



#pragma mark - 懒加载

/**图片视图*/
- (BMTopicPicView *)picView{
    
    if (!_picView) {
        _picView = [BMTopicPicView viewFromXib];
        [self.contentView addSubview:_picView];
    }
    return _picView;
    
}

/**声音视图*/
- (BMTopicVoiceView *)voiceView{
    if (_voiceView == nil) {
        _voiceView = [BMTopicVoiceView viewFromXib];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

/**视频视图*/
- (BMTopicVideoView *)videoView{
    
    if (_videoView == nil) {
        _videoView = [BMTopicVideoView viewFromXib];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}







- (void)awakeFromNib{
    
    [super awakeFromNib];
    // self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];

}


#pragma mark - 模型数据添加

- (void)setTopic:(BMTopic *)topic{
    
    _topic = topic;
    [topic cellHeight];
   
        
        //1.图像设置
      UIImage *placeholder = [UIImage circleImage:@"defaultUserIcon"];
    
      [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
          
          if (image == nil) return ;
          self.profileImageView.image = [image circleImage];
          
      }];
    
    //2.名字设置
    self.nameLabel.text = topic.name;
    [self.nameLabel sizeToFit];
    
 
 
    //3.名字,vip 设置
   if (topic.top_cmt.count >0) {
       
#warning here setvipImageView Wrong  这里设置图标出现问题
       self.vipImageView.hidden = NO;
       self.vipView.hidden = NO;
       self.nameLabel.textColor = [UIColor redColor];
        
       
       
    }else{
        
        self.vipImageView.hidden = YES;
        self.vipView.hidden = YES;
        self.nameLabel.textColor = BMColor(71, 116, 166);
    }

    //4.时间设置
    self.creatAtLabel.text = topic.created_at;
    [self.creatAtLabel sizeToFit];
    

    //4.文本设置
    self.text_Label.text = topic.text;
    
    switch (topic.type) {
        case BMTopicTypeWord:{//NSLog(@"文本");
            self.picView.hidden = YES;
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            
        }break;
        case BMTopicTypePic:{ //NSLog(@"图片");
            self.picView.hidden = NO;
            self.picView.frame = topic.contentF;
            self.picView.topic = topic;
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            
        }break;
        case BMTopicTypeVoice:{//NSLog(@"语音");
            self.picView.hidden = YES;
            self.voiceView.hidden = NO;
            self.voiceView.frame = topic.contentF;
            self.voiceView.topic = topic;
            self.videoView.hidden = YES;
            
        }break;
        case BMTopicTypeVedio:{//NSLog(@"视频");
            self.picView.hidden = YES;
            self.voiceView.hidden = YES;
            self.videoView.hidden = NO;
            self.videoView.frame = topic.contentF;
            self.videoView.topic = topic;
            
        }break;
        default:
            break;
    }
    
    //5.最热评论设置
    if (topic.top_cmt.count > 0) {
        self.cmtView.hidden = NO;
        BMComment *comment = topic.top_cmt.firstObject;
        NSString *username = comment.user.username;
        NSString *content =  comment.content;
        self.cmtLabel.text = [NSString stringWithFormat:@"%@: %@",username,content];
        self.TopConstraint.constant= 5;
        self.BottomConstraint.constant= 5;
        self.CmtConstraint.constant = 10;
        
    }else{
        self.cmtLabel.text = nil;
        self.TopConstraint.constant= 0;
        self.BottomConstraint.constant= 0;
        self.CmtConstraint.constant = 0;
        self.cmtView.hidden = YES;
       
    }

    

    // 6.底部点赞 踩设置
    
    self.ding.selected = NO;
    self.cai.selected = NO;
    self.share.selected = NO;
    self.common.selected= NO;
    
    
    [self setButton:self.ding number:topic.ding place:@"顶"];
    [self setButton:self.cai number:topic.cai place:@"踩" ];
    [self setButton:self.share number:topic.repost place:@"分享"];
    [self setButton:self.common number:topic.comment place:@"评论"];
    

}


- (void)setButton:(UIButton *)button
            number:(NSInteger)count
            place:(NSString *)title{
    
  
    NSString *number = count>10000?[NSString stringWithFormat:@"%.1f万",count/10000.0]:[NSString stringWithFormat:@"%ld",(long)count];

    count == 0 ? [button setTitle:title forState:UIControlStateNormal]: [button setTitle:number forState:UIControlStateNormal];

}




#pragma mark - 设置cell的边距 分割线

- (void)setFrame:(CGRect)frame{
    
//    frame.origin.x +=10;
//    frame.size.width -=20;
      frame.size.height -= BMCellSeperateMargin;
//    frame.origin.y += 1;
    
    [super setFrame:frame];
}


#pragma mark - 右侧点击事件

- (IBAction)clickAction:(UIButton *)sender {
    
    if (iOSVersion > 9.0) {
        
        
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
        
        
       NSArray *titles = @[@"色情",@"广告",@"政治",@"抄袭",@"其他"];
       for (NSInteger i = 0; i <titles.count; i++) {
            
            [alertVC addAction:[UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            //    NSLog(@"%@",action.title);
                
            }]];
         }
      [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
      [self.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
        
        
    }else{
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"色情",@"广告",@"政治",@"抄袭",@"其他", nil];
        [alert show];
        
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"button :%ld--%@",(long)buttonIndex,alertView.title);
}


- (IBAction)dingAction:(UIButton *)sender {
    
    if (sender.selected)return;
    if (self.cai.selected == YES) return;
    

    
}
- (IBAction)caiAction:(UIButton *)sender {
   
   if (sender.selected)return;
   if (self.ding.selected == YES) return;
    

    
    
}
- (IBAction)shareAction:(UIButton *)sender {

    
       [[NSNotificationCenter defaultCenter] postNotificationName:BMMaincellShareButtonDidClickNotifiction object:self.topic];

    
}
- (IBAction)commonAction:(UIButton *)sender {
    
    
    
    if ([self.getCurrentVC isKindOfClass:[BMCommentController class]]) return;
    
    BMCommentController *commentVC = [[BMCommentController alloc] init];
    commentVC.topic = self.topic;
    [self.getCurrentVC.navigationController pushViewController:commentVC animated:YES];

}






@end
