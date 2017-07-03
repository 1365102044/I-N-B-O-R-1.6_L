//
//  YXMyAccountQueryProdOverList.m
//  MyAccount
//
//  Created by 郑键 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountQueryProdOverList.h"
#import "NSDate+YXExtension.h"

@implementation YXMyAccountQueryProdOverList

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"bidId" : @"id",
             };
}

- (void)setStartTime:(NSString *)startTime
{
    _startTime = [NSDate dateStrFromCstampTime:startTime.longLongValue withDateFormat:@"YYYY/MM/dd HH:mm"];
}

- (void)setEndTime:(NSString *)endTime
{
    
//    _endTime = [NSDate dateStrFromCstampTime:endTime.integerValue withDateFormat:@"YYYY/MM/dd HH:mm"];
    _endTime = [NSDate dataStrFromDataStr:endTime withDateFormat:@"YYYY/MM/dd HH:mm"];
}

- (void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200", [imgUrl componentsSeparatedByString:@"?"].firstObject];
}

@end
