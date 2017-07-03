//
//  YXNoPayMoneyCell.m
//  Payment
//
//  Created by 郑键 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXNoPayMoneyCell.h"
#import "YXPaymentHomepageViewDataModel.h"
#import "YXStringFilterTool.h"

@interface YXNoPayMoneyCell()

/**
 顶部分割线视图
 */
@property (weak, nonatomic) IBOutlet UIView *topMarginView;

/**
 底部分割视图
 */
@property (weak, nonatomic) IBOutlet UIView *bottomMarginView;

/**
 价格label
 */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation YXNoPayMoneyCell

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 界面赋值

 @param dataModel dataModel 模型数据
 */
- (void)setDataModel:(YXPaymentHomepageViewDataModel *)dataModel
{
    _dataModel = dataModel;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@", [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%zd", dataModel.payAmount.integerValue / 100]]];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 界面样式 */
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.topMarginView.backgroundColor = [UIColor colorWithWhite:237.0/255.0 alpha:1.0];
    self.bottomMarginView.backgroundColor = [UIColor colorWithWhite:237.0/255.0 alpha:1.0];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
