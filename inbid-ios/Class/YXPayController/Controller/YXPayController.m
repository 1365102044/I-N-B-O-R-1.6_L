//
//  YXPayController.m
//  YXPayController
//
//  Created by 郑键 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPayController.h"

@interface YXPayController ()

//** 支付方式选择 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *paymentMethodSelected;
@property (weak, nonatomic) IBOutlet UIView *SplitPaymentView;
@property (weak, nonatomic) IBOutlet UIView *splitPaymentTipsView;


@property (weak, nonatomic) IBOutlet UILabel *EnsureMoneyLable;

@end

@implementation YXPayController

#pragma mark - 响应事件
//** 切换支付方式 */
- (IBAction)paymentMethodSelectedValueChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.SplitPaymentView.hidden = YES;
    }else if (sender.selectedSegmentIndex == 1){
        self.SplitPaymentView.hidden = NO;
    }
}

#pragma mark - 控制器生命周期

//** 视图加载完毕 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.EnsureMoneyLable.text = [NSString stringWithFormat:@"￥%@",self.ensureMoney];

    
    
#warning TODO:判断当前支付手段情况
    [self paymentMethodSelectedValueChanged:self.paymentMethodSelected];
    
#warning TODO:判断当前是否已经是分笔支付
    self.splitPaymentTipsView.hidden = YES;
}

@end
