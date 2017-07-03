//
//  YXAppraisalReportController.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXAppraisalReportController;
@class YXOrderDetailModel;

@protocol YXAppraisalReportControllerDelegate <NSObject>

/**
 监听用户点击事件

 @param appraisalReportController appraisalReportController
 @param isRestPage isRestPage
 */
- (void)appraisalReportController:(YXAppraisalReportController *)appraisalReportController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXAppraisalReportController : UIViewController

/**
 鉴定id
 */
@property (nonatomic, assign) long long identifyId;

/**
 是否显示其他功能
 */
@property (nonatomic, assign) BOOL isShowOtherFuncView;

/**
 代理
 */
@property (nonatomic, weak) id<YXAppraisalReportControllerDelegate> delegate;

/**
 我的鉴定订单
 */
@property (nonatomic, strong) YXOrderDetailModel *orderDetailModel;

@end
