//
//  YXMySendAuctionHoldTest.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySendAuctionHoldTest.h"
#import "YXMySendAuctionTimeList.h"
#import "NSDate+YXExtension.h"

@implementation YXMySendAuctionHoldTest

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"orderId" : @"id",
             @"timeList": @"logs"
             };
}

- (void)setCreateTime:(NSString *)createTime
{
    _createTime = [NSDate dateStrFromCstampTime:createTime.longLongValue withDateFormat:@"YYYY-MM-dd HH:mm"];
}

- (void)setTimeList:(NSArray *)timeList
{
    _timeList = [YXMySendAuctionTimeList mj_objectArrayWithKeyValuesArray:timeList];
}

- (void)setSuggestMoney:(NSInteger)suggestMoney
{
    _maxSuggestMoney = suggestMoney + suggestMoney * 0.3;
    _minSuggestMoney = suggestMoney * 0.7;
    _suggestMoney = suggestMoney;
}

- (void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100", [imgUrl componentsSeparatedByString:@"?"].firstObject];
}

@end
