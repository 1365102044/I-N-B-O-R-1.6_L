//
//  YXMyAccountPaymentChooseTitleView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXMyAccountPaymentChooseTitleView : UIView
/*
 @brief 2 全额支付     1 分笔支付
 */
@property(nonatomic,assign) NSInteger  isPartPay;

/*
 @brief 已付金额
 */
@property(nonatomic,strong) NSString *  alearypaycount;


@end
