//
//  YXSendAuctionImageManager.h
//  YXSendAuction
//
//  Created by 郑键 on 16/11/14.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXSendAuctionImageManager : NSObject

/**
 图片下标，递增，删除不减小
 */
@property (nonatomic, assign) NSInteger imageIndex;

/**
 生成订单成功id
 */
@property (nonatomic, copy) NSString *orderId;

/**
 获取图片管理单例

 @return return 单例对象
 */
+ (instancetype)defaultManager;

@end
