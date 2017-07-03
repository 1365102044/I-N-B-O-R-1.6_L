//
//  YXOrederDetailBottomFuncView.m
//  OrderDetail
//
//  Created by 郑键 on 16/12/15.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXOrederDetailBottomFuncView.h"
#import "YXOrderDetailBaseDataModel.h"

@interface YXOrederDetailBottomFuncView()

/**
 功能按钮数组
 */
@property (nonatomic, strong) NSMutableArray *funcButtonsArray;

/**
 顶部编剧线
 */
@property (nonatomic, strong) UIView *topSpacingView;

@end

@implementation YXOrederDetailBottomFuncView

#pragma mark - Zero.Const

/**
 *功能按钮最大数量
 */
NSInteger YXOrderDetailBottomFuncViewSubButtonMaxCount      = 3;

/**
 右侧边距
 */
CGFloat funcButtonRightSpacing                              = 10;

/**
 间距
 */
CGFloat funcButtonMargin                                    = 10;

/**
 宽度
 */
CGFloat funcButtonWidth                                     = 74;

/**
 高度
 */
CGFloat funcButtonHeight                                    = 27;

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 赋值

 @param orderDetailBaseDataModel 数据
 */
- (void)setOrderDetailBaseDataModel:(YXOrderDetailBaseDataModel *)orderDetailBaseDataModel
{
    _orderDetailBaseDataModel = orderDetailBaseDataModel;
    
    [self.funcButtonsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        btn.hidden = YES;
    }];
    
    //** ================================判断当前状态================================ */
    //** 待付款 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPendingPayment) {
        [self setSubFuncButtonWithTitlesArray:@[@"去支付",
                                                @"联系客服"]];
    }
    
    //** 线下转账 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPendingPayment_lineTransfer) {
        [self setSubFuncButtonWithTitlesArray:@[@"其他方式支付",
                                                @"联系客服",
                                                @"上传凭证"]];
        
    }
    
    //** 线下转账审核凭证 */
    if (orderDetailBaseDataModel.status == YXOrderStatusCheckTransfer) {
        [self setSubFuncButtonWithTitlesArray:@[@"编辑凭证",
                                                @"联系客服"]];
    }
    
    //** 线下转账凭证审核失败 */
    if (orderDetailBaseDataModel.status == YXOrderStatusCheckTransferFaild) {
        [self setSubFuncButtonWithTitlesArray:@[@"其他方式支付",
                                                @"联系客服",
                                                @"上传凭证"]];
    }
    
    //** 部分付款之未支付定金 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPartPayment_notPayBond
        || orderDetailBaseDataModel.status == YXOrderStatusPartPayment_alreadyPayBond
        || orderDetailBaseDataModel.status == YXOrderStatusPartPayment) {
        [self setSubFuncButtonWithTitlesArray:@[@"继续支付",
                                                @"联系客服"]];
    }
    
    //** 待发货之未支付定金 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPendingDelivery_notPayBond
        || orderDetailBaseDataModel.status == YXOrderStatusPendingDelivery_alreadyPayBond) {
        [self setSubFuncButtonWithTitlesArray:@[@"提醒发货",
                                                @"联系客服"]];
    }
    
    //** 待收货 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPendingRecive) {
        if (orderDetailBaseDataModel.dataModel.deliveryType == 0) {
            [self setSubFuncButtonWithTitlesArray:@[@"查看物流",
                                                    @"联系客服"]];
        }
        
        if (orderDetailBaseDataModel.dataModel.deliveryType == 1) {
            [self setSubFuncButtonWithTitlesArray:@[@"联系客服"]];
        }
    }
    
    //** 待确认 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPendingSure) {
        if (orderDetailBaseDataModel.dataModel.deliveryType == 0) {
            [self setSubFuncButtonWithTitlesArray:@[@"确认收货",
                                                    @"查看物流",
                                                    @"联系客服"]];
        }
        
        if (orderDetailBaseDataModel.dataModel.deliveryType == 1) {
            [self setSubFuncButtonWithTitlesArray:@[@"确认收货",
                                                    @"联系客服"]];
        }
        
    }
    
    //** 交易完成 */
    if (orderDetailBaseDataModel.status == YXOrderStatusSuccess) {
        if (orderDetailBaseDataModel.dataModel.deliveryType == 0) {
            [self setSubFuncButtonWithTitlesArray:@[@"查看物流",
                                                    @"联系客服"]];
            /**
             @"评价",
             */
        }
        
        if (orderDetailBaseDataModel.dataModel.deliveryType == 1) {
            [self setSubFuncButtonWithTitlesArray:@[@"联系客服"]];
            /**
             @"评价",
             */
        }
    }
    
    //** 取消需要退款定金和部分货款 */
    if (orderDetailBaseDataModel.status == YXOrderStatusCancelNeedRefund_bondAndPartPayment
        || orderDetailBaseDataModel.status == YXOrderStatusCancelNeedRefund_partPayment) {
        [self setSubFuncButtonWithTitlesArray:@[@"申请退款",
                                                @"联系客服"]];
    }
    
    //** 取消不需退款 */
    if (orderDetailBaseDataModel.status == YXOrderStatusCancelNotNeedRefund_timeOut
        || orderDetailBaseDataModel.status == YXOrderStatusCancelNotNeedRefund_userCancel
        || orderDetailBaseDataModel.status == YXOrderStatusCancelNotNeedRefund_payedDeposit) {
        [self setSubFuncButtonWithTitlesArray:@[@"联系客服"]];
    }
    
    //** 退过款 */
    if (orderDetailBaseDataModel.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund_payedDeposit
        || orderDetailBaseDataModel.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund) {
        [self setSubFuncButtonWithTitlesArray:@[@"查看退款",
                                                @"联系客服"]];
    }
}

