//
//  YXDingjinAgreementView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/14.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXDingjinAgreementView.h"
#import "UILabel+Extension.h"

@interface YXDingjinAgreementView ()
{
    
    UIView *topview;
    UILabel *xieyititlelable;
    UIImageView *xieyiimage;
    UILabel *shouldPaydignjinleftlable;
    UILabel *shouldPaydingjinRightlable;
    
    UISwitch *mysitch;
    
    UIView *backview;
}

@end

@implementation YXDingjinAgreementView


-(void)clickswitch:(UISwitch *)sender
{

    [YXNotificationTool postNotificationName:@"clickxieyinoti" object:nil userInfo:@{@"isornot":@(sender.isOn)}];
}
-(void)clickfuwuxieyi
{
    
    if (self.fuwuxieyiblock) {
        self.fuwuxieyiblock();
    }
}

-(void)setOneMouthPriceConfirmModel:(YXOneMouthPriceConfirmOrderModle *)OneMouthPriceConfirmModel
{
    _OneMouthPriceConfirmModel = OneMouthPriceConfirmModel;
    
    shouldPaydingjinRightlable.text = [NSString stringWithFormat:@"￥%@",[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",OneMouthPriceConfirmModel.depositPrice/100]]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        backview = [[UIView alloc]init];
        backview.backgroundColor = [UIColor whiteColor];
        backview.layer.borderWidth = 0.5;
        backview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        [self addSubview:backview];
        
        
        UIColor *color = UIColorFromRGB(0x050505);
        
        topview = [[UIView alloc]init];
        topview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        topview.layer.borderWidth = 0.5;
        [backview addSubview:topview];
        
        xieyititlelable = [[UILabel alloc]init];
        xieyititlelable.text = @"我已同意定金不退等平台服务协议";
        xieyititlelable.textColor = color;
        xieyititlelable.font = YXSFont(13);
        [topview addSubview:xieyititlelable];
        
        xieyiimage = [[UIImageView alloc]init];
        xieyiimage.image = [UIImage imageNamed:@"fuwuxieyiwenhao"];
        [topview addSubview:xieyiimage];
        topview.userInteractionEnabled = YES;
        xieyititlelable.userInteractionEnabled = YES;

        
        mysitch = [[UISwitch alloc]init];
        [mysitch setOn:YES];
        [mysitch addTarget:self action:@selector(clickswitch:) forControlEvents:UIControlEventValueChanged];
        [topview addSubview:mysitch];
        // 控件大小，不能设置frame，只能用缩放比例
        mysitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
//        mysitch.onTintColor = UIColorFromRGB(0x999999);
        
        shouldPaydignjinleftlable = [[UILabel alloc]init];
        
        shouldPaydignjinleftlable.textColor = UIColorFromRGB(0x050505);
        shouldPaydignjinleftlable.font = YXRegularfont(12);
        
        [backview addSubview:shouldPaydignjinleftlable];
        NSString *str =@"需付定金 尾款需在下单后48小时内完成支付";
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x050505) range:NSMakeRange(0, 4)];
         [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(12) range:NSMakeRange(0, 4)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xaaa7aa) range:NSMakeRange(4, attrStr.length-4)];
        [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(10) range:NSMakeRange(4, attrStr.length-4)];
        shouldPaydignjinleftlable.attributedText = attrStr;
        
        
        shouldPaydingjinRightlable = [[UILabel alloc]init];
        shouldPaydingjinRightlable.text = @"￥10000";
        shouldPaydingjinRightlable.textColor = UIColorFromRGB(0x050505);
        shouldPaydingjinRightlable.font = YXRegularfont(12);
        shouldPaydingjinRightlable.textAlignment = NSTextAlignmentRight;
        [backview addSubview:shouldPaydingjinRightlable];

 
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(clickfuwuxieyi)];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(clickfuwuxieyi)];
        [topview addGestureRecognizer:tap1];
        [xieyititlelable addGestureRecognizer:tap];
        
    }
    return self;
}


-(void)layoutSubviews
{
    
    [super layoutSubviews];
    backview.frame = CGRectMake(0, 0, YXScreenW, 84);
    topview.frame = CGRectMake(0, 0, YXScreenW, 44);
    
    CGFloat xieyiW = [xieyititlelable widthWithHeight:44];
    xieyititlelable.frame = CGRectMake(10,0 , xieyiW, topview.height);
    xieyiimage.frame = CGRectMake(xieyititlelable.right+10, 0, 12, 12);
    xieyiimage.centerY = xieyititlelable.centerY;
    
    mysitch.frame  = CGRectMake(YXScreenW-12-mysitch.width, (topview.height-mysitch.height)/2, mysitch.width, mysitch.height);
//    mysitch.centerY = xieyititlelable.centerY;
    
    CGFloat shouldW = [shouldPaydignjinleftlable widthWithHeight:40];
    shouldPaydignjinleftlable.frame =CGRectMake(10, topview.bottom+5, shouldW, 30);
    shouldPaydingjinRightlable.frame = CGRectMake(YXScreenW-10-150, shouldPaydignjinleftlable.y, 150, 30);
    
    
    
}
@end
