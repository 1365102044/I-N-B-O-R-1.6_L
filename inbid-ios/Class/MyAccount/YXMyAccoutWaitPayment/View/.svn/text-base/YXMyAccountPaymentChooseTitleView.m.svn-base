//
//  YXMyAccountPaymentChooseTitleView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountPaymentChooseTitleView.h"

@interface YXMyAccountPaymentChooseTitleView ()

{
    UIImageView *leftimageview;
    UILabel *chooseTitlelable;

    
}

@end

@implementation YXMyAccountPaymentChooseTitleView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        leftimageview = [[UIImageView alloc]init];
        leftimageview.image = [UIImage imageNamed:@"waitpaymenttype"];
        
        
        chooseTitlelable = [[UILabel alloc]init];
        chooseTitlelable.text = @"选择支付方式";
        chooseTitlelable.textColor =UIColorFromRGB(0x050505);
        chooseTitlelable.font = YXRegularfont(13);
        
        
        [self addSubview:leftimageview];
        [self addSubview:chooseTitlelable];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    leftimageview.frame = CGRectMake(10, 12, 15, 15);
    chooseTitlelable.frame = CGRectMake(leftimageview.right+4, 0, YXScreenW-20-20, self.height);
    
    

}

-(void)setIsPartPay:(NSInteger)isPartPay
{
    _isPartPay = isPartPay;
    NSString  *alerypay = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",[self.alearypaycount integerValue]/100] ];

    if (isPartPay == 1) {
        chooseTitlelable.text = [NSString stringWithFormat:@"已选择分笔支付，已支付￥%@元",alerypay];
    }
    
}

-(void)setAlearypaycount:(NSString *)alearypaycount
{
    _alearypaycount = alearypaycount;
    NSString  *alerypay = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",[self.alearypaycount integerValue]/100] ];
    if (_isPartPay == 1) {
        chooseTitlelable.text = [NSString stringWithFormat:@"已选择分笔支付，已支付￥%@元",alerypay];
    }
    
}

@end
