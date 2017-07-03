//
//  YXMeMainTableWalletView.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/14.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMeMainTableWalletView.h"
#import "YXStringFilterTool.h"
@interface YXMeMainTableWalletView ()
{
    UILabel *titlelable;
    UILabel *moneycountlable;
    UILabel *yuanlable;
    UIButton *gotodescbtn;
    UIView *line;
}
@end
@implementation YXMeMainTableWalletView

-(void)setWalltModle:(YXMyAccountBaseData *)WalltModle{

    moneycountlable.text = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%.2f",[WalltModle.balanceMoney floatValue]]];
    if (WalltModle.openingStatus) {
        
        moneycountlable.textColor = UIColorFromRGB(0xff7800);
        yuanlable.text = @"账户余额（元）";
        yuanlable.textColor = UIColorFromRGB(0x999999);
        yuanlable.font = YXSFont(12);
        gotodescbtn.hidden = NO;
    }else{
        
        moneycountlable.text = @"尚未开通钱包";
        moneycountlable.textColor = UIColorFromRGB(0x333333);
        yuanlable.text = @"点击开通";
        yuanlable.textColor = UIColorFromRGB(0x00aeff);
        yuanlable.font = YXSFont(15);
        gotodescbtn.hidden = YES;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        titlelable = [[UILabel alloc]init];
        titlelable.text = @"我的钱包";
        titlelable.textAlignment = NSTextAlignmentLeft;
        titlelable.font = YXSFont(15);
        [self addSubview:titlelable];
        
        line = [[UIView alloc]init];
        line.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:line];
        
        moneycountlable = [[UILabel alloc]init];
        moneycountlable.text = @"test-1456456";
        moneycountlable.textAlignment = NSTextAlignmentLeft;
        moneycountlable.font = YXSFont(24);
        [self addSubview:moneycountlable];
        
        yuanlable = [[UILabel alloc]init];
        yuanlable.text = @"账户余额（元）";
        yuanlable.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:yuanlable];
        
        gotodescbtn = [[UIButton alloc]init];
        [gotodescbtn setTitle:@"查看明细" forState:UIControlStateNormal];
        [gotodescbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        gotodescbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        gotodescbtn.titleLabel.font = YXSFont(13);
        gotodescbtn.userInteractionEnabled = NO;
        [self addSubview:gotodescbtn];
        gotodescbtn.hidden = YES;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftmagrin = 10;
    titlelable.frame = CGRectMake(leftmagrin, 5, 100, 30);
    line.frame = CGRectMake(0, titlelable.bottom+5, YXScreenW, 1);
    moneycountlable.frame = CGRectMake(24, titlelable.bottom+10, YXScreenW-20, 30);
    yuanlable.frame = CGRectMake(24, moneycountlable.bottom+5, 100, 20);
    gotodescbtn.frame = CGRectMake(YXScreenW-110, 5, 100, 20);
    gotodescbtn.centerY = titlelable.centerY;
}
@end
