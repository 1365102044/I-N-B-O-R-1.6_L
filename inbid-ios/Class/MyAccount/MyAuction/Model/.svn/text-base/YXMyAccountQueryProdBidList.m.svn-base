//
//  YXMyAccountQueryProdBidList.m
//  MyAccount
//
//  Created by 郑键 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountQueryProdBidList.h"
#import "NSDate+YXExtension.h"

@implementation YXMyAccountQueryProdBidList

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"bidId" : @"id",
             };
}

- (NSTimeInterval)surplusBidTime
{
    if (!_surplusBidTime) {
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                NSDate *now = [dateformatter dateFromString:self.endTime];
//        NSDate *now = [dateformatter dateFromString:@"2016-09-28 16:06:40"];
        _surplusBidTime = [now timeIntervalSinceNow];
        
    }
    return _surplusBidTime;
}

- (void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200", [imgUrl componentsSeparatedByString:@"?"].firstObject];
}

@end
