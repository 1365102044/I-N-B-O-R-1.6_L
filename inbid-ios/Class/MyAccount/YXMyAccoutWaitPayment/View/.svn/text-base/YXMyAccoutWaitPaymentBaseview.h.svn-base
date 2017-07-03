//
//  YXMyAccoutWaitPaymentBaseview.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YXMyAccoutWaitPayModle.h"
#import "YXMySureMoneyNopaymentModle.h"


typedef void(^AddAddressBaseBlock)();
/*
 @brief 输入金额是 上移动视图
 */
typedef void(^textfieldEditingStatus)(NSInteger a,NSInteger paycount);

typedef void(^baseviewHeightBlock)(CGFloat height);

@interface YXMyAccoutWaitPaymentBaseview : UIView

@property(nonatomic,copy) baseviewHeightBlock baseviewheightblock;

@property(nonatomic,copy) textfieldEditingStatus  textfieldSatusblock;

@property(nonatomic,copy) AddAddressBaseBlock  addaddressbaseblock;


/*
 @brief 1分支付   2全额支付情况下 还不知道状态 要去选择支付状态    
 */
@property(nonatomic,assign) NSInteger  isPartPay;


//@property(nonatomic,strong) NSDictionary * dict;
/*
 @brief 1 保证金的继续支付 
 */
@property(nonatomic,assign) NSInteger  fomreVC;


/*
 @brief  支付保证金金额的时候，判读剩余金额是否小于2000   1 如果小于2000 只能支付全部   2 不小2000  可以粉笔支付
 */
//@property(nonatomic,assign) NSInteger  iscanChangeShengyuCount;



/*
 @brief  如果是保证金的话，应付金额 小于2000 直接全额支付，不能选择支付方式   1
 */
//@property(nonatomic,assign) NSInteger  shouldPaymentALLmarginpriceStatus;





/*
 @brief 拍品 去付款页面 的数据模型
 */
@property(nonatomic,strong) YXMyAccoutWaitPayModle * DingdanDataModle;

/*
 @brief 保证金 未付款订单 详情的数据模型
 */
@property(nonatomic,strong) YXMySureMoneyNopaymentModle * NoPayMarginPriceOrderModle;


@end
