//
//  YXPlatformOnBehalfOfSellingContentController.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXOrderDetailModel;
@class YXPlatformOnBehalfOfSellingContentController;

@protocol YXPlatformOnBehalfOfSellingContentControllerDelegate <NSObject>

/**
 监听用户点击事件

 @param platformOnBehalfOfSellingContentController 平台代卖内容控制器
 @param isRestPage                                 开关
 */
- (void)platformOnBehalfOfSellingContentController:(YXPlatformOnBehalfOfSellingContentController *)platformOnBehalfOfSellingContentController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXPlatformOnBehalfOfSellingContentController : UITableViewController

/**
 数据
 */
@property (nonatomic, strong) YXOrderDetailModel *detailModel;

/**
 佣金比例
 */
@property (nonatomic, copy) NSString *commissionRatio;

@property (nonatomic, weak) id<YXPlatformOnBehalfOfSellingContentControllerDelegate> obsverDelegate;

@end
