//
//  YXKeyBoardShowOrHiddenTool.h
//  inbid-ios
//
//  Created by 胤讯测试 on 2017/1/12.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YXKeyboardWillShowDelegate <NSObject>
/**
 键盘弹出
 */
-(void)KeyboardWillShowDelegateHeight:(CGFloat)heigth animationtime:(CGFloat)time;
/**
 键盘隐藏
 */
-(void)KeyboardWillHiddenDelegateHeight:(CGFloat)heigth animationtime:(CGFloat)time;
@end

@interface YXKeyBoardTool : NSObject

@property(nonatomic,weak) id<YXKeyboardWillShowDelegate> delegate;

+(instancetype)sharedKeyBoard;

/**
 注册 键盘 通知
 */
-(void)RegisterNotification;


///**
// 键盘弹出高度
// */
//-(CGFloat)keyboardShowHeight;
//
///**
// 键盘弹出时间
// */
//-(CGFloat)KeyboardShowTime;

@end
