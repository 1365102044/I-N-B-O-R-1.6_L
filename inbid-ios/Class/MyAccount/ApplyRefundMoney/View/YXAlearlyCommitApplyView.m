//
//  YXAlearlyCommitApplyView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXAlearlyCommitApplyView.h"
#import "UILabel+YBAttributeTextTapAction.h"
@interface YXAlearlyCommitApplyView ()
{
    UIImageView *myimageview;
    UILabel *toplable;
    UILabel *seactionlable;
    UILabel *desclable;

}

@end

@implementation YXAlearlyCommitApplyView


-(void)setRefundModle:(YXApplyRefundSultModle *)refundModle
{
    _refundModle = refundModle;
    
    toplable.text = @"申请已提交";
    seactionlable.text = @"将退回至您的支付银行卡内";

    
    NSString *kefuphone = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    NSString *desc = [NSString stringWithFormat:@"1.平台将在%@个工作日内处理您的退款申请。\n2.银行到账时间预计需要%@个工作日。\n3.如需帮助可联系客服%@。",refundModle.refundDealDays,refundModle.refundWorkDays,kefuphone];
    NSMutableAttributedString *atter = [[NSMutableAttributedString alloc]initWithString:desc];
    [atter addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x939393) range:NSMakeRange(0, atter.length)];
    [atter addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x419bef) range:NSMakeRange(desc.length-kefuphone.length-1, kefuphone.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    [atter addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,  atter.length)];
    desclable.attributedText  = atter;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        myimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_对号"]];
        [self addSubview:myimageview];
        
        toplable = [[UILabel alloc]init];
        toplable.font = YXSFont(17);
        toplable.textColor = UIColorFromRGB(0x050505);
        toplable.numberOfLines = 0;
        toplable.textAlignment= NSTextAlignmentCenter;
        [self addSubview:toplable];
        
        
        seactionlable = [[UILabel alloc]init];
        seactionlable.font = YXSFont(12);
        seactionlable.textColor = UIColorFromRGB(0x050505);
        seactionlable.numberOfLines = 0;
        seactionlable.textAlignment= NSTextAlignmentCenter;
        [self addSubview:seactionlable];
        
        desclable = [[UILabel alloc]init];
        desclable.font = YXSFont(13);
        desclable.textColor = UIColorFromRGB(0x050505);
        desclable.numberOfLines = 0;
        [self addSubview:desclable];
        
        NSString *kefuphone = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
        [desclable yb_addAttributeTapActionWithStrings:@[kefuphone] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
            
            [YXStringFilterTool YXCallPhoneWith:self];
        }];

    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    myimageview.frame = CGRectMake(10, 100, 43, 43);
    myimageview.centerX = self.centerX;
    
    toplable.frame = CGRectMake(10, myimageview.bottom+40, YXScreenW-20, 40);
    seactionlable.frame = CGRectMake(10, toplable.bottom+10, YXScreenW-20, 40);
    desclable.frame =CGRectMake(25, seactionlable.bottom+50, YXScreenW-30, 120);
    
}
@end
