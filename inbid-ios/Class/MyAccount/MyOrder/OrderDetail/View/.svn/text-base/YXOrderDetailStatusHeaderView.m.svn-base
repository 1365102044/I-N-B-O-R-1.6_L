//
//  YXOrderDetailStatusHeaderView.m
//  OrderDetail
//
//  Created by 郑键 on 16/12/12.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXOrderDetailStatusHeaderView.h"
#import "YXOrderDetailBaseDataModel.h"
#import "YXStringFilterTool.h"
#import "UIColor+YXColor_Extension.h"
//** 第三方&系统库 */
#import <UIImageView+WebCache.h>

#define STATUS_VIEW_WIDTH(Spacing, Margin)                 (([UIScreen mainScreen].bounds.size.width - (self.statusArray.count - 1) * Spacing - 2 * Margin) / self.statusArray.count)
#define STATUS_PROGRESSVIEW_WIDTH(Spacing)                 ([UIScreen mainScreen].bounds.size.width - 2 * Spacing)

@interface YXOrderDetailStatusHeaderView()

/**
 状态进度视图
 */
@property (nonatomic, strong) UIProgressView *progressView;

/**
 顶部分割线View
 */
@property (nonatomic, strong) UIView *topSpacingView;

/**
 商品图片控件
 */
@property (nonatomic, strong) UIImageView *goodImageView;

/**
 商品名称
 */
@property (nonatomic, strong) UILabel *goodNameLabel;

/**
 商品价格
 */
@property (nonatomic, strong) UILabel *priceLabel;

/**
 订单编号
 */
@property (nonatomic, strong) UILabel *orderIdLabel;

/**
 底部分割线
 */
@property (nonatomic, strong) UIView *bottomSpacingView;

@end

@implementation YXOrderDetailStatusHeaderView

#pragma mark - Zero.Const

/**
 顶部分割线高度
 */
CGFloat topSpacingViewHeight        = 10;

/**
 商品图片左边距
 */
CGFloat goodImageViewLeftSpacing    = 20;

/**
 商品图片上边距
 */
CGFloat goodImageViewTopSpacing     = 22.5;

/**
 商品图片宽高
 */
CGFloat goodImageViewWidth          = 76.5;

/**
 商品名称左边距
 */
CGFloat goodNameLabelLeftMargin     = 15;

/**
 订单号左边距
 */
CGFloat orderIdLabelSpacing         = 12;

/**
 底部分割线高度
 */
CGFloat bottomSpacingViewHeight     = 0.5;

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 数据模型

 @param orderDetailBaseModel 赋值界面
 */
- (void)setOrderDetailBaseModel:(YXOrderDetailBaseDataModel *)orderDetailBaseModel
{
    _orderDetailBaseModel = orderDetailBaseModel;
    
    [self resetSubViewsHiddenStatus];
    
    //** 默认headerView类型 */
    if (self.style == YXOrderDetailHeaderViewNone) {
        self.topSpacingView.hidden = NO;
        
        return;
    }
    
    //** 商品详情展示headerView类型 */
    if (self.style == YXOrderDetailHeaderViewDetail) {
        self.topSpacingView.hidden      = NO;
        self.goodImageView.hidden       = NO;
        self.goodNameLabel.hidden       = NO;
        self.priceLabel.hidden          = NO;
        self.bottomSpacingView.hidden   = NO;
        
        [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:self.orderDetailBaseModel.dataModel.imgUrl]
                              placeholderImage:[UIImage imageNamed:@""]
                                       options:SDWebImageRetryFailed];
        
        [self setupLabelWithText:self.orderDetailBaseModel.dataModel.prodName
                     andFontSize:12.f
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:NO
                        andLabel:self.goodNameLabel];
        [self setupLabelAttrbuteStringWithText:[NSString stringWithFormat:@"单价:¥%@",
                                                [self setMoneyStrmethodComma:self.orderDetailBaseModel.dataModel.orderTotalAmount]]
                                  andFistColor:[UIColor orderUnitPriceTextColor]
                              andFirstFontSize:11.f
                                andSecondColor:[UIColor themGoldColor]
                             andSecondFontSize:12.f
                              andFirstRangeLoc:0
                              andFirstRangeLen:3
                             andSecondRangeLoc:3
                             andSecondRangeLen:[self setMoneyStrmethodComma:self.orderDetailBaseModel.dataModel.orderTotalAmount].length + 1
                                      andLabel:self.priceLabel];
        return;
    }
    
    //** 订单编号组头样式 */
    if (self.style == YXOrderDetailHeaderViewOrderId) {
        self.topSpacingView.hidden      = NO;
        self.orderIdLabel.hidden        = NO;
        
        [self setupLabelWithText:[NSString stringWithFormat:@"订单编号：%@", self.orderDetailBaseModel.dataModel.orderId]
                     andFontSize:12.f
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:YES
                        andLabel:self.orderIdLabel];
        
        return;
    }
}

