//
//  YXAlipayManager.h
//  Payment
//
//  Created by 胤讯测试 on 16/12/2.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXPaymentHomepageViewDataModel;
@class YXSeverSignInformationModel;
@class YXAlipayManager;

@protocol YXAlipayManagerDelegate <NSObject>

/**
 支付结果回调

 @param alipayManager               支付宝管理者
 @param aliPayResult                支付宝支付结果
 */
- (void)alipayManager:(YXAlipayManager *)alipayManager andAliPayResult:(NSString *)aliPayResult;

@end

@interface YXAlipayManager : NSObject

/**
 服务器签名数据
 */
@property (nonatomic, strong) YXSeverSignInformationModel *signInformationModel;

/**
 支付宝代理
 */
@property (nonatomic, weak) id<YXAlipayManagerDelegate> delegate;

/**
 获取单利
 
 @return 对象
 */
+ (instancetype)sharedManager;
/**
 拼接参数，调用支付
 */
- (void)doAlipayPay:(YXPaymentHomepageViewDataModel*)OrderModle;
/**
 支付宝 支付 处理支付结果
 */
- (void)handleOpenURL:(NSURL *)url;


@end
