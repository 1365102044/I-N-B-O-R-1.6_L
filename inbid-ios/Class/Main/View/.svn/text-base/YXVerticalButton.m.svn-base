//
//  YXVerticalButton.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/7.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXVerticalButton.h"

@implementation YXVerticalButton


- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = self.bounds.origin.x + self.bounds.size.width / 2 - 12;
    self.imageView.y = 5;
    self.imageView.width = self.imageView.size.width;
    self.imageView.height = self.imageView.size.height;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
