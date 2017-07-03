//
//  YXSendAuctionAgreementViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/25.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionAgreementViewController.h"

#define MYBUNDLE_NAME_2   @"ImageResourceBundle.bundle"
#define MYBUNDLE_PATH_2   [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME_2]

@interface YXSendAuctionAgreementViewController ()

/**
 内容视图
 */
@property (nonatomic, strong) UIScrollView *contentScrollView;

/**
 协议内容图片视图
 */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation YXSendAuctionAgreementViewController

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.控制器生命周期

/**
 加载视图
 */
- (void)loadView
{
    self.view = self.contentScrollView;
}

/**
 视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"胤宝售卖服务协议";
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_contentScrollView addSubview:self.imageView];
        _contentScrollView.contentSize = self.imageView.bounds.size;
    }
    return _contentScrollView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImage *contenImage = [UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent: @"胤宝商品售卖协议"]];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, contenImage.size.height / contenImage.size.width * [UIScreen mainScreen].bounds.size.width)];
        _imageView.image = contenImage;
    }
    return _imageView;
}

@end
