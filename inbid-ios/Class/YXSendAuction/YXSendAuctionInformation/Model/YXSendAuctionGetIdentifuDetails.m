//
//  YXSendAuctionGetIdentifuDetails.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/11.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionGetIdentifuDetails.h"
#import "YXMySendAuctionTimeList.h"

@implementation YXSendAuctionGetIdentifuDetails

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"orderId" : @"id",
             @"timeList": @"logs"
             };
}

- (void)setTimeList:(NSArray *)timeList
{
    _timeList = [YXMySendAuctionTimeList mj_objectArrayWithKeyValuesArray:timeList];
}

- (void)setPics:(NSArray *)pics
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *imgUrlDic in pics) {
        
        [imgUrlDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            NSString *imgUrl = (NSString *)obj;
            [tempArray addObject: [NSString stringWithFormat:@"%@", [imgUrl componentsSeparatedByString:@"?"].firstObject]];
        }];
    }
    _pics = tempArray.copy;
}

@end
