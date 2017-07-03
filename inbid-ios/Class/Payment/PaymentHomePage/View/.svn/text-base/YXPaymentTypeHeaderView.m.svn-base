//
//  YXPaymentTypeHeaderView.m
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPaymentTypeHeaderView.h"
#import "UIColor+YXColor_Extension.h"
#import "YXPaymentHomepageViewDataModel.h"

@interface YXPaymentTypeHeaderView()

/**
 顶部分割视图
 */
@property (nonatomic, strong) UIView *topMarginView;

/**
 titlelable
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 内容label
 */
@property (nonatomic, strong) UILabel *detailLabel;

/**
 底部分割线视图
 */
@property (nonatomic, strong) UIView *bottomMarginView;

/**
 顶部分割线视图
 */
@property (nonatomic, strong) UIView *topMarginLineView;

@end

@implementation YXPaymentTypeHeaderView

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 界面赋值

 @param baseModel baseModel
 */
- (void)setBaseModel:(YXPaymentHomepageViewDataModel *)baseModel
{
    _baseModel = baseModel;
    if (self.type == YXPaymentTypeHeaderViewDetailHeader) {
        
        self.titleLabel.text = @"订单号：";
        self.detailLabel.text = self.baseModel.orderId;
    }
    
    if (self.type == YXPaymentTypeHeaderViewPaymentTypeHeader) {
        self.titleLabel.text = @"选择支付方式";
        self.detailLabel.text = @"查看银行及限额说明";
    }
}

/**
 根据不同类型，设置不同约束

 @param type 类型
 */
- (void)setType:(YXPaymentTypeHeaderViewType)type
{
    _type = type;
    
    if (type == YXPaymentTypeHeaderViewDetailHeader) {
        
        self.detailLabel.textColor = YXColor(25, 10, 11);
        self.detailLabel.font = YXSFont(12);
        self.detailLabel.hidden = NO;
    }
    
    if (type == YXPaymentTypeHeaderViewPaymentTypeHeader) {
        
        self.titleLabel.text = @"选择支付方式";
        self.detailLabel.text = @"查看银行及限额说明";
        self.detailLabel.textColor = UIColorFromRGB(0xffb13d);
        self.detailLabel.font = YXSFont(10);
        self.detailLabel.hidden = YES;
    }
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 实例化对象
 
 @param reuseIdentifier reuseIdentifier 重用标志
 @return 返回创建的实例
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self customUI];
    }
    return self;
}

#pragma mark - Sixth.界面配置

/**
 自定义UI
 */
- (void)customUI
{
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bgView;
    
    [self.contentView addSubview:self.topMarginView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.bottomMarginView];
    [self.contentView addSubview:self.topMarginLineView];
    
    [self.topMarginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    
    [self.bottomMarginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(13.5);
        make.top.mas_equalTo(self.topMarginView.mas_bottom).mas_offset(13.5);
    }];
    
    [self.topMarginLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topMarginView.mas_bottom);
        make.left.right.mas_equalTo(self.topMarginView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.contentView).mas_offset(-20);
    }];
}

#pragma mark - Seventh.懒加载

- (UIView *)topMarginView
{
    if (!_topMarginView) {
        _topMarginView = [[UIView alloc] init];
        _topMarginView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
    }
    return _topMarginView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"测试数据";
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"测试数据";
        _detailLabel.font = [UIFont systemFontOfSize:12];
        [_detailLabel sizeToFit];
    }
    return _detailLabel;
}

- (UIView *)bottomMarginView
{
    if (!_bottomMarginView) {
        _bottomMarginView = [[UIView alloc] init];
        _bottomMarginView.backgroundColor = [UIColor themGrayColor];
    }
    return _bottomMarginView;
}

- (UIView *)topMarginLineView
{
    if (!_topMarginLineView) {
        _topMarginLineView = [[UIView alloc] init];
        _topMarginLineView.backgroundColor = [UIColor themGrayColor];
    }
    return _topMarginLineView;
}

@end