/**
 科学计数法
 
 @param price 价格
 */
- (NSString *)setMoneyStrmethodComma:(long long)price
{
    return [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld", price]];
}

/**
 设置label
 
 @param text 文字
 @param fontSize 文字大小
 @param textColor 文字颜色
 */
- (void)setupLabelWithText:(NSString *)text
               andFontSize:(CGFloat)fontSize
              andTextColor:(UIColor *)textColor
      andIsPingFangSCLight:(BOOL)isPingFangSCLight
                  andLabel:(UILabel *)label
{
    label.text = text;
    label.textColor = textColor;
    if (isPingFangSCLight) {
        label.font = YXRegularfont(fontSize);
    }else{
        label.font = [UIFont systemFontOfSize:fontSize];
    }
}

/**
 设置富文本label

 @param text                文字
 @param firstColor          第一种颜色
 @param firstFontSize       第一种字体大小
 @param secondColor         第二种文字颜色
 @param secondFontSize      第二种文字
 @param FirstRangeLoc       第一起点
 @param FirstRangeLen       第一长度
 @param SecondRangeLoc      第二起点
 @param SecondRangeLen      第二长度
 @param label label
 */
- (void)setupLabelAttrbuteStringWithText:(NSString *)text
                            andFistColor:(UIColor *)firstColor
                        andFirstFontSize:(CGFloat)firstFontSize
                          andSecondColor:(UIColor *)secondColor
                       andSecondFontSize:(CGFloat)secondFontSize
                             andFirstRangeLoc:(NSUInteger)firstRangeLoc
                        andFirstRangeLen:(NSUInteger)firstRangeLen
                        andSecondRangeLoc:(NSUInteger)secondRangeLoc
                        andSecondRangeLen:(NSUInteger)secondRangeLen
                                andLabel:(UILabel *)label
{
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:text];
    [attrM addAttribute:NSForegroundColorAttributeName
                  value:firstColor
                  range:NSMakeRange(firstRangeLoc, firstRangeLen)];
    [attrM addAttribute:NSFontAttributeName
                  value:[UIFont systemFontOfSize:firstFontSize]
                  range:NSMakeRange(firstRangeLoc, firstRangeLen)];
    
    
    [attrM addAttribute:NSForegroundColorAttributeName
                  value:secondColor
                  range:NSMakeRange(secondRangeLoc, secondRangeLen)];
    [attrM addAttribute:NSFontAttributeName
                  value:[UIFont systemFontOfSize:secondFontSize]
                  range:NSMakeRange(secondRangeLoc, secondRangeLen)];
    
    label.attributedText = attrM;
}

/**
 重置当前子控件的隐藏状态
 */
- (void)resetSubViewsHiddenStatus
{
    self.topSpacingView.hidden      = YES;
    self.progressView.hidden        = YES;
    self.goodImageView.hidden       = YES;
    self.goodNameLabel.hidden       = YES;
    self.priceLabel.hidden          = YES;
    self.bottomSpacingView.hidden   = YES;
    self.orderIdLabel.hidden        = YES;
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 初始化
 
 @param reuseIdentifier reuseIdentifier     重用标志
 @return                                    实例对象
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupCustomUI];
    }
    return self;
}

