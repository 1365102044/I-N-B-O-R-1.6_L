//
//  YXMySureMoneyModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySureMoneyModle.h"
#import "YXMySureMoneyNopaymentModle.h"

@implementation YXMySureMoneyModle
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"dataList" : @"data",
             };
}

- (void)setDataList:(NSArray *)dataList
{
    _dataList = [YXMySureMoneyNopaymentModle mj_objectArrayWithKeyValuesArray:dataList];
}

@end
