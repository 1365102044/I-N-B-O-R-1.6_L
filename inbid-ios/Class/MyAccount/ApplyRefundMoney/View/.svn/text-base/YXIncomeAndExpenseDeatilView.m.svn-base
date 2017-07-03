//
//  YXIncomeAndExpenseDeatilView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXIncomeAndExpenseDeatilView.h"
#import "UILabel+Extension.h"
@interface YXIncomeAndExpenseDeatilView ()
{
    UILabel *priceLable;
    UILabel *statusLable;
    
    UIView *backMindview;
    UILabel *jindutitleLable;
    UIImageView *jinduImageview;
    
    UILabel *leftrow1;
    UILabel *rightrow1;
    UILabel *leftrow2;
    UILabel *rightrow2;
    UILabel *leftrow3;
    UILabel *rightrow3;
    
    UILabel *tuidaobrandLeftLable;
    UILabel * tuidaobrandRightLable;
    
    UILabel *beizhuLeftLable;
    UILabel *beizhuRightLable;
    
    UILabel *dingdanNumberLable;
    
    UILabel *creatTimeLeftLable;
    UILabel *creatTimeRightLable;
    
    UILabel *waterNumberLeftLable;
    UILabel *waterNumberRightLable;
    
}

@end

@implementation YXIncomeAndExpenseDeatilView


