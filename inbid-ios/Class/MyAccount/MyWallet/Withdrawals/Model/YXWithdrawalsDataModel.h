//
//  YXWithdrawalsDataModel.h
//  inbid-ios
//
//  Created by 郑键 on 17/2/21.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXBankCardDetailInformationModel;

@interface YXWithdrawalsDataModel : NSObject

//** =========================================================================================== */
//** ============================================数据=========================================== */
//** =========================================================================================== */

/**
 * 月可用额度
 */
//private String amt_month;
@property (nonatomic, copy) NSString *amt_month;

/**
 * 日可用额度
 */
//private String amt_day;
@property (nonatomic, copy) NSString *amt_day;

/**
 * 单笔可用额度
 */
//private String amt_single;
@property (nonatomic, copy) NSString *amt_single;

/**
 * 可操作次数
 */
//private String available_times;
@property (nonatomic, copy) NSString *available_times;

/**
 * 绑定银行卡标志：true已绑，false未绑
 */
//private Boolean bindCardFlag;
@property (nonatomic, assign, getter=isBindCardFlag) BOOL bindCardFlag;

/**
 *  签约银行卡信息
 */
//private AgreeListBean agreeListBean;
@property (nonatomic, strong) YXBankCardDetailInformationModel *agreeListBean;

@end
