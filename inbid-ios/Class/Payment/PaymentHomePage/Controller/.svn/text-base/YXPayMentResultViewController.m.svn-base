//
//  YXPayMentResultViewController.m
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPayMentResultViewController.h"
#import "YXSendAuctionInformationController.h"
#import "YXNavigationController.h"
#import "YXWeChatPayManager.h"
#import "YXOrderDetailViewController.h"
#import "YXPaymentHomePageController.h"

@interface YXPayMentResultViewController ()
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet UIButton *ToSeeOrderDeatilBtn;
@property (weak, nonatomic) IBOutlet UIButton *ToPayMentBtn;

/**
 支付事务类型
 */
//@property (nonatomic, assign) YXPaymentTransType transType;

@end

@implementation YXPayMentResultViewController

/**
 鉴定费订单

 @param orderId orderId 订单编号
 */
- (void)setOrderId:(long long)orderId
{
    _orderId = orderId;
    
//    self.transType = YXPaymentTransIdentifyCost;
}

/**
 返回按钮的点击事件
 
 @param sender 点击按钮
 */
- (void)backButtonClick:(UIButton *)sender
{
    //** 跳转详情界面 */
    [self ClickToSeeOrderDeatil:sender];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"付款结果";
    
    self.titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    self.ToSeeOrderDeatilBtn.layer.masksToBounds = YES;
    self.ToSeeOrderDeatilBtn.layer.cornerRadius = 4;
    
    self.ToPayMentBtn.layer.masksToBounds = YES;
    self.ToPayMentBtn.layer.cornerRadius = 4;
    
    //** 配置关闭按钮 */
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setImage:[UIImage imageNamed:@"icon_PayFenBiClose"] forState:UIControlStateNormal];
    [leftButton sizeToFit];
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    if (self.isBalanceNotEnough) {
        [self.titleBtn setTitle:@"对不起，卡内余额不足，支付失败!" forState:UIControlStateNormal];
    }
    
}
- (IBAction)ClickToSeeOrderDeatil:(id)sender {
    
    //** 判断，当为鉴定订单时，跳转鉴定详情 */
    if (self.transType == YXPaymentHomePageControllerIdentifyCost) {
        if (self.navigationController.viewControllers.count == 5) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
        }else{
            //** 鉴定费详情 */
            YXSendAuctionInformationController *sendAuctionInformationController = [[YXSendAuctionInformationController alloc] init];
            sendAuctionInformationController.sourceViewController = self;
            sendAuctionInformationController.orderID = self.orderId;
            [self.navigationController pushViewController:sendAuctionInformationController animated:YES];
        }
        return;
    }
    
    if (self.transType == YXPaymentHomePageControllerFixGood
        || self.transType == YXPaymentHomePageControllerFixGood_partPayment
        || self.transType == YXPaymentHomePageControllerDeposit
        || self.transType == YXPaymentHomePageControllerDepositExcept
        || self.transType == YXPaymentHomePageControllerDepositExcept_partPayment) {
        //** 一口价，订单详情 ，看情况添加判断条件*/
        [self pushOrderDetailController];

        return;
    }
}

/**
 跳转订单详情页面
 */
- (void)pushOrderDetailController
{
    YXOrderDetailViewController *detailController = [YXOrderDetailViewController orderDetailViewControllerWithOrderId:self.orderId andExtend:self];
    [self.navigationController pushViewController:detailController animated:YES];
}


- (IBAction)ClickPayMentBtn:(id)sender {
    
    YXLog(@"重新支付");
    NSArray *VCarr = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[VCarr objectAtIndex:(VCarr.count - 2)] animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
