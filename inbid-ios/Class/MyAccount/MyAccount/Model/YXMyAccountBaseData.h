//
//  YXMyAccountBaseData.h
//  MyAccount
//
//  Created by 郑键 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXMyAccountBaseData : NSObject

/**
 * 会员ID
 */
//private Long id;
@property (nonatomic, assign)NSInteger vipId;

/**
 * 昵称
 */
//private String nickname;
@property (nonatomic, copy)NSString *nickname;
/**
 * 头像
 */
//private String head;
@property (nonatomic, copy)NSString *head;
/**
 * 手机
 */
//private String phone;
@property (nonatomic, copy)NSString *phone;
/**
 * 会员性别
 */
//private Integer sex;
@property (nonatomic, copy)NSString *sex;
/**
 * 会员生日
 */
//private String birthday;
@property (nonatomic, copy)NSString *birthday;
/**
 * 邮箱账号
 */
//private String email;
@property (nonatomic, copy)NSString *email;
/**
 * 修改时间
 */
//private Date updateTime;
@property (nonatomic, assign)NSInteger updateTime;
/**
 * 是否设置支付密码：设置为1，默认为0没有
 */
//private Integer isPaymentCode;
//@property (nonatomic, assign)NSInteger isPaymentCode;
/**
 * 绑定银行卡 0未绑定 1表示绑定
 */
//private Integer cardStatus;
//@property (nonatomic, assign)NSInteger cardStatus;

/**
 * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
 */
//private Integer validateStatus;
//@property (nonatomic, assign)NSInteger validateStatus;
/**
 * 版本
 */
//private Integer version;
@property (nonatomic, assign)NSInteger version;


/**
 待付款订单数(包含未支付、部分支付)*** v-1.6
 */
@property(nonatomic,assign) NSInteger  noPayCount;
/**
 待收货订单数
 */
@property(nonatomic,assign) NSInteger  waitGetCount;

//是否设置支付密码：设置为1，默认为0没有
@property(nonatomic,assign) NSInteger  isPaymentCode;

//实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
@property(nonatomic,assign) NSInteger  validateStatus;

//绑定银行卡状态： 0未绑定 1表示绑定
@property(nonatomic,assign) NSInteger  cardStatus;

//余额(单位分)
@property(nonatomic,assign) NSInteger  totalMoney;

//我的足迹数
@property(nonatomic,assign) NSInteger  recordCount;

//我的关注
@property(nonatomic,assign) NSInteger  colletionCount;

//0不显示我的钱包金额 1表示显示
@property(nonatomic,assign) NSInteger  isShowMoney;

//我的钱包金额 （字符）
@property(nonatomic,copy) NSString*  balanceMoney;

//我买到的
@property(nonatomic,assign) NSInteger  buyCount;

//我的鉴定
@property(nonatomic,assign) NSInteger  identifyCount;


//我发布的
@property(nonatomic,assign) NSInteger  publishCount;

//我卖出的
@property(nonatomic,assign) NSInteger  sellCount;

//0未开通1开通
@property(nonatomic,assign) NSInteger  openingStatus;

// 1允许加入钱包0不允许加入钱包
@property(nonatomic,assign) NSInteger  isDisable;
//待付款数
@property(nonatomic,assign) NSInteger  noPayOrder;
//待发货数
@property(nonatomic,assign) NSInteger  hasPayOrder;
//待收货数
@property(nonatomic,assign) NSInteger  getOrder;
//待确认数
@property(nonatomic,assign) NSInteger  confrimOrder;

//" ": 1, qq绑定状态0代表未绑定1代表绑定
@property(nonatomic,assign) NSInteger  qqCount;

//" ": 0, 微信绑定状态0代表未绑定1代表绑定
@property(nonatomic,assign) NSInteger  wechatCount;
//"recycleCount ": 3, 平台回收
@property(nonatomic,assign) NSInteger  recycleCount;
//"refundCount ": 2, 退回商品
@property(nonatomic,assign) NSInteger  refundCount;
//地址信息
@property(nonatomic,assign) NSInteger  consigneeCount;
//提货信息
@property(nonatomic,assign) NSInteger  pickupCount;

@end