#pragma mark - Sixth.界面配置

/**
 配置界面
 */
- (void)setupCustomUI
{
    UIView *bgView              = [UIView new];
    bgView.backgroundColor      = [UIColor whiteColor];
    self.backgroundView         = bgView;
    
    //** ====================================公共控件===================================== */
    [self.contentView addSubview:self.topSpacingView];
    [self.topSpacingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(topSpacingViewHeight);
    }];
    
    //** ====================================详情控件===================================== */
    [self.contentView addSubview:self.goodImageView];
    [self.contentView addSubview:self.goodNameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.bottomSpacingView];
    
    [self.goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(goodImageViewLeftSpacing);
        make.top.mas_equalTo(self.contentView).mas_offset(goodImageViewTopSpacing);
        make.height.width.mas_equalTo(goodImageViewWidth);
    }];
    
    [self.goodNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodImageView);
        make.left.mas_equalTo(self.goodImageView.mas_right).mas_offset(goodNameLabelLeftMargin);
        make.right.mas_equalTo(self.contentView).mas_offset(-goodNameLabelLeftMargin);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.goodImageView).mas_offset(-4);
        make.left.mas_equalTo(self.goodNameLabel);
    }];
    
    [self.bottomSpacingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(bottomSpacingViewHeight);
    }];
    
    //** ===================================订单时间状态控件==================================== */
    [self.contentView addSubview:self.orderIdLabel];
    
    [self.orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topSpacingView.mas_bottom).mas_offset(orderIdLabelSpacing);
        make.left.mas_equalTo(self.contentView).mas_offset(orderIdLabelSpacing);
    }];
}

#pragma mark - Seventh.懒加载

- (UILabel *)orderIdLabel
{
    if (!_orderIdLabel) {
        _orderIdLabel                       = [UILabel new];
        _orderIdLabel.backgroundColor       = [UIColor whiteColor];
    }
    return _orderIdLabel;
}

- (UIView *)bottomSpacingView
{
    if (!_bottomSpacingView) {
        _bottomSpacingView                  = [UIView new];
        _bottomSpacingView.backgroundColor  = [UIColor themGrayColor];
        _bottomSpacingView.hidden           = YES;
    }
    return _bottomSpacingView;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel                         = [UILabel new];
        _priceLabel.backgroundColor         = [UIColor whiteColor];
        _priceLabel.hidden                  = YES;
    }
    return _priceLabel;
}

- (UILabel *)goodNameLabel
{
    if (!_goodNameLabel) {
        _goodNameLabel                      = [UILabel new];
        _goodNameLabel.backgroundColor      = [UIColor whiteColor];
        _goodNameLabel.font                 = [UIFont systemFontOfSize:13.f];
        _goodNameLabel.textColor            = [UIColor orderTextColor];
        _goodNameLabel.hidden               = YES;
    }
    return _goodNameLabel;
}

- (UIImageView *)goodImageView
{
    if (!_goodImageView) {
        _goodImageView                      = [UIImageView new];
        _goodImageView.hidden               = YES;
    }
    return _goodImageView;
}

- (UIView *)topSpacingView
{
    if (!_topSpacingView) {
        _topSpacingView                     = [UIView new];
        _topSpacingView.backgroundColor     = [UIColor themLightGrayColor];
        _topSpacingView.hidden              = YES;
        
        UIView *topView                     = [UIView new];
        UIView *bottomView                  = [UIView new];
        topView.backgroundColor             = [UIColor themGrayColor];
        bottomView.backgroundColor          = [UIColor themGrayColor];
        
        [_topSpacingView addSubview:topView];
        [_topSpacingView addSubview:bottomView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(_topSpacingView);
            make.height.mas_equalTo(bottomSpacingViewHeight);
        }];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(_topSpacingView);
            make.height.mas_equalTo(topView);
        }];
    }
    return _topSpacingView;
}

@end
