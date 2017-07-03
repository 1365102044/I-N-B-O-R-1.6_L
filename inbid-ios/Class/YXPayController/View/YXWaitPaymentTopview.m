//
//  YXWaitPaymentTopview.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/14.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXWaitPaymentTopview.h"
#import "YXDrawLineview.h"



@interface YXWaitPaymentTopview ()
{
    UILabel*logiticsNumber;
    UILabel*NeedPayamout;
    UILabel*nameLable;
    
}

@end
@implementation YXWaitPaymentTopview

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        logiticsNumber = [self addLable:@"订单号：1234567891236" andtextcolor:UIColorFromRGB(0x050505) andfont:13];
        NeedPayamout = [self addLable:@"应付金额：￥433，333" andtextcolor:UIColorFromRGB(0xf97841) andfont:13];
        
        nameLable = [self addLable:@"案例介绍的法律请我而收玩儿玩儿去无人沃尔沃是打发" andtextcolor:UIColorFromRGB(0x050505) andfont:13];
        nameLable.alpha = 0.68;
        
        [self addSubview:logiticsNumber];
        [self addSubview:NeedPayamout];
        [self addSubview:nameLable];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat kmargin = 15;
    
    
    logiticsNumber.frame = CGRectMake(kmargin, 0, (YXScreenW-30)/2, 35);
    
    NeedPayamout.frame = CGRectMake(YXScreenW/2, 0, (YXScreenW-30)/2, 35);
    
    nameLable.frame = CGRectMake(kmargin, logiticsNumber.bottom+1, YXScreenW-30, 35);
    
    

}

-(void)drawRect:(CGRect)rect
{
    YXDrawLineview *linetool = [[YXDrawLineview alloc]init];
    [linetool setDrawlineviewOrgin:CGPointMake(4, logiticsNumber.bottom) movetoPoint:CGPointMake(YXScreenW, logiticsNumber.bottom) color:UIColorFromRGB(0xe5e5e5)];
    [linetool setDrawlineviewOrgin:CGPointMake(4, nameLable.bottom) movetoPoint:CGPointMake(4, nameLable.bottom) color:UIColorFromRGB(0xe5e5e5)];
}


-(UILabel*)addLable:(NSString *)str andtextcolor:(UIColor*)color andfont:(NSInteger)font
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = str;
    lable.font = YXRegularfont(font);
    lable.textColor = color;
    return lable;
}

@end
