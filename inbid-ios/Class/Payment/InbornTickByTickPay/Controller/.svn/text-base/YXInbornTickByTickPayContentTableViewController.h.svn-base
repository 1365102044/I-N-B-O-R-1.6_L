//
//  YXInbornTickByTickPayContentTableViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/12/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXPaymentHomepageViewDataModel;
@class YXInbornTickByTickPayContentTableViewController;

@protocol YXInbornTickByTickPayContentTableViewControllerDelegate <NSObject>

/**
 点击事件

 @param inbornTickByTickPayContentTableViewController inbornTickByTickPayContentTableViewController
 @param sender 点击的按钮
 */
- (void)inbornTickByTickPayContentTableViewController:(YXInbornTickByTickPayContentTableViewController *)inbornTickByTickPayContentTableViewController
                                          clickButton:(UIButton *)sender;

@end

@interface YXInbornTickByTickPayContentTableViewController : UITableViewController

/**
 数据模型
 */
@property (nonatomic, strong) YXPaymentHomepageViewDataModel *dataModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXInbornTickByTickPayContentTableViewControllerDelegate> customDelegate;

/**
 当前输入金额输入框s
 */
@property (weak, nonatomic) IBOutlet UITextField *currentMoneyTextField;

@end
