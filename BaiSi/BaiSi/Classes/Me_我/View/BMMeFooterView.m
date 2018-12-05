//
//  BMMeFooterView.m
//  BaiSi
//
//  Created by developershang on 2017/5/18.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMMeFooterView.h"
#import "BMMeSquare.h"
#import "UIButton+WebCache.h"
#import "BMMeButton.h"


@interface BMMeFooterView ()

@property(nonatomic, strong)NSMutableArray *squares;

@end

@implementation BMMeFooterView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
      
       
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] =  @"square";
        params[@"c"] =  @"topic";
        [manager GET:BMCommonURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       // NSLog(@"请求成功：%@--",responseObject);
     //   [responseObject writeToFile:@"/Users/developershang/Desktop/me.plist" atomically:YES];
            
         NSMutableArray *squares =  [BMMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            self.squares = squares;
            [self setupButtonWith:squares];

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"请求失败0:%@--",error);
        }];
        
        
    }
    return self;
}


- (void)setupButtonWith:(NSArray *)squares{
    
    NSInteger count = squares.count;
    NSInteger clos  = 4;
    CGFloat margin = 0.0;
    CGFloat buttonW = (self.bm_width - margin *(clos - 1))/4;
    CGFloat buttonH = buttonW;
 
    for (NSInteger i = 0; i < count-1; i++) {
        BMMeSquare *square = squares[i];
        BMMeButton *btn = [[BMMeButton alloc] init];
        btn.tag = 100 + i;
        
        btn.bm_x = (buttonW + margin) *(i%clos);
        btn.bm_y = (buttonH + margin) *(i/clos);
        btn.bm_width = buttonW;
        btn.bm_height = buttonH;
        
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:square.name forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
       
        [btn addTarget:self action:@selector(squareClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        

    }
    
    self.bm_height = ((count - 1)/clos + 1 )*buttonH;
   // self.bm_height = self.subviews.lastObject.bm_bottomY;
    UITableView *table = (UITableView *)self.superview;
    [table reloadData];
    
}


- (void)squareClick:(UIButton *)button{
    
 
    
    if ([self.delegate respondsToSelector:@selector(footerView:didClickButton:atIndex:)]) {
        
        [self.delegate footerView:self didClickButton:button atIndex:button.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(footerView:didClickButtonModel:)]) {
         BMMeSquare *square = self.squares[button.tag - 100];
        [self.delegate footerView:self didClickButtonModel:square];
    }
    
}
@end
