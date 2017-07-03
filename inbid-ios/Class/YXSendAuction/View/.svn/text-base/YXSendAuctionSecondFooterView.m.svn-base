//
//  YXSendAuctionSecondFooterView.m
//  YXSendAuction
//
//  Created by 郑键 on 16/11/11.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXSendAuctionSecondFooterView.h"

@interface YXSendAuctionSecondFooterView()

/**
 售卖协议按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *checkAregmentButton;

@end

@implementation YXSendAuctionSecondFooterView

/**
 我已阅读并同意按钮点击事件

 @param sender sender
 */
- (IBAction)isReadAndAgreeButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

/**
 查看售卖服务协议

 @param sender sender
 */
- (IBAction)checkAregment:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(sendAuctionSecondFooterView:clickButton:)]) {
        [self.delegate sendAuctionSecondFooterView:self clickButton:sender];
    }
}

/**
 初始化
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    //** 初始化界面 */
    self.backgroundColor = [UIColor whiteColor];
    [self.isReadAndAgreeButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    [self.checkAregmentButton setTitleColor:[UIColor themBlueColor] forState:UIControlStateNormal];
    self.isReadAndAgreeButton.selected = YES;
}

@end
