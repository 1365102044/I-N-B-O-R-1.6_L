//
//  YXPaymentDetailCell.m
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPaymentDetailCell.h"
#import "UIColor+YXColor_Extension.h"

@interface YXPaymentDetailCell()

/**
 商品名称label
 */
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;

/**
 商品名称内容label
 */
@property (weak, nonatomic) IBOutlet UILabel *goodNameContentLabel;

/**
 订单总金额label
 */
@property (weak, nonatomic) IBOutlet UILabel *totleLabel;

/**
 应付金额label
 */
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;

/**
 订单总金额价格label
 */
@property (weak, nonatomic) IBOutlet UILabel *totleContentLabel;

/**
 应付金额价格label
 */
@property (weak, nonatomic) IBOutlet UILabel *handleContentLabel;

/**
 底部分割线视图
 */
@property (weak, nonatomic) IBOutlet UIView *bottomMarginLineView;
@end

@implementation YXPaymentDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 配置界面 */
    self.backgroundColor                                = [UIColor redColor];
    self.selectionStyle                                 = UITableViewCellSelectionStyleNone;
    
    self.goodNameLabel.font                             = [UIFont systemFontOfSize:14.f];
    self.goodNameContentLabel.font                      = [UIFont systemFontOfSize:14.f];
    
    self.totleLabel.font                                = [UIFont systemFontOfSize:13.f];
    self.totleLabel.textColor                           = [UIColor lightGrayColor];
    
    self.handleLabel.font                               = [UIFont systemFontOfSize:13.f];
    self.handleLabel.textColor                          = [UIColor lightGrayColor];
    
    self.totleContentLabel.font                         = [UIFont systemFontOfSize:13.f];
    self.totleContentLabel.textColor                    = [UIColor lightGrayColor];
    
    self.handleContentLabel.font                        = [UIFont systemFontOfSize:13.f];
    self.handleContentLabel.textColor                   = [UIColor themGoldColor];
    
    self.bottomMarginLineView.backgroundColor           = [UIColor themGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDeatilmodle:(YXPaymentHomepageViewDataModel *)deatilmodle
{
    _deatilmodle                = deatilmodle;
    
    _goodNameLabel.text         = @"商品名称：";
    _goodNameContentLabel.text  = deatilmodle.prodName;
    _totleLabel.text = @"订单总金额：";
    _totleContentLabel.text     = [NSString stringWithFormat:@"￥%@",
                                   [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                       [deatilmodle.totalAmount longLongValue] / 100]]];
    _handleLabel.text = @"待付金额：";
    _handleContentLabel.text    = [NSString stringWithFormat:@"￥%@",
                                   [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%lld",
                                                                       [deatilmodle.payAmount longLongValue] / 100]]];
}

@end
