//
//  YXApplePayManager.h
//  inbid-ios
//
//  Created by 郑键 on 16/12/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLPaySdk.h"
@class YXSeverSignInformationModel;


typedef NS_ENUM(NSUInteger, YXApplePayManagerType) {
    YXApplePayManagerOrder,
    YXApplePayManagerAuth,
};


@protocol YXApplePayManagerDelegate <NSObject>
/**
 支付回调
 @param YXApplePayManager         YXApplePayManager
 @param resultCode              结果状态码
 */
- (void)ApplePayManager:(id)applePayManager andResltCode:(NSString *)resultCode;

@end




@interface YXApplePayManager : NSObject

/**
 代理
 */
@property (nonatomic, weak) id<YXApplePayManagerDelegate> delegate;

/**
 加密数据
 */
@property (nonatomic, strong) YXSeverSignInformationModel *severSignInformationModel;

/**
 开启apple pay
 */
+ (instancetype)startApplePayWithType:(YXApplePayManagerType)type
                        andController:(UIViewController *)viewController;

@end
