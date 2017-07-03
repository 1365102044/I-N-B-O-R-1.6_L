//
//  YXMyAccoutBindBankCardViewController.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyAccoutBindBankCardViewController;

@protocol YXMyAccoutBindBankCardViewControllerDelegate <NSObject>

/**
 监听用户事件

 @param myAccoutBindBankCardViewController 验证银行卡控制器
 @param isRestPage                         开关
 */
- (void)myAccoutBindBankCardViewController:(YXMyAccoutBindBankCardViewController *)myAccoutBindBankCardViewController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXMyAccoutBindBankCardViewController : YXMainKeyBoaryViewController

@property(nonatomic,strong) NSString * bindbankStatus;

/**
 代理
 */
@property (nonatomic, weak) id<YXMyAccoutBindBankCardViewControllerDelegate> delegate;

@end
