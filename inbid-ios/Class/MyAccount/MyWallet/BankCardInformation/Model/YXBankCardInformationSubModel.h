//
//  YXBankCardInformationSubModel.h
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXBankCardInformationSubModel : NSObject

/**
 title
 */
@property (nonatomic, copy) NSString *title;

/**
 placeHolder
 */
@property (nonatomic, copy) NSString *placeHolder;

/**
 reId
 */
@property (nonatomic, copy) NSString *reId;

/**
 userInputText
 */
@property (nonatomic, copy) NSString *userInputText;

/**
 是否允许用户交互
 */
@property (nonatomic, assign, getter=isUserInteraction) BOOL userInteraction;

/**
 键盘类型
 */
@property (nonatomic, assign) UIKeyboardType keyboardType;

/**
 限制输入字数
 */
@property (nonatomic, copy) NSString *maxTextCount;

/**
 倒计时
 */
@property (nonatomic, assign) CGFloat time;

/**
 需要倒计时时调用
 */
- (void)countDown;

@end

