//
//  YXHelpViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/12.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHelpViewController.h"
#import "YXMySearchBtn.h"
#import  "MQChatViewManager.h"
#import "YXChatViewManger.h"
#define HELPCELLID @"helpcell"

#import "YXMyAccountMainViewController.h"

@interface YXHelpViewController ()<UIWebViewDelegate>



@property(nonatomic,strong) UIWebView * helpWebView;
@end

@implementation YXHelpViewController



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}



- (void)loadView
{
    self.helpWebView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.helpWebView.delegate = self;
    self.view = self.helpWebView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"帮助中心";
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    
    NSString *URL ;
    if (self.helpIndex) {
        
        URL = [NSString stringWithFormat:@"%@/helpCenter.html?md=%ld&iosAndr=headerTrue#index-%ld",kHELP_URL,(long)self.helpIndex, (long)self.helpIndex];
    }else{

        URL = [NSString stringWithFormat:@"%@/helpCenter.html?iosAndr=headerTrue",kHELP_URL];

    }
    NSURL *url = [NSURL URLWithString:URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.helpWebView loadRequest:request];
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [YXNetworkHUD show];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *state  = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    if ([state isEqualToString:@"complete"]) {
        [YXNetworkHUD dismiss];
    }
}
@end
