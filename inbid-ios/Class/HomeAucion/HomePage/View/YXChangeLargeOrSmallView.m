//
//  YXChangeLargeOrSmallView.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/24.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXChangeLargeOrSmallView.h"

@interface YXChangeLargeOrSmallView()



@end

@implementation YXChangeLargeOrSmallView

/**
 切换小图点击事件
 */
- (IBAction)smallButtonClick:(UIButton *)sender
{
    self.currentButton.enabled = YES;
    sender.enabled = NO;
    self.currentButton = sender;
    if ([self.delegate respondsToSelector:@selector(changeLargeOrSmallView:andClickButton:)]) {
        [self.delegate changeLargeOrSmallView:self andClickButton:sender];
    }
}

/**
 切换大图点击事件
 */
- (IBAction)largeButtonClick:(UIButton *)sender
{
    self.currentButton.enabled = YES;
    sender.enabled = NO;
    self.currentButton = sender;
    if ([self.delegate respondsToSelector:@selector(changeLargeOrSmallView:andClickButton:)]) {
        [self.delegate changeLargeOrSmallView:self andClickButton:sender];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    //** 判断当前是哪种布局 */
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isDefaultLayout"]) {
        self.largeButton.enabled = NO;
        self.currentButton = self.largeButton;
    }else{
        self.smallButton.enabled = NO;
        self.currentButton = self.smallButton;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.height == 0) {
        [UIView animateWithDuration:0.25 animations:^{
           self.buttonSuperViewHeightCons.constant = 0;
        }];
        self.largeButton.hidden = YES;
        self.smallButton.hidden = YES;
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.buttonSuperViewHeightCons.constant = 90.5;
        }];
        self.largeButton.hidden = NO;
        self.smallButton.hidden = NO;
    }
}

@end
