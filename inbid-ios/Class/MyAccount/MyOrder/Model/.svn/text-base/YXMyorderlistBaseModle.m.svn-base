//
//  YXMyorderlistBaseModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/28.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyorderlistBaseModle.h"
#import "YXOrderDetailBaseDataModel.h"
@implementation YXMyorderlistBaseModle

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"dataList" : @"data",
             };
}

- (void)setDataList:(NSArray *)dataList
{
    _dataList = [YXOrderDetailBaseDataModel mj_objectArrayWithKeyValuesArray:dataList];
}

@end
