//
//  YXPaymentHomePageController.m
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPaymentHomePageController.h"
#import "YXPaymentHomepageViewDataBaseModel.h"
#import "YXPaymentDetailCell.h"
#import "YXPaymentTypeCell.h"
#import "YXPaymentTypeHeaderView.h"
#import "YXLineTransferController.h"
#import "YXInbornTickByTickPayViewController.h"
#import <PassKit/PassKit.h>
#import "YXAlertViewTool.h"
#import "YXPayMentNetRequestTool.h"
#import "YXWebPagePayViewController.h"
#import "YXWeChatPayManager.h"
#import "YXAlipayManager.h"
#import "YXSeverSignInformationModel.h"
#import "YXPayMentResultViewController.h"
#import "YXSendAuctionInformationController.h"
#import "YXNavigationController.h"
#import "AppDelegate.h"
#import "YXPaymentSuccessViewController.h"
#import "YXApplePayManager.h"
#import "YXUnionPayManager.h"
#import <SVProgressHUD.h>
#warning ++++test
#import "YXPayMentOrderDeatilViewController.h"
#import "YXChatViewManger.h"
#import "YXOneMouthPriceDeatilViewController.h"
#import "YXMyAccountRealNameViewController.h"

/**
 支付结果处理

 - YXPaymentResultSuccessed:                支付成功
 - YXPaymentResultUserCancel:               用户取消支付
 - YXPaymentResultFaild:                    支付失败
 */
typedef NS_ENUM(NSUInteger, YXPaymentResultType) {
    YXPaymentResultSuccessed,
    YXPaymentResultUserCancel,
    YXPaymentResultFaild,
};

@interface YXPaymentHomePageController () <UITableViewDataSource, UITableViewDelegate,PKPaymentAuthorizationViewControllerDelegate, YXInbornTickByTickPayViewControllerDelegate, YXWeChatPayManagerDelegate, YXAlipayManagerDelegate, YXUnionPayManagerDelegate,YXApplePayManagerDelegate, YXMyAccountRealNameViewControllerDelegate>
{
    PKPaymentRequest *request;
}

/**
 商品id
 */
@property (nonatomic, assign) long long prodId;

/**
 当前支付类型
 */
@property (nonatomic, assign) YXPaymentHomePageControllerType type;

/**
 内容视图
 */
@property (nonatomic, strong) UITableView *contentTableView;

/**
 确认支付按钮
 */
@property (nonatomic, strong) UIButton *surePaymentButton;

/**
 视图配置数组
 */
@property (nonatomic, strong) NSArray *viewDataSourceArray;

/**
 当前选中的模型数据
 */
@property (nonatomic, strong) YXPaymentHomepageViewDataModel *currentModel;

/**
>>>>>>> .r305
 胤宝分笔支付输入金额界面
 */
@property (nonatomic, weak) YXInbornTickByTickPayViewController *tickByTickPayPayController;

/**
 银联支付请求
 */
//@property (nonatomic, strong) PayEaseComPayment *payeaseComPayment;

/*
 @brief requestDataModle
 */
@property(nonatomic,strong) YXPaymentHomepageViewDataModel * RequestDataModle;

/**
 headerView
 */
@property(nonatomic,weak) YXPaymentTypeHeaderView * headerView;

/**
 是否是分笔支付
 */
@property (nonatomic, assign) BOOL isPartPayment;

/**
 服务器签名参数
 */
@property (nonatomic, strong) YXSeverSignInformationModel *signInofrmationModel;

/**
 当前的鉴定详情控制器
 */
@property (nonatomic, strong) YXNavigationController *currentDetailInformationController;

/**
 倒计时定时器
 */
@property (nonatomic, strong) NSTimer *countDownTimer;

/**
 apple pay支付管理者
 */
@property (nonatomic, strong) YXApplePayManager *applePayManager;

/**
 银联支付管理者
 */
@property (nonatomic, strong) YXUnionPayManager *unionPayManager;

/**
 是否进入过实名认证
 */
@property (nonatomic, assign) BOOL isToVerifiedController;

@end

@implementation YXPaymentHomePageController

//** 重用标志 */
static NSString * const kYXPaymentHomePageControllerDetailCellReusableIdentifier = @"kYXPaymentHomePageControllerDetailCellReusableIdentifier";
static NSString * const kYXPaymentHomePageControllerPaymentTypeCellReusableIdentifier = @"kYXPaymentHomePageControllerPaymentTypeCellReusableIdentifier";
static NSString * const kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier = @"kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier";

//** 常量 */
CGFloat kYXPaymentSureButtonHeight = 44;


#pragma mark - First.通知

/**
 接收到回到前台通知

 @param no no 通知参数
 */
