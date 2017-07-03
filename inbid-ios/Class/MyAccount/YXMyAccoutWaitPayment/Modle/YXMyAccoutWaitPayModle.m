//
//  YXMyAccoutWaitPayModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccoutWaitPayModle.h"

@implementation YXMyAccoutWaitPayModle
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"orderID" : @"id",
             };
}
@end
