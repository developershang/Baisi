//
//  BMComment.m
//  BaiSi
//
//  Created by developershang on 2017/6/15.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMComment.h"

@implementation BMComment
/** 返回数据中的属性名字的替换 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}


- (CGFloat)cellHeight{
    
    // 如果cell的高度已经计算过, 就直接返回
    if (_cellHeight) return _cellHeight;

    _cellHeight = 40;
    
    CGSize size1 =[self.content stringSizeWithfont:[UIFont systemFontOfSize:15] maxW:(BMScreenWidth - 58.0)];
        
    _cellHeight +=  size1.height;
    
    // 分割线
    _cellHeight += BMMargin;
    return _cellHeight;
    
    
}

@end
