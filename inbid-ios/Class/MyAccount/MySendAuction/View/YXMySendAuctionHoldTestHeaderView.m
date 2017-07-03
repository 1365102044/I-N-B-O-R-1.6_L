//
//  YXMySendAuctionHoldTestHeaderView.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySendAuctionHoldTestHeaderView.h"
#import "YXMySendAuctionHoldTest.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "UIColor+YXColor_Extension.h"

@interface YXMySendAuctionHoldTestHeaderView()<YBAttributeTapActionDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *submitTimeLabel;

//** 当前商品状态指示控件 */
@property (weak, nonatomic) IBOutlet UIView *tipsView;
//** 提示文字label */
@property (weak, nonatomic) IBOutlet UILabel *tipsTextLabel;
//** 重新提交按钮 */
@property (nonatomic, strong) UIButton *reSubmitButton;
//** 立即验证按钮 */
@property (nonatomic, strong) UIButton *nowVerificationButton;
//** 立即鉴定 */
@property (nonatomic, strong) UIButton *nowAppraisalButton;
//** 平台代卖按钮 */
@property (nonatomic, strong) UIButton *platformSellButton;
//** 平台回收 */
@property (nonatomic, strong) UIButton *platformRecoveryButton;
//** 立即邮寄 */
@property (nonatomic, strong) UIButton *nowMailButton;
//** 我要寄回 */
@property (nonatomic, strong) UIButton *mailBackButton;

//** 按钮的父控件 */
@property (weak, nonatomic) IBOutlet UIView *cellButtonSuperView;
//** 鉴定中lable */
@property (weak, nonatomic) IBOutlet UILabel *identificationLabel;
//** 鉴定编号label */
@property (weak, nonatomic) IBOutlet UILabel *identifyOrderIdLabel;

/**
 顶部分割线视图
 */
@property (weak, nonatomic) IBOutlet UIView *topMarginView;

/**
 底部分割线视图
 */
@property (weak, nonatomic) IBOutlet UIView *bottomMarginView;

@end

@implementation YXMySendAuctionHoldTestHeaderView

#pragma mark - 赋值


- (void)setCurrentSection:(NSInteger)currentSection
{
    _currentSection = currentSection;
    
    self.sendAuctionHoldTestModel.currentSection = currentSection;
}