- (void)paymentCallBack:(NSNotification *)no
{
    [YXNetworkHUD show];
    
    if (self.RequestDataModle.paymentType == 2) {
        //** 微信情况下使用self.signInofrmationModel.prepayId 如果其他支付方式，请添加判断 */
        [[YXPayMentNetRequestTool sharedTool] noticePayWXQueryWithTransactionId:nil andpaymentId:self.signInofrmationModel.paymentId andType:self.RequestDataModle.transType success:^(id objc, id respodHeader) {
            [YXNetworkHUD dismiss];
            if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                if ([objc isEqualToString:@"SUCCESS"]) {
                    //** 成功 */
                    [self handlePaymentResultsWithResult:YXPaymentResultSuccessed];
                }
                
                if ([objc isEqualToString:@"NOTPAY"]) {
                    //** 取消 YXPaymentResultUserCancel*/
                    [self handlePaymentResultsWithResult:YXPaymentResultUserCancel];
                }
                
                if ([objc isEqualToString:@"FAIL"]) {
                    //** 失败 */
                    [self handlePaymentResultsWithResult:YXPaymentResultFaild];
                }
                
            }else{
                [self handlePaymentResultsWithResult:YXPaymentResultUserCancel];
            }
            [YXWeChatPayManager sharedManager].delegate = nil;
        } failure:^(NSError *error) {
            //** 查询失败，请查看详情 */
            [self handlePaymentResultsWithResult:YXPaymentResultUserCancel];
        }];
        return;
    }
    
    if (self.RequestDataModle.paymentType == 3) {
        [[YXPayMentNetRequestTool sharedTool] noticePayAlipayQueryWithTradeNo:nil outTradeNo:self.signInofrmationModel.paymentId andType:self.RequestDataModle.transType success:^(id objc, id respodHeader) {
            if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                if ([objc isEqualToString:@"SUCCESS"]) {
                    //** 成功 */
                    [self handlePaymentResultsWithResult:YXPaymentResultSuccessed];
                }
                
                if ([objc isEqualToString:@"ORDERNOTEXIST"]) {
                    //** 取消 YXPaymentResultUserCancel*/
                    [self handlePaymentResultsWithResult:YXPaymentResultUserCancel];
                }
                
                if ([objc isEqualToString:@"FAIL"]) {
                    //** 失败 */
                    [self handlePaymentResultsWithResult:YXPaymentResultFaild];
                }
                
            }else{
                [self handlePaymentResultsWithResult:YXPaymentResultUserCancel];
            }
        } failure:^(NSError *error) {
            [self handlePaymentResultsWithResult:YXPaymentResultUserCancel];
        }];
    }
    
}

#pragma mark - Second.赋值

/**
 收到当前订单id

 @param prodId 订单id
 */
- (void)setProdId:(long long)prodId
{
    _prodId = prodId;
    
    //** 请求网络获取当前页面数据 */
}

#pragma mark - Third.点击事件

/**
 定时器响应事件
 */
- (void)timerEvent
{
    
}

/**
 返回按钮点击事件

 @param sender 返回按钮
 */
- (void)backButtonClick:(UIButton *)sender
{
    NSString *cancelOrderTimeString;
    if (self.RequestDataModle.isPayedDeposit) {
        cancelOrderTimeString = @"48小时";
    }else{
        if (self.RequestDataModle.alreadyPayAmount.longLongValue > 0) {
            cancelOrderTimeString = @"48小时";
        }else{
            cancelOrderTimeString = @"30分钟";
        }
    }
    NSString *tipsText = [NSString stringWithFormat:@"您确定要放弃支付吗？下单后%@内未完成支付，订单将被取消，请您尽快支付。可在",
                          cancelOrderTimeString];
    if (self.type == YXPaymentHomePageControllerIdentifyCost) {
        //** 鉴定订单 */
        tipsText = @"您确定要放弃支付吗？\n可在我的-我的鉴定-立即鉴定再次支付。";
    }else{
        tipsText = [NSString stringWithFormat:@"%@我的-我购买的-待付款中再次支付。", tipsText];
    }
    
    __weak YXPaymentHomePageController *weakSelf = self;
    [YXAlertViewTool showAlertView:self
                             title:@"温馨提示"
                           message:tipsText
                       cancelTitle:@"确认离开"
                        otherTitle:@"继续支付"
                       cancelBlock:^{
           
                           //** 一口价详情到支付界面 没有支付 点击返回，回到详情 */
                           NSArray *VCarr = weakSelf.navigationController.viewControllers;
                           for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                               
                               if ([vc isKindOfClass:[YXOneMouthPriceDeatilViewController class]]) {
                                   for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                                       if ([vc isKindOfClass:[YXPayMentResultViewController class]]||[vc isKindOfClass:[YXPaymentSuccessViewController class] ]) {
                                           
                                           [weakSelf.navigationController popToViewController:[VCarr objectAtIndex:(VCarr.count-6)] animated:YES];
                                           
                                           return ;
                                       }
                                       
                                    }
                                   
                                   [weakSelf.navigationController popToViewController:[VCarr objectAtIndex:(VCarr.count-3)] animated:YES];
                                   
                                   return ;
                               }
                           }
                           [weakSelf.navigationController popViewControllerAnimated:YES];
                           
                       } confrimBlock:^{
                           
                       }];
}

/**
 去支付点击事件

 @param sender sender
 */
- (void)surePaymentButtonClick:(UIButton *)sender
{
    if (!self.currentModel) {
        //** 弹窗，请选择支付方式 */
        [YXAlertViewTool showAlertView:self title:@"提示" message:@"请选择支付方式" confrimBlock:^{
            
        }];
        return;
    }
    
    [self prepayboolwithPayType:self.currentModel.title];
   
}

/**
 根据支付方式支付

 @param paymentTypeTitle paymentTypeTitle 支付方式title
 */
