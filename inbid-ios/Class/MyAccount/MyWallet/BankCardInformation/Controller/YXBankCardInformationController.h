//
//  YXBankCardInformationController.h
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 银行卡信息

 - YXBankCardInformationControllerNone:                     无类型
 - YXBankCardInformationControllerAddBankCard:              添加银行卡
 - YXBankCardInformationControllerCreditCardInformation:    信用卡信息
 - YXBankCardInformationControllerDebitCardInformation:     储蓄卡信息
 */
typedef NS_ENUM(NSUInteger, YXBankCardInformationControllerType) {
    YXBankCardInformationControllerNone,
    YXBankCardInformationControllerAddBankCard,
    YXBankCardInformationControllerCreditCardInformation,
    YXBankCardInformationControllerDebitCardInformation,
};

@interface YXBankCardInformationController : UIViewController

/**
 初始化方法

 @param type type           类型
 @param cardholderName      持卡人姓名
 @param cardNumber          卡号
 @param extend              扩展参数（传入1/2 1：pop到绑定银行卡的来源页 2：push到重置密码页面）
 @return                    对应类型的对象
 */
+ (instancetype)bankCardInformationControllerWithType:(YXBankCardInformationControllerType)type
                                       cardholderName:(NSString *)cardholderName
                                           cardNumber:(NSString *)cardNumber
                                               extend:(id)extend;

@end
