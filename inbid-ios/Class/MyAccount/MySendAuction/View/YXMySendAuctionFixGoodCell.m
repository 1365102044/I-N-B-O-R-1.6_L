//
//  YXMySendAuctionFixGoodCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySendAuctionFixGoodCell.h"
#import "YXMySendAuctionHoldTest.h"

@interface YXMySendAuctionFixGoodCell()

//** 按钮的父控件 */
@property (weak, nonatomic) IBOutlet UIView *cellButtonSuperView;
//** 鉴定中lable */
@property (weak, nonatomic) IBOutlet UILabel *identificationLabel;
//** 鉴定编号label */
@property (weak, nonatomic) IBOutlet UILabel *identifyOrderIdLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *submitTimeLabel;

/**
 逾期处理
 */
@property (nonatomic, strong) UIButton *beOverdueButton;

/**
 顶部分割线
 */
@property (weak, nonatomic) IBOutlet UIView *topMarginView;

/**
 底部分割线
 */
@property (weak, nonatomic) IBOutlet UIView *bottomMarginView;

@end

@implementation YXMySendAuctionFixGoodCell

/**
 功能按钮点击

 @param sender sender
 */
- (void)otherFunctionButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(mySendAuctionFixGoodCell:funcButton:andModel:)]) {
        [self.delegate mySendAuctionFixGoodCell:self funcButton:sender andModel:self.sendAuctionHoldTestModel];
    }
}

/**
 控件赋值

 @param sendAuctionHoldTestModel sendAuctionHoldTestModel
 */
- (void)setSendAuctionHoldTestModel:(YXMySendAuctionHoldTest *)sendAuctionHoldTestModel
{
    _sendAuctionHoldTestModel = sendAuctionHoldTestModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:sendAuctionHoldTestModel.imgUrl] placeholderImage:[UIImage imageNamed:@"ic_zhanwf"]];
    
    self.goodNameLabel.text = sendAuctionHoldTestModel.prodName;
    self.submitTimeLabel.text = sendAuctionHoldTestModel.endTime;
    self.identifyOrderIdLabel.text = [NSString stringWithFormat:@"一口价编号：%lld", sendAuctionHoldTestModel.orderId];
    
    [self.beOverdueButton removeFromSuperview];
    self.identificationLabel.hidden = NO;
    
    if (sendAuctionHoldTestModel.bidStatus == 1) {
        self.identificationLabel.text = @"待出售";
    }else if (sendAuctionHoldTestModel.bidStatus == 2) {
        self.identificationLabel.text = @"出售中";
    }else if (sendAuctionHoldTestModel.bidStatus == 3) {
        self.identificationLabel.text = @"订单未支付";
    }else if (sendAuctionHoldTestModel.bidStatus == 4) {
        
        /**
         打款状态 1.平台未打款 2.平台打款中3.平台已打款
         */
        //@property (nonatomic, assign) NSInteger paymentStatus;
        if (sendAuctionHoldTestModel.paymentStatus == 2) {
            self.identificationLabel.text = @"平台打款中";
        }else if (sendAuctionHoldTestModel.paymentStatus == 3) {
            self.identificationLabel.text = @"平台已打款";
        }else{
            self.identificationLabel.text = @"已出售";
        }
        
    }else if (sendAuctionHoldTestModel.bidStatus == 5) {
        if (sendAuctionHoldTestModel.auctionStatus == 4) {
            self.identificationLabel.text = @"已申请退回";
        }else{
            self.identificationLabel.hidden = YES;
            [self.contentView addSubview:self.beOverdueButton];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.sendAuctionHoldTestModel.bidStatus == 5) {
        if (self.sendAuctionHoldTestModel.auctionStatus == 4) {
        }else{
            [self.beOverdueButton mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(77.5);
                make.height.mas_equalTo(25);
                make.right.mas_equalTo(self.contentView).mas_offset(-13);
                make.bottom.mas_equalTo(self.contentView).mas_offset(-13);
                
            }];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bgView;
    
    self.topMarginView.backgroundColor = [UIColor themGrayColor];
    self.bottomMarginView.backgroundColor = [UIColor themGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    frame.origin.x = 0;
//    frame.size.height -= 10;
//    frame.origin.y += 10;
//}

- (UIButton *)beOverdueButton
{
    if (!_beOverdueButton) {
        _beOverdueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beOverdueButton setTitle:@"逾期处理" forState:UIControlStateNormal];
        _beOverdueButton.backgroundColor = [UIColor mainThemColor];
        [_beOverdueButton sizeToFit];
        _beOverdueButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _beOverdueButton.layer.cornerRadius = 2;
        [_beOverdueButton.layer masksToBounds];
        [_beOverdueButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beOverdueButton;
}

@end
