//
//  YXSendAuctionInformationController.h
//  YXSendAuction
//
//  Created by 郑键 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXOrderDetailModel;
@class YXSendAuctionInformationController;

@protocol YXSendAuctionInformationControllerDelegate <NSObject>

/**
 监听用户是否有操作回调

 @param sendAuctionInformationController 当前控制器
 @param isRestPage                       是否改变刷新开关
 */
- (void)sendAuctionInformationController:(YXSendAuctionInformationController *)sendAuctionInformationController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXSendAuctionInformationController : UIViewController

/**
 被点击的模型数据
 */
@property (nonatomic, strong) YXOrderDetailModel *orderDeatailModel;

/**
 佣金比例
 */
@property (nonatomic, copy) NSString *commissionRatio;
/**
 来源控制器
 */
@property (nonatomic, weak) UIViewController *sourceViewController;

/**
 订单id
 */
@property(nonatomic,assign) long long orderID;
/*
 @brief 1 消息进来的
 */
@property(nonatomic,assign) NSInteger  formeVC;

/**
 代理
 */
@property (nonatomic, weak) id<YXSendAuctionInformationControllerDelegate> delegate;
//**点击推送通知进入的**/
@property(nonatomic,strong) NSString * formeNoti;
@end
