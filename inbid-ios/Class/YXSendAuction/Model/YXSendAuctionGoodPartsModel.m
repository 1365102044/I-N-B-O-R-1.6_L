//
//  YXSendAuctionGoodPartsModel.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/16.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionGoodPartsModel.h"

@implementation YXSendAuctionGoodPartsModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"partId" : @"id",
             @"partDescription" : @"description",
             };
}

@end
