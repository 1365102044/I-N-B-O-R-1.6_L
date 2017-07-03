//
//  YXPayMentOrderBaseView.m
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPayMentOrderBaseView.h"
#import "YXPayMentOrderdeatilTopview.h"
#import "YXPayMentOrderdeatilGoodsInformationView.h"
#import "YXPayMentOrderdeatilPayTypeView.h"
@interface YXPayMentOrderBaseView ()

@property(nonatomic,strong)  YXPayMentOrderdeatilGoodsInformationView *GoodsInformationView;
@property(nonatomic,strong)  YXPayMentOrderdeatilTopview *JinDuTopView;
@property(nonatomic,strong) YXPayMentOrderdeatilPayTypeView * PayTypeView;
@end
@implementation YXPayMentOrderBaseView

-(YXPayMentOrderdeatilGoodsInformationView*)GoodsInformationView
{
    if (!_GoodsInformationView) {
        _GoodsInformationView = [[YXPayMentOrderdeatilGoodsInformationView alloc]init];
        _GoodsInformationView.backgroundColor = [UIColor whiteColor];
    }
    return _GoodsInformationView;
}
-(YXPayMentOrderdeatilTopview*)JinDuTopView
{
    if (!_JinDuTopView) {
        
        _JinDuTopView = [[YXPayMentOrderdeatilTopview alloc]init];
        _JinDuTopView.backgroundColor = [UIColor whiteColor];
        _JinDuTopView.layer.borderWidth = 0.5;
        _JinDuTopView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    }
    return _JinDuTopView;
}
-(YXPayMentOrderdeatilPayTypeView *)PayTypeView
{
    if (!_PayTypeView) {
        _PayTypeView = [[YXPayMentOrderdeatilPayTypeView alloc]init];
        _PayTypeView.backgroundColor = [UIColor whiteColor];
        _PayTypeView.layer.borderWidth = 0.5;
        _PayTypeView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    }
    return _PayTypeView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        

        [self addSubview:self.JinDuTopView];
        [self addSubview:self.GoodsInformationView];
        [self addSubview:self.PayTypeView];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.JinDuTopView.frame = CGRectMake(0, 0, YXScreenW, 160);
    self.GoodsInformationView.frame = CGRectMake(0, self.JinDuTopView.bottom+10, YXScreenW, 190);
    self.PayTypeView.frame = CGRectMake(0, self.GoodsInformationView.bottom, YXScreenW, 200);
    if (self.heightblock) {
        self.heightblock(self.PayTypeView.bottom);
    }
}
@end
