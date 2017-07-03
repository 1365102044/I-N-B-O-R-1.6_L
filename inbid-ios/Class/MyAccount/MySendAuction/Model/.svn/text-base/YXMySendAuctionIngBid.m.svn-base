//
//  YXMySendAuctionIngBid.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySendAuctionIngBid.h"
#import "NSDate+YXExtension.h"

@implementation YXMySendAuctionIngBid
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
    _endTime = [NSDate dateStrFromCstampTime:endTime.longLongValue withDateFormat:@"YYYY/MM/dd HH:mm"];
}

- (void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100", [imgUrl componentsSeparatedByString:@"?"].firstObject];
}

@end
