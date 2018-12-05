//
//  BMTestCell.m
//  BaiSi
//
//  Created by developershang on 2017/5/20.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMTestCell.h"

@implementation BMTestCell



+ (BMTestCell *)dequeueCellWithtableView:(UITableView *)table{
    
    static NSString *reuseID = @"BMTestCellID";
    
    BMTestCell *cell = [table dequeueReusableCellWithIdentifier:reuseID];
    
    if (cell == nil) {
        cell = [[BMTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor blackColor];
        
        
        
    }
    
    return cell;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
