//
//  BMMeFooterView.h
//  BaiSi
//
//  Created by developershang on 2017/5/18.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BMMeFooterView,BMMeSquare;

@protocol BMMeFooterViewdelegate <NSObject>

@optional

- (void)footerView:(BMMeFooterView *)footerView didClickButton:(UIButton*)button atIndex:(NSInteger)index;

- (void)footerView:(BMMeFooterView *)footerView didClickButtonModel:(BMMeSquare*)model;
@end


@interface BMMeFooterView : UIView

@property (nonatomic, assign)id<BMMeFooterViewdelegate>delegate;

@end
