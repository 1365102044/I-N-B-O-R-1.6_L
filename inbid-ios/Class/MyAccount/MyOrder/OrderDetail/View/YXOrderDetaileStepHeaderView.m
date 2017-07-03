//
//  YXOrderDetaileStepHeaderView.m
//  OrderDetail
//
//  Created by 郑键 on 16/12/14.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXOrderDetaileStepHeaderView.h"
#import "YXOrderDetailBaseDataModel.h"
#import "UIColor+YXColor_Extension.h"

@interface YXOrderDetaileStepHeaderView()

/**
 文字label集合
 */
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *stepTextLabelsArray;

/**
 数字label集合
 */
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *stepNumberLabelsArray;

/**
 进度指示线集合
 */
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *stepLineViewsArray;

@end

@implementation YXOrderDetaileStepHeaderView

#pragma mark - Zero.Const

/**
 numberLabel的宽高
 */
CGFloat numberLabelWidthAndHeight   = 21;

/**
 numberLabel的宽高
 */
CGFloat numberSpacing               = 35.5;

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 数据赋值

 @param orderDetailBaseDataModel 数据
 */
- (void)setOrderDetailBaseDataModel:(YXOrderDetailBaseDataModel *)orderDetailBaseDataModel
{
    _orderDetailBaseDataModel = orderDetailBaseDataModel;
    
    NSArray *tempArray = [self getStepTextArrayWithType:2];
    
    //** 未支付 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPendingPayment
        || orderDetailBaseDataModel.status == YXOrderStatusPendingPayment_lineTransfer
        || orderDetailBaseDataModel.status == YXOrderStatusCheckTransfer
        || orderDetailBaseDataModel.status == YXOrderStatusCheckTransferFaild) {
        [self changeStepStatusWithCurrentIndex:1
                               andCurrentColor:[UIColor mainThemColor]
                              andSetupSubViews:NO
                             andTitleTextArray:tempArray];
    }
    
    //** 部分付款 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPartPayment_notPayBond
        || orderDetailBaseDataModel.status == YXOrderStatusPartPayment
        || orderDetailBaseDataModel.status == YXOrderStatusPartPayment_alreadyPayBond) {
        [self changeStepStatusWithCurrentIndex:1
                               andCurrentColor:[UIColor mainThemColor]
                              andSetupSubViews:NO
                             andTitleTextArray:tempArray];
    }
    
    //** 待发货 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPendingDelivery_notPayBond
        || orderDetailBaseDataModel.status == YXOrderStatusPendingDelivery_alreadyPayBond) {
        [self changeStepStatusWithCurrentIndex:2
                               andCurrentColor:[UIColor mainThemColor]
                              andSetupSubViews:NO
                             andTitleTextArray:tempArray];
    }
    
    //** 待收货 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPendingRecive) {
        [self changeStepStatusWithCurrentIndex:3
                               andCurrentColor:[UIColor mainThemColor]
                              andSetupSubViews:NO
                             andTitleTextArray:tempArray];
    }
    
    //** 待确认 */
    if (orderDetailBaseDataModel.status == YXOrderStatusPendingSure) {
        [self changeStepStatusWithCurrentIndex:4
                               andCurrentColor:[UIColor mainThemColor]
                              andSetupSubViews:NO
                             andTitleTextArray:tempArray];
    }
    
    //** 交易完成 */
    if (orderDetailBaseDataModel.status == YXOrderStatusSuccess) {
        [self changeStepStatusWithCurrentIndex:5
                               andCurrentColor:[UIColor mainThemColor]
                              andSetupSubViews:NO
                             andTitleTextArray:tempArray];
    }
    
    //** 如果订单取消，那么隐藏控件 */
    if (orderDetailBaseDataModel.status == YXOrderStatusCancelNotNeedRefund_payedDeposit
        || orderDetailBaseDataModel.status == YXOrderStatusCancelNotNeedRefund_timeOut
        || orderDetailBaseDataModel.status == YXOrderStatusCancelNotNeedRefund_userCancel
        || orderDetailBaseDataModel.status == YXOrderStatusCancelNeedRefund_partPayment
        || orderDetailBaseDataModel.status == YXOrderStatusCancelNeedRefund_bondAndPartPayment
        || orderDetailBaseDataModel.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund_payedDeposit
        || orderDetailBaseDataModel.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund) {
        [self changeSubViewsHiddenWithHiddenStatus:YES];
    }else{
        [self changeSubViewsHiddenWithHiddenStatus:NO];
    }
}

/**
 切换子控件是否隐藏

 @param hiddenStatus 隐藏状态
 */
