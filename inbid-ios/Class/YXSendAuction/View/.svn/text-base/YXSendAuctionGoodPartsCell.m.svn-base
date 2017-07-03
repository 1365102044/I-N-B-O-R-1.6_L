//
//  YXSendAuctionGoodPartsCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/16.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionGoodPartsCell.h"
#import "YXSendAuctionGoodPartsModel.h"

@interface YXSendAuctionGoodPartsCell()

/**
 商品配件按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *partButton;

@end

@implementation YXSendAuctionGoodPartsCell

/**
 配件按钮点击事件

 @param sender sender
 */
- (IBAction)partButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.model.isDisable = sender.selected;
    
    if ([self.delegate respondsToSelector:@selector(sendAuctionGoodPartsCell:andClickButtonModel:)]) {
        [self.delegate sendAuctionGoodPartsCell:self andClickButtonModel:self.model];
    }
}

/**
 赋值

 @param model model
 */
- (void)setModel:(YXSendAuctionGoodPartsModel *)model
{
    _model = model;
    [self.partButton setTitle:model.dataValue forState:UIControlStateNormal];
    self.partButton.selected = model.isDisable;
}

/**
 初始化
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.partButton setBackgroundImage:[UIImage imageNamed:@"ic_sendAuction_goodPart_sel"] forState:UIControlStateSelected];
    [self.partButton setBackgroundImage:[UIImage imageNamed:@"ic_myLabel_nor"] forState:UIControlStateNormal];
    [self.partButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateSelected];
    [self.partButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
}

@end
