//
//  YXMySendAuctionEndBid.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySendAuctionEndBid.h"
#import "NSDate+YXExtension.h"

@implementation YXMySendAuctionEndBid
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"bidId" : @"id",
             };
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
