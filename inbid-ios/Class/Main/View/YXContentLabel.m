//
//  YXContentLabel.m
//  inbid-ios
//
//  Created by 郑键 on 16/8/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXContentLabel.h"

@implementation YXContentLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}


@end
