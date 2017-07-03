//
//  YXVerifyPhoneView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/3.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXVerifyPhoneView.h"
#import "UILabel+Extension.h"
@interface YXVerifyPhoneView ()
{

    UIButton *toptitleBtn;
    UILabel *descLable;
    
}

@end

@implementation YXVerifyPhoneView


-(void)setPhoneTextFiled:(NSString *)phone AccountStatus:(YXBindingPhoneType)TheAccountStatus
{
    NSString *str = [NSString stringWithFormat:@"验证手机信息，进行绑定 \n请输入已发送至%@的验证码",phone];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:str];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    descLable.attributedText = att;

    if (TheAccountStatus == YXAlearlyRegisterApp) {
        
        [toptitleBtn setTitle:@"该手机已注册过胤宝" forState:UIControlStateNormal];
    }else if (TheAccountStatus == YXNotRegister){
        
        [toptitleBtn setTitle:@"该手机未注册过胤宝" forState:UIControlStateNormal];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        toptitleBtn = [[UIButton alloc]init];
        [toptitleBtn setImage:[UIImage imageNamed:@"thridpartyloginwaring"] forState:UIControlStateNormal];
        [toptitleBtn setTitleColor:UIColorFromRGB(0x262626) forState:UIControlStateNormal];
        toptitleBtn.titleLabel.font = YXSFont(15);
        toptitleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [self addSubview:toptitleBtn];
        
        descLable = [[UILabel alloc]init];
        descLable.numberOfLines = 2;
        descLable.textColor = UIColorFromRGB(0x939393);
        descLable.font = YXSFont(13);
        [self addSubview:descLable];

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    toptitleBtn.frame  = CGRectMake(10, 40, YXScreenW-20, 25);
    descLable.frame = CGRectMake(10, toptitleBtn.bottom+20, YXScreenW-20, 90);

}
@end
