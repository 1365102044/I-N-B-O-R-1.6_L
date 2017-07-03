//
//  YXPlatformOnBehalfOfSellingController.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXOrderDetailModel;
@class YXPlatformOnBehalfOfSellingController;

@protocol YXPlatformOnBehalfOfSellingControllerDelegate <NSObject>

/**
 监听用户点击回调

 @param platformOnBehalfOfSellingController 平台代卖控制器
 @param isRestPage                          开关
 */
- (void)platformOnBehalfOfSellingController:(YXPlatformOnBehalfOfSellingController *)platformOnBehalfOfSellingController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXPlatformOnBehalfOfSellingController : UIViewController

/**
 佣金比例
 */
@property (nonatomic, copy) NSString *commissionRatio;

/**
 数据
 */
@property (nonatomic, strong) YXOrderDetailModel *detailModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXPlatformOnBehalfOfSellingControllerDelegate> delegate;

@end
