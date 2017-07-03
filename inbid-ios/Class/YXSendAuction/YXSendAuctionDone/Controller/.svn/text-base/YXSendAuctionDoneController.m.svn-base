//
//  YXSendAuctionDoneController.m
//  YXSendAuction
//
//  Created by 郑键 on 16/9/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionDoneController.h"
#import "YXSendAuctionInformationController.h"
#import "YXNavigationController.h"
#import "YXHelpViewController.h"

@interface YXSendAuctionDoneController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipsTopCons;

@end

@implementation YXSendAuctionDoneController

#pragma mark - 响应事件

- (void)rightButtonClick:(UIButton *)sender
{
    YXHelpViewController *helpdeatilvc = [[YXHelpViewController alloc]init];
    helpdeatilvc.helpIndex = 13;
    [self.navigationController pushViewController:helpdeatilvc animated:YES];
}

- (IBAction)closeButtonClick:(id)sender
{
    YXSendAuctionInformationController *informationController = [YXSendAuctionInformationController new];
    informationController.sourceViewController = self;
    YXNavigationController *navigationController = [[YXNavigationController alloc] initWithRootViewController:informationController];

    [self presentViewController:navigationController animated:YES completion:^{
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}

/**
 关闭按钮点击事件
 
 @param sender 关闭按钮
 */
- (void)backButtonClick:(id)sender
{
    //** 抬起tabBar */
    self.tabBarController.tabBar.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.tabBarController.tabBar.y = [UIScreen mainScreen].bounds.size.height - self.tabBarController.tabBar.height;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"寄卖";
    
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setImage:[UIImage imageNamed:@"矩形-15-拷贝"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setImage:[UIImage imageNamed:@"ic_baozhengjinwenhao"] forState:UIControlStateNormal];
    [rightButton sizeToFit];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

/**
 视图已经离开

 @param animated animated
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.delegate respondsToSelector:@selector(sendAuctionDoneController:clearData:)]) {
        [self.delegate sendAuctionDoneController:self clearData:YES];
    }
}

@end
