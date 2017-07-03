//
//  YXNewsBaseModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNewsBaseModle.h"
#import "YXNewsEnsureNotiListModle.h"

@implementation YXNewsBaseModle
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"dataList" : @"data",
             };
}

- (void)setDataList:(NSArray *)dataList
{
    _dataList = [YXNewsEnsureNotiListModle mj_objectArrayWithKeyValuesArray:dataList];
}

@end