- (void)setSendAuctionHoldTestModel:(YXMySendAuctionHoldTest *)sendAuctionHoldTestModel
{
    _sendAuctionHoldTestModel = sendAuctionHoldTestModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:sendAuctionHoldTestModel.imgUrl] placeholderImage:[UIImage imageNamed:@"ic_zhanwf"]];
    
    self.goodNameLabel.text = sendAuctionHoldTestModel.prodName;
    self.submitTimeLabel.text = sendAuctionHoldTestModel.createTime;
    self.identifyOrderIdLabel.text = [NSString stringWithFormat:@"鉴定编号：%lld", sendAuctionHoldTestModel.orderId];
    
    
    [self resetTipsView];
    /**
     * 订单状态
     * 1为刚提交，2为审核不通过，3为审核通过 ，4部分付款，5待发货，6待确认收货，7交易完成，8交易取消
     */
    //private Integer orderStatus;
    //@property (nonatomic, assign) NSInteger orderStatus;
    if (sendAuctionHoldTestModel.orderStatus == 1) {
        
        [self setTipsText:@"      您已提交商品图片和描述，等待审核中"];
        
    }else if (sendAuctionHoldTestModel.orderStatus == 2) {
        
        [self setTipsText:@"      您提交的商品图片无法被识别为奢侈品，请重新提交"];
        
        //添加重新提交按钮
        [self.cellButtonSuperView addSubview:self.reSubmitButton];
        
    }else if (sendAuctionHoldTestModel.orderStatus == 3) {
        
        if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"cardStatus"]] isEqualToString:@"1"]) {
            
            [self setTipsText:@"      您的商品需要进行官方鉴定，官方鉴定合格的商品将出示权威的鉴定报告"];
            
        }else{
            
            [self setTipsText:@"      您提交的商品已经通过初步审核，为了保证您后续的交易安全，请进行相关身份验证"];
            
            //添加立即验证按钮
            [self.cellButtonSuperView addSubview:self.nowVerificationButton];
        
        }
    }else if (sendAuctionHoldTestModel.orderStatus == 4) {
        [self setTipsText: @"      鉴定费不允许分笔支付，数据错误"];
    }else if (sendAuctionHoldTestModel.orderStatus == 5) {
        
        [self setTipsText:@"      请在15日之内将您的商品邮寄到胤宝官方"];
        
        //添加立即邮寄按钮
        [self.cellButtonSuperView addSubview:self.nowMailButton];
        
        
    }else if (sendAuctionHoldTestModel.orderStatus == 6) {
        /**
         * 物流类型，0为自送；1为走物流
         */
        //private Integer isDelivery;
        if (sendAuctionHoldTestModel.deliveryType == 1) {
            //--已邮寄
            [self setTipsText:@"      自送中"];
            self.identificationLabel.text = @"自送中";
            self.identificationLabel.hidden = NO;
        }else if (sendAuctionHoldTestModel.deliveryType == 0){
            [self setTipsText:@"      商品已寄出"];
            self.identificationLabel.text = @"已邮寄";
            self.identificationLabel.hidden = NO;
        }
    }else if (sendAuctionHoldTestModel.orderStatus == 7) {
        
        /**
         * 鉴定状态
         * 0待鉴定 1为鉴定中，2为鉴定成功；3为鉴定失败
         */
        //private Integer identifyStatus;
        //@property (nonatomic, assign) NSInteger identifyStatus;
        if (sendAuctionHoldTestModel.identifyStatus == 0) {
            
            [self setTipsText: @"      正在为您鉴定商品，请耐心等待"];
            
            //添加鉴定中按钮
            self.identificationLabel.text = @"鉴定中";
            self.identificationLabel.hidden = NO;
        }else if (sendAuctionHoldTestModel.identifyStatus == 1) {
            
            [self setTipsText: @"      正在为您鉴定商品，请耐心等待"];
            
            //添加鉴定中按钮
            self.identificationLabel.text = @"鉴定中";
            self.identificationLabel.hidden = NO;
        }else if (sendAuctionHoldTestModel.identifyStatus == 2) {
            
            [self setTipsText: @"      鉴定完毕，您的商品符合售卖规定。"];
            
            /**
             * 退回状态,1,未申请 2,已申请,3,退回中,4,已退回
             */
            //private Integer refundStatus;
            if (sendAuctionHoldTestModel.refundStatus == 1) {
                
                /**
                 * 对商品的处理状态
                 * 1为不同意交易；2为平台寄拍；3为回收价卖给平台,4=平台已打款
                 */
                //private Integer manageStatus;
                
                if (sendAuctionHoldTestModel.manageStatus == 1) {
                    //添加已申请
                    self.identificationLabel.text = @"已申请退回";
//                    [self.cellButtonSuperView addSubview:self.identificationLabel];
                    self.identificationLabel.hidden = NO;
                }else if (sendAuctionHoldTestModel.manageStatus == 2) {
                    
                    //添加已同意寄拍
                    //self.identificationLabel.text = @"已同意寄拍";
                    self.identificationLabel.text = @"平台已接受商品寄拍";
//                    [self.cellButtonSuperView addSubview:self.identificationLabel];
                    self.identificationLabel.hidden = NO;
                }else if (sendAuctionHoldTestModel.manageStatus == 3) {
                    //添加回收
                    //self.identificationLabel.text = @"已同意平台回收";
                    self.identificationLabel.text = @"平台打款中";
                    self.identificationLabel.hidden = NO;
//                    [self.cellButtonSuperView addSubview:self.identificationLabel];
                }else if (sendAuctionHoldTestModel.manageStatus == 4) {
                    //添加回收
                    self.identificationLabel.text = @"平台已打款";
                    self.identificationLabel.hidden = NO;
//                    [self.cellButtonSuperView addSubview:self.identificationLabel];
                }else if (sendAuctionHoldTestModel.manageStatus == 5) {
                    //添加回收
                    self.identificationLabel.text = @"已寄卖";
                    self.identificationLabel.hidden = NO;
                    //                    [self.cellButtonSuperView addSubview:self.identificationLabel];
                }else if (sendAuctionHoldTestModel.manageStatus == 0){
                    //鉴定结果
                    [self.cellButtonSuperView addSubview:self.platformSellButton];
                    //** 本地化当前状态，是否是鉴定完未处理状态 */
                    [YXUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%lld", self.sendAuctionHoldTestModel.orderId]];
                }
                
            }else if (sendAuctionHoldTestModel.refundStatus == 2) {
                //添加已申请
                self.identificationLabel.text = @"已申请退回";
                self.identificationLabel.hidden = NO;
//                [self.cellButtonSuperView addSubview:self.identificationLabel];
            }else if (sendAuctionHoldTestModel.refundStatus == 3) {
                //添加已申请
                self.identificationLabel.text = @"退回中";
                self.identificationLabel.hidden = NO;
//                [self.cellButtonSuperView addSubview:self.identificationLabel];
            }else if (sendAuctionHoldTestModel.refundStatus == 4) {
                //添加已申请
                self.identificationLabel.text = @"已退回";
                self.identificationLabel.hidden = NO;
//                [self.cellButtonSuperView addSubview:self.identificationLabel];
            }
            
            
            
        }else if (sendAuctionHoldTestModel.identifyStatus == 3) {
            
            [self setTipsText: @"      鉴定完毕，您的商品不符合售卖规定。"];
            /**
             * 退回状态,1,未申请 2,已申请,3,退回中,4,已退回
             */
            //private Integer refundStatus;
            if (sendAuctionHoldTestModel.refundStatus == 1) {
                [self.cellButtonSuperView addSubview:self.mailBackButton];
                //** 本地化当前状态，是否是鉴定完未处理状态 */
                [YXUserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%lld", self.sendAuctionHoldTestModel.orderId]];
            }else if (sendAuctionHoldTestModel.refundStatus == 2) {
                //添加已申请
                self.identificationLabel.text = @"已申请退回";
                //[self.cellButtonSuperView addSubview:self.identificationLabel];
                self.identificationLabel.hidden = NO;
            }else if (sendAuctionHoldTestModel.refundStatus == 3) {
                //添加已申请
                self.identificationLabel.text = @"退回中";
                //[self.cellButtonSuperView addSubview:self.identificationLabel];
                self.identificationLabel.hidden = NO;
            }else if (sendAuctionHoldTestModel.refundStatus == 4) {
                //添加已申请
                self.identificationLabel.text = @"已退回";
                //[self.cellButtonSuperView addSubview:self.identificationLabel];
                self.identificationLabel.hidden = NO;
            }
            
        }

    }else if (sendAuctionHoldTestModel.orderStatus == 8) {
        [self setTipsText: @"      交易已取消"];
    }
}

//** 重置提示视图 */
- (void)resetTipsView
{
    [self.reSubmitButton removeFromSuperview];
    [self.nowVerificationButton removeFromSuperview];
    [self.nowAppraisalButton removeFromSuperview];
    [self.platformSellButton removeFromSuperview];
    [self.platformRecoveryButton removeFromSuperview];
    [self.mailBackButton removeFromSuperview];
    [self.nowMailButton removeFromSuperview];
    self.identificationLabel.hidden = YES;
    self.nowAppraisalButton = nil;
    [YXUserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%lld", self.sendAuctionHoldTestModel.orderId]];
}


/**
 更新提示标签文案

 @param tipsText 传入提示文字
 */
- (void)setTipsText:(NSString *)tipsText
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;
    NSString *psText = tipsText;
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:psText];
    NSDictionary *allAttributes = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:10],
                                    NSParagraphStyleAttributeName:paragraphStyle
                                    };
    [attributes addAttributes:allAttributes range:NSMakeRange(0, psText.length)];
    
    if ([tipsText isEqualToString:@"      鉴定完毕，您的商品符合售卖规定。（查看鉴定报告）"]) {
        
        //[attributes addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:151.0/255.0 green:29.0/255.0 blue:20.0/255.0 alpha:1.0] range:NSMakeRange(22, 8)];
    }else if ([tipsText isEqualToString:@"      鉴定完毕，您的商品不符合售卖规定。（查看鉴定报告）"]) {
        
        //[attributes addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:151.0/255.0 green:29.0/255.0 blue:20.0/255.0 alpha:1.0] range:NSMakeRange(23, 8)];
    }
    
    self.tipsTextLabel.attributedText = attributes;
    self.tipsTextLabel.lineBreakMode=NSLineBreakByWordWrapping;
    //--添加点击事件
    [self.tipsTextLabel yb_addAttributeTapActionWithStrings:@[@"（查看鉴定报告）"] delegate:self];
}

