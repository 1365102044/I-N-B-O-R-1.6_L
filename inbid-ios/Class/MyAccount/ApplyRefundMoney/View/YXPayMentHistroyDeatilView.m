//
//  YXPayMentHistroyDeatilView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPayMentHistroyDeatilView.h"
#import "UILabel+Extension.h"
#import "YXPayAndIncomeDetailModel.h"

@interface YXPayMentHistroyDeatilView ()
{
    UILabel *pricelable;
    UILabel *statuslable;
    
    UILabel *paytypeleftlable;
    UILabel *paytyperightlable;
    
    UILabel *typeLeftlable;
    UILabel *typeRightlable;
    
    UILabel *beizhuLeftlable;
    UILabel *beizhuRightlable;
    
    UILabel *dingdanNumberlable;
    
    UIView *speatview;
    
    UILabel *creatTimeLeftlable;
    UILabel *creatTimeRightlable;
    
    UILabel *waterLeftlable;
    UILabel *waterRightlable;
    
    //标示
    NSString *isWalletHistroy;
}

@end

@implementation YXPayMentHistroyDeatilView

- (void)setPayAndIncomeDetailModel:(YXPayAndIncomeDetailModel *)payAndIncomeDetailModel
{
    _payAndIncomeDetailModel = payAndIncomeDetailModel;
    
    isWalletHistroy = @"PayAndIncome";
    pricelable.text = [NSString stringWithFormat:@"¥%@", [YXStringFilterTool strmethodComma:payAndIncomeDetailModel.money_order]];
    
    /**
     *  根据状态判断并赋值
     */
    
    if ([payAndIncomeDetailModel.oid_biz isEqualToString:@"202000"]) {
        paytyperightlable.text = @"提现";
        if ([payAndIncomeDetailModel.result_pay isEqualToString:@"SUCCESS"]) {
            statuslable.text = @"提现成功";
        }else if ([payAndIncomeDetailModel.result_pay isEqualToString:@"PROCESSING"]) {
            statuslable.text = @"银行代付处理中";
        }else if ([payAndIncomeDetailModel.result_pay isEqualToString:@"WAITING"]) {
            statuslable.text = @"提现等待中";
        }else if ([payAndIncomeDetailModel.result_pay isEqualToString:@"FAILURE"]) {
            statuslable.text = @"提现失败";
        }
    }else if ([payAndIncomeDetailModel.oid_biz isEqualToString:@"107001"]) {
        paytyperightlable.text = @"交易付款";
        if ([payAndIncomeDetailModel.result_pay isEqualToString:@"SUCCESS"]) {
            statuslable.text = @"交易付款成功";
        }else if ([payAndIncomeDetailModel.result_pay isEqualToString:@"PROCESSING"]) {
            statuslable.text = @"银行代付处理中";
        }else if ([payAndIncomeDetailModel.result_pay isEqualToString:@"WAITING"]) {
            statuslable.text = @"交易付款等待中";
        }else if ([payAndIncomeDetailModel.result_pay isEqualToString:@"FAILURE"]) {
            statuslable.text = @"交易付款失败";
        }
    }
    
    /**
     *  支付方式
     */
    if (payAndIncomeDetailModel.flag_dc) {
        typeRightlable.text = @"支出";
    }else{
        typeRightlable.text = @"收入";
    }
    
    dingdanNumberlable.text = [NSString stringWithFormat:@"商品交易订单号[%@]",
                               payAndIncomeDetailModel.no_order];
    beizhuRightlable.text = [NSString stringWithFormat:@"无信息"];
    creatTimeRightlable.text = _payAndIncomeDetailModel.dt_billtrans;
    
    
    [self layoutSubviews];
    
}

/**
 赋值
 */
