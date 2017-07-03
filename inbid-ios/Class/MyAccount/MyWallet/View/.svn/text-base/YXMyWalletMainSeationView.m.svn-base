//
//  YXMyWalletMainSeationView.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/20.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyWalletMainSeationView.h"

@interface YXMyWalletMainSeationView ()

{
    UILabel *toptitle;
    UILabel *HaveMoneyAccoutLable;
    UILabel *CanUseMoneyLable;
    UILabel *NotCanUseMoneyLable;
    
}

@end

@implementation YXMyWalletMainSeationView


-(void)setDataModel:(YXMyWalletAccountInformModle *)dataModel{

    //余额
     HaveMoneyAccoutLable.text = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%.2f",[dataModel.balance floatValue]/1]];

//    可用余额
    CanUseMoneyLable.text = [NSString stringWithFormat:@"可用余额 %@",[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%.2f",[dataModel.cashout_amt floatValue]/1]]];

//    冻结余额
    NotCanUseMoneyLable.text = [NSString stringWithFormat:@"冻结余额 %@",[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%.2f",[dataModel.freeze_balance floatValue]/1]]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        toptitle = [self creatLable];
        toptitle.text = @"余额";
        [self addSubview:toptitle];
        
        HaveMoneyAccoutLable  = [self creatLable];
//        HaveMoneyAccoutLable.text = @"0.00";
        [self addSubview:HaveMoneyAccoutLable];
        
        CanUseMoneyLable = [self creatLable];
        CanUseMoneyLable.text = @"可用余额 0.00";
        CanUseMoneyLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:CanUseMoneyLable];
        
        NotCanUseMoneyLable = [self creatLable];
        NotCanUseMoneyLable.text = @"冻结余额 0.00";
        NotCanUseMoneyLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:NotCanUseMoneyLable];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    toptitle.frame = CGRectMake(30, 10, 100, 30);
    HaveMoneyAccoutLable.frame = CGRectMake(30, toptitle.bottom, 200, 30);
    CanUseMoneyLable.frame  = CGRectMake(YXScreenW-220, toptitle.y, 200, 30);
    NotCanUseMoneyLable.frame = CGRectMake(CanUseMoneyLable.x, CanUseMoneyLable.bottom, CanUseMoneyLable.width, 30);
    
}
-(UILabel *)creatLable{
    UILabel *lable = [[UILabel alloc]init];
    lable.textColor = UIColorFromRGB(0x333333);
    lable.font = YXSFont(15);
    return lable;
}
@end
