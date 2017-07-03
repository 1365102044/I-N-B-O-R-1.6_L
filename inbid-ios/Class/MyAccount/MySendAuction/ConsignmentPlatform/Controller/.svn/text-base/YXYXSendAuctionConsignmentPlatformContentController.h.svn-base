//
//  YXYXSendAuctionConsignmentPlatformContentController.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXAppraisaReportIdentifyModel;

/**
 当前界面加载数据类型
 
 - kYXSendAuctionConsignmentPlatformControllerLoadReConsignment: kYXSendAuctionConsignmentPlatformControllerLoadReConsignment 一口价流拍后
 - kYXSendAuctionConsignmentPlatformControllerLoadConsignment:   kYXSendAuctionConsignmentPlatformControllerLoadConsignment   设置一口价
 */
typedef NS_ENUM(NSUInteger, kYXSendAuctionConsignmentPlatformContentControllerLoadDataType) {
    kYXSendAuctionConsignmentPlatformContentControllerLoadReConsignment,
    kYXSendAuctionConsignmentPlatformContentControllerLoadConsignment,
};

@interface YXYXSendAuctionConsignmentPlatformContentController : UITableViewController

/**
 平台寄卖数据接口
 */
@property (nonatomic, strong) YXAppraisaReportIdentifyModel *appraisaReportIdentifyModel;

/**
 售卖金额输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *selaMoneyTextField;

/**
 寄卖周期结果label
 */
@property (weak, nonatomic) IBOutlet UILabel *showDayPickerLabel;

/**
 需要展示内容的类型 
 */
@property (nonatomic, assign) kYXSendAuctionConsignmentPlatformContentControllerLoadDataType type;

@end
