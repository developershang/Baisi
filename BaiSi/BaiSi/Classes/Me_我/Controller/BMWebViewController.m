//
//  BMWebViewController.m
//  BaiSi
//
//  Created by developershang on 2017/5/19.
//  Copyright © 2017年 developershang. All rights reserved.
//

#import "BMWebViewController.h"

@interface BMWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Left;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Right;
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Refresh;


@end

@implementation BMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.automaticallyAdjustsScrollViewInsets = NO;
  // self.WebView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.WebView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (IBAction)LeftAction:(UIBarButtonItem *)sender {
    [self.WebView goBack];
}
- (IBAction)RightAction:(UIBarButtonItem *)sender {
    [self.WebView goForward];
}
- (IBAction)RefreshAction:(UIBarButtonItem *)sender {
    [self.WebView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.Left.enabled = webView.canGoBack;
    self.Right.enabled = webView.canGoForward;
    self.Refresh.enabled = YES;
    
}

@end