- (void)payAndPaymentTypeTitle:(NSString *)paymentTypeTitle
{
    
    if ([paymentTypeTitle isEqualToString:@"微信支付"]) {
        
        //** 跳转相应的控制器 */
        [YXWeChatPayManager sharedManager].delegate = self;
        if ([[YXWeChatPayManager sharedManager] weChatPay:self.signInofrmationModel]) {
            //** 调用微信支付时，修改刷新状态 */
            __weak AppDelegate *appDelegat = [UIApplication sharedApplication].delegate;
            appDelegat.status = AppDelegateDidBecomeActiveQueryGoodStatus;
            [self.currentDetailInformationController dismissViewControllerAnimated:NO completion:nil];
        }else{
            [YXAlertViewTool showAlertView:self title:@"选择支付方式失败" message:@"请检查是否安装微信客户端" confrimBlock:^{
                
            }];
        }
        return;
    }
    
    if ([paymentTypeTitle isEqualToString:@"支付宝支付"]) {
        
        //** 跳转相应的控制器 */
        __weak AppDelegate *appDelegat = [UIApplication sharedApplication].delegate;
        appDelegat.status = AppDelegateDidBecomeActiveQueryGoodStatus;
        [YXAlipayManager sharedManager].signInformationModel = self.signInofrmationModel;
        [YXAlipayManager sharedManager].delegate = self;
        [[YXAlipayManager sharedManager] doAlipayPay:self.RequestDataModle];
        return;
    }
    
    if ([paymentTypeTitle isEqualToString:@"银联支付"]) {
        //** 跳转相应的控制器 */
        self.unionPayManager.severSignInformationModel = self.signInofrmationModel;
        return;
    }
    
    if ([paymentTypeTitle isEqualToString:@"Apple Pay"]) {
        //** 跳转相应的控制器 */
        self.applePayManager.severSignInformationModel = self.signInofrmationModel;
        self.applePayManager.delegate = self;
        
        return;
    }
    
//    if ([paymentTypeTitle isEqualToString:@"胤宝分笔支付"]) {
//        //** 跳转相应的控制器 */
//        self.tickByTickPayPayView.dataModel = self.RequestDataModle;
//        [[UIApplication sharedApplication].keyWindow addSubview:self.tickByTickPayPayView];
//        [UIView animateWithDuration:0.25 animations:^{
//            self.tickByTickPayPayView.alpha = 1;
//        }];
//        return;
//    }
    
    if ([paymentTypeTitle isEqualToString:@"PC支付"]) {
        __weak AppDelegate *appDelegat = [UIApplication sharedApplication].delegate;
        appDelegat.status = AppDelegateDidBecomeActiveNone;
        //** 跳转相应的控制器 */
        YXWebPagePayViewController *controller = [[YXWebPagePayViewController alloc]init];
        controller.dataModel = self.RequestDataModle;
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    if ([paymentTypeTitle isEqualToString:@"网银转账汇款"]) {
        __weak AppDelegate *appDelegat = [UIApplication sharedApplication].delegate;
        appDelegat.status = AppDelegateDidBecomeActiveNone;
        //** 跳转相应的控制器 */
        YXLineTransferController *lineTransferController = [[YXLineTransferController alloc] init];
        lineTransferController.orderId = self.RequestDataModle.orderId;
        [self.navigationController pushViewController:lineTransferController animated:YES];
        return;
    }
}

/**
 展示等待遮罩视图

 @param title 传入展示文字
 */
- (void)showHUDWithTitle:(NSString *)title
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:title];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

/**
 获取预支付的支付类型参数
 */
-(void)prepayboolwithPayType:(NSString *)type
{
    if ([type isEqualToString:@"微信支付"]) {
        if (![self checkCurrentOrderIsPartPayment]) {
            [self showHUDWithTitle:@"正在调用微信支付"];
        }
        self.RequestDataModle.paymentType = 2;
    }else if ([type isEqualToString:@"支付宝支付"]) {
        if (![self checkCurrentOrderIsPartPayment]) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay:"]]) {
                //** 安装了支付宝应用 */
                [self showHUDWithTitle:@"正在调用支付宝支付"];
            }else{
                //** 未安装支付宝，可弹窗去appStore下载 */
            }
        }
        self.RequestDataModle.paymentType = 3;
    }else if ([type isEqualToString:@"银联支付"]) {
        
        
        if ([self checkValidateStatus]) {
            self.RequestDataModle.paymentType = 5;
        }else{
            
            YXMyAccountRealNameViewController * realnameVC = [[YXMyAccountRealNameViewController alloc]init];
            realnameVC.delegate = self;
            [self.navigationController pushViewController:realnameVC animated:YES];
            
            return;
        }
        
    }else if ([type isEqualToString:@"Apple Pay"]) {
        self.RequestDataModle.paymentType = 4;
        if ([LLAPPaySDK canDeviceSupportApplePayPayments] == kLLAPPayDeviceNotBindChinaUnionPayCard) {
            [YXAlertViewTool showAlertView:self title:@"提示" message:@"使用Apple pay需要先绑定银行卡\n请到桌面-Wallet应用内绑定银行卡" confrimBlock:^{
                
            }];
            return;
        }
    }else{
        [self payAndPaymentTypeTitle:type];
        return;
    }
    
    //** 判断，是否是分笔支付 */
    if ([self checkCurrentOrderIsPartPayment]) {
        self.tickByTickPayPayController.dataModel = self.RequestDataModle;
        [self.navigationController pushViewController:self.tickByTickPayPayController animated:YES];
        return;
    }
    
    [self requestPrePay:self.RequestDataModle.paymentType typestr:type];
    
}

/**
 *  查看是否认证支付过
 *
 *  @return 是否认证支付过
 */
- (BOOL)checkValidateStatus
{
    /**
     *  由于当前是认证支付，判断是否已经进行过实名认证，未认证，跳转实名认证。认证过，发起预支付请求
     */
    
    if ([[YXUserDefaults objectForKey:@"validateStatus"] isEqualToString:@"2"]) {
        return YES;
    }else{
        return NO;
    }
}

/**
 当前订单是否是分笔

 @return 返回 YES是分笔 NO不是分笔
 */
- (BOOL)checkCurrentOrderIsPartPayment
{
    if ((self.RequestDataModle.payAmount.longLongValue / 100) < 4000) {
        //** userPartAmountString的setter方式*100 */
        self.RequestDataModle.userPartAmountString = [NSString stringWithFormat:@"%lld",
                                                      self.RequestDataModle.payAmount.longLongValue / 100];
        return NO;
    }
    
    if (self.type == YXPaymentHomePageControllerFixGood_partPayment
        || self.type == YXPaymentHomePageControllerDepositExcept_partPayment
        || self.type == YXPaymentHomePageControllerBidGood_partPayment) {
        return YES;
    }else{
        return NO;
    }
}

/**
 预支付接口
 */
