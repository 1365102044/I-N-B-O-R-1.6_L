//
//  YXInbornTickByTickPayViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/12/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXInbornTickByTickPayViewController;
@class YXPaymentHomepageViewDataModel;

@protocol YXInbornTickByTickPayViewControllerDelegate <NSObject>

/**
 完成分笔支付方式选择，金额填写
 
 @param inbornTickByTickPayView inbornTickByTickPayView     分笔支付界面
 @param paymentType paymentType                             支付方式
 @param moneyText moneyText                                 支付金额
 */
- (void)inbornTickByTickPayController:(YXInbornTickByTickPayViewController *)inbornTickByTickPayController
                 andPaymentType:(NSString *)paymentType
                   andMoneyText:(NSString *)moneyText;

@end

/**
 当前分笔状态
 
 - YXInbornTickByTickPayContinuePay: 胤宝分笔继续支付
 */
typedef NS_ENUM(NSUInteger, YXInbornTickByTickPayType) {
    YXInbornTickByTickPayContinuePay,
};

@interface YXInbornTickByTickPayViewController : UIViewController

/**
 代理
 */
@property (nonatomic, weak) id<YXInbornTickByTickPayViewControllerDelegate> delegate;

/**
 数据模型
 */
@property (nonatomic, strong) YXPaymentHomepageViewDataModel *dataModel;

@end
