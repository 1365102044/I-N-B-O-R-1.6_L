//
//  YXHaveBanKModle.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHaveBanKModle : NSObject

@property(nonatomic,copy) NSString * bankCardType;

@property(nonatomic,copy) NSString * bankCardNo;

@property(nonatomic,copy) NSString * idCard;

@property(nonatomic,copy) NSString * name;

@property(nonatomic,copy) NSString * refundBankId;

@property(nonatomic,assign) NSInteger  success;


/**
 在提交退款申请后 返回的时间处理
 */
@property(nonatomic,copy) NSString * refundDays;

@property(nonatomic,copy) NSString * refundDealDays;

@property(nonatomic,copy) NSString * refundWorkDays;

@end
