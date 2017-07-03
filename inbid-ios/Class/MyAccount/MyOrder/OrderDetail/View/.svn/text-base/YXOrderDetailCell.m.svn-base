//
//  YXOrderDetailCell.m
//  OrderDetail
//
//  Created by 郑键 on 16/12/13.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXOrderDetailCell.h"
#import "YXOrderDetailBaseDataModel.h"
#import "YXStringFilterTool.h"

@interface YXOrderDetailCell()

/**
 子控件数组
 */
@property (nonatomic, strong) NSMutableArray *subLabelsArray;

/**
 辅助视图
 */
@property (nonatomic, strong) UIImageView *accessimageView;

/**
 间距分割线
 */
@property (nonatomic, strong) UIView *marginLineView;

/**
 汽车标志
 */
@property (nonatomic, strong) UIImageView *carImageView;

/**
 倒计时label
 */
@property (nonatomic, weak) UILabel *countDownlabel;

@end

@implementation YXOrderDetailCell

#pragma mark - Zero.Const

/**
 最大label数量
 */
CGFloat maxSubLabelsCount               = 10;

/**
 状态label上边距
 */
CGFloat statusLabelTopSpacing           = 20;

/**
 订单总金额label左边距
 */
CGFloat totleMoneyLabelLeftSpacing      = 12;

/**
 订单总金额label上边距
 */
CGFloat totleMoneyLabelTopSpacing       = 15;

/**
 订单金额label内间距
 */
CGFloat lableVMargin                    = 14;

/**
 副主视图右侧边距
 */
CGFloat accessImageViewRightSpacing     = 10;

/**
 邮寄方式上边距
 */
CGFloat mailTypeTopSpacing              = 20;

/**
 邮寄方式label间距
 
 */
CGFloat mailTypeLabelMargin             = 13;

/**
 辅助视图宽
 */
CGFloat accessImageWidth                = 7;

/**
 辅助视图高
 */
CGFloat accessImageHeight               = 12.5;

/**
 状态辅助视图宽高
 */
CGFloat statusImageHeightAndWidth       = 14;

#pragma mark - First.通知

/**
 接收到倒计时通知
 */
- (void)changeCountDownLabel:(NSNotification *)no
{
    //** 状态显示 */
    if (![self.orderDetailBaseDataModel isKindOfClass:[YXOrderDetailBaseDataModel class]]) return;
    
    if (self.style == YXOrderDetailCellStatus) {
        if (self.orderDetailBaseDataModel.status == YXOrderStatusSuccess) {
            [self resetSubLabelsWithCount:1 andHiddenStatus:NO];
        }
        
        if (self.orderDetailBaseDataModel.status != YXOrderStatusSuccess) {
            [self resetSubLabelsWithCount:2 andHiddenStatus:NO];
        }
        
        self.marginLineView.hidden      = NO;
        UILabel *firstLabel             = self.subLabelsArray.firstObject;
        UILabel *secondLabel            = self.subLabelsArray[1];
        
        [self setupLabelWithText:self.orderDetailBaseDataModel.title
                     andFontSize:14.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:firstLabel];
        [self setupLabelWithText:self.orderDetailBaseDataModel.detailTitle
                     andFontSize:11.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:YES
                        andLabel:secondLabel];
    }
}

#pragma mark - Second.赋值

/**
 基础模型

 @param orderDetailBaseDataModel 数据模型
 */
- (void)setOrderDetailBaseDataModel:(YXOrderDetailBaseDataModel *)orderDetailBaseDataModel
{
    _orderDetailBaseDataModel = orderDetailBaseDataModel;
    
    //** 赋值 */
}

/**
 根据对应样式设置界面

 @param style 样式枚举
 */
