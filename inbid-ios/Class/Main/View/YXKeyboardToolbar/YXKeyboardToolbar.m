//
//  YXKeyboardToolbar.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXKeyboardToolbar.h"

@implementation YXKeyboardToolbar

/**
 取消按钮点击事件

 @param sender 传入点击的按钮
 */
- (IBAction)cancelButtonClick:(UIBarButtonItem *)sender
{
    if ([self.customDelegate respondsToSelector:@selector(keyboardToolbar:doneButtonClick:)]) {
        [self.customDelegate keyboardToolbar:self doneButtonClick:sender];
    }
}

/**
 完成按钮点击事件

 @param sender 传入点击的按钮
 */
- (IBAction)doneButton:(UIBarButtonItem *)sender
{
    if ([self.customDelegate respondsToSelector:@selector(keyboardToolbar:doneButtonClick:)]) {
        [self.customDelegate keyboardToolbar:self doneButtonClick:sender];
    }
}

/**
 启动xib时调用
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, 44);
}

@end
