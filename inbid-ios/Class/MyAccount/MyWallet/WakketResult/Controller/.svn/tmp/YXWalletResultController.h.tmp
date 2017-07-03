//
//  YXWalletResultController.h
//  Project
//
//  Created by 郑键 on 17/2/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 钱包模块结果控制器

 - YXWalletResultControllerDefault:                 默认结果样式
 - YXWalletResultControllerWithdrawalsResult:       提现结果
 */
typedef NS_ENUM(NSUInteger, YXWalletResultControllerType) {
    YXWalletResultControllerDefault,
    YXWalletResultControllerWithdrawalsResult,
};

@interface YXWalletResultController : UIViewController

/**
 实例化当前对象

 @param type type 类型
<<<<<<< .mine
 @param extend extend 扩展参数（当type == YXWalletResultControllerDefault时，extend传入{"titleString":名称,"imageNamed":"xxxx", "buttonTitle":"buttonTitle" ,sourVcType:"XXX"}，如有其他需要，可调整参数传递方式）
=======
 @param extend extend 扩展参数
 （当type == YXWalletResultControllerDefault时，extend传入{"titleString":名称,"imageNamed":"xxxx", "buttonTitle":"buttonTitle"}，如有其他需要，可调整参数传递方式）
 （当type == YXWalletResultControllerWithdrawalsResult时，extend传入{"bankName":名称,"cardNo":"xxxx", "amount":"xxxx"}，如有其他需要，可调整参数传递方式）
>>>>>>> .r1414
 @return 实例化对象
 */
+ (instancetype)walletResultControllerWithType:(YXWalletResultControllerType)type
                                        extend:(id)extend;

@end
