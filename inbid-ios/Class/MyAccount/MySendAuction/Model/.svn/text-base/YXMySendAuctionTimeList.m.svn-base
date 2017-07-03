//
//  YXMySendAuctionTimeList.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySendAuctionTimeList.h"
#import "NSDate+YXExtension.h"

@implementation YXMySendAuctionTimeList

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"timeListId" : @"id",
             };
}

- (void)setCreateTime:(NSString *)createTime
{
    _createTime = [NSDate dateStrFromCstampTime:createTime.longLongValue withDateFormat:@"YYYY-MM-dd HH:mm"];
}

@end
