//
//  YXPlatformRecoveryController.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXOrderDetailModel;
@class YXPlatformRecoveryController;
@class YXAppraisaReportIdentifyModel;

@protocol YXPlatformRecoveryControllerDelegate <NSObject>

/**
 监听用户点击事件

 @param platformRecoveryController 平台回收控制器
 @param isRestPage                 开关
 */
- (void)platformRecoveryController:(YXPlatformRecoveryController *)platformRecoveryController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXPlatformRecoveryController : UIViewController

/**
 等待鉴定数据
 */
@property (nonatomic, strong) YXOrderDetailModel *orderDetailModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXPlatformRecoveryControllerDelegate> delegate;

/**
 鉴定结果数据
 */
@property (nonatomic, strong) YXAppraisaReportIdentifyModel *appraisaReportIdentifyModel;

/**
 当前种类 一口价
 */
@property (nonatomic, copy) NSString *type;

@end