-(void)requestPrePay:(NSInteger)payType typestr:(NSString *)typestr
{
    [[YXPayMentNetRequestTool sharedTool] loadPayMentPrePayDataWithOrderId:self.RequestDataModle.orderId
                                                              andPayAmount:self.RequestDataModle.payAmount
                                                            andPaymentType:payType
                                                              andTransType:self.RequestDataModle.transType
                                                              andIsPartPay:self.RequestDataModle.isPartPay
                                                           andIsDepositPay:self.RequestDataModle.isCurrentDepositPay
                                                                   success:^(id objc, id respodHeader) {
                                                                       
                                                                       YXLog(@"-----预支付接口---%@",objc);
                                                                       if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                           [SVProgressHUD dismiss];
                                                                           self.signInofrmationModel = [YXSeverSignInformationModel mj_objectWithKeyValues:objc];
                                                                           [self payAndPaymentTypeTitle:typestr];
                                                                       }else{
                                                                           [SVProgressHUD dismiss];
                                                                           [YXAlertViewTool showAlertView:self
                                                                                                    title:@"支付异常"
                                                                                                  message:[NSString stringWithFormat:@"%@", objc]
                                                                                             confrimBlock:^{
                                                                               
                                                                           }];
                                                                       }
                                                                       
                                                                   } failure:^(NSError *error) {
        
                                                                       YXLog(@"-----error---%@",error);
                                                                       [SVProgressHUD dismiss];
                                                                   }];
}


#pragma mark - Fourth.代理方法

#pragma mark <YXMyAccountRealNameViewControllerDelegate>

/**
 实名认证代理方法

 @param myAccountRealNameViewController         myAccountRealNameViewController
 @param exten                                   扩展参数
 */
- (void)myAccountRealNameViewController:(YXMyAccountRealNameViewController *)myAccountRealNameViewController
                                 extend:(id)exten
{
    self.isToVerifiedController = YES;
}

#pragma mark <YXApplePayManagerDelegate>
- (void)ApplePayManager:(id)applePayManager andResltCode:(NSString *)resultCode{

    if ([resultCode isEqualToString:@"支付异常"]) {
        [self handlePaymentResultsWithResult:YXPaymentResultFaild];
    }
    
    if ([resultCode isEqualToString:@"支付成功"]) {
        [self handlePaymentResultsWithResult:YXPaymentResultSuccessed];
    }
    
    if ([resultCode isEqualToString:@"支付失败"]) {
        [self handlePaymentResultsWithResult:YXPaymentResultFaild];
    }
    
    if ([resultCode isEqualToString:@"银行卡余额不足"]) {
        
        [YXAlertViewTool showAlertView:self
                                 title:@"提示"
                               message:@"交易失败，当前银行卡内余额不足，请更换其他银行卡或更换其他支付方式"
                          confrimBlock:^{
            
        }];
        return;
    }

    if ([resultCode isEqualToString:@"卡限额超限"]) {
        
        [YXAlertViewTool showAlertView:self
                                 title:@"提示"
                               message:@"交易失败，当前支付金额超出卡限额，请更换其他银行卡或更换其他支付方式，推荐使用银联支付"
                          confrimBlock:^{
            
        }];
        return;
    }
    
    if ([resultCode isEqualToString:@"银行交易出错"]) {
        
        [YXAlertViewTool showAlertView:self
                                 title:@"提示"
                               message:@"交易失败，发卡行交易权限受限，详情请咨询您的发卡银行，请更换其他银行卡或更换其他支付方式"
                          confrimBlock:^{
                              
                          }];
        return;
    }
    
    if ([resultCode isEqualToString:@"单笔金额超限"]) {
        
        [YXAlertViewTool showAlertView:self
                                 title:@"提示"
                               message:@"交易失败，支付金额超出卡单笔支付限额，请更换其他银行卡或更换其他支付方式，推荐使用银联支付"
                          confrimBlock:^{
            
        }];
        return;
    }
    
    if ([resultCode isEqualToString:@"支付取消"]) {
        [self handlePaymentResultsWithResult:YXPaymentResultUserCancel];
    }
}


#pragma mark <YXUnionPayManagerDelegate>
/**
 银联支付回调

 @param unionPayManager     unionPayManager
 @param resultCode          状态码
 */
- (void)unionPayManager:(YXUnionPayManager *)unionPayManager
           andResltCode:(NSString *)resultCode
{
    if ([resultCode isEqualToString:@"异常"]) {
        [self handlePaymentResultsWithResult:YXPaymentResultFaild];
    }
    
    if ([resultCode isEqualToString:@"成功"]) {
        [self handlePaymentResultsWithResult:YXPaymentResultSuccessed];
    }
    
    if ([resultCode isEqualToString:@"失败"]) {
        [self handlePaymentResultsWithResult:YXPaymentResultFaild];
    }
    
    if ([resultCode isEqualToString:@"取消"]) {
        [self handlePaymentResultsWithResult:YXPaymentResultUserCancel];
    }
}

#pragma mark <YXAlipayManagerDelegate>

/**
 支付宝回调

 @param alipayManager                   支付宝管理者
 @param aliPayResult                    支付结果  9000成功  6001用户取消  其他失败
 */
- (void)alipayManager:(YXAlipayManager *)alipayManager andAliPayResult:(NSString *)aliPayResult
{
    if ([aliPayResult isEqualToString:@"9000"]) {
        //** 成功 */
        [self handlePaymentResultsWithResult:YXPaymentResultSuccessed];
        return;
    }
    
    if ([aliPayResult isEqualToString:@"6001"]) {
        //** 用户取消 */
        [self handlePaymentResultsWithResult:YXPaymentResultUserCancel];
        return;
    }
    
    if (![aliPayResult isEqualToString:@"9000"] && ![aliPayResult isEqualToString:@"6001"]) {
        //** 支付失败 */
        [self handlePaymentResultsWithResult:YXPaymentResultFaild];
        return;
    }
}

