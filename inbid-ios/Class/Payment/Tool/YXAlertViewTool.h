//
//  YXAlertViewTool.h
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXAlertViewTool : UIAlertController

/**
 有确定 和 取消 按钮
 */
+ (void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelButtonTitle otherTitle:(NSString *)otherButtonTitle cancelBlock:(void (^)())cancle confrimBlock:(void (^)())confirm;

/**
 只有一个确定按钮
 */
+(void)showAlertView:(UIViewController *)viewController title:(NSString*)title message:(NSString *)message confrimBlock:(void(^)())comfirm;

/**
 alertView底部弹窗

 @param viewController      viewController
 @param totalTitle          总标题
 @param titlesArray         标题数组
 @param messageArray        信息数组
 @param comfirm             回调
 */
+ (void)showAlertView:(UIViewController *)viewController
           totalTitle:(NSString *)totalTitle
          titlesArray:(NSArray<NSString *> *)titlesArray
         messageArray:(NSArray<NSString *> *)messageArray
         confrimBlock:(void(^)(NSString *title))comfirm;

@end
