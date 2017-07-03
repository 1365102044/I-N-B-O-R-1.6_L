//
//  YXWalletPayAndIncomeDataModel.h
//  inbid-ios
//
//  Created by 郑键 on 17/2/23.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXWalletPayAndIncomeDataModel : NSObject

//"amt_bal": "10000.00",
/**
 交易后余额
 */
@property (nonatomic, copy) NSString *amt_bal;

//"amt_inoccur": "10000.00",
/**
 收款金额
 */
@property (nonatomic, copy) NSString *amt_inoccur;

//"amt_outoccur": "0",
/**
 付款金额
 */
@property (nonatomic, copy) NSString *amt_outoccur;

//"date_acct": "20170220",
/**
 账务日期 yyyy-MM-dd 格式
 */
@property (nonatomic, copy) NSString *date_acct;

//"dt_billtrans": "2017-02-20 16:06:26",
/**
 交易时间
 */
@property (nonatomic, copy) NSString *dt_billtrans;

//"flag_dc": "0",
/**
 * 资金存取标志
 * 0 代表钱包账户入账 1 代表钱包账户出账
 */
@property (nonatomic, assign) BOOL flag_dc;

//"oid_biz": "107001",
/**
 * 业务类型        110001 账户充值
 101001 虚拟商品销售
 107001 商户付款
 202000 账号提现
 301000 转账
 301001 我要付款
 301002 我要收款
 */
@property (nonatomic, copy) NSString *oid_biz;

//"oid_paybill": "2017022079382039"
/**
 连连支付支付单号
 */
@property (nonatomic, copy) NSString *oid_paybill;

//** =========================================================================================== */
//** ==========================================lastCell========================================= */
//** =========================================================================================== */

/**
 是否是最后一个cell
 */
@property (nonatomic, assign, getter=isLastCell) BOOL lastCell;

@end