- (void)setStyle:(YXOrderDetailCellStyle)style
{
    _style = style;
    
    if (self.style == YXOrderDetailCellNone) return;
    
    [self resetSubLabelsWithCount:self.subLabelsArray.count andHiddenStatus:YES];
    
    //** 状态显示 */
    if (self.style == YXOrderDetailCellStatus) {
        if (self.orderDetailBaseDataModel.status == YXOrderStatusSuccess) {
            [self resetSubLabelsWithCount:1 andHiddenStatus:NO];
        }
        
        if (self.orderDetailBaseDataModel.status != YXOrderStatusSuccess) {
            if ([self checkIsNeedCountDownLabel]) {
                [self resetSubLabelsWithCount:3 andHiddenStatus:NO];
            }else{
                [self resetSubLabelsWithCount:2 andHiddenStatus:NO];
            }
        }
        
        UILabel *firstLabel                     = self.subLabelsArray.firstObject;
        UILabel *secondLabel                    = self.subLabelsArray[1];
        firstLabel.textAlignment                = NSTextAlignmentCenter;
        secondLabel.textAlignment               = NSTextAlignmentCenter;
        self.accessimageView.hidden             = NO;
        self.marginLineView.hidden              = NO;
        self.accessimageView.image              = [UIImage imageNamed:self.orderDetailBaseDataModel.accessImageNamed];
        
        [self setupLabelWithText:self.orderDetailBaseDataModel.title
                     andFontSize:14.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:firstLabel];
        [self setupLabelWithText:self.orderDetailBaseDataModel.detailTitle
                     andFontSize:11.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:YES
                        andLabel:secondLabel];
    }
    
    //** 当前详情金额 */
    if (self.style == YXOrderDetailCellDetail) {
        [self resetSubLabelsWithCount:maxSubLabelsCount andHiddenStatus:NO];
        
        UILabel *totleMoneyLabel                = self.subLabelsArray[0];
        UILabel *totleMoneyCountentLabel        = self.subLabelsArray[1];
        UILabel *mailMoneyLabel                 = self.subLabelsArray[2];
        UILabel *mailMoneyContentLabel          = self.subLabelsArray[3];
        UILabel *payedLabel                     = self.subLabelsArray[4];
        UILabel *payedContentLabel              = self.subLabelsArray[5];
        UILabel *surplusLabel                   = self.subLabelsArray[6];
        UILabel *surplusContentLabel            = self.subLabelsArray[7];
        UILabel *benefitLabel                   = self.subLabelsArray[8];
        UILabel *benefitContentLabel            = self.subLabelsArray[9];
        self.marginLineView.hidden              = NO;
        
        [self setupLabelWithText:@"订单总金额"
                     andFontSize:13.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:NO
                        andLabel:totleMoneyLabel];
        [self setupLabelWithText:[NSString stringWithFormat:@"¥%@",
                                  [self setMoneyStrmethodComma:self.orderDetailBaseDataModel.dataModel.orderTotalAmount]]
                     andFontSize:13.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:NO
                        andLabel:totleMoneyCountentLabel];
        
        [self setupLabelWithText:@"+运费（含商品保价费）"
                     andFontSize:11.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:YES
                        andLabel:mailMoneyLabel];
        [self setupLabelWithText:[NSString stringWithFormat:@"¥%@",
                                  [self setMoneyStrmethodComma:(self.orderDetailBaseDataModel.dataModel.carriage
                                                                + self.orderDetailBaseDataModel.dataModel.protectPrice)]]
                     andFontSize:11.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:NO
                        andLabel:mailMoneyContentLabel];
       
        [self setupLabelWithText:@"-活动优惠（包邮）"
                     andFontSize:11.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:YES
                        andLabel:benefitLabel];
        [self setupLabelWithText:[NSString stringWithFormat:@"¥%@",
                                  [self setMoneyStrmethodComma:self.orderDetailBaseDataModel.dataModel.orderDiscountAmount]]
                     andFontSize:11.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:NO
                        andLabel:benefitContentLabel];
        
        [self setupLabelWithText:@"-已付金额"
                     andFontSize:11.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:YES
                        andLabel:payedLabel];
        [self setupLabelWithText:[NSString stringWithFormat:@"¥%@",
                                  [self setMoneyStrmethodComma:self.orderDetailBaseDataModel.dataModel.alreadyPayAmount]]
                     andFontSize:11.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:NO
                        andLabel:payedContentLabel];
        
        [self setupLabelWithText:@"待付金额"
                     andFontSize:13.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:NO
                        andLabel:surplusLabel];
        [self setupLabelWithText:[NSString stringWithFormat:@"¥%@",
                                  [self setMoneyStrmethodComma:self.orderDetailBaseDataModel.dataModel.calculationAmount]]
                     andFontSize:13.0
                    andTextColor:[UIColor themGoldColor]
            andIsPingFangSCLight:NO
                        andLabel:surplusContentLabel];
    }
    
    //** 支付方式 */
    if (self.style == YXOrderDetailCellPaymentStyle) {
        [self resetSubLabelsWithCount:2 andHiddenStatus:NO];
        
        UILabel *firstLabel                     = self.subLabelsArray[0];
        UILabel *secondLabel                    = self.subLabelsArray[1];
        self.accessimageView.hidden             = NO;
        self.accessimageView.image              = [UIImage imageNamed:@"返回"];
        self.marginLineView.hidden              = NO;
        
        [self setupLabelWithText:self.orderDetailBaseDataModel.title
                     andFontSize:13.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:NO
                        andLabel:firstLabel];
        [self setupLabelWithText:self.orderDetailBaseDataModel.detailTitle
                     andFontSize:12.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:YES
                        andLabel:secondLabel];
    }
    
    //** 邮寄方式 */
    if (self.style == YXOrderDetailCellMail) {
        [self resetSubLabelsWithCount:6 andHiddenStatus:NO];
        
        UILabel *mailTypeLabel                  = self.subLabelsArray[0];
        UILabel *mailTypeContentLabel           = self.subLabelsArray[1];
        UILabel *consigneeLabel                 = self.subLabelsArray[2];
        UILabel *consigneeContentLabel          = self.subLabelsArray[3];
        UILabel *addressLabel                   = self.subLabelsArray[4];
        UILabel *addressContentLabel            = self.subLabelsArray[5];
        
        [self setupLabelWithText:@"配送方式"
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:mailTypeLabel];
        [self setupLabelWithText:@"快递邮寄"
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:mailTypeContentLabel];
        
        [self setupLabelWithText:@"收货人"
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:consigneeLabel];
        [self setupLabelWithText:[NSString stringWithFormat:@"%@  %@",
                                  self.orderDetailBaseDataModel.dataModel.consigneeName,
                                  self.orderDetailBaseDataModel.dataModel.consigneeMobile]
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:consigneeContentLabel];
        
        [self setupLabelWithText:@"收货地址"
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:addressLabel];
        [self setupLabelWithText:[NSString stringWithFormat:@"%@%@%@",
                                  self.orderDetailBaseDataModel.dataModel.consigneeProvince,
                                  self.orderDetailBaseDataModel.dataModel.consigneeCity,
                                  self.orderDetailBaseDataModel.dataModel.consigneeAddressDetail]
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:addressContentLabel];
    }
    
    //** 最新物流展示及点击查询物流 */
    if (self.style == YXOrderDetailCellLogistics) {
        
    }
    
    //** 自提 */
    if (self.style == YXOrderDetailCellMailPickUp) {
        [self resetSubLabelsWithCount:7 andHiddenStatus:NO];
        
        self.marginLineView.hidden                  = NO;
        UILabel *deliveryTypeLabel                  = self.subLabelsArray[0];
        UILabel *pickUpAddressLabel                 = self.subLabelsArray[1];
        UILabel *vipNumberLabel                     = self.subLabelsArray[2];
        UILabel *businessTimeLabel                  = self.subLabelsArray[3];
        UILabel *userInformataionLabel              = self.subLabelsArray[4];
        UILabel *userNameAndPhoneNumberLable        = self.subLabelsArray[5];
        UILabel *cardIdLabel                        = self.subLabelsArray[6];
        
        [self setupLabelWithText:@"配送方式  自提"
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:deliveryTypeLabel];
        [self setupLabelWithText:[NSString stringWithFormat:@"自提地址  %@",
                                  [YXUserDefaults objectForKey:@"consigneeAddress"]]
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:pickUpAddressLabel];
        
        [self setupLabelWithText:[NSString stringWithFormat:@"贵宾专线  %@",
                                  [YXUserDefaults objectForKey:@"customerPhone"]]
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:vipNumberLabel];
        [self setupLabelWithText:[NSString stringWithFormat:@"营业时间  %@",
                                  [YXUserDefaults objectForKey:@"businessTime"]]
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:businessTimeLabel];
        
        [self setupLabelWithText:@"自提人联系信息"
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:userInformataionLabel];
        [self setupLabelWithText:[NSString stringWithFormat:@"%@  %@",
                                  self.orderDetailBaseDataModel.dataModel.pickupName,
                                  self.orderDetailBaseDataModel.dataModel.pickupMobile]
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:userNameAndPhoneNumberLable];
        [self setupLabelWithText:[NSString stringWithFormat:@"%@",
                                  self.orderDetailBaseDataModel.dataModel.pickupIdCard]
                     andFontSize:11.0
                    andTextColor:[UIColor orderTextColor]
            andIsPingFangSCLight:YES
                        andLabel:cardIdLabel];
    }
    
    //** 时间详情 */
    if (self.style == YXOrderDetailTimeDetail) {
        [self resetSubLabelsWithCount:2 andHiddenStatus:NO];
        
        UILabel *firstLabel                         = self.subLabelsArray[0];
        UILabel *secondLabel                        = self.subLabelsArray[1];

        [self setupLabelWithText:self.orderDetailBaseDataModel.title
                     andFontSize:12.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:YES
                        andLabel:firstLabel];
        [self setupLabelWithText:self.orderDetailBaseDataModel.detailTitle
                     andFontSize:12.0
                    andTextColor:[UIColor orderUnitPriceTextColor]
            andIsPingFangSCLight:YES
                        andLabel:secondLabel];
    }
}

