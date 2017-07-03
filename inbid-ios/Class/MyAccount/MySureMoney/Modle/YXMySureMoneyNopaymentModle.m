//
//  YXMySureMoneyNopaymentModle.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySureMoneyNopaymentModle.h"

@implementation YXMySureMoneyNopaymentModle
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"NopaymentId" : @"id",
             };
}
-(void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100", [imgUrl componentsSeparatedByString:@"?"].firstObject];
}
@end