#pragma mark <WXApiManagerDelegate>

/**
 微信支付回调

 @param response response
 */
- (void)managerDidPayResponse:(PayResp *)response
{
    if (response.errCode == 0) {
        //** 成功 */
        [self handlePaymentResultsWithResult:YXPaymentResultSuccessed];
        return;
    }
    
    if (response.errCode == -2) {
        //** 用户取消 YXPaymentResultUserCancel*/
        [self handlePaymentResultsWithResult:YXPaymentResultUserCancel];
        return;
    }
    
    if (response.errCode == -1) {
        //** 错误--可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等 */
        [self handlePaymentResultsWithResult:YXPaymentResultFaild];
        return;
    }
}

/**
 支付结果处理

 @param resultType 支付结果类型
 */
- (void)handlePaymentResultsWithResult:(YXPaymentResultType)resultType
{
    //** 测试 YXPaymentResultSuccessed\YXPaymentResultUserCancel */
    if (resultType == YXPaymentResultSuccessed) {
        //** 支付成功 */
        
        if (self.type == YXPaymentHomePageControllerIdentifyCost) {
            //** 鉴定费详情 */
            YXSendAuctionInformationController *sendAuctionInformationController = [[YXSendAuctionInformationController alloc] init];
            sendAuctionInformationController.sourceViewController = self;
            sendAuctionInformationController.orderID = self.RequestDataModle.orderId.longLongValue;
            YXNavigationController *navigationController = [[YXNavigationController alloc] initWithRootViewController:sendAuctionInformationController];
            [self presentViewController:navigationController animated:YES completion:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            return;
        }
        
        if (self.type == YXPaymentHomePageControllerFixGood
            || self.type == YXPaymentHomePageControllerFixGood_partPayment
            || self.type == YXPaymentHomePageControllerDeposit
            || self.type == YXPaymentHomePageControllerDepositExcept
            || self.type == YXPaymentHomePageControllerDepositExcept_partPayment) {
            
            YXPaymentSuccessViewControllerType currentType;
            
            if (self.type == YXPaymentHomePageControllerFixGood) {
                currentType = YXPaymentSuccessViewControllerAllPayment;
            }else if (self.type == YXPaymentHomePageControllerDeposit) {
                currentType = YXPaymentSuccessViewControllerPartDeposit;
            }else if (self.type == YXPaymentHomePageControllerFixGood_partPayment) {
                currentType = YXPaymentSuccessViewControllerPartPayment;
            }else if (self.type == YXPaymentHomePageControllerDepositExcept_partPayment) {
                currentType = YXPaymentSuccessViewControllerPartDepositExcept_partPayment;
            }else if (self.type == YXPaymentHomePageControllerDepositExcept){
                currentType = YXPaymentSuccessViewControllerPartDepositExcept;
            }
            
            YXPaymentSuccessViewController *paymentSuccessViewController = [YXPaymentSuccessViewController new];
            paymentSuccessViewController.type = currentType;
            paymentSuccessViewController.paymentBaseDataModel = self.RequestDataModle;
            [self.navigationController pushViewController:paymentSuccessViewController animated:YES];
        
            return;
        }
        return;
    }
    
    if (resultType == YXPaymentResultUserCancel) {
        
        
        return;
    }

    
    if (resultType == YXPaymentResultFaild) {
        YXPayMentResultViewController *resultController = [[YXPayMentResultViewController alloc] init];
        resultController.orderId = self.RequestDataModle.orderId.longLongValue;
        resultController.transType = (int)self.type;
        [self.navigationController pushViewController:resultController animated:YES];
        return;
    }

}

#pragma mark <YXInbornTickByTickPayViewControllerDelegate>

/**
 胤宝分笔支付 填写信息完成回调

 @param inbornTickByTickPayView inbornTickByTickPayView         胤宝分笔支付
 @param paymentType paymentType                                 支付方式
 @param moneyText moneyText                                     金额
 */
- (void)inbornTickByTickPayController:(YXInbornTickByTickPayViewController *)inbornTickByTickPayController
                       andPaymentType:(NSString *)paymentType
                         andMoneyText:(NSString *)moneyText
{
    if ([paymentType isEqualToString:@"微信支付"]) {
        [self showHUDWithTitle:@"正在调用微信支付"];
    }else if ([paymentType isEqualToString:@"支付宝支付"]) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay:"]]) {
            //** 安装了支付宝应用 */
            [self showHUDWithTitle:@"正在调用支付宝支付"]; 
        }else{
            //** 未安装支付宝，可弹窗去appStore下载 */
        }
    }else if([paymentType isEqualToString:@"银联支付"]){
        
        if ([self checkValidateStatus]) {
            self.RequestDataModle.paymentType = 5;
        }else{
            
            YXMyAccountRealNameViewController * realnameVC = [[YXMyAccountRealNameViewController alloc]init];
            realnameVC.delegate = self;
            [self.navigationController pushViewController:realnameVC animated:YES];
            
            return;
        }
    }
    
    self.RequestDataModle.userPartAmountString = moneyText;
    [[YXPayMentNetRequestTool sharedTool] loadPayMentPrePayDataWithOrderId:self.RequestDataModle.orderId
                                                              andPayAmount:self.RequestDataModle.userPartAmountString
                                                            andPaymentType:self.RequestDataModle.paymentType
                                                              andTransType:self.RequestDataModle.transType
                                                              andIsPartPay:self.RequestDataModle.isPartPay
                                                           andIsDepositPay:self.RequestDataModle.isCurrentDepositPay
                                                                   success:^(id objc, id respodHeader) {
                                                                       
                                                                       YXLog(@"-----预支付接口---%@",objc);
                                                                       if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                           [SVProgressHUD dismiss];
                                                                           self.signInofrmationModel = [YXSeverSignInformationModel mj_objectWithKeyValues:objc];
                                                                           [self payAndPaymentTypeTitle:paymentType];
                                                                       }else{
                                                                           [SVProgressHUD dismiss];
                                                                       }
                                                                       
                                                                   } failure:^(NSError *error) {
                                                                       
                                                                       YXLog(@"-----error---%@",error);
                                                                       [SVProgressHUD dismiss];
                                                                   }];
}