/**
 查看是否需要倒计时label
 */
- (BOOL)checkIsNeedCountDownLabel
{
    if (self.orderDetailBaseDataModel.status == YXOrderStatusPendingPayment
        || self.orderDetailBaseDataModel.status == YXOrderStatusPendingPayment_lineTransfer
        || self.orderDetailBaseDataModel.status == YXOrderStatusPartPayment
        || self.orderDetailBaseDataModel.status == YXOrderStatusPartPayment_alreadyPayBond
        || self.orderDetailBaseDataModel.status == YXOrderStatusPartPayment_notPayBond
        || self.orderDetailBaseDataModel.status == YXOrderStatusCheckTransferFaild) {
        return YES;
    }else{
        return NO;
    }
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
 科学计数法

 @param price 价格
 */
- (NSString *)setMoneyStrmethodComma:(long long)price
{
    return [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld", price]];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 实例化控件

 @param style               样式
 @param reuseIdentifier     重用标志
 @return                    实例对象
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCustomUI];
        [self registerNotifcation];
    }
    return self;
}

/**
 布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.style == YXOrderDetailCellNone) return;
    
    //** 状态显示 */
    if (self.style == YXOrderDetailCellStatus) {
        
        UILabel *firstLabel                 = self.subLabelsArray.firstObject;
        UILabel *secondLabel                = self.subLabelsArray[1];
        
        [firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).mas_offset(statusLabelTopSpacing);
        }];
        
        [secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(firstLabel.mas_bottom).mas_offset(statusLabelTopSpacing);
            make.left.mas_equalTo(self.contentView).mas_offset(totleMoneyLabelLeftSpacing);
            make.right.mas_equalTo(self.contentView).mas_offset(-totleMoneyLabelLeftSpacing);
        }];
        
        [self.marginLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.accessimageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(firstLabel);
            make.right.mas_equalTo(firstLabel.mas_left).mas_offset(-lableVMargin * 0.5);
            make.width.height.mas_equalTo(statusImageHeightAndWidth);
        }];
    }
    
    //** 当前详情金额 */
    if (self.style == YXOrderDetailCellDetail) {
        
        UILabel *totleMoneyLabel            = self.subLabelsArray[0];
        UILabel *totleMoneyCountentLabel    = self.subLabelsArray[1];
        UILabel *mailMoneyLabel             = self.subLabelsArray[2];
        UILabel *mailMoneyContentLabel      = self.subLabelsArray[3];
        UILabel *payedLabel                 = self.subLabelsArray[4];
        UILabel *payedContentLabel          = self.subLabelsArray[5];
        UILabel *surplusLabel               = self.subLabelsArray[6];
        UILabel *surplusContentLabel        = self.subLabelsArray[7];
        UILabel *benefitLabel               = self.subLabelsArray[8];
        UILabel *benefitContentLabel        = self.subLabelsArray[9];
        
        [totleMoneyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(totleMoneyLabelLeftSpacing);
            make.top.mas_equalTo(self.contentView).mas_offset(totleMoneyLabelTopSpacing);
        }];
        
        [totleMoneyCountentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_offset(-totleMoneyLabelLeftSpacing);
            make.top.mas_equalTo(totleMoneyLabel);
        }];
        
        [mailMoneyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(totleMoneyLabel).mas_offset(totleMoneyLabelLeftSpacing);
            make.top.mas_equalTo(totleMoneyLabel.mas_bottom).mas_offset(lableVMargin);
        }];
        
        [mailMoneyContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(totleMoneyCountentLabel);
            make.top.mas_equalTo(mailMoneyLabel);
        }];
        
        [benefitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(mailMoneyLabel);
            make.top.mas_equalTo(mailMoneyLabel.mas_bottom).mas_offset(lableVMargin);
        }];
        
        [benefitContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(totleMoneyCountentLabel);
            make.top.mas_equalTo(benefitLabel);
        }];
        
        [payedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(mailMoneyLabel);
            make.top.mas_equalTo(benefitLabel.mas_bottom).mas_offset(lableVMargin);
        }];
        
        [payedContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(totleMoneyCountentLabel);
            make.top.mas_equalTo(payedLabel);
            
        }];
        
        [surplusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(totleMoneyLabel);
            make.top.mas_equalTo(self.marginLineView.mas_bottom).mas_offset(totleMoneyLabelTopSpacing);
        }];
        
        [surplusContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(payedContentLabel);
            make.top.mas_equalTo(surplusLabel);
        }];
        
        [self.marginLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
            make.top.mas_equalTo(payedLabel.mas_bottom).mas_offset(totleMoneyLabelTopSpacing);
        }];
    }
    
    //** 支付方式 */
    if (self.style == YXOrderDetailCellPaymentStyle) {
        self.accessimageView.hidden         = NO;
        UILabel *firstLabel                 = self.subLabelsArray[0];
        UILabel *secondLabel                = self.subLabelsArray[1];
        [firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(totleMoneyLabelLeftSpacing);
            make.top.mas_equalTo(self.contentView).mas_offset(totleMoneyLabelTopSpacing);
        }];
        
        [secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(firstLabel);
            make.right.mas_equalTo(self.accessimageView.mas_left).mas_offset(-lableVMargin);
        }];
        
        [self.accessimageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_offset(-accessImageViewRightSpacing);
            make.centerY.mas_equalTo(firstLabel);
            make.width.mas_equalTo(accessImageWidth);
            make.height.mas_equalTo(accessImageHeight);
        }];
        
        [self.marginLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    
    //** 邮寄方式 */
    if (self.style == YXOrderDetailCellMail) {
        
        UILabel *mailTypeLabel              = self.subLabelsArray[0];
        UILabel *mailTypeContentLabel       = self.subLabelsArray[1];
        UILabel *consigneeLabel             = self.subLabelsArray[2];
        UILabel *consigneeContentLabel      = self.subLabelsArray[3];
        UILabel *addressLabel               = self.subLabelsArray[4];
        UILabel *addressContentLabel        = self.subLabelsArray[5];
        
        [mailTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(totleMoneyLabelLeftSpacing);
            make.top.mas_equalTo(self.contentView).mas_offset(mailTypeTopSpacing);
        }];
        
        [mailTypeContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(mailTypeLabel.mas_right).mas_offset(lableVMargin);
            make.top.mas_equalTo(mailTypeLabel);
        }];
        
        [consigneeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(totleMoneyLabelLeftSpacing);
            make.top.mas_equalTo(mailTypeLabel.mas_bottom).mas_offset(mailTypeLabelMargin);
        }];
        
        [consigneeContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(mailTypeContentLabel);
            make.top.mas_equalTo(consigneeLabel);
        }];
        
        [addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(totleMoneyLabelLeftSpacing);
            make.top.mas_equalTo(consigneeLabel.mas_bottom).mas_offset(mailTypeLabelMargin);
        }];
        
        [addressContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(addressLabel.mas_right).mas_offset(lableVMargin);
            make.top.mas_equalTo(addressLabel);
        }];
    }
    
    //** 最新物流展示及点击查询物流 */
    if (self.style == YXOrderDetailCellLogistics) {
        
       
    }
    
    //** 自提 */
    if (self.style == YXOrderDetailCellMailPickUp) {
        
        UILabel *deliveryTypeLabel              = self.subLabelsArray[0];
        UILabel *pickUpAddressLabel             = self.subLabelsArray[1];
        UILabel *vipNumberLabel                 = self.subLabelsArray[2];
        UILabel *businessTimeLabel              = self.subLabelsArray[3];
        UILabel *userInformataionLabel          = self.subLabelsArray[4];
        UILabel *userNameAndPhoneNumberLable    = self.subLabelsArray[5];
        UILabel *cardIdLabel                    = self.subLabelsArray[6];
        
        [deliveryTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(totleMoneyLabelLeftSpacing);
            make.top.mas_equalTo(self.contentView).mas_offset(statusLabelTopSpacing);
        }];
        
        [pickUpAddressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(deliveryTypeLabel);
            make.top.mas_equalTo(deliveryTypeLabel.mas_bottom).mas_offset(lableVMargin);
        }];
        
        [vipNumberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(pickUpAddressLabel);
            make.top.mas_equalTo(pickUpAddressLabel.mas_bottom).mas_offset(lableVMargin);
        }];
        
        [businessTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vipNumberLabel);
            make.top.mas_equalTo(vipNumberLabel.mas_bottom).mas_offset(lableVMargin);
        }];
        
        [userInformataionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(businessTimeLabel);
            make.top.mas_equalTo(self.marginLineView.mas_bottom).mas_offset(mailTypeTopSpacing);
        }];
        
        [userNameAndPhoneNumberLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userInformataionLabel);
            make.top.mas_equalTo(userInformataionLabel.mas_bottom).mas_offset(lableVMargin);
        }];
        
        [cardIdLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userNameAndPhoneNumberLable);
            make.top.mas_equalTo(userNameAndPhoneNumberLable.mas_bottom).mas_offset(lableVMargin);
        }];
        
        [self.marginLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(businessTimeLabel.mas_bottom).mas_offset(mailTypeTopSpacing);
            make.height.mas_equalTo(0.5);
        }];
    }
    
    //** 时间详情 */
    if (self.style == YXOrderDetailTimeDetail) {
        
        UILabel *firstLabel     = self.subLabelsArray[0];
        UILabel *secondLabel    = self.subLabelsArray[1];
        
        [firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).mas_offset(totleMoneyLabelLeftSpacing);
        }];
        
        [secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(firstLabel);
            make.left.mas_equalTo(firstLabel.mas_right);
        }];
        
    }
}

