//
//  YXInputPaymentPasswordView.h
//  Project
//
//  Created by 郑键 on 17/2/17.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXInputPaymentPasswordView;

@protocol YXInputPaymentPasswordViewDelegate <NSObject>

/**
 按钮点击事件

 @param inputPaymentPasswordView            inputPaymentPasswordView
 @param pwd                                 pwd
 @param button                              button
 SVN提交丢失，重修改提交
 */
- (void)inputPaymentPasswordView:(YXInputPaymentPasswordView *)inputPaymentPasswordView
                             pwd:(NSString *)pwd
                     otherButton:(UIButton *)button;

@end

@interface YXInputPaymentPasswordView : UIView

/**
 代理
 */
@property (nonatomic, weak) id<YXInputPaymentPasswordViewDelegate> delegate;

/**
 弹出视图
 
 @param extend extend       扩展参数
 */
+ (instancetype)inputPaymentPasswordViewPresentWithExtend:(id)extend;

@end
