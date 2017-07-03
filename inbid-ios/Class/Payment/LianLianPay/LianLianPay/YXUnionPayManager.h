//
//  YXUnionPayManager.h
//  inbid-ios
//
//  Created by 郑键 on 16/12/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXSeverSignInformationModel;
@class YXUnionPayManager;

@protocol YXUnionPayManagerDelegate <NSObject>

/**
 支付回调

 @param unionPayManager         unionPayManager
 @param resultCode              结果状态码
 */
- (void)unionPayManager:(YXUnionPayManager *)unionPayManager
           andResltCode:(NSString *)resultCode;

@end

@interface YXUnionPayManager : NSObject

/**
 加密数据
 */
@property (nonatomic, strong) YXSeverSignInformationModel *severSignInformationModel;

/**
 开启apple pay
 */
+ (instancetype)startUnionPayWithController:(UIViewController *)viewController;

/**
 代理
 */
@property (nonatomic, weak) id<YXUnionPayManagerDelegate> delegate;

@end
