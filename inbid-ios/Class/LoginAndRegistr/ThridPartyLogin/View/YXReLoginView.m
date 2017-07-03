//
//  YXReLoginView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/3.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXReLoginView.h"


@interface YXReLoginView ()
{
    UIButton *toptitleBtn;
    UILabel *descLable;

}

@end
@implementation YXReLoginView

/**
 改变对应的状态
 */
-(void)setLoginTypeWith:(YXThridLoginType)type
{
    NSString *str ;
    if (type == YXWeiChatLogin) {
        
        [toptitleBtn setTitle:@"该手机已绑定其他微信" forState:UIControlStateNormal];
 
            str = @"请通过手机号登录 \n 解除原微信绑定后可绑定新的微信账号";
      
    }else if (type ==YXQQLogin){
        
        [toptitleBtn setTitle:@"该手机已绑定其他QQ" forState:UIControlStateNormal];
        str = @"请通过手机号登录 \n 解除原QQ绑定后可绑定新的QQ账号";
    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:str];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    descLable.attributedText = att;
    
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
        descLable.numberOfLines = 0;
        descLable.textAlignment = NSTextAlignmentCenter;
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
    descLable.frame = CGRectMake(10, toptitleBtn.bottom+25, YXScreenW-20, 100);
    
}


@end
