//
//  YXThridPartyLoginView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/3.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXThridPartyLoginView.h"
@interface YXThridPartyLoginView ()
{
    UIButton *QQBtn;
    UIButton *WXBtn;
    UIImageView *leftimage;
    UILabel *mindlable;
    
    UIButton *helpBtn;
}

@end
@implementation YXThridPartyLoginView

-(void)setIscanhiddenView:(NSString *)iscanhiddenView
{

    _iscanhiddenView = iscanhiddenView;

}

-(void)ClickQQBtn
{
    if (self.ClickQQblock) {
        self.ClickQQblock();
    }
}
-(void)ClickWXBtn
{
    if (self.ClickWXblock) {
        self.ClickWXblock();
    }
}
-(void)clcikHelpBtn{
    if (self.clickHelpblock) {
        self.clickHelpblock();
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        leftimage = [[ UIImageView alloc]init];
        leftimage.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:leftimage];

        mindlable = [[UILabel alloc]init];
        mindlable.text = @"第三方登录";
        mindlable.textColor = UIColorFromRGB(0x050505);
        mindlable.font = YXSFont(13);
        mindlable.backgroundColor = UIColorFromRGB(0xf9f9f9);
        mindlable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:mindlable];
        
        
        QQBtn = [[UIButton alloc]init];
        [QQBtn setImage:[UIImage imageNamed:@"QQthridpartylogin"] forState:UIControlStateNormal];
        QQBtn.layer.masksToBounds = YES;
        QQBtn.layer.cornerRadius = 25;
        [QQBtn addTarget:self action:@selector(ClickQQBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:QQBtn];
        
        WXBtn = [[UIButton alloc]init];
        [WXBtn setImage:[UIImage imageNamed:@"WXthridpartylogin"] forState:UIControlStateNormal];
        [WXBtn addTarget:self action:@selector(ClickWXBtn) forControlEvents:UIControlEventTouchUpInside];
        WXBtn.layer.masksToBounds = YES;
        WXBtn.layer.cornerRadius = 25;
        [self addSubview:WXBtn];
        

        helpBtn = [[UIButton alloc]init];
        [helpBtn setTitle:@"帮助中心" forState:UIControlStateNormal];
        [helpBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        [helpBtn addTarget:self action:@selector(clcikHelpBtn) forControlEvents:UIControlEventTouchUpInside];
        helpBtn.titleLabel.font = YXSFont(13);
        [self addSubview:helpBtn];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    leftimage.frame = CGRectMake(20, 15, YXScreenW-40, 1);
    
    mindlable.frame = CGRectMake(10, 5, 80, 25);
    mindlable.centerX = self.centerX;
    mindlable.centerY = leftimage.centerY;
    
    CGFloat W = 50;
    
    if ([_iscanhiddenView isEqualToString:@"WX"]) {
        
        WXBtn.hidden = YES;
        QQBtn.frame = CGRectMake((YXScreenW-W)/2  , mindlable.bottom+15, W,W);
        
    }else if ([_iscanhiddenView isEqualToString:@"QQ"]){
        
        QQBtn.hidden = YES;
        WXBtn.frame = CGRectMake((YXScreenW-W)/2  , mindlable.bottom+15, W,W);
        WXBtn.backgroundColor = [UIColor redColor];
        
    }else{
        
        QQBtn.frame = CGRectMake((YXScreenW/2-W)/2  , mindlable.bottom+15, W,W);
        WXBtn.frame = CGRectMake(YXScreenW/2+(YXScreenW/2-W)/2, QQBtn.y, W, W);
    }
    
    helpBtn.frame = CGRectMake((YXScreenW-100)/2, QQBtn.bottom +15, 100, 20);
    
}

@end
