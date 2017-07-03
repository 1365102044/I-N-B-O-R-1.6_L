//
//  YXInbornTickByTickPayViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/12/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXInbornTickByTickPayViewController.h"
#import "YXInbornTickByTickPayContentTableViewController.h"
#import "YXPaymentHomepageViewDataModel.h"
#import "YXChatViewManger.h"

@interface YXInbornTickByTickPayViewController () <YXInbornTickByTickPayContentTableViewControllerDelegate>

/**
 内容控制器
 */
@property (nonatomic, weak) YXInbornTickByTickPayContentTableViewController *contentTableViewController;

@end

@implementation YXInbornTickByTickPayViewController

/**
 获取内容控制器

 @param segue           segue
 @param sender          sender
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    _contentTableViewController                 = segue.destinationViewController;
    _contentTableViewController.dataModel       = self.dataModel;
    _contentTableViewController.customDelegate  = self;
}

#pragma mark - Zero.Const

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

-(void)ClickNews
{
    [[YXChatViewManger sharedChatviewManger] LoadChatView];
    [[YXChatViewManger sharedChatviewManger] presentMQChatViewControllerInViewController:self];
}

#pragma mark - Fourth.代理方法

#pragma mark <YXInbornTickByTickPayContentTableViewControllerDelegate>

/**
 打开第三方支付按钮

 @param inbornTickByTickPayContentTableViewController inbornTickByTickPayContentTableViewController
 @param sender 按钮
 */
- (void)inbornTickByTickPayContentTableViewController:(YXInbornTickByTickPayContentTableViewController *)inbornTickByTickPayContentTableViewController
                                          clickButton:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(inbornTickByTickPayController:andPaymentType:andMoneyText:)]) {
        [_delegate inbornTickByTickPayController:self
                                  andPaymentType:self.dataModel.paymentTypeString
                                    andMoneyText:[NSString stringWithFormat:@"%lld", self.contentTableViewController.currentMoneyTextField.text.longLongValue]];
//        [_delegate inbornTickByTickPayController:self
//                                  andPaymentType:self.dataModel.paymentTypeString
//                                    andMoneyText:[NSString stringWithFormat:@"%lld", self.contentTableViewController.currentMoneyTextField.text.longLongValue]];
    }
}

#pragma mark - Fifth.控制器生命周期

/**
 视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets       = NO;
    self.title                                      = @"确认分笔支付";
    [self setNavRightItems];
}

#pragma mark - Sixth.界面配置

/**
 添加消息item
 */
-(void)setNavRightItems
{
    UIButton *Rightbtn                          = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    Rightbtn.imageEdgeInsets                    = UIEdgeInsetsMake(0, 0, 0, -20);
    UIBarButtonItem *rightitem                  = [[UIBarButtonItem alloc]initWithCustomView:Rightbtn];
    self.navigationItem.rightBarButtonItem      = rightitem;
    [Rightbtn setImage:[UIImage imageNamed:@"ico_payNews"] forState:UIControlStateNormal];
    [Rightbtn addTarget:self action:@selector(ClickNews) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - Seventh.懒加载

@end
