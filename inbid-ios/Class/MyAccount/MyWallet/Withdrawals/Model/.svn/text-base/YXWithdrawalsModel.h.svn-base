//
//  YXWithdrawalsModel.h
//  Project
//
//  Created by 郑键 on 17/2/16.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXWithdrawalsDataModel;

@interface YXWithdrawalsModel : NSObject

//** =========================================================================================== */
//** ============================================视图=========================================== */
//** =========================================================================================== */

/**
 行高
 */
@property (nonatomic, assign) CGFloat cacheHeightForRow;

/**
 cell类型
 */
@property (nonatomic, assign) CGFloat cellType;

/**
 *  下面的属性，用来区分当cellType为YXWithdrawalsCellTitleLabelAndAccessButton时的区分
 *  以及银行的名称及附属信息，到账时间选择
 */

/**
 title
 */
@property (nonatomic, copy) NSString *title;

/**
 detailTitle
 */
@property (nonatomic, copy) NSString *detailTitle;

/**
 titleFontSize
 */
@property (nonatomic, assign) CGFloat titleFontSize;

/**
 detailTitleFontSize
 */
@property (nonatomic, assign) CGFloat detailTitleFontSize;


/**
 totalAmont 用于展示在输入框内，可提现金额总数
 */
@property (nonatomic, copy) NSString *totalAmont;

/**
 showTotalAmont 判断是否展示可提现全部金额在输入框内
 */
@property (nonatomic, assign) BOOL showTotalAmont;

/**
 showTipsColor 判断是否展示红色提示
 */
@property (nonatomic, assign) BOOL showTipsColor;

/**
 底部按钮是否可以点击
 */
@property (nonatomic, assign) BOOL funcButtonEnable;

//** =========================================================================================== */
//** ============================================用户=========================================== */
//** =========================================================================================== */

/**
 用户输入
 */
@property (nonatomic, copy) NSString *userInputText;

//** =========================================================================================== */
//** ============================================数据=========================================== */
//** =========================================================================================== */

/**
 dataModel
 */
@property (nonatomic, strong) YXWithdrawalsDataModel *dataModel;

@end
