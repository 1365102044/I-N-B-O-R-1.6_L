//
//  YXMyAccoutWaitPaymentTypeView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccoutWaitPaymentTypeView.h"

@interface YXMyAccoutWaitPaymentTypeView ()
{

    UIButton *wuliuBtn;
    UIButton*zitiBtn;
}

@end

@implementation YXMyAccoutWaitPaymentTypeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        wuliuBtn = [[UIButton alloc]init];
        [wuliuBtn setTitle:@"物流快递" forState:UIControlStateNormal];
        wuliuBtn.layer.cornerRadius = 1;
        wuliuBtn.layer.borderWidth = 1;
        wuliuBtn.layer.borderColor = [UIColor mainThemColor].CGColor;
        wuliuBtn.layer.masksToBounds = YES;
        [wuliuBtn addTarget:self action:@selector(clickpaytype:) forControlEvents:UIControlEventTouchUpInside];
        wuliuBtn.titleLabel.font = YXRegularfont(11);
        [wuliuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        wuliuBtn.tag = 100;
        
        zitiBtn = [[UIButton alloc]init];
        [zitiBtn setTitle:@"上门自提" forState:UIControlStateNormal];
        zitiBtn.layer.cornerRadius = 2;
        zitiBtn.layer.borderWidth = 0.7;
        zitiBtn.layer.borderColor = [UIColor mainThemColor].CGColor;
        zitiBtn.layer.masksToBounds = YES;
        [zitiBtn addTarget:self action:@selector(clickpaytype:) forControlEvents:UIControlEventTouchUpInside];
        zitiBtn.titleLabel.font = YXRegularfont(11);
        zitiBtn.tag = 200;
        [zitiBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];

        
        [self addSubview:wuliuBtn];
        [self addSubview:zitiBtn];
        
        wuliuBtn.selected = YES;
        wuliuBtn.backgroundColor = [UIColor mainThemColor];
        
    }
    return self;
}

-(void)clickpaytype:(UIButton*)sender
{
    if (sender.tag == 100) {
        
        wuliuBtn.backgroundColor = [UIColor mainThemColor];
        zitiBtn.backgroundColor = [UIColor clearColor];
        [zitiBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        [wuliuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [[NSNotificationCenter defaultCenter]  postNotificationName:@"develyType" object:nil userInfo:@{@"tag" : @"1"}];

        
    }else if (sender.tag==200){
    
        
        [[NSNotificationCenter defaultCenter]  postNotificationName:@"develyType" object:nil userInfo:@{@"tag" : @"2"}];
        
        zitiBtn.backgroundColor = [UIColor mainThemColor];
        wuliuBtn.backgroundColor = [UIColor clearColor];
        [wuliuBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        [zitiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    wuliuBtn.frame = CGRectMake(10, 5, 80, 25);
    
    zitiBtn.frame = CGRectMake(wuliuBtn.right +50, wuliuBtn.y, 80, 25);
    
    
    

}

@end
