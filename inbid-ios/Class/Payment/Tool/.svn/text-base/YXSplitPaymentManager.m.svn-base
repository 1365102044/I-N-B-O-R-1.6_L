//
//  YXSplitPaymentManager.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSplitPaymentManager.h"

@implementation YXSplitPaymentManager
+(instancetype)sharedSpliPayment
{
    static dispatch_once_t onceToken;
    static YXSplitPaymentManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YXSplitPaymentManager alloc]init];
    });
    return  instance;
}
/**
 获取预支付的 支付类型参数
 */
-(NSInteger)GetPrePaymentType:(NSString *)type
{
    NSInteger paytype ;
    //** TODO:测试代码 */
    if ([type isEqualToString:@"微信支付"]) {
        return 2;
    }else if ([type isEqualToString:@"支付宝支付"]) {
        return 3;
    }else if ([type isEqualToString:@"银联支付"]) {
        return 5;
    }else if ([type isEqualToString:@"Apple Pay"]) {
        return 4;
    }else{
        return 0;
    }
    
}

@end
