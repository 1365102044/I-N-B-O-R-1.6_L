//
//  YXYmAccountPaymentUserInformationView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 @brief 添加地址
 */
typedef void(^addAddressBlock)();

typedef void(^userInformationHeightBlock)(CGFloat height);

@interface YXYmAccountPaymentUserInformationView : UIView

@property(nonatomic,copy) userInformationHeightBlock uerinformationheightblock;


@property(nonatomic,copy) addAddressBlock  addAdressblock;


/*
 @brief 2 全额支付     1 分笔支付
 */
@property(nonatomic,assign) NSInteger  isPartPay;

@property(nonatomic,strong) NSString * proname;

@property(nonatomic,strong) NSDictionary * dict;

@property(nonatomic,strong) NSDictionary * addressDict;

@end