#pragma mark - 响应事件

- (void)headerViewClick:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(mySendAuctionHoldTestHeaderView:andHoldTestModel:)]) {
        [self.delegate mySendAuctionHoldTestHeaderView:self andHoldTestModel:self.sendAuctionHoldTestModel];
    }
}


//** 其他功能按钮 */
- (void)otherFunctionButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(mySendAuctionHoldTestHeaderView:andButton:andHoldTestModel:)]) {
        [self.delegate mySendAuctionHoldTestHeaderView:self andButton:sender andHoldTestModel:self.sendAuctionHoldTestModel];
    }
}

#pragma mark - 代理方法

/**
 UILabel点击文字事件

 @param string 点击的文字
 @param range  范围
 @param index  下标
 */
- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index
{
    //回调到控制器，push鉴定报告界面
    if ([self.delegate respondsToSelector:@selector(mySendAuctionHoldTestHeaderView:andClickText:andIdentifyId:)]) {
        [self.delegate mySendAuctionHoldTestHeaderView:self andClickText:string andIdentifyId:self.sendAuctionHoldTestModel.orderId];
    }
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bgView;
    
    //添加手势点击
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClick:)];
//    [self addGestureRecognizer:tap];
    
    self.cellButtonSuperView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    
    //** 设置字体粗细 */
    //self.identifyOrderIdLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    //self.submitTimeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    //self.goodNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13.f];
    self.identificationLabel.textColor = [UIColor mainThemColor];
    
    self.topMarginView.backgroundColor = [UIColor themGrayColor];
    self.bottomMarginView.backgroundColor = [UIColor themGrayColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /**
     * 订单状态
     * 1为刚提交，2为审核不通过，3为审核通过 ，4部分付款，5待发货，6待确认收货，7交易完成，8交易取消
     */
    //private Integer orderStatus;
    //@property (nonatomic, assign) NSInteger orderStatus;
    if (self.sendAuctionHoldTestModel.orderStatus == 1) {
        
        
    }else if (self.sendAuctionHoldTestModel.orderStatus == 2) {
        
        [self.reSubmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cellButtonSuperView);
            make.width.mas_equalTo(77.5);
            make.height.mas_equalTo(25);
            make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
        }];
        
    }else if (self.sendAuctionHoldTestModel.orderStatus == 3) {
            
        if([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"cardStatus"]] isEqualToString:@"1"]){
            
            [self.nowAppraisalButton  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.cellButtonSuperView);
                make.width.mas_equalTo(77.5);
                make.height.mas_equalTo(25);
                make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
            }];
            
        }else{
            
            [self.nowVerificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.cellButtonSuperView);
                make.width.mas_equalTo(77.5);
                make.height.mas_equalTo(25);
                make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
            }];
        }
            
    }else if (self.sendAuctionHoldTestModel.orderStatus == 4) {
        
    }else if (self.sendAuctionHoldTestModel.orderStatus == 5) {
        //--立即邮寄
        [self.nowMailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cellButtonSuperView);
            make.width.mas_equalTo(77.5);
            make.height.mas_equalTo(25);
            make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
        }];
        
    }else if (self.sendAuctionHoldTestModel.orderStatus == 6) {
        
        //已邮寄
//        [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(self.cellButtonSuperView);
//            make.width.mas_equalTo(150);
//            make.height.mas_equalTo(25);
//            make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//        }];

        
    }else if (self.sendAuctionHoldTestModel.orderStatus == 7) {
        
        /**
         * 鉴定状态
         * 0待鉴定 1为鉴定中，2为鉴定成功；3为鉴定失败
         */
        //private Integer identifyStatus;
        //@property (nonatomic, assign) NSInteger identifyStatus;
        if (self.sendAuctionHoldTestModel.identifyStatus == 0) {
            
//            [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.mas_equalTo(self.cellButtonSuperView);
//                make.width.mas_equalTo(77.5);
//                make.height.mas_equalTo(25);
//                make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//            }];
            
        }else if (self.sendAuctionHoldTestModel.identifyStatus == 1) {
            
//            [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.mas_equalTo(self.cellButtonSuperView);
//                make.width.mas_equalTo(77.5);
//                make.height.mas_equalTo(25);
//                make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//            }];
            
        }else if (self.sendAuctionHoldTestModel.identifyStatus == 2) {
            
            /**
             * 退回状态,1,未申请 2,已申请,3,退回中,4,已退回
             */
            //private Integer refundStatus;
            if (self.sendAuctionHoldTestModel.refundStatus == 1) {
                
                /**
                 * 对商品的处理状态
                 * 1为不同意交易；2为平台寄拍；3为回收价卖给平台,4=平台已打款
                 */
                //private Integer manageStatus;
                
                if (self.sendAuctionHoldTestModel.manageStatus == 1) {
                    //添加已申请
//                    [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.centerY.mas_equalTo(self.cellButtonSuperView);
//                        make.width.mas_equalTo(150);
//                        make.height.mas_equalTo(25);
//                        make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                    }];
                    
                }else if (self.sendAuctionHoldTestModel.manageStatus == 2) {
                    
                    //添加已同意寄拍
//                    [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.centerY.mas_equalTo(self.cellButtonSuperView);
//                        make.width.mas_equalTo(150);
//                        make.height.mas_equalTo(25);
//                        make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                    }];
                    
                }else if (self.sendAuctionHoldTestModel.manageStatus == 3) {
                    //添加回收
//                    [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.centerY.mas_equalTo(self.cellButtonSuperView);
//                        make.width.mas_equalTo(150);
//                        make.height.mas_equalTo(25);
//                        make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                    }];
                }else if (self.sendAuctionHoldTestModel.manageStatus == 4) {
                    //添加回收
//                    [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.centerY.mas_equalTo(self.cellButtonSuperView);
//                        make.width.mas_equalTo(150);
//                        make.height.mas_equalTo(25);
//                        make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                    }];
                }else if (self.sendAuctionHoldTestModel.manageStatus == 0){
                    //if (self.sendAuctionHoldTestModel.recycleMoney != 0) {
                        
//                        [self.platformRecoveryButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.top.mas_equalTo(self.cellButtonSuperView);
//                            make.width.mas_equalTo(77.5);
//                            make.height.mas_equalTo(25);
//                            make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                        }];
                        
//                        [self.platformSellButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.top.mas_equalTo(self.cellButtonSuperView);
//                            make.width.mas_equalTo(77.5);
//                            make.height.mas_equalTo(25);
//                            make.right.mas_equalTo(self.platformRecoveryButton.mas_left).mas_offset(-7);
//                        }];
//                        
//                        [self.mailBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.top.mas_equalTo(self.cellButtonSuperView);
//                            if (iPHone5) {
//                                make.width.mas_equalTo(38.75);
//                            }else{
//                                make.width.mas_equalTo(77.5);
//                            }
//                            make.height.mas_equalTo(25);
//                            make.right.mas_equalTo(self.platformSellButton.mas_left).mas_offset(-7);
//                        }];
                        
                    //}else{
                        
                        [self.platformSellButton mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(self.cellButtonSuperView);
                            make.width.mas_equalTo(77.5);
                            make.height.mas_equalTo(25);
                            make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
                        }];
//
//                        [self.mailBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.top.mas_equalTo(self.cellButtonSuperView);
//                            make.width.mas_equalTo(77.5);
//                            make.height.mas_equalTo(25);
//                            make.right.mas_equalTo(self.platformSellButton.mas_left).mas_offset(-7);
//                        }];
                    //}

                }
                
            }else if (self.sendAuctionHoldTestModel.refundStatus == 2) {
                //添加已申请
                //添加回收
//                [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerY.mas_equalTo(self.cellButtonSuperView);
//                    make.width.mas_equalTo(150);
//                    make.height.mas_equalTo(25);
//                    make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                }];
            }else if (self.sendAuctionHoldTestModel.refundStatus == 3) {
                //添加已申请
                //添加回收
//                [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerY.mas_equalTo(self.cellButtonSuperView);
//                    make.width.mas_equalTo(150);
//                    make.height.mas_equalTo(25);
//                    make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                }];
            }else if (self.sendAuctionHoldTestModel.refundStatus == 4) {
                //添加已申请
                //添加回收
//                [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerY.mas_equalTo(self.cellButtonSuperView);
//                    make.width.mas_equalTo(150);
//                    make.height.mas_equalTo(25);
//                    make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                }];
            }
            
            
            
            
        }else if (self.sendAuctionHoldTestModel.identifyStatus == 3) {
         
            /**
             * 退回状态,1,未申请 2,已申请,3,退回中,4,已退回
             */
            //private Integer refundStatus;
            if (self.sendAuctionHoldTestModel.refundStatus == 1) {
                [self.mailBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.cellButtonSuperView);
                    make.width.mas_equalTo(77.5);
                    make.height.mas_equalTo(25);
                    make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
                }];
            }else if (self.sendAuctionHoldTestModel.refundStatus == 2) {
//                [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerY.mas_equalTo(self.cellButtonSuperView);
//                    make.width.mas_equalTo(100);
//                    make.height.mas_equalTo(25);
//                    make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                }];
            }else if (self.sendAuctionHoldTestModel.refundStatus == 3) {
//                [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerY.mas_equalTo(self.cellButtonSuperView);
//                    make.width.mas_equalTo(77.5);
//                    make.height.mas_equalTo(25);
//                    make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                }];
            }else if (self.sendAuctionHoldTestModel.refundStatus == 4) {
//                [self.identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerY.mas_equalTo(self.cellButtonSuperView);
//                    make.width.mas_equalTo(77.5);
//                    make.height.mas_equalTo(25);
//                    make.right.mas_equalTo(self.cellButtonSuperView).mas_offset(-13);
//                }];
            }
        }
        
    }else if (self.sendAuctionHoldTestModel.orderStatus == 8) {
        
    }
}


