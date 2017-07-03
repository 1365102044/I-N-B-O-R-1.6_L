//
//  YXPlaceholderTextView.m
//  inbid-ios
//
//  Created by 郑键 on 16/8/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPlaceholderTextView.h"


@interface YXPlaceholderTextView()

/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation YXPlaceholderTextView

//** 添加占位文字 */
- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceVertical = YES;
        self.placeholderColor = [UIColor colorWithWhite:175.0/255.0 alpha:1.0];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.alwaysBounceVertical = YES;
    self.placeholderColor = [UIColor colorWithWhite:175.0/255.0 alpha:1.0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//** 监听文字改变 */
- (void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;
}

//** 更新占位文字尺寸 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}


#pragma mark - 重写setter


- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    self.font = [UIFont systemFontOfSize:self.placeholderFontSize];
    
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

/**
 * setNeedsDisplay方法 : 会在恰当的时刻自动调用drawRect:方法
 * setNeedsLayout方法 : 会在恰当的时刻调用layoutSubviews方法
 */

- (CGFloat)placeholderFontSize
{
    if (!_placeholderFontSize) {
        _placeholderFontSize = 15;
    }
    return _placeholderFontSize;
}

@end