#pragma mark <PMCRequestDelegate>

/**
 银联支付请求失败回调

 @param request                                                 请求
 @param errorMessage                                            错误信息
 */
//-(void)request:(PMCRequest *)request failed:(NSString *)errorMessage
//{
//    UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil
//                                                         message:errorMessage
//                                                        delegate:nil
//                                               cancelButtonTitle:@"确认"
//                                               otherButtonTitles:nil];
//    [alertView show];
//}

/**
 银联支付请求

 @param request 请求
 @param XMLData 订单
 */
//- (void)request:(PMCRequest *)request success:(id)XMLData
//{
//    [SVProgressHUD dismiss];
//    NSLog(@"下订单接口返回数据：%@", XMLData);
//    if (!_payeaseComPayment) {
//        _payeaseComPayment = [[PayEaseComPayment alloc] init];
//        _payeaseComPayment.delegate = self;
//    }
//    
//    PMCMakeOrderInfo *makeOrderInfo = [[PMCMakeOrderInfo alloc] initWithXMLData:XMLData];
//    if ([makeOrderInfo.status isEqualToString:@"0"]) {
//        [_payeaseComPayment sendDataWithParentController:self orderID:makeOrderInfo.oid merchantID:self.signInofrmationModel.v_mid orderMd5Info:self.unionPayManager.orderMd5Info otherInfo:@{kBankCardNumKey:@"", kEnableEditBankNumTextKey:@(YES)}];
//    }else{
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:makeOrderInfo.statusDesc delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
////        [alert show];
//    }
//}

#pragma mark <PayEaseComPaymentDelegate>

///**
// 支付结果回调
//
// @param payStatus payStatus
// @param statusDesc statusDesc
// */
//-(void)PayEaseComResultStatus:(PayEaseComPayStatus)payStatus statusDescription:(NSString *)statusDesc
//{
//    NSString *result = [NSString stringWithFormat:@"%zd:%@",payStatus, statusDesc];
//    UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:result delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
//    [alertView show];
//}

#pragma mark <YXUnionPayManagerDelegate>

///**
// 发送订单预支付请求
//
// @param unionPayManager                                         unionPayManager
// @param parametersData                                          parametersData
// @param tag tag
// */
//- (void)unionPayManager:(YXUnionPayManager *)unionPayManager andParametersData:(NSData *)parametersData andTag:(NSString *)tag
//{
//    [self.unionPayManager.orderRequest sendPOSTRequest:kOrderUrl parametersData:parametersData withTag:tag];
//}

#pragma mark <UITableViewDataSource>

/**
 返回组
 
 @param tableView                                               tableView
 
 @return 组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewDataSourceArray.count;
}

/**
 返回行
 
 @param tableView                                               tableView
 @param section                                                 section
 
 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YXPaymentHomepageViewDataBaseModel *baseModel = self.viewDataSourceArray[section];
    return baseModel.data.count;
}

/**
 自定义cell
 
 @param tableView                                               tableView
 @param indexPath                                               indexPath
 
 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXPaymentHomepageViewDataBaseModel *baseModel = self.viewDataSourceArray[indexPath.section];
    
    if (indexPath.section == 0) {
        YXPaymentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXPaymentHomePageControllerDetailCellReusableIdentifier forIndexPath:indexPath];
        cell.deatilmodle = self.RequestDataModle;
        return cell;
    }
    
    if (indexPath.section == 1) {
        YXPaymentTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXPaymentHomePageControllerPaymentTypeCellReusableIdentifier forIndexPath:indexPath];
        cell.dataModel = baseModel.data[indexPath.row];
        return cell;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YXPaymentTypeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier];
    _headerView = headerView;
    if (!headerView) {
        headerView = [[YXPaymentTypeHeaderView alloc] initWithReuseIdentifier:kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier];
    }
    if (section == 0) headerView.type   = YXPaymentTypeHeaderViewDetailHeader;
    if (section == 1) headerView.type   = YXPaymentTypeHeaderViewPaymentTypeHeader;
    headerView.baseModel                = self.RequestDataModle;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    YXPaymentHomepageViewDataBaseModel *baseModel = self.viewDataSourceArray[section];
    return baseModel.headerHeight.floatValue;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXPaymentHomepageViewDataBaseModel *baseModel = self.viewDataSourceArray[indexPath.section];
    YXPaymentHomepageViewDataModel *model = baseModel.data[indexPath.row];
    return model.rowHeight.floatValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return;
    
    self.currentModel.isSelected = [NSString stringWithFormat:@"%zd", !self.currentModel.isSelected.boolValue];
    //** 获取数据, 切换选中状态 */
    YXPaymentHomepageViewDataBaseModel *baseModel = self.viewDataSourceArray[indexPath.section];
    YXPaymentHomepageViewDataModel *dataModel = baseModel.data[indexPath.row];
    dataModel.isSelected = [NSString stringWithFormat:@"%zd", !dataModel.isSelected.boolValue];
    
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:1];
    [self.contentTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    self.currentModel = dataModel;
}

#pragma mark - Fifth.控制器生命周期

/**
 实例化当前控制器

 @param prodId      商品id
 @param type        控制器类型
 @return            返回控制器实例
 */
