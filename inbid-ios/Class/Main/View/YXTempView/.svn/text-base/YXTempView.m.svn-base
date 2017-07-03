//
//  YXTempView.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXTempView.h"

@interface YXTempView()

@property (nonatomic, strong) UIImageView *logImageView;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation YXTempView

- (void)setLogImageNamed:(NSString *)logImageNamed
{
    _logImageNamed = logImageNamed;
    self.logImageView.image = [UIImage imageNamed:logImageNamed];
    
}

- (void)setTipsText:(NSString *)tipsText
{
    _tipsText = tipsText;
    
    self.tipsLabel.text = tipsText;
    

    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        UIImageView *logImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_tempDataAddressLog"]];
        [self addSubview:logImageView];
        _logImageView = logImageView;
        
        UILabel *tipsLabel = [[UILabel alloc] init];
        tipsLabel.text = @"当前没有新数据";
        tipsLabel.font = [UIFont systemFontOfSize:13.0];
        tipsLabel.textColor = [UIColor colorWithWhite:170.0/255.0 alpha:1.0];
        [tipsLabel sizeToFit];
        [self addSubview:tipsLabel];
        _tipsLabel = tipsLabel;
        
        self.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.tipsText isEqualToString:@"您还没有待收货订单信息"]||[self.tipsText isEqualToString:@"您还没有订单信息"]||[self.tipsText isEqualToString:@"您还没有待付款订单信息"]||[self.tipsText isEqualToString:@"暂时您没有冻结中信息"]||[self.tipsText isEqualToString:@"暂时您没有未付款信息"]||[self.tipsText isEqualToString:@"暂时您没有已解冻信息"]) {
        [self.logImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).mas_offset(-80);
        }];
        
    }else{
    
        [self.logImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).mas_offset(-32);
        }];
    }
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.logImageView.mas_bottom).mas_offset(20);
    }];
}

@end
