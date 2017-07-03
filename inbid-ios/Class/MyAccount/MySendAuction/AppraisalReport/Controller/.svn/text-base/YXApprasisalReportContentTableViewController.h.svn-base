//
//  YXApprasisalReportContentTableViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXAppraisaReportIdentifyModel;
@class YXApprasisalReportContentTableViewController;

@protocol YXApprasisalReportContentTableViewControllerDelegate <NSObject>

/**
 监听用户点击

 @param apprasisalReportContentTableViewController apprasisalReportContentTableViewController
 @param isRestPage isRestPage
 */
- (void)apprasisalReportContentTableViewController:(YXApprasisalReportContentTableViewController *)apprasisalReportContentTableViewController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXApprasisalReportContentTableViewController : UITableViewController

/**
 鉴定结果数据
 */
@property (nonatomic, strong) YXAppraisaReportIdentifyModel *appraisaReportIdentifyModel;

/**
 是否显示其他功能
 */
@property (nonatomic, assign) BOOL isShowOtherFuncView;

/**
 代理
 */
@property (nonatomic, weak) id<YXApprasisalReportContentTableViewControllerDelegate> delegate;

@end