+ (instancetype)loadPaymentControllerWithProdId:(long long)prodId andType:(YXPaymentHomePageControllerType)type
{
    YXPaymentHomePageController *controller = [[self alloc] init];
    controller.type = type;
    controller.prodId = prodId;
    return controller;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden= YES;
    
    //** 加载网络数据 */
    [self loadData];
    //** 开启定时器 */
    [self creatTimer];
}

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"paymentCallBackFromeWX" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.isToVerifiedController = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"paymentCallBackFromeWX" object:nil];
}

/**
 视图即将离开
 
 @param animated 动画
 */
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self cleanTimer];
}

/**
 释放定时器
 */
- (void)cleanTimer
{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}

/**
 控制器视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 配置界面 */
    [self setupCustomUI];
    //** 注册控件 */
    [self registerSubViews];
    //** 注册通知 */
    [self registerNotification];
    //** 默认选中第一个支付方式 */
    [self tableView:self.contentTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
}

/**
 添加定时器
 */
- (void)creatTimer
{
    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
}

/**
 加载网络数据
 */
-(void)loadData
{
    [YXNetworkHUD show];
    [[YXPayMentNetRequestTool sharedTool] loadPayMentHomePageDataWithOrderId:self.prodId
                                                              andPaymentType:[self returenTransType]
                                                                     success:^(id objc, id respodHeader) {
                                                                         [YXNetworkHUD dismiss];
                                                                         YXLog(@"---zhifus----%@",objc);
                                                                         if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                             
                                                                             self.RequestDataModle = [YXPaymentHomepageViewDataModel mj_objectWithKeyValues:objc];
                                                                             //** 为模型赋值，告诉模型当前订单支付类型 */
                                                                             self.RequestDataModle.paymentControllerType = self.type;
                                                                             self.RequestDataModle.userPartAmountString = @"";
                                                                             [self.contentTableView reloadData];
                                                                             if (self.isToVerifiedController) {
                                                                                 [self surePaymentButtonClick:self.surePaymentButton];
                                                                             }
                                                                         }
                                                                     } failure:^(NSError *error) {
                                                                         [YXNetworkHUD dismiss];
                                                                         YXLog(@"---error--%@",error);
                                                                     }];
}

/**
 返回事务类型

 @return 事务类型编码
 */
- (NSInteger)returenTransType
{
    if (self.type == YXPaymentHomePageControllerIdentifyCost) {
        //** 鉴定费 */
        return 1;
    }
    
    if (self.type == YXPaymentHomePageControllerBidGood
        || self.type == YXPaymentHomePageControllerBidGood_partPayment) {
        //** 拍卖订单 */
        return 2;
    }
    
    if (self.type == YXPaymentHomePageControllerBond) {
        //** 保证金 */
        return 3;
    }
    
    if (self.type == YXPaymentHomePageControllerFixGood
        || self.type == YXPaymentHomePageControllerFixGood_partPayment
        || self.type == YXPaymentHomePageControllerDeposit
        || self.type == YXPaymentHomePageControllerDepositExcept
        || self.type == YXPaymentHomePageControllerDepositExcept_partPayment) {
        //** 一口价&定金支付 */
        return 4;
    }else{
        return 100;
    }
}

#pragma mark - Sixth.界面配置

/**
 注册通知
 */
- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(paymentCallBack:)
                                                 name:@"paymentCallBackFromeWX"
                                               object:nil];
}

/**
 配置自定义UI界面
 */
- (void)setupCustomUI
{
    self.title = @"选择支付方式";
    
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.surePaymentButton];
    self.contentTableView.backgroundColor   = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
    self.contentTableView.contentInset      = UIEdgeInsetsMake(0, 0, kYXPaymentSureButtonHeight, 0);
    
    [self setNavRightItems];
    
    UIButton *leftButton                    = [[UIButton alloc] init];
    UIBarButtonItem *leftButtonItem         = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [leftButton setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [leftButton sizeToFit];
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem   = leftButtonItem;
}

/**
 注册子控件
 */
- (void)registerSubViews
{
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXPaymentDetailCell class])
                                                      bundle:nil] forCellReuseIdentifier:kYXPaymentHomePageControllerDetailCellReusableIdentifier];
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXPaymentTypeCell class])
                                                      bundle:nil] forCellReuseIdentifier:kYXPaymentHomePageControllerPaymentTypeCellReusableIdentifier];
    [self.contentTableView registerClass:[YXPaymentTypeHeaderView class] forHeaderFooterViewReuseIdentifier:kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier];
}
/**
 添加消息item
 */