- (void)changeSubViewsHiddenWithHiddenStatus:(BOOL)hiddenStatus
{
    [self.stepNumberLabelsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = (UILabel *)obj;
        
        UILabel *textLabel = (UILabel *)self.stepTextLabelsArray[idx];
        
        label.hidden = hiddenStatus;
        textLabel.hidden = hiddenStatus;
    }];
    
    [self.stepLineViewsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *lineView = (UIView *)obj;
        lineView.hidden = hiddenStatus;
    }];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 注册入口

 @param reuseIdentifier         重用标志
 @return                        返回对象实例
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle]
                loadNibNamed:NSStringFromClass([YXOrderDetaileStepHeaderView class])
                owner:nil
                options:nil].lastObject;
    }
    return self;
}

/**
 从xib加载
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bgView;
    
    [self changeStepStatusWithCurrentIndex:self.stepNumberLabelsArray.count
                           andCurrentColor:[UIColor orderStepNormalColor]
                          andSetupSubViews:YES
                         andTitleTextArray: [self getStepTextArrayWithType:1]];
}

/**
 获取状态文字数组

 @param type type 1.刚开始 2.进行中
 */
- (NSArray *)getStepTextArrayWithType:(NSInteger)type
{
    //** 判断是否是自提 */
    if (self.orderDetailBaseDataModel.dataModel.deliveryType == 0) {
        
        if (type == 1) return @[@"已下单",
                                @"待付款",
                                @"待发货",
                                @"待收货",
                                @"待确认"];
        
        if (type == 2) return @[@"已下单",
                                @"已付款",
                                @"已发货",
                                @"已收货",
                                @"已确认"];
    }
    
    if (self.orderDetailBaseDataModel.dataModel.deliveryType == 1) {
        if (type == 1) return @[@"已下单",
                                @"待付款",
                                @"待配货",
                                @"待自提",
                                @"待确认"];
        
        if (type == 2) return @[@"已下单",
                                @"已付款",
                                @"已配货",
                                @"已自提",
                                @"已确认"];
    }
    return nil;
}

#pragma mark - Sixth.界面配置

/**
 根据下标修改当前step状态展示

 @param index 下标
 */
- (void)changeStepStatusWithCurrentIndex:(NSInteger)index
                         andCurrentColor:(UIColor *)currentColor
                        andSetupSubViews:(BOOL)isSetupSubViews
                       andTitleTextArray:(NSArray *)titleTextArray
{
    if (index == 1) {
        [self chageStepLineStatusWithIndexArray:@[@0]
                                andCurrentColor:currentColor];
    }
    
    if (index == 2) {
        [self chageStepLineStatusWithIndexArray:@[@0,
                                                  @1,
                                                  @2]
                                andCurrentColor:currentColor];
    }
    
    if (index == 3) {
        [self chageStepLineStatusWithIndexArray:@[@0,
                                                  @1,
                                                  @2,
                                                  @3,
                                                  @4]
                                andCurrentColor:currentColor];
    }
    
    if (index == 4) {
        [self chageStepLineStatusWithIndexArray:@[@0,
                                                  @1,
                                                  @2,
                                                  @3,
                                                  @4,
                                                  @5,
                                                  @6]
                                andCurrentColor:currentColor];
    }
    
    if (index == 5) {
        [self chageStepLineStatusWithIndexArray:@[@0,
                                                  @1,
                                                  @2,
                                                  @3,
                                                  @4,
                                                  @5,
                                                  @6,
                                                  @7]
                                andCurrentColor:currentColor];
    }
    
    [self.stepNumberLabelsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *label                  = (UILabel *)obj;
        label.backgroundColor           = currentColor;
        
        UILabel *textLabel              = self.stepTextLabelsArray[idx];
        textLabel.textColor             = currentColor;
        textLabel.text                  = titleTextArray[idx];
        textLabel.font                  = [UIFont systemFontOfSize:11];
        
        if (isSetupSubViews) {
            //** 画边框，及圆角 */
            label.layer.borderWidth     = 2.f;
            label.layer.borderColor     = currentColor.CGColor;
            label.layer.cornerRadius    = numberLabelWidthAndHeight * 0.5;
            label.layer.masksToBounds   = YES;
            label.textColor             = [UIColor whiteColor];
            label.font                  = [UIFont systemFontOfSize:10];
            
            textLabel.font              = YXRegularfont(11);
            textLabel.textColor         = [UIColor normalTextColor];
        }
        
        if (idx == index - 1) {
            *stop = YES;
        }
    }];
}

/**
 变换当前进度指示线颜色

 @param indexArray 下标数组
 */
- (void)chageStepLineStatusWithIndexArray:(NSArray *)indexArray
                          andCurrentColor:(UIColor *)currentColor
{
    for (NSNumber *number in indexArray) {
        UIView *lineView = self.stepLineViewsArray[number.integerValue];
        lineView.backgroundColor = currentColor;
    }
}

#pragma mark - Seventh.懒加载

@end