#pragma mark - 懒加载

- (UIButton *)reSubmitButton
{
    if (!_reSubmitButton) {
        _reSubmitButton = [[UIButton alloc] init];
        [_reSubmitButton setTitle:@"重新提交" forState:UIControlStateNormal];
        [_reSubmitButton setBackgroundColor:[UIColor mainThemColor]];
        [_reSubmitButton sizeToFit];
        _reSubmitButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _reSubmitButton.layer.cornerRadius = 2;
        [_reSubmitButton.layer masksToBounds];
        
        [_reSubmitButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reSubmitButton;
}

- (UIButton *)nowVerificationButton
{
    if (!_nowVerificationButton) {
        _nowVerificationButton = [[UIButton alloc] init];
        [_nowVerificationButton setTitle:@"立即验证" forState:UIControlStateNormal];
        [_nowVerificationButton setBackgroundColor:[UIColor mainThemColor]];
        [_nowVerificationButton sizeToFit];
        _nowVerificationButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _nowVerificationButton.layer.cornerRadius = 2;
        [_nowVerificationButton.layer masksToBounds];
        
        [_nowVerificationButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nowVerificationButton;
}

- (UIButton *)nowAppraisalButton
{
    if (!_nowAppraisalButton) {
        _nowAppraisalButton = [[UIButton alloc] init];
        [_nowAppraisalButton setTitle:@"立即鉴定" forState:UIControlStateNormal];
        [_nowAppraisalButton setBackgroundColor:[UIColor mainThemColor]];
        [_nowAppraisalButton sizeToFit];
        _nowAppraisalButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _nowAppraisalButton.layer.cornerRadius = 2;
        [_nowAppraisalButton.layer masksToBounds];
        //添加立即鉴定按钮
        [self.cellButtonSuperView addSubview:self.nowAppraisalButton];
        
        [_nowAppraisalButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nowAppraisalButton;
}

- (UIButton *)platformSellButton
{
    if (!_platformSellButton) {
        _platformSellButton = [[UIButton alloc] init];
        [_platformSellButton setTitle:@"鉴定结果" forState:UIControlStateNormal];
        [_platformSellButton setBackgroundColor:[UIColor mainThemColor]];
        [_platformSellButton sizeToFit];
        _platformSellButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _platformSellButton.layer.cornerRadius = 2;
        [_platformSellButton.layer masksToBounds];
        
        [_platformSellButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _platformSellButton;
}

- (UIButton *)platformRecoveryButton
{
    if (!_platformRecoveryButton) {
        _platformRecoveryButton = [[UIButton alloc] init];
        [_platformRecoveryButton setTitle:@"平台回收" forState:UIControlStateNormal];
        [_platformRecoveryButton setBackgroundColor:[UIColor mainThemColor]];
        [_platformRecoveryButton sizeToFit];
        _platformRecoveryButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _platformRecoveryButton.layer.cornerRadius = 2;
        [_platformRecoveryButton.layer masksToBounds];
        
        [_platformRecoveryButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _platformRecoveryButton;
}

- (UIButton *)nowMailButton
{
    if (!_nowMailButton) {
        _nowMailButton = [[UIButton alloc] init];
        [_nowMailButton setTitle:@"立即邮寄" forState:UIControlStateNormal];
        [_nowMailButton setBackgroundColor:[UIColor mainThemColor]];
        [_nowMailButton sizeToFit];
        _nowMailButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _nowMailButton.layer.cornerRadius = 2;
        [_nowMailButton.layer masksToBounds];
        
        [_nowMailButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _nowMailButton;
}

- (UIButton *)mailBackButton
{
    if (!_mailBackButton) {
        _mailBackButton = [[UIButton alloc] init];
        [_mailBackButton setTitle:@"我要退回" forState:UIControlStateNormal];
        [_mailBackButton setBackgroundColor:[UIColor mainThemColor]];
        [_mailBackButton sizeToFit];
        _mailBackButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _mailBackButton.layer.cornerRadius = 2;
        [_mailBackButton.layer masksToBounds];
        
        [_mailBackButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mailBackButton;
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.x = 0;
//    frame.size.height -= 10;
//    frame.origin.y += 10;
//    
//    [super setFrame:frame];
//}

@end
