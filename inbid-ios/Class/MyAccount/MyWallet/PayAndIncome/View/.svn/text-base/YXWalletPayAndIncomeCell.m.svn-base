//
//  YXWalletPayAndIncomeCell.m
//  inbid-ios
//
//  Created by 郑键 on 17/2/23.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXWalletPayAndIncomeCell.h"
#import "YXWalletPayAndIncomeDataModel.h"

@interface YXWalletPayAndIncomeCell()

/**
 button
 */
@property (nonatomic, strong) UIButton *selectedDateButton;

/**
 Top titleLabel
 */
@property (nonatomic, strong) UILabel *topTitleLable;

/**
 Top detailLabel
 */
@property (nonatomic, strong) UILabel *topDetailLabel;

/**
 bottom titleLabel
 */
@property (nonatomic, strong) UILabel *bottomTitleLabel;

/**
 bottom detailLabel
 */
@property (nonatomic, strong) UILabel *bottomDetailLabel;

/**
 button
 */
@property (nonatomic, strong) UIButton *funcButton;

/**
 bgView
 */
@property (nonatomic, strong) UIView *myBackgroundView;

/**
 bottomMarginLine
 */
@property (nonatomic, strong) UIView *bottomMarginLineView;

@end

@implementation YXWalletPayAndIncomeCell

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 赋值界面

 @param dataModel dataModel
 */
- (void)setDataModel:(YXWalletPayAndIncomeDataModel *)dataModel
{
    _dataModel = dataModel;
    
    [self resetSubViewStatus];
    
    if (dataModel.isLastCell) {
        
        self.funcButton.hidden = NO;
        self.topTitleLable.hidden = NO;
        self.bottomMarginLineView.hidden = YES;
        
        self.myBackgroundView.backgroundColor = [UIColor themLightGrayColor];
        self.topTitleLable.text = @"只有这点收支记录";

        /**
         *  最后一个cell
         */
        [self.topTitleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(5));
            make.centerX.mas_equalTo(self.contentView);
        }];
        
        [self.funcButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.topTitleLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(0));
        }];
        
    }else{
        
        self.topTitleLable.hidden = NO;
        self.topDetailLabel.hidden = NO;
        self.bottomTitleLabel.hidden = NO;
        self.bottomDetailLabel.hidden = NO;
        self.bottomMarginLineView.hidden = NO;
        
        self.myBackgroundView.backgroundColor = [UIColor whiteColor];
        
        /**
         *  重新布局控件
         */
        [self.topTitleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(10));
        }];
        
        [self.topDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topTitleLable);
            make.right.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(-15));
        }];
        
        [self.bottomTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.top.mas_equalTo(self.topTitleLable.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(5));
        }];
        
        [self.bottomDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bottomTitleLabel);
            make.right.mas_equalTo(self.topDetailLabel);
        }];
        
        
        /**
         *  根据状态判断并赋值
         */
        if ([dataModel.oid_biz isEqualToString:@"202000"]) {
            self.topTitleLable.text = @"提现";
            
        }else if ([dataModel.oid_biz isEqualToString:@"107001"]) {
            self.topTitleLable.text = @"交易付款";
        }
        
        /**
         *  付款金额
         */
        if (dataModel.flag_dc) {
            self.bottomTitleLabel.text = [NSString stringWithFormat:@"¥%@",
                                          [YXStringFilterTool strmethodComma:dataModel.amt_outoccur]];
            self.bottomDetailLabel.text = @"支出";
        }else{
            self.bottomTitleLabel.text = [NSString stringWithFormat:@"¥%@",
                                          [YXStringFilterTool strmethodComma:dataModel.amt_inoccur]];
            self.bottomDetailLabel.text = @"收入";
        }
        
        /**
         *  时间
         */
        self.topDetailLabel.text = dataModel.dt_billtrans;
    }
}

/**
 重置控件状态
 */
- (void)resetSubViewStatus
{
    self.topTitleLable.hidden = YES;
    self.topDetailLabel.hidden = YES;
    self.bottomTitleLabel.hidden = YES;
    self.bottomDetailLabel.hidden = YES;
    self.funcButton.hidden = YES;
}

#pragma mark - Third.点击事件

/**
 选择日期按钮

 @param sender sender
 */
- (void)funcButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(walletPayAndIncomeCell:buttonClick:)]) {
        [self.delegate walletPayAndIncomeCell:self buttonClick:sender];
    }
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.视图生命周期

/**
 初始化

 @param style                       style
 @param reuseIdentifier             reuseIdentifier
 @return return                     value
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCustomUI];
    }
    return self;
}


#pragma mark - Sixth.界面配置

- (void)setupCustomUI
{
    self.backgroundView = self.myBackgroundView;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.selectedDateButton];
    [self.contentView addSubview:self.funcButton];
    [self.contentView addSubview:self.bottomMarginLineView];
    
    [self.bottomMarginLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(1));
    }];
    
    NSMutableArray *tempArrayM = [NSMutableArray array];
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = SYSTEM_FONT(14.f);
    label1.textColor = [UIColor walletTextColor];
    [self.contentView addSubview:label1];
    _topTitleLable = label1;
    [tempArrayM addObject:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = SYSTEM_FONT(11.f);
    label2.textColor = [UIColor walletTextColor];
    [self.contentView addSubview:label2];
    [tempArrayM addObject:label2];
    _topDetailLabel = label2;
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.font = SYSTEM_FONT(11.f);
    label3.textColor = [UIColor walletTextColor];
    [self.contentView addSubview:label3];
    [tempArrayM addObject:label3];
    _bottomTitleLabel = label3;
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.font = SYSTEM_FONT(11.f);
    label4.textColor = [UIColor walletTextColor];
    [self.contentView addSubview:label4];
    [tempArrayM addObject:label4];
    _bottomDetailLabel = label4;
}

#pragma mark - Seventh.懒加载

- (UIView *)bottomMarginLineView
{
    if (!_bottomMarginLineView) {
        _bottomMarginLineView = [UIView new];
        _bottomMarginLineView.backgroundColor = [UIColor themGrayColor];
    }
    return _bottomMarginLineView;
}

- (UIView *)myBackgroundView
{
    if (!_myBackgroundView) {
        _myBackgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        _myBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _myBackgroundView;
}

- (UIButton *)funcButton
{
    if (!_funcButton) {
        _funcButton = [[UIButton alloc] init];
        _funcButton.titleLabel.font = REGULAR_FONT(14);
        [_funcButton setTitle:@"查看其它时间段收支记录"
                     forState: UIControlStateNormal];
        [_funcButton setTitleColor:[UIColor systemButtonTextColor]
                          forState:UIControlStateNormal];
        [_funcButton addTarget:self
                        action:@selector(funcButtonClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [_funcButton sizeToFit];
    }
    return _funcButton;
}

@end