/**
 注销
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YXOrderDetailCellCountDownNotification object:nil];
}

#pragma mark - Sixth.界面配置

/**
 切换所有子控件状态

 @param hiddenStatus 是否隐藏
 */
- (void)resetAllSubViewsWithHiddenStatus:(BOOL)hiddenStatus
{
    [self resetSubLabelsWithCount:maxSubLabelsCount andHiddenStatus:hiddenStatus];
    self.marginLineView.hidden          = hiddenStatus;
    self.carImageView.hidden            = hiddenStatus;
    self.accessimageView.hidden         = hiddenStatus;
}

/**
 切换控件状态

 @param count                   数量
 @param hiddenStatus            状态
 */
- (void)resetSubLabelsWithCount:(NSInteger)count andHiddenStatus:(BOOL)hiddenStatus
{
    if (hiddenStatus) {
        self.carImageView.hidden        = hiddenStatus;
        self.marginLineView.hidden      = hiddenStatus;
        self.accessimageView.hidden     = hiddenStatus;
    }
    
    [self.subLabelsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = (UILabel *)obj;
        label.hidden = hiddenStatus;
        if (idx == (count - 1)) {
            *stop = YES;
        }
    }];
}

/**
 配置界面
 */
- (void)setupCustomUI
{
    for (NSInteger i = 0; i < maxSubLabelsCount; i++) {
        UILabel *label          = [UILabel new];
        label.hidden            = YES;
        label.numberOfLines     = 0;
        label.backgroundColor   = [UIColor whiteColor];
        [self.subLabelsArray addObject:label];
        [self.contentView addSubview:label];
    }
    
    [self.contentView addSubview:self.marginLineView];
    [self.contentView addSubview:self.accessimageView];
    [self.contentView addSubview:self.carImageView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 注册通知
 */
- (void)registerNotifcation
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCountDownLabel:) name:YXOrderDetailCellCountDownNotification object:nil];
}

#pragma mark - Seventh.懒加载

- (UIImageView *)carImageView
{
    if (!_carImageView) {
        _carImageView = [UIImageView new];
    }
    return _carImageView;
}

- (UIView *)marginLineView
{
    if (!_marginLineView) {
        _marginLineView = [[UIView alloc] init];
        _marginLineView.backgroundColor = [UIColor themGrayColor];
    }
    return _marginLineView;
}

- (UIImageView *)accessimageView
{
    if (!_accessimageView) {
        _accessimageView = [UIImageView new];
        _accessimageView.backgroundColor = [UIColor whiteColor];
    }
    return _accessimageView;
}


- (NSMutableArray *)subLabelsArray
{
    if (!_subLabelsArray) {
        _subLabelsArray = [NSMutableArray array];
    }
    return _subLabelsArray;
}

@end
