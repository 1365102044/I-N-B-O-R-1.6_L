//
//  YXMyAccountPaymentChoosePayTypeView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^choosepaytypeHeight)(CGFloat height);
/*
 @brief number 编辑的状态  1正在编辑 2结束编辑 3正在编辑中  paycount textfild的内容
 */
typedef void(^statrEditngBlock)(NSInteger number ,NSInteger paycount);



@interface YXMyAccountPaymentChoosePayTypeView : UIView

@property(nonatomic,copy) statrEditngBlock  editingblock;

@property(nonatomic,copy) choosepaytypeHeight  heightblock;
/*
 @brief 2 全额支付     1 分笔支付
 */
@property(nonatomic,assign) NSInteger  isPartPay;


/*
 @brief  支付保证金金额的时候，判读剩余金额是否小于2000   1 如果小于2000 只能支付全部   2 不小2000  可以粉笔支付
 */
//@property(nonatomic,assign) NSInteger  iscanChangeShengyuCount;
/*
 @brief 保证金的剩余金额 直接显示 只能全部显示 
 */
@property(nonatomic,assign) NSInteger  shengyuMoneyCount;





/*
 @brief  如果是保证金的话，应付金额 小于2000 直接全额支付，不能选择支付方式   1
 */
//@property(nonatomic,assign) NSInteger  shouldPaymentALLmarginpriceStatus;


@end
