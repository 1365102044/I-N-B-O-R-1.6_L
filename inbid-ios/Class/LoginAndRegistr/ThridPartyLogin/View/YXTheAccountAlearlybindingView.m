//
//  YXTheAccountAlearlybindingView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 2017/1/17.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXTheAccountAlearlybindingView.h"

@interface YXTheAccountAlearlybindingView ()

@property (weak, nonatomic) IBOutlet UIImageView *Loginimage;

@property (weak, nonatomic) IBOutlet UILabel *TitleLable;

@property (weak, nonatomic) IBOutlet UILabel *DescLable;

@property (weak, nonatomic) IBOutlet UIButton *LoginBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginimageTopConstance;

@end

@implementation YXTheAccountAlearlybindingView

/**
 改变对应的状态
 */
-(void)setLoginTypeWith:(YXThridLoginType)type{

    NSString *typestr ;
    if (type == YXWeiChatLogin) {
        
        typestr = @"微信";
        _Loginimage.image = [UIImage imageNamed:@"icon_thirdReloginweichat"];
        
    }else if (type ==YXQQLogin){
        
        typestr = @"QQ";
        _Loginimage.image = [UIImage imageNamed:@"icon_thirdReloginqq"];
    }
    NSString *str = [NSString stringWithFormat:@"该手机号\n已绑定其他%@",typestr];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:str];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    _TitleLable.attributedText = att;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"YXTheAccountAlearlybindingView" owner:nil options:nil].lastObject;
        
        if (YXScreenW <=320) {
            
            self.loginimageTopConstance.constant = 60;
        }
        
        NSString *str1 = @"您已通过手机登录，通过“我的”-“第三方绑定”对已绑定的账号解绑后重新绑定。";
        NSMutableAttributedString *att1 = [[NSMutableAttributedString alloc]initWithString:str1];
        //调整行距
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle1.lineSpacing = 10;
        paragraphStyle1.alignment = NSTextAlignmentCenter;
        [att1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str1 length])];
        _DescLable.attributedText = att1;
        
        _LoginBtn.layer.cornerRadius = 4;
        _LoginBtn.layer.masksToBounds = YES;
        
        
    }
    return self;
}

- (IBAction)ClickLoginbtn:(id)sender {
    
    if (self.loginBlock) {
        self.loginBlock();
    }
}
- (IBAction)ClickBackBtn:(id)sender {
//    if (self.backBlock) {
//        self.backBlock();
//    }
}

@end