-(void)setNavRightItems
{
    UIButton *Rightbtn                          = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    Rightbtn.imageEdgeInsets                    = UIEdgeInsetsMake(0, 0, 0, -20);
    UIBarButtonItem *rightitem                  = [[UIBarButtonItem alloc]initWithCustomView:Rightbtn];
    self.navigationItem.rightBarButtonItem      = rightitem;
    [Rightbtn setImage:[UIImage imageNamed:@"ico_payNews"] forState:UIControlStateNormal];
    [Rightbtn addTarget:self action:@selector(ClickNews) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)ClickNews
{
    [[YXChatViewManger sharedChatviewManger] LoadChatView];
    [[YXChatViewManger sharedChatviewManger] presentMQChatViewControllerInViewController:self];
}
#pragma mark - Seventh.懒加载

- (YXUnionPayManager *)unionPayManager
{
    if (!_unionPayManager) {
        _unionPayManager = [YXUnionPayManager startUnionPayWithController:self];
        _unionPayManager.delegate = self;
    }
    return _unionPayManager;
}

- (YXApplePayManager *)applePayManager
{
    if (!_applePayManager) {
        _applePayManager = [YXApplePayManager startApplePayWithType:YXApplePayManagerOrder andController:self];
    }
    return _applePayManager;
}

- (NSTimer *)countDownTimer
{
    if (!_countDownTimer) {
        _countDownTimer = [NSTimer timerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(timerEvent)
                                                userInfo:nil
                                                 repeats:YES];
    }
    return _countDownTimer;
}

- (UITableView *)contentTableView
{
    if (!_contentTableView) {
        _contentTableView                       = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _contentTableView.dataSource            = self;
        _contentTableView.delegate              = self;
        _contentTableView.separatorStyle        = UITableViewCellSeparatorStyleNone;
    }
    return _contentTableView;
}

- (UIButton *)surePaymentButton
{
    if (!_surePaymentButton) {
        CGFloat height                          = kYXPaymentSureButtonHeight;
        CGFloat y                               = self.view.bounds.size.height - height;
        _surePaymentButton                      = [[UIButton alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, height)];
        _surePaymentButton.backgroundColor      = [UIColor blackColor];
        [_surePaymentButton setTitle:@"去支付" forState:UIControlStateNormal];
        [_surePaymentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_surePaymentButton addTarget:self action:@selector(surePaymentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _surePaymentButton;
}

- (NSArray *)viewDataSourceArray
{
    if (!self.RequestDataModle) return nil;
    
    if (!_viewDataSourceArray) {

        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:@[@{@"data":@[@{@"title":@"订单信息",
                                                                                   @"rowHeight":@"121"}],
                                                                       @"headerHeight":@"50"}]];
        NSMutableArray *tempDataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"银联支付",
                                                                           @"imageNamed":@"icon_UnionPay",
                                                                           @"detaileText":@"大额支付、超出限额时推荐使用",
                                                                           @"isSelected":@"0",
                                                                           @"rowHeight":@"58.5"},
                                                                         @{@"title":@"支付宝支付",
                                                                           @"imageNamed":@"icon_Alipay",
                                                                           @"detaileText":@"支付宝单笔每日最高消费50000",
                                                                           @"isSelected":@"0",
                                                                           @"rowHeight":@"58.5"}]];
        if (self.type  == YXPaymentHomePageControllerIdentifyCost
            || self.type == YXPaymentHomePageControllerBond
            || self.type == YXPaymentHomePageControllerDeposit) {
            
            //** 判断当前版本是否满足apple pay */
//            kLLAPPayDeviceSupport,                  // 完全支持
//            kLLAPPayDeviceNotSupport,               // 设备无法支持，无法绑卡，原因是机型不支持，或者系统版本太低
//            kLLAPPayDeviceVersionTooLow,            // 设备无法支持银联卡支付，需要iOS9.2以上
//            kLLAPPayDeviceNotBindChinaUnionPayCard, // 设备支持，用户未绑卡
            if ([LLAPPaySDK canDeviceSupportApplePayPayments] == kLLAPPayDeviceSupport
                || [LLAPPaySDK canDeviceSupportApplePayPayments] == kLLAPPayDeviceNotBindChinaUnionPayCard) {
                [tempDataArray addObject:@{@"title":@"Apple Pay",
                                           @"imageNamed":@"icon_ApplePay",
                                           @"detaileText":@"大额支付、超出限额时推荐使用",
                                           @"isSelected":@"0",
                                           @"rowHeight":@"58.5"}];
            }
            
            if ((self.RequestDataModle.payAmount.longLongValue / 100) < 5000) {
                [tempDataArray addObject:@{@"title":@"微信支付",
                                           @"imageNamed":@"icon_WeiXinPay",
                                           @"detaileText":@"微信钱包单笔每日最高消费50000",
                                           @"isSelected":@"0",
                                           @"rowHeight":@"58.5"}];
            }
            
        }else{
            
            if ([LLAPPaySDK canDeviceSupportApplePayPayments] == kLLAPPayDeviceSupport
                || [LLAPPaySDK canDeviceSupportApplePayPayments] == kLLAPPayDeviceNotBindChinaUnionPayCard) {
                [tempDataArray addObject:@{@"title":@"Apple Pay",
                                           @"imageNamed":@"icon_ApplePay",
                                           @"detaileText":@"大额支付、超出限额时推荐使用",
                                           @"isSelected":@"0",
                                           @"rowHeight":@"58.5"}];
            }
            
            //** 分笔 */
            if (self.type == YXPaymentHomePageControllerFixGood
                || self.type == YXPaymentHomePageControllerDepositExcept) {
                [tempDataArray addObject:@{@"title":@"PC支付",
                                           @"imageNamed":@"icon_payment_PCPay",
                                           @"detaileText":@"大额支付、超出限额时推荐使用",
                                           @"isSelected":@"0",
                                           @"rowHeight":@"58.5"}];
            }else{
                
            }
        }
        
        [tempArray addObject:@{@"data":tempDataArray.copy,
                               @"headerHeight":@"50"}];
        
        
        _viewDataSourceArray        = [YXPaymentHomepageViewDataBaseModel mj_objectArrayWithKeyValuesArray:tempArray.copy];
    }
    return _viewDataSourceArray;
}

//- (YXUnionPayManager *)unionPayManager
//{
//    if (!_unionPayManager) {
//        _unionPayManager = [YXUnionPayManager initWithMidNumberText:@"10516" andAmountText:@"0.01" andOnlyIdentifyText:@"201512300"];
//        _unionPayManager.delegate = self;
//        _unionPayManager.orderRequest = [[PMCRequest alloc] init];
//        [_unionPayManager.orderRequest setDelegate:self];
//    }
//    return _unionPayManager;
//}

- (YXInbornTickByTickPayViewController *)tickByTickPayPayController
{
    if (!_tickByTickPayPayController) {
        YXInbornTickByTickPayViewController *tickByTickPayControler     = [[UIStoryboard storyboardWithName:
                                                                            NSStringFromClass([YXInbornTickByTickPayViewController class])
                                                                                                     bundle:nil]
                                                                           instantiateInitialViewController];
        _tickByTickPayPayController                                     = tickByTickPayControler;
        _tickByTickPayPayController.delegate                            = self;
    }
    return _tickByTickPayPayController;
}

@end
