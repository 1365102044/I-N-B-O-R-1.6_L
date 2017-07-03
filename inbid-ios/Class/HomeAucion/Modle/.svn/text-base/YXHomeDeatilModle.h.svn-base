//
//  YXHomeDeatilModle.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXHomeDeatilImgesModle.h"
#import "YXHomeDeatilBidRecordVosListModle.h"
#import "YXHomeDeatilShuxingModle.h"



@interface YXHomeDeatilModle : NSObject


/**
 订单号
 */
@property(nonatomic,copy) NSString * orderId;
/**
 * 拍卖编号
 */
@property(nonatomic,copy) NSString * prodBidId;

/**
 * 商品编号
 */
@property(nonatomic,copy) NSString *  prodId;

/**
 * 商品图片
 */
@property(nonatomic,strong) NSArray * prodImgs;

/**
 * 商品状态,1:待上架,2:上架,3:下架;4:中拍未支付；5:卖出
 */
@property(nonatomic,copy) NSString * prodStatus;


/**
 * 拍卖状态,1:未开拍,2:拍卖中,3:中拍未支付；4:拍卖完成 5流拍
 */
@property(nonatomic,copy) NSString * bidStatus;



//** -------图片下面 -----------**/

/**
 * 商品名称
 */
@property(nonatomic,copy) NSString * prodName;
/**
 * 当前价格,单位为分
 */
@property(nonatomic,assign) long  currentPrice;



/**
 * 商品品牌名称
 */
@property(nonatomic,copy) NSString * prodBrandName;

/**
 * 商品分类名称
 */
@property(nonatomic,copy) NSString * catName;


/**
 * 拍卖结束时间
 */
@property(nonatomic,copy) NSString * endTime;


/**
 * 关注数
 */
@property(nonatomic,assign) NSInteger  collectNum;
/**
 * 参与人数
 */
@property(nonatomic,assign) NSInteger  actorNum;



//** -------竞拍信息 -----------**/
/**
 * 起拍价格
 */
@property(nonatomic,assign) long long startPrice;

/**
 * 保证金
 */
@property(nonatomic,assign) long long  marginPrice;

/**
 * 最小加价
 */
@property(nonatomic,assign) long  minAddPrice;

/**
 * 拍卖开始时间
 */
@property(nonatomic,copy)  NSString * startTime;

/*
 @brief 鉴定级别
 */
@property(nonatomic,copy) NSString * identifyLevel;

/*
 @brief 竞拍延时周期
 */
@property(nonatomic,copy) NSString * extendCron;

//** -------属性 发货 -----------**/

//属性
@property(nonatomic,strong) NSArray * prodProps;

/**
 * 送货区域
 */
@property(nonatomic,copy) NSString *deliverArea;

/**
 * 发货时间
 */
@property(nonatomic,copy) NSString *  deliverTime;




//** -------商品描述 -----------**/
/**
 * 商品简述
 */
@property(nonatomic,copy) NSString * prodDesc;
/**
 * 商品详细内容
 */
@property(nonatomic,strong) NSString * prodDetailContent;



/*
 @brief 出价记录
 */
@property(nonatomic,strong) NSArray * bidRecordVos;
/*
 @brief 关注 0未关注  1 已关注
 */
@property(nonatomic,assign) NSInteger  isCollect ;

#pragma mark  *** 一口价

/**
 是否 是自营  0 个人 ，  1 自营
 */
@property(nonatomic,assign) NSInteger  isSelf;

/**
 是否允许定金支付 0 不允许 ，1 允许
 */
@property(nonatomic,assign) NSInteger  isAllowDepositPay;

/**
 定金金额
 */
@property(nonatomic,copy) NSString*  depositPrice;

/**
 保价
 */
@property(nonatomic,assign) NSInteger  protectPrice;


/**
 运费
 */
@property(nonatomic,assign) NSInteger  carriage;

/**
 1 标示是本人继续支付 0标示不是本人
 */
@property(nonatomic,assign) NSInteger  continuePay;

@end
