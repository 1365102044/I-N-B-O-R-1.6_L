//
//  YXSendAuctionFirstHeaderView.m
//  YXSendAuction
//
//  Created by 郑键 on 16/11/11.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXSendAuctionFirstHeaderView.h"

@interface YXSendAuctionFirstHeaderView()<YXKeyboardToolbarDelegate>

/**
 边框视图
 */
@property (weak, nonatomic) IBOutlet UIView *broderView;

/**
 辅助视图
 */
@property (nonatomic, strong) YXKeyboardToolbar *customAccessoryView;

@end

@implementation YXSendAuctionFirstHeaderView

#pragma mark <YXKeyboardToolbarDelegate>

/**
 键盘辅助视图
 
 @param keyboardToolbar keyboardToolbar
 @param doneButtonClick doneButtonClick
 */
- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    if ([self.delegate respondsToSelector:@selector(sendAuctionFirstHeaderView:endEditing:)]) {
        [self.delegate sendAuctionFirstHeaderView:self endEditing:YES];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 配置界面 */
    
    //** 添加边框 */
    [self.broderView.layer setBorderWidth:1.0];
    CGColorRef color = [UIColor colorWithWhite:238.0/255.0 alpha:1.0].CGColor;
    [self.broderView.layer setBorderColor:color];
    
    //** 添加占位文字 */
    self.detailTextView.placeholderFontSize = 13.f;
    self.detailTextView.placeholder = @"描述一下您的宝贝吧\n 如是否有破损，使用情况，包含配件等。";
    self.detailTextView.placeholderColor = [UIColor colorWithRed:170.f/255.0 green:167.0/255.0 blue:167.0/255.0 alpha:1.0];
    //** 配置输入框 */
    [self.detailTextView setInputAccessoryView:self.customAccessoryView];
}

- (YXKeyboardToolbar *)customAccessoryView
{
    if (!_customAccessoryView) {
        
        _customAccessoryView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YXKeyboardToolbar class]) owner:nil options:nil].firstObject;
        _customAccessoryView.customDelegate = self;
    }
    return _customAccessoryView;
}

@end
