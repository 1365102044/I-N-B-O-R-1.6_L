//
//  YXPayMentOrderdeatilPayTypeView.m
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPayMentOrderdeatilPayTypeView.h"

@interface YXPayMentOrderdeatilPayTypeView ()
{
    UILabel *paytypetitle;
    
    UIView *addressview;
    UILabel *peisonglable;
    UILabel *shouhuopersonlable;
    UILabel *shouhuoaddresslable;
    
    UILabel *dingdannumberlable;
    UILabel *ceartTimelable;
    
}

@end
@implementation YXPayMentOrderdeatilPayTypeView



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
         UIColor *color = UIColorFromRGB(0x050505);
        paytypetitle = [self creatlable:@"支付方式   网银转账汇款" font:11 textcolor:color];
        [self addSubview:paytypetitle];
        
        addressview = [[UIView alloc]init];
        addressview.backgroundColor = [UIColor whiteColor];
        addressview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        addressview.layer.borderWidth = 0.5;
        [self addSubview:addressview];
        
        peisonglable = [self creatlable:@"配送方式    快递邮寄" font:11 textcolor:color];
        shouhuopersonlable = [self creatlable:@"收货人        胤宝  18801040890" font:11 textcolor:color];
        shouhuoaddresslable = [self creatlable:@"收货地址    北京望京" font:11 textcolor:color];
        
        [addressview addSubview:peisonglable];
        [addressview addSubview:shouhuoaddresslable];
        [addressview addSubview:shouhuopersonlable];
        
        
        dingdannumberlable = [self creatlable:@"订单号：121" font:11 textcolor:color];
        ceartTimelable = [self creatlable:@"创建时间：2015-21-21" font:11 textcolor:color];
        dingdannumberlable.alpha = 0.6;
        ceartTimelable.alpha = 0.6;
        
        [self addSubview:dingdannumberlable];
        [self addSubview:ceartTimelable];
        
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat heighttext = 20;
    CGFloat jiange = 5;
    paytypetitle.frame = CGRectMake(margin, margin, YXScreenW-20, heighttext);
    
    addressview.frame = CGRectMake(0, paytypetitle.bottom+margin, YXScreenW, 100);
    peisonglable.frame =  CGRectMake(margin, margin, YXScreenW-margin*2, heighttext);
    shouhuopersonlable.frame = CGRectMake(margin, peisonglable.bottom+jiange, YXScreenW-margin*2, heighttext);
    shouhuoaddresslable.frame =CGRectMake(margin, shouhuopersonlable.bottom+jiange, YXScreenW-margin*2, heighttext);
    
    dingdannumberlable.frame = CGRectMake(margin, addressview.bottom+jiange, YXScreenW-margin*2, heighttext);
    ceartTimelable.frame =CGRectMake(margin, dingdannumberlable.bottom+jiange, YXScreenW-margin*2, heighttext);
    
    
}

-(UILabel *)creatlable:(NSString *)str font:(NSInteger)font textcolor:(UIColor*)color
{
    UILabel *lable = [[UILabel alloc]init];
    lable.font = YXSFont(font);
    lable.text = str;
    lable.textColor = color;
    
    return lable;
}

@end
