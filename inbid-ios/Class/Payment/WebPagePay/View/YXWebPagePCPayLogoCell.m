//
//  YXWebPagePCPayLogoCell.m
//  Payment
//
//  Created by 郑键 on 16/12/1.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXWebPagePCPayLogoCell.h"


@interface YXWebPagePCPayLogoCell ()

@property (weak, nonatomic) IBOutlet UILabel *desclable;

@end
@implementation YXWebPagePCPayLogoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSString *urlString = [NSString stringWithFormat:@"%@/pay", kOuternet];
    NSString *tipsText = [NSString stringWithFormat:@"电脑打开%@扫描二维码即可在线支付。",
                          urlString];
    NSMutableAttributedString *atter = [[NSMutableAttributedString alloc]initWithString:tipsText];
    [atter addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x050505) range:NSMakeRange(0, atter.length)];
    [atter addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x419bef) range:NSMakeRange(4, urlString.length)];
    [atter addAttribute:NSFontAttributeName value:YXSFont(12) range:NSMakeRange(0, atter.length)];
    self.desclable.attributedText = atter;
    self.desclable.textAlignment = NSTextAlignmentCenter;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
