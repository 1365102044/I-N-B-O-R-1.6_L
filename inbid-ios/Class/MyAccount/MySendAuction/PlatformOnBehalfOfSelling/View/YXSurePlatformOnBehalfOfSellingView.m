//
//  YXSurePlatformOnBehalfOfSellingView.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSurePlatformOnBehalfOfSellingView.h"
#import "UILabel+YBAttributeTextTapAction.h"

@interface YXSurePlatformOnBehalfOfSellingView()<YBAttributeTapActionDelegate>

//** 官方提示文案 */
@property (weak, nonatomic) IBOutlet UILabel *officialTipsLabel;
//** 备注文案 */
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UILabel *psLabel;

@end

@implementation YXSurePlatformOnBehalfOfSellingView

#pragma mark - 点击事件

//delegate
- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index
{
    //打电话
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",string];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:callWebview];
    
}

//** 确定按钮点击事件 */
- (IBAction)sureButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(suerPlatformOnBehalOfSellingView:andClickButton:)]) {
        [self.delegate suerPlatformOnBehalOfSellingView:self andClickButton:sender];
    }
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    //设置文案行间距
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineSpacing = 12;
    
    NSDictionary *attributes1 = @{
                                  NSFontAttributeName:[UIFont systemFontOfSize:13],
                                  NSParagraphStyleAttributeName:paragraphStyle1,
                                  NSForegroundColorAttributeName:[UIColor colorWithWhite:90.0/255.0 alpha:1.0]
                                  };
    self.officialTipsLabel.attributedText = [[NSAttributedString alloc] initWithString:@"您的商品已经提交胤宝官方代卖，胤宝将为您重新定义商品，包括产品图片细节展示及相关文案的描述，以客观的展示进行售卖。" attributes:attributes1];
    
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle2.lineSpacing = 6;
    NSString *phonestr = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    NSString *psText = [NSString stringWithFormat:@"备注：代卖商品系统在重新拍照和描述之后会尽快排期上线，期间有任何疑问，请联系客服 %@", phonestr];
    
    NSMutableAttributedString *attributes2 = [[NSMutableAttributedString alloc] initWithString:psText];
    NSDictionary *allAttributes = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:11],
                                    NSParagraphStyleAttributeName:paragraphStyle2
                                    };
    [attributes2 addAttributes:allAttributes range:NSMakeRange(0, psText.length)];
    [attributes2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:150.0/255.0 green:193.0/255.0 blue:243.0/255.0 alpha:1.0] range:NSMakeRange(41, [phonestr length])];
    
    self.psLabel.attributedText = attributes2;
    //    [self.psLabel yb_addAttributeTapActionWithStrings:@[@"010-6789093",@"010-6789093"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
    //
    //        YXLog(@"%@", string);
    //    }];
    [self.psLabel yb_addAttributeTapActionWithStrings:@[phonestr] delegate:self];
    
    //画虚线边框
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor colorWithWhite:179.0/255.0 alpha:1.0].CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 270, 96.5)].CGPath;
    border.frame = self.centerView.bounds;
    border.lineWidth = 1.f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    [self.centerView.layer addSublayer:border];
    
    //--设置内边距
    //    self.psLabel.textInsets = UIEdgeInsetsMake(0, 18, 0, 18);
    
}

@end