-(void)setRefundDeatilModle:(YXApplyRefundSultModle *)RefundDeatilModle
{
    _RefundDeatilModle = RefundDeatilModle;
    
    priceLable.text = [YXStringFilterTool formFenTransformaYuanWith:RefundDeatilModle.refundAmt];
    statusLable.text = RefundDeatilModle.MyRefundStatus;
    
    NSString *bankNum = [RefundDeatilModle.bankCardNo substringWithRange:NSMakeRange(RefundDeatilModle.bankCardNo.length-4, 4)];
    NSArray *nameArr = [RefundDeatilModle.bankCardType componentsSeparatedByString:@"·"];
    NSString * brandstr = [NSString stringWithFormat:@"%@(%@)%@",nameArr[0],bankNum,RefundDeatilModle.name];
    tuidaobrandRightLable.text = brandstr;
    
    dingdanNumberLable.text =  [NSString stringWithFormat:@"商品交易订单号[%@]",RefundDeatilModle.orderId];
    creatTimeRightLable.text = [YXStringFilterTool transformfromenumbertoTiemstr:[RefundDeatilModle.createTime longLongValue]];

    waterNumberRightLable.text = RefundDeatilModle.refundId;
    
    
    UIColor *color2 = [UIColor mainThemColor];
    NSArray *timeArr = [[YXStringFilterTool transformfromenumbertoTiemstr:[RefundDeatilModle.updateTime longLongValue]] componentsSeparatedByString:@"-"];
    NSString *updateTime;
    NSArray *CreateTimeArr = [[YXStringFilterTool transformfromenumbertoTiemstr:[RefundDeatilModle.createTime longLongValue]]componentsSeparatedByString:@"-"];
    NSString *CreateTime;
    if (timeArr.count>2) {
     
        updateTime = [NSString stringWithFormat:@"%@-%@",timeArr[1],timeArr[2]];
    }
    if (CreateTimeArr.count>2) {
        
        CreateTime = [NSString stringWithFormat:@"%@-%@",CreateTimeArr[1],CreateTimeArr[2]];
    }
    leftrow1.textColor = color2;
    rightrow1.text = CreateTime;
    rightrow1.hidden =NO;
    if (RefundDeatilModle.refundStatus==1) {
        
        jinduImageview.image = [UIImage imageNamed:@"icon_refundmoneystatus1"];
        
    }else if (RefundDeatilModle.refundStatus==2){
        
        jinduImageview.image = [UIImage imageNamed:@"icon_refundmoneystatus2"];

        
    }else if (RefundDeatilModle.refundStatus ==3){

        jinduImageview.image = [UIImage imageNamed:@"icon_refundmoneystatus3"];
        leftrow3.font=  YXSFont(13);
        leftrow3.textColor = color2;
        rightrow3.text = updateTime;
        rightrow3.hidden =NO;
        leftrow2.textColor = UIColorFromRGB(0x050505);
        leftrow3.textColor = UIColorFromRGB(0x050505);
    }else if (RefundDeatilModle.refundStatus == 4){
        
        jinduImageview.image = [UIImage imageNamed:@"icon_refundmoneystatus1"];
        leftrow1.textColor = color2;
        rightrow1.text = CreateTime;
         rightrow1.hidden =NO;
    }
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        

        priceLable = [self loadMylableWith:@"" font:24];
        priceLable.textColor = UIColorFromRGB(0x262626);
        priceLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:priceLable];
        
        statusLable = [self loadMylableWith:@"test处理中" font:13];
        statusLable.textColor = UIColorFromRGB(0xa90311);
        statusLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:statusLable];
        
        
        backMindview = [[UIView alloc]init];
        backMindview.backgroundColor = [UIColor whiteColor];
        backMindview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        backMindview.layer.borderWidth = 0.5;
        [self addSubview:backMindview];
        
        jindutitleLable = [self loadMylableWith:@"处理进度" font:12];
        [backMindview addSubview:jindutitleLable];
        
        jinduImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_refundmoneystatus1"]];
        [backMindview addSubview:jinduImageview];
        
        leftrow1 = [self loadMylableWith:@"申请退款" font:13];
        leftrow1.textColor = UIColorFromRGB(0x050505);
        rightrow1 = [self loadMylableWith:@"test12-12 " font:10];
        rightrow1.textAlignment = NSTextAlignmentRight;
        rightrow1.textColor = UIColorFromRGB(0xaaa7a7);
        [backMindview addSubview:leftrow1];
        [backMindview addSubview:rightrow1];
        
        leftrow2 = [self loadMylableWith:@"平台处理中" font:13];
        rightrow2 = [self loadMylableWith:@"test12-12 " font:10];
        rightrow2.textAlignment = NSTextAlignmentRight;
        rightrow2.textColor = UIColorFromRGB(0xaaa7a7);
        [backMindview addSubview:leftrow2];
        [backMindview addSubview:rightrow2];
        
        leftrow3 = [self loadMylableWith:@"退款完成" font:13];
        
        rightrow3 = [self loadMylableWith:@"test12-12 " font:10];
        rightrow3.textAlignment = NSTextAlignmentRight;
        rightrow3.textColor = UIColorFromRGB(0xaaa7a7);
        [backMindview addSubview:leftrow3];
        [backMindview addSubview:rightrow3];
        rightrow1.hidden = YES;
        rightrow2.hidden = YES;
        rightrow3.hidden = YES;
        
        tuidaobrandLeftLable = [self loadMylableWith:@"退款到" font:12];
        tuidaobrandRightLable = [self loadMylableWith:@"test工商" font:12];
        tuidaobrandRightLable.textAlignment = NSTextAlignmentRight;
        [backMindview addSubview:tuidaobrandRightLable];
        [backMindview addSubview:tuidaobrandLeftLable];
        
        beizhuLeftLable = [self loadMylableWith:@"备注" font:12];
        beizhuRightLable = [self loadMylableWith:@"商品订单退款" font:12];
        beizhuRightLable.textAlignment = NSTextAlignmentRight;
        [backMindview addSubview:beizhuRightLable];
        [backMindview addSubview:beizhuLeftLable];
        
        dingdanNumberLable = [self loadMylableWith:@"test" font:12];
        dingdanNumberLable.textAlignment = NSTextAlignmentRight;
        [backMindview addSubview:dingdanNumberLable];
        
        creatTimeLeftLable = [self loadMylableWith:@"创建时间" font:12];
        creatTimeRightLable = [self loadMylableWith:@"test" font:12];
        creatTimeRightLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:creatTimeRightLable];
        [self addSubview:creatTimeLeftLable];
        
        waterNumberLeftLable = [self loadMylableWith:@"交易流水号" font:12];
        waterNumberRightLable = [self loadMylableWith:@"test" font:12];
        waterNumberRightLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:waterNumberRightLable];
        [self addSubview:waterNumberLeftLable];
        waterNumberLeftLable.hidden = YES;
        waterNumberRightLable.hidden = YES;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat Hei = 15;
    CGFloat leftW = 80;
    CGFloat rightW = 120;
    CGFloat leftMar = 10;
    CGFloat rowW = 70;
    
    priceLable.frame = CGRectMake(10, 45, YXScreenW-20, 25);
    statusLable.frame = CGRectMake(10, priceLable.bottom+15, YXScreenW-20, 20);
    
    
    backMindview.frame = CGRectMake(0, statusLable.bottom+40, YXScreenW, 250);
    
    jindutitleLable.frame = CGRectMake(leftMar, 20, leftW, Hei);
    
    leftrow1.frame = CGRectMake(0, jindutitleLable.y, rowW, Hei);
    leftrow1.centerX = backMindview.centerX;
    rightrow1.frame = CGRectMake(YXScreenW-10-rowW, leftrow1.y, rowW, Hei);
    
    jinduImageview.frame = CGRectMake(leftrow1.x-20, jindutitleLable.y, 15, 101);
    
    leftrow2.frame = CGRectMake(leftrow1.x, leftrow1.bottom+29, rowW, Hei);
    rightrow2.frame = CGRectMake(rightrow1.x, leftrow2.y, rowW, Hei);
    
    leftrow3.frame = CGRectMake(leftrow2.x, leftrow2.bottom+28, rowW, Hei);
    rightrow3.frame = CGRectMake(rightrow2.x, leftrow3.y, rowW, Hei);
    
    tuidaobrandLeftLable.frame = CGRectMake(leftMar, leftrow3.bottom+20, leftW, Hei);
    tuidaobrandRightLable.frame = CGRectMake(YXScreenW-rightW-10, tuidaobrandLeftLable.y, rightW, Hei);
    beizhuLeftLable.frame = CGRectMake(leftMar, tuidaobrandLeftLable.bottom+15, leftW, Hei);
    beizhuRightLable.frame = CGRectMake(YXScreenW-rightW-10, beizhuLeftLable.y, rightW, Hei);
    CGFloat dingdanH = [dingdanNumberLable heightWithWidth:YXScreenW-100];
    if (dingdanH<=Hei) {
        dingdanH = Hei;
    }
    dingdanNumberLable.frame = CGRectMake(110, beizhuLeftLable.bottom+15, YXScreenW-120, dingdanH);
    
    
    creatTimeLeftLable.frame = CGRectMake(leftMar, backMindview.bottom+15, leftW, Hei);
    creatTimeRightLable.frame = CGRectMake(YXScreenW-rightW-10, creatTimeLeftLable.y, rightW, Hei);
    
    waterNumberLeftLable.frame = CGRectMake(leftMar, creatTimeLeftLable.bottom+15, leftW+20, Hei);
    waterNumberRightLable.frame = CGRectMake(waterNumberLeftLable.right+10, waterNumberLeftLable.y, YXScreenW-waterNumberLeftLable.right-20, Hei);
    
}
-(UILabel*)loadMylableWith:(NSString *)text font:(NSInteger )font
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = text;
    lable.font = YXRegularfont(font);
    lable.textColor = UIColorFromRGB(0x939393);
    return lable;
    
}

@end
