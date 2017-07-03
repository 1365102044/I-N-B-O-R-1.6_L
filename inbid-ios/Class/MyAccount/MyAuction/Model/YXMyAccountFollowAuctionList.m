//
//  YXMyAccountFollowAuctionList.m
//  MyAccount
//
//  Created by 郑键 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountFollowAuctionList.h"

@implementation YXMyAccountFollowAuctionList

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"followId" : @"id",
             };
}

- (void)setStartTime:(NSString *)startTime
{
    _startTime = startTime;
}

- (void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200", [imgUrl componentsSeparatedByString:@"?"].firstObject];
}

@end
