//
//  YXNoMoreDataFooterView.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNoMoreDataFooterView.h"

@interface YXNoMoreDataFooterView()

@property (nonatomic, strong) UILabel *noMoreDataTipsLabel;
@property (nonatomic, strong) UIImageView *leftImageLine;
@property (nonatomic, strong) UIImageView *rightImageLine;

@end

@implementation YXNoMoreDataFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        UILabel *noMoreDataTipsLabel = [[UILabel alloc] init];
        noMoreDataTipsLabel.text = @"没有更多数据了";
        noMoreDataTipsLabel.textColor = YXColor(162.0, 162.0, 162.0);
        noMoreDataTipsLabel.font = [UIFont systemFontOfSize:14];
        [noMoreDataTipsLabel sizeToFit];
        [self addSubview:noMoreDataTipsLabel];
        _noMoreDataTipsLabel = noMoreDataTipsLabel;
        
        UIImageView *leftImageLine = [[UIImageView alloc] init];
        leftImageLine.image = [UIImage imageNamed:@"ic_homePageNoMoreDataLeftLine"];
        [self addSubview:leftImageLine];
        _leftImageLine = leftImageLine;
        
        UIImageView *rightImageLine = [[UIImageView alloc] init];
        rightImageLine.image = [UIImage imageNamed:@"ic_homePageNoMoreDataRightLine"];
        [self addSubview:rightImageLine];
        _rightImageLine = rightImageLine;
        
        self.backgroundColor = UIColorFromRGB(0xf9f9f9);
    }
    return self;    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.noMoreDataTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
    }];
    
    [self.leftImageLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.noMoreDataTipsLabel.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(1);
    }];
    
    [self.rightImageLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.noMoreDataTipsLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(1);
    }];
}

@end
