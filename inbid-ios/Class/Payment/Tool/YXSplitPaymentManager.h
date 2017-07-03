//
//  YXSplitPaymentManager.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXSplitPaymentManager : NSObject

+(instancetype)sharedSpliPayment;

-(NSInteger)GetPrePaymentType:(NSString *)type;

@end