/**
 配置功能按钮样式

 @param titlesArray titlesArray
 */
- (void)setSubFuncButtonWithTitlesArray:(NSArray *)titlesArray
{
    [titlesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *title             = (NSString *)obj;
        UIButton *button            = self.funcButtonsArray[idx];
        button.hidden               = NO;
        [button setTitle:title forState:UIControlStateNormal];
        
        if (idx == 0) {
            [button setBackgroundColor:[UIColor mainThemColor]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
            
            button.layer.borderWidth    = 1.f;
            button.layer.borderColor    = [UIColor mainThemColor].CGColor;
        }
        
        if (idx == titlesArray.count - 1) {
            *stop = YES;
        }
    }];
}

#pragma mark - Third.点击事件

/**
 按钮点击事件

 @param sender 按钮
 */
- (void)funcButtonClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(orederDetailBottomFuncView:andClickButton:)]) {
        [_delegate orederDetailBottomFuncView:self andClickButton:sender];
    }
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 初始化

 @param frame frame
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupCustomUI];
    }
    return self;
}

/**
 布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIButton *rightButton   = self.funcButtonsArray[0];
    UIButton *centerButton  = self.funcButtonsArray[1];
    UIButton *leftButton    = self.funcButtonsArray[2];
    
    [rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-funcButtonRightSpacing);
        make.width.mas_equalTo(funcButtonWidth);
        make.height.mas_equalTo(funcButtonHeight);
    }];
    
    [centerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.mas_equalTo(rightButton);
        make.right.mas_equalTo(rightButton.mas_left).mas_offset(-funcButtonMargin);
    }];
    
    [leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.mas_equalTo(rightButton);
        make.right.mas_equalTo(centerButton.mas_left).mas_offset(-funcButtonMargin);
    }];
    
    [self.topSpacingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - Sixth.界面配置

/**
 配置界面
 */
- (void)setupCustomUI
{
    for (NSInteger i = 0; i < YXOrderDetailBottomFuncViewSubButtonMaxCount; i++) {
        UIButton *btn               = [UIButton new];
        btn.hidden                  = YES;
        btn.titleLabel.font         = [UIFont systemFontOfSize:12.f];
        btn.layer.cornerRadius      = 2.f;
        btn.layer.masksToBounds     = YES;
        [btn addTarget:self action:@selector(funcButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.funcButtonsArray addObject:btn];
    }
    
    [self addSubview:self.topSpacingView];
    self.backgroundColor            = [UIColor whiteColor];
}

#pragma mark - Seventh.懒加载

- (UIView *)topSpacingView
{
    if (!_topSpacingView) {
        _topSpacingView = [UIView new];
        _topSpacingView.backgroundColor = [UIColor themGrayColor];
    }
    return _topSpacingView;
}

- (NSMutableArray *)funcButtonsArray
{
    if (!_funcButtonsArray) {
        _funcButtonsArray = [NSMutableArray array];
    }
    return _funcButtonsArray;
}

@end
