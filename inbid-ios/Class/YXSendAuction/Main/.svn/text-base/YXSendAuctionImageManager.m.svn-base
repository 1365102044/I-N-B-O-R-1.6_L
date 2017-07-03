//
//  YXSendAuctionImageManager.m
//  YXSendAuction
//
//  Created by 郑键 on 16/11/14.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXSendAuctionImageManager.h"

@implementation YXSendAuctionImageManager

+ (instancetype)defaultManager {
    
    static YXSendAuctionImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

@end
