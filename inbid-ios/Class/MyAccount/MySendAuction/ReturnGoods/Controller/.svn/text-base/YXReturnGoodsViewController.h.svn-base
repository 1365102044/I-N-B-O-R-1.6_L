//
//  YXReturnGoodsViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyAddressList;
@class YXMySendAuctionEndBid;
@class YXOrderDetailModel;
@class YXReturnGoodsViewController;

@protocol YXReturnGoodsViewControllerDelegate <NSObject>

/**
 监听用户操作

 @param returnGoodsViewController 我要退回按钮
 @param isRestPage                开关
 */
- (void)returnGoodsViewController:(YXReturnGoodsViewController *)returnGoodsViewController changeRestPageON:(BOOL)isRestPage;

@end


@interface YXReturnGoodsViewController : UIViewController

/**
 点击地址列表地址返回数据
 */
@property (nonatomic, strong) YXMyAddressList *addressList;

/**
 新地址的回调
 */
@property (nonatomic, strong) NSDictionary *addNewAddressDict;

/**
 完成寄拍订单
 */
@property (nonatomic, strong) YXMySendAuctionEndBid *endBidList;

/**
 我的鉴定订单
 */
@property (nonatomic, strong) YXOrderDetailModel *detailModel;

/**
 商品名称
 */
@property (nonatomic, copy) NSString *goodName;

/**
 选中地址的id
 */
@property (nonatomic, assign) long long addressId;

/**
 代理
 */
@property (nonatomic, weak) id<YXReturnGoodsViewControllerDelegate> delegate;

/**
 一口价商品退货id
 */
@property (nonatomic, assign) long long fixGoodReturnId;

/**
 商品id
 */
@property (nonatomic, assign) long long prodId;

/**
 一口价id
 */
@property (nonatomic, assign) long long buyoutId;

@end
