//
//  BMMeCell.m
//  BaiSi
//
//  Created by developershang on 2017/5/18.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMMeCell.h"

@implementation BMMeCell


+ (BMMeCell *)dequeueCellWithtableView:(UITableView *)table{
    
    static NSString *reuseID = @"BMMeCellID";
    
    BMMeCell *cell = [table dequeueReusableCellWithIdentifier:reuseID];
    
    if (cell == nil) {
        cell = [[BMMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
     
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor blackColor];
    }

    return cell;

}


@end
