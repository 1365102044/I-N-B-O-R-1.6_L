//
//  YXSendAuctionConsignmentPlatformController.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXAppraisaReportIdentifyModel;
@class YXSendAuctionConsignmentPlatformController;

/**
 当前界面加载数据类型

 - kYXSendAuctionConsignmentPlatformControllerLoadReConsignment: kYXSendAuctionConsignmentPlatformControllerLoadReConsignment 一口价流拍后
 - kYXSendAuctionConsignmentPlatformControllerLoadConsignment:   kYXSendAuctionConsignmentPlatformControllerLoadConsignment   设置一口价
 */
typedef NS_ENUM(NSUInteger, kYXSendAuctionConsignmentPlatformControllerLoadDataType) {
    kYXSendAuctionConsignmentPlatformControllerLoadReConsignment,
    kYXSendAuctionConsignmentPlatformControllerLoadConsignment,
};

@protocol YXSendAuctionConsignmentPlatformControllerDelegate <NSObject>

/**
 监听用户操作，回调界面

 @param sendAuctionConsignmentPlatformController sendAuctionConsignmentPlatformController
 @param isRestPage isRestPage
 */
- (void)sendAuctionConsignmentPlatformController:(YXSendAuctionConsignmentPlatformController *)sendAuctionConsignmentPlatformController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXSendAuctionConsignmentPlatformController : UIViewController

/**
 平台寄卖数据接口
 */
@property (nonatomic, strong) YXAppraisaReportIdentifyModel *appraisaReportIdentifyModel;

/**
 需要展示内容的类型 1.
 */
@property (nonatomic, assign) kYXSendAuctionConsignmentPlatformControllerLoadDataType type;

@property (nonatomic, weak) id <YXSendAuctionConsignmentPlatformControllerDelegate> delegate;

@end
