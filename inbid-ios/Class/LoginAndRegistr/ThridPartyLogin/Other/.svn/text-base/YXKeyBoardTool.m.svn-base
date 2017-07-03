//
//  YXKeyBoardShowOrHiddenTool.m
//  inbid-ios
//
//  Created by 胤讯测试 on 2017/1/12.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXKeyBoardTool.h"

@interface YXKeyBoardTool ()
{
    CGFloat keyboardHeight;
    CGFloat keyboardShowTime;
}
@end

@implementation YXKeyBoardTool

+(instancetype)sharedKeyBoard
{
    static dispatch_once_t onceToken;
    static YXKeyBoardTool* instance;
    dispatch_once(&onceToken, ^{
        instance = [[YXKeyBoardTool alloc]init];
    });

    
    return instance;
}
/**
 注册 键盘 通知
 */
-(void)RegisterNotification{
    
    //添加通知，来控制键盘和输入框的位置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];//键盘的弹出
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];//键盘的消失
    
}
-(void)keyboardWillShown:(NSNotification *)noti{
    
    NSDictionary* info = [noti userInfo];
    //得到鍵盤的高度
    keyboardHeight = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    keyboardShowTime = animationDuration;

    if ([self.delegate respondsToSelector:@selector(KeyboardWillShowDelegateHeight:animationtime:)]) {
        [self.delegate KeyboardWillShowDelegateHeight:keyboardHeight animationtime:keyboardShowTime];
    }
}

-(void)keyboardWillBeHidden:(NSNotification *)noti{
    if ([self.delegate respondsToSelector:@selector(KeyboardWillHiddenDelegateHeight:animationtime:)]) {
        [self.delegate KeyboardWillHiddenDelegateHeight:keyboardHeight animationtime:keyboardShowTime];
    }


}

@end
