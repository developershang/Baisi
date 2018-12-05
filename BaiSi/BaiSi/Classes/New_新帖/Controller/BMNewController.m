//
//  BMNewController.m
//  BaiSi
//
//  Created by developershang on 2017/5/17.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMNewController.h"

#import "BMNewDeController.h"



@interface BMNewController ()<UIScrollViewDelegate>
{
    BOOL isBtnClick;
}
/**数据*/
@property (nonatomic, strong)NSArray *dataArr;
/**按钮bar*/
@property (nonatomic, weak)UIScrollView *toolbar;
/**选中按钮*/
@property (nonatomic, weak)UIButton *selectBtn;
/**指示剂*/
@property (nonatomic, weak)UIView *lineView;
/**内容视图*/
@property (nonatomic, weak)UIScrollView *contentView;

@end

@implementation BMNewController


#pragma mark - 1.懒加载

- (NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr =  @[@"推荐",@"视频",@"图片",@"段子",@"语音",@"互动区",@"网红",@"社会",@"投片",@"美女",@"冷知识",@"游戏",@"萌宠"];
    }
    return _dataArr;
}



#pragma mark - 2.初始化

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupChildVC];
    
    [self addContentView];
    
    [self addToolBar];
    
    
}

- (void)setupNav{

    
     self.view.backgroundColor = BMColor(230, 230, 230);
     self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highLightImage:@"MainTagSubIconClick" target:self action:nil];
    self.navigationItem.leftBarButtonItem = item;
    
    
}

- (void)setupChildVC{
    
    for (NSInteger i = 0; i<self.dataArr.count; i++) {
        
        BMNewDeController *NewDeVC = [[BMNewDeController alloc] init];
        switch (i) {
            case 0:{NewDeVC.topicType = BMTopicTypeAll; }break;
            case 1:{NewDeVC.topicType = BMTopicTypeVedio; }break;
            case 2:{NewDeVC.topicType = BMTopicTypePic; }break;
            case 3:{NewDeVC.topicType = BMTopicTypeWord; }break;
            case 4:{NewDeVC.topicType = BMTopicTypeVoice; }break;
            default:{NewDeVC.topicType = BMTopicTypeAll; }break;
        }
       [self addChildViewController:NewDeVC];
        
    }
    
}


#pragma mark - 3.添加消息分类工具条

- (void)addToolBar{
    //添加工具条
    UIScrollView *toolbar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bm_width, 35)];
    self.toolbar = toolbar;
    toolbar.backgroundColor = BMColor(253, 49, 89);
    
    toolbar.tag = 10;
    toolbar.delegate = self;
    toolbar.showsHorizontalScrollIndicator = NO;
    NSUInteger count = self.childViewControllers.count;
    CGFloat varW = 80 *([UIScreen mainScreen].bounds.size.width) / 414;
    toolbar.contentSize = CGSizeMake(varW *count, toolbar.bm_height);
    [self.view addSubview:toolbar];
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + 100;
        [btn setTitle:self.dataArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:BMColor(200, 200, 200) forState:UIControlStateNormal];
        // [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        btn.center = CGPointMake(varW * 0.5 + varW * i, toolbar.bm_height * 0.5);
        [toolbar addSubview:btn];
    }
    
    //添加指示剂
    UIView *lineView = [[UIView alloc] init];
    lineView.bm_height = 2;
    lineView.bm_width = 40;
    lineView.bm_y = toolbar.bm_height - 2.2;
    lineView.backgroundColor = [UIColor whiteColor];
    [toolbar addSubview:lineView];
    self.lineView = lineView;
    UIButton *btn = (UIButton*)[toolbar viewWithTag:100];
    isBtnClick = YES;
    [self btnAction:btn];
    
}

- (void)addContentView{
    
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    contentView.backgroundColor = BMColor(240, 240, 240);
    self.contentView = contentView;
    [self.view addSubview:contentView];
    contentView.tag = 21;
    contentView.delegate = self;
    NSInteger count = self.childViewControllers.count;
    contentView.contentSize = CGSizeMake(self.view.bm_width * count, self.view.bm_height);
    contentView.pagingEnabled = YES;
    [self.view bringSubviewToFront:self.toolbar];
    
}



#pragma mark - 4.<UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
        if (scrollView.tag ==21) {
            isBtnClick = NO;
            NSInteger count = (int)scrollView.contentOffset.x/self.view.bm_width;
            UIButton *button = (UIButton *)[self.toolbar viewWithTag:count + 100];
            [self btnAction:button];
            
        }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
 if (scrollView.tag == 21) {
           
   NSInteger count = (int)scrollView.contentOffset.x/self.view.bm_width;
    // 4. 添加子控制器的View
    UITableView *tabView = (UITableView *)self.childViewControllers[count].view;
    if (tabView.superview) return;
    tabView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    tabView.bm_x = self.view.bm_width *count;
    tabView.bm_y = 0;
    tabView.bm_width = self.view.bm_width;
    tabView.bm_height = self.view.bm_height;
    [self.contentView addSubview:tabView];
     
    }
}



#pragma mark - 5.按钮事件

- (void)btnAction:(UIButton *)button{

    //1.恢复上一个button的设置
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.selectBtn.selected = NO;
    
    //2.设置新的button的大小 样式
    CGSize size = [button.currentTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    button.selected = YES;
    self.selectBtn = button;
    
    //3.设置scrollview的偏移量 和 lineView的偏移量
    NSInteger tag = button.tag - 100;
    [UIView animateWithDuration:0.2 animations:^{
        // 3.1 contentView 偏移量
        if (isBtnClick) {
          self.contentView.contentOffset = CGPointMake(self.view.bm_width * tag, 0);
        }
     
        
        // 3.2 button字体颜色设定
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button sizeToFit];
        
        // 3.3 lineView 偏移 宽度
        self.lineView.bm_width = size.width;
        self.lineView.bm_centerX = button.bm_centerX;
        
        // 3.4 lineViewScrollView  偏移计算
        CGFloat offset =  button.bm_centerX - self.view.bm_width *0.5;
        CGFloat offset1 = button.bm_centerX + self.view.bm_width *0.5;
        CGFloat offset2 = self.toolbar.contentSize.width - self.toolbar.bm_width;
        if (offset < 0) {
            
            
            self.toolbar.contentOffset = CGPointMake(0 , 0);
            
        }else{
            
            if (offset1 > self.toolbar.contentSize.width) {
                
                self.toolbar.contentOffset = CGPointMake(offset2 , 0);
                
            }else{
                
                self.toolbar.contentOffset = CGPointMake(offset , 0);
                
            }
            
        }
        
        
    }];
    
    if (isBtnClick) {
        
        // 4. 添加子控制器的View
        UITableView *tabView = (UITableView *)self.childViewControllers[tag].view;
        if (tabView.superview) return;
        tabView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
        tabView.bm_x = self.view.bm_width *tag;
        tabView.bm_y = 0;
        tabView.bm_width = self.view.bm_width;
        tabView.bm_height = self.view.bm_height;
        [self.contentView addSubview:tabView];
        
    }else{
        
        isBtnClick = YES;
    }
   
    
}


@end
