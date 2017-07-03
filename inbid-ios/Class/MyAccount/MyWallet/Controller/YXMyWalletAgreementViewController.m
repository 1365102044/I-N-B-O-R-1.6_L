//
//  YXMyWalletAgreementViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/20.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyWalletAgreementViewController.h"
#import "YXMyWalletSetPassWordViewController.h"

#warning ===
#import "YXPerfectAccountInformationViewController.h"
#import "YXUploadIDPhotoViewController.h"
#import "YXMyWalletBankCardListViewController.h"

@interface YXMyWalletAgreementViewController ()
@property(nonatomic,strong) UIWebView * WebView;

@end

@implementation YXMyWalletAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"钱包服务协议";
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"payAccountAgreement" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.WebView loadHTMLString:html baseURL:nil];
    [self.view addSubview:self.WebView];
    
    
    if (!self.isHiddenBoobView) {
        [self setBoomView];
    }
    
}

-(void)clickNextBtn:(UIButton *)sender
{
    YXMyWalletSetPassWordViewController *wallet = [[YXMyWalletSetPassWordViewController alloc]init];
    [self.navigationController pushViewController:wallet animated:YES];
    
}

-(void)setBoomView{

    UIView *boomview = [[UIView alloc]initWithFrame:CGRectMake(0, YXScreenH-90, YXScreenW, 90)];
    boomview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:boomview];
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 5, YXScreenW-30, 50)];
    [nextBtn addTarget:self action:@selector(clickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = YXSFont(15);
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor mainThemColor];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = 4;
    [boomview addSubview:nextBtn];
    
    UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(15, nextBtn.bottom+8, YXScreenW-30, 15)];
    desc.text = @"点击下一步即同意钱包服务协议";
    desc.textColor = UIColorFromRGB(0x999999);
    desc.textAlignment = NSTextAlignmentCenter;
    desc.font = YXSFont(12);
    [boomview addSubview:desc];
    
}

-(UIWebView *)WebView{
    if (!_WebView) {
        CGFloat Hei = YXScreenH-90 ;
        if (self.isHiddenBoobView) {
            Hei =  YXScreenH;
        }
        _WebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, Hei)];
        _WebView.dataDetectorTypes = UIDataDetectorTypeAll;
        _WebView.backgroundColor = YXBackMainColor;
    }
    return _WebView;
}

@end
