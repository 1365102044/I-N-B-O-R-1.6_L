//
//  YXNewsEnsureNotiListModle.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXNewsEnsureNotiListModle : NSObject
/**
 * 消息编号
 */

@property(nonatomic,assign) NSInteger  MyId;


/**
 * 用户编号
 */
@property(nonatomic,assign) NSInteger  memberId;


/**
 * 商品名称
 */
@property(nonatomic,copy) NSString*  prodName;

/**
 * 商品图片
 */
@property(nonatomic,copy) NSString * imgUrl;


/**
 * 保证金编号
 */
@property(nonatomic,assign) long long  marginId;

/**
 * 保证金
 */
@property(nonatomic,assign) NSInteger  marginPrice;


/**
 * 订单编号
 */
@property(nonatomic,copy) NSString *  orderId;


/**
 * 配送单号
 */
@property(nonatomic,copy) NSString*  deliveryNum;

/**
 * 配送商
 */
@property(nonatomic,copy) NSString  *deliveryMerchant;

/**
 * 消息类型，1表示保证金消息，2表示订单消息，3表示系统消息
 */
@property(nonatomic,assign) NSInteger  msgType;


/**
 * 消息子类型，1表示付款通知，2表示关注竞拍即将开始
 */
@property(nonatomic,assign) NSInteger  msgSubType;


/**
 * 关联编号（保证金编号、订单编号等）
 */
@property(nonatomic,assign) long long   refId;


/**
 * 消息标题
 */
@property(nonatomic,copy) NSString*  msgTitle;


/**
 * 消息内容
 */
@property(nonatomic,copy) NSString*  msgContent;

/**
 * 创建时间
 */
@property(nonatomic,copy) NSString*  createTime;
/**
 * 修改时间
 */
@property(nonatomic,copy) NSString  * updateTime;
/**
 * 是否已读，0表示未读，1表示已读
 */
@property(nonatomic,assign) NSInteger  readable;



/**
 * 是否删除，0表示未删除，1表示删除
 */
@property(nonatomic,assign) NSInteger  deleted;

/**
 * 订单状态：1未付款，2部分付款，3待发货，4待确认收货，5交易完成，6交易取消
 */
@property(nonatomic,assign) NSInteger  orderStatus;


/**
 * 配送状态 1:未发货,2:配货中,3:已发货,4:确认收货
 */
@property(nonatomic,assign) NSInteger  deliveryStatus;

/*
 @brief 是否有地址  0 没有地址   1 有地址
 */
@property(nonatomic,assign) NSInteger  hasAddress;


/*
 orderstatus   2 付款中  3 已付款  4 订单已发货  
 delivery      4 已签收

 */
@property(nonatomic,strong) NSString * identifyImgUrl;


/**
 订单列表中的 状态
 */
@property(nonatomic,copy) NSString * MyOrderListStatus;

@end