-(void)setDeatilModle:(YXPayHistroyModle *)DeatilModle
{
    _DeatilModle = DeatilModle;
    
    pricelable.text = [YXStringFilterTool formFenTransformaYuanWith:DeatilModle.payAmt];
    
    paytyperightlable.text = DeatilModle.MypayType;
    
    dingdanNumberlable.text = [NSString stringWithFormat:@"商品交易订单号[%@]",DeatilModle.orderId];
    beizhuRightlable.text = [NSString stringWithFormat:@"商品交易%@",DeatilModle.MyPayMoneyType];
    creatTimeRightlable.text = [YXStringFilterTool transformfromenumbertoTiemstr:[DeatilModle.createTime longLongValue]];
    waterRightlable.text = DeatilModle.transactionId;
    
    
    [self layoutSubviews];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        UIColor * mycolor = UIColorFromRGB(0x050505);
        
        pricelable = [self loadMylableWith:@"" font:21];
        pricelable.textColor = mycolor;
        statuslable = [self loadMylableWith:@"支付成功" font:11];
        statuslable.textColor = UIColorFromRGB(0xad0810);
        pricelable.textAlignment = NSTextAlignmentCenter;
        statuslable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:pricelable];
        [self addSubview:statuslable];
        
        paytypeleftlable = [self loadMylableWith:@"支付方式" font:13];
        paytypeleftlable.textColor = mycolor;
        paytyperightlable = [self loadMylableWith:@"test" font:13];
        paytyperightlable.textAlignment = NSTextAlignmentRight;
        [self addSubview:paytyperightlable];
        [self addSubview:paytypeleftlable];
        
        typeLeftlable = [self loadMylableWith:@"类型" font:13];
        typeLeftlable.textColor = mycolor;
        typeRightlable =[self loadMylableWith:@"支出" font:13 ];
        typeRightlable.textAlignment = NSTextAlignmentRight;
        [self addSubview:typeRightlable];
        [self addSubview:typeLeftlable];
        
        beizhuLeftlable = [self loadMylableWith:@"备注" font:13];
        beizhuLeftlable.textColor = mycolor;
        beizhuRightlable = [self loadMylableWith:@"test商品交易安全" font:13];
        beizhuRightlable.textAlignment = NSTextAlignmentRight;
        [self addSubview:beizhuLeftlable];
        [self addSubview:beizhuRightlable];
        
        dingdanNumberlable = [self loadMylableWith:@"test" font:13];
        dingdanNumberlable.textAlignment = NSTextAlignmentRight;
        dingdanNumberlable.numberOfLines = 0;
        [self addSubview:dingdanNumberlable];
        
        speatview = [[UIView alloc]init];
        speatview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        speatview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        speatview.layer.borderWidth = 0.5;
        [self addSubview:speatview];
        
        creatTimeLeftlable = [self loadMylableWith:@"创建时间" font:13];
        creatTimeRightlable = [self loadMylableWith:@"test" font:13];
        creatTimeRightlable.textAlignment = NSTextAlignmentRight;
        [self addSubview:creatTimeRightlable];
        [self addSubview:creatTimeLeftlable];
        
        waterLeftlable = [self loadMylableWith:@"交易流水号" font:13];
        waterRightlable = [self loadMylableWith:@"test" font:13];
        waterRightlable.textAlignment = NSTextAlignmentRight;
        [self addSubview:waterRightlable];
        [self addSubview:waterLeftlable];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat hei = 15;
    CGFloat mar = 10;
    CGFloat leftW = 60;
    CGFloat rigW = 200;
    CGFloat rigX = YXScreenW -rigW-10;
    
    pricelable.frame = CGRectMake(mar, 75, YXScreenW-20, 20);
    statuslable.frame = CGRectMake(mar, pricelable.bottom+15, YXScreenW-20, hei);
    
    paytypeleftlable.frame = CGRectMake(mar, statuslable.bottom+30, leftW, hei);
    paytyperightlable.frame = CGRectMake(rigX, paytypeleftlable.y, rigW, hei);
    
    typeLeftlable.frame = CGRectMake(mar, paytypeleftlable.bottom+15, leftW, hei);
    typeRightlable.frame = CGRectMake(rigX, typeLeftlable.y, rigW, hei);

    beizhuLeftlable.frame = CGRectMake(mar, typeLeftlable.bottom+15, leftW, hei);
    beizhuRightlable.frame = CGRectMake(rigX, beizhuLeftlable.y, rigW, hei);
    
    CGFloat dingdanH = [dingdanNumberlable heightWithWidth:YXScreenW-100];
    if (dingdanH<=hei) {
        dingdanH = hei;
    }
    dingdanNumberlable.frame = CGRectMake(110, beizhuLeftlable.bottom+15, YXScreenW-120, dingdanH);
    
    
    speatview.frame = CGRectMake(0, dingdanNumberlable.bottom+30, YXScreenW, 5);
    
    creatTimeLeftlable.frame = CGRectMake(mar, speatview.bottom+15, leftW, hei);
    creatTimeRightlable.frame = CGRectMake(rigX, creatTimeLeftlable.y, rigW, hei);
    
    if ([isWalletHistroy isEqualToString:@"PayAndIncome"]) {
        
        if(self.Heightblock)
        {
            self.Heightblock(creatTimeLeftlable.bottom+15);
        }
    }else{
    
        waterLeftlable.frame = CGRectMake(mar, creatTimeLeftlable.bottom+15, leftW+20, hei);
        waterRightlable.frame = CGRectMake(waterLeftlable.right+10, waterLeftlable.y, YXScreenW-waterLeftlable.right-20, hei);
        
        if(self.Heightblock)
        {
            self.Heightblock(waterLeftlable.bottom+10);
        }
    }
    
}

-(UILabel *)loadMylableWith:(NSString *)text font:(NSInteger )font
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = text;
    lable.font = YXSFont(font);
    lable.textColor = UIColorFromRGB(0x939393);
    return lable;
}

@end
