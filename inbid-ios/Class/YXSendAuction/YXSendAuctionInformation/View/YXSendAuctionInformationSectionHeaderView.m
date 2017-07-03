//
//  YXSendAuctionInformationSectionHeaderView.m
//  YXSendAuction
//
//  Created by 郑键 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionInformationSectionHeaderView.h"
#import "YXMySendAuctionSubTableViewController.h"
#import "YXSendAuctionGetIdentifuDetails.h"


@interface YXSendAuctionInformationSectionHeaderView()

/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

/**
 title
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 title左边约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeftCons;

/**
 物品当前状态label
 */
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end


@implementation YXSendAuctionInformationSectionHeaderView

#pragma mark - 赋值

- (void)setIdentifuDetails:(YXSendAuctionGetIdentifuDetails *)identifuDetails
{
    _identifuDetails = identifuDetails;
    
    if (identifuDetails) {
        self.iconImageView.hidden = YES;
        self.titleLabelLeftCons.constant = -12;
        self.statusLabel.hidden = NO;
        self.titleLabel.text = [NSString stringWithFormat:@"鉴定编号：%lld", identifuDetails.orderId];
        
        
        if (self.identifuDetails.orderStatus == 1) {
            self.statusLabel.text = @"刚提交";
        }else if (self.identifuDetails.orderStatus == 2) {
            self.statusLabel.text = @"审核不通过";
        }else if (self.identifuDetails.orderStatus == 3) {
            if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"cardStatus"]] isEqualToString:@"1"]) {
                self.statusLabel.text = @"审核通过";
            }else{
                self.statusLabel.text = @"未进行身份验证";
            }
        }else if (self.identifuDetails.orderStatus == 4) {
            self.statusLabel.text = @"部分付款";
        }else if (self.identifuDetails.orderStatus == 5) {
            self.statusLabel.text = @"待邮寄";
        }else if (self.identifuDetails.orderStatus == 6) {
            /**
             * 物流类型，0为自送；1为走物流
             */
            //private Integer isDelivery;
            if (self.identifuDetails.deliveryType == 1) {
                //--已邮寄
               self.statusLabel.text = @"自送中";
            }else if (self.identifuDetails.deliveryType == 0){
                self.statusLabel.text = @"已邮寄";
            }
            
        }else if (self.identifuDetails.orderStatus == 7) {
            /**
             * 鉴定状态
             * 0待鉴定 1为鉴定中，2为鉴定成功；3为鉴定失败
             */
            //private Integer identifyStatus;
            //@property (nonatomic, assign) NSInteger identifyStatus;
            if (self.identifuDetails.identifyStatus == 0) {
                self.statusLabel.text = @"鉴定中";
            }else if (self.identifuDetails.identifyStatus == 1) {
                self.statusLabel.text = @"鉴定中";
            }else if (self.identifuDetails.identifyStatus == 2) {
                /**
                 * 退回状态,1,未申请 2,已申请,3,退回中,4,已退回
                 */
                //private Integer refundStatus;
                if (self.identifuDetails.refundStatus == 1) {
                    
                    /**
                     * 对商品的处理状态
                     * 1为不同意交易；2为平台寄拍；3为回收价卖给平台,4=平台已打款,5=一口价
                     */
                    //private Integer manageStatus;
                    
                    if (self.identifuDetails.manageStatus == 1) {
                        self.statusLabel.text = @"已申请退回";
                    }else if (self.identifuDetails.manageStatus == 2) {
                        self.statusLabel.text = @"平台已接受商品寄拍";
                    }else if (self.identifuDetails.manageStatus == 3) {
                        //self.statusLabel.text = @"平台回收";
                        self.statusLabel.text = @"平台打款中";
                    }else if (self.identifuDetails.manageStatus == 4) {
                        self.statusLabel.text = @"平台已打款";
                    }else if (self.identifuDetails.manageStatus == 5) {
                        self.statusLabel.text = @"已寄卖";
                    }else if (self.identifuDetails.manageStatus == 0){
                        if (self.identifuDetails.recycleMoney == 0) {
                            self.statusLabel.text = @"鉴定成功";
                        }else{
                            self.statusLabel.text = @"鉴定成功";
                        }
                    }
                }else if (self.identifuDetails.refundStatus == 2) {
                    self.statusLabel.text = @"已申请退回";
                }else if (self.identifuDetails.refundStatus == 3) {
                    self.statusLabel.text = @"退回中";
                }else if (self.identifuDetails.refundStatus == 4) {
                    self.statusLabel.text = @"已退回";
                }
            }else if (self.identifuDetails.identifyStatus == 3) {
                /**
                 * 退回状态,1,未申请 2,已申请,3,退回中,4,已退回
                 */
                //private Integer refundStatus;
                if (self.identifuDetails.refundStatus == 1) {
                    self.statusLabel.text = @"鉴定失败";
                }else if (self.identifuDetails.refundStatus == 2) {
                    self.statusLabel.text = @"已申请退回";
                }else if (self.identifuDetails.refundStatus == 3) {
                    self.statusLabel.text = @"退回中";
                }else if (self.identifuDetails.refundStatus == 4) {
                    self.statusLabel.text = @"已退回";
                }
            }
        }else if (self.identifuDetails.orderStatus == 8) {
            self.statusLabel.text = @"交易取消";
        }
        
        
        
        
    }else{
        self.iconImageView.hidden = NO;
        self.statusLabel.hidden = YES;
        self.titleLabelLeftCons.constant = 4;
        self.iconImageView.image = [UIImage imageNamed:self.dataDict[@"titleImageNamed"]];
        self.titleLabel.text = self.dataDict[@"title"];
        self.statusLabel.hidden = YES;
    }
}


- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    
    if ([dataDict[@"title"] isEqualToString:@"订单编号"]) {
        self.iconImageView.hidden = YES;
        self.titleLabelLeftCons.constant = -12;
        self.statusLabel.hidden = NO;
        self.titleLabel.text = @"鉴定编号:";
    }else{
        self.iconImageView.hidden = NO;
        self.statusLabel.hidden = YES;
        self.titleLabelLeftCons.constant = 4;
        self.iconImageView.image = [UIImage imageNamed:dataDict[@"titleImageNamed"]];
        self.titleLabel.text = dataDict[@"title"];
    }
}

- (void)setSourceController:(UIViewController *)sourceController
{
    _sourceController = sourceController;
    
//    if ([self.sourceController isKindOfClass:[YXMySendAuctionSubTableViewController class]]) {
//        self.statusLabel.hidden = YES;
//        return;
//    }
//    
//    //设置文案行间距
//    //--初始化
//    if ([self.dataDict[@"title"] isEqualToString:@"订单号"]) {
//        self.iconImageView.hidden = YES;
//        self.titleLabelLeftCons.constant = -12;
//        self.statusLabel.hidden = NO;
//        self.titleLabel.text = [NSString stringWithFormat:@"订单号：%@", [YXSendAuctionManager defaultSendAuctionManager].orderId];
//        self.statusLabel.text = @"已提交";
//    }else{
//        self.iconImageView.hidden = NO;
//        self.statusLabel.hidden = YES;
//        self.titleLabelLeftCons.constant = 4;
//        self.iconImageView.image = [UIImage imageNamed:self.dataDict[@"titleImageNamed"]];
//        self.titleLabel.text = self.dataDict[@"title"];
//    }
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bgView;
    
    self.statusLabel.textColor = [UIColor mainThemColor];
}

@end
