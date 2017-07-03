//
//  YXPiceuppersonbasemodle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPiceuppersonbasemodle.h"

#import "YXPickUpPersonListModle.h"

@implementation YXPiceuppersonbasemodle
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"dataList" : @"data",
             };
}
- (void)setDataList:(NSArray *)dataList
{
    _dataList = [YXPickUpPersonListModle mj_objectArrayWithKeyValuesArray:dataList];
}

@end
