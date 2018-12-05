//
//  BMTopicCell.h
//  BaiSi
//
//  Created by developershang on 2017/6/12.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMTopic;


@interface BMTopicCell : UITableViewCell

/**帖子*/
@property(nonatomic, strong)BMTopic *topic;

/**最热评论*/
@property (weak, nonatomic) IBOutlet UIView *cmtView;

@end
