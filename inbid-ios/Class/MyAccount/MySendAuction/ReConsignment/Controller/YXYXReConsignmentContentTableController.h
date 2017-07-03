//
//  YXYXReConsignmentContentTableController.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXAppraisaReportIdentifyModel;
@class YXYXReConsignmentContentTableController;

@protocol YXYXReConsignmentContentTableControllerDelegate <NSObject>

/**
 监听用户点击事件

 @param reConsignmentContentTableController reConsignmentContentTableController
 @param isRestPage isRestPage
 */
- (void)reConsignmentContentTableController:(YXYXReConsignmentContentTableController *)reConsignmentContentTableController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXYXReConsignmentContentTableController : UITableViewController

/**
 鉴定结果数据
 */
@property (nonatomic, strong) YXAppraisaReportIdentifyModel *appraisaReportIdentifyModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXYXReConsignmentContentTableControllerDelegate> delegate;

@end
