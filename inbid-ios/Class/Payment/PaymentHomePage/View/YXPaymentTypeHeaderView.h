//
//  YXPaymentTypeHeaderView.h
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXPaymentHomepageViewDataModel;

/**
 类型

 - YXPaymentTypeHeaderViewDetailHeader:             支付详情header
 - YXPaymentTypeHeaderViewPaymentTypeHeader:        支付方式header
 */
typedef NS_ENUM(NSUInteger, YXPaymentTypeHeaderViewType) {
    YXPaymentTypeHeaderViewDetailHeader,
    YXPaymentTypeHeaderViewPaymentTypeHeader,
};

@interface YXPaymentTypeHeaderView : UITableViewHeaderFooterView

/**
 类型
 */
@property (nonatomic, assign) YXPaymentTypeHeaderViewType type;

/**
 属性
 */
@property (nonatomic, strong) YXPaymentHomepageViewDataModel *baseModel;


@end
