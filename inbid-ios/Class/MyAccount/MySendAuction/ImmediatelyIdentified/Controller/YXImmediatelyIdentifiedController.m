//
//  YXImmediatelyIdentifiedController.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXImmediatelyIdentifiedController.h"
#import "YXMySendAuctionHoldTest.h"
#import "YXPayZBarViewController.h"
#import "YXZBarPaySuccessOrFailResultViewController.h"

@interface YXImmediatelyIdentifiedController ()

/**
 代付款的鉴定费
 */
@property (weak, nonatomic) IBOutlet UILabel *paymentsOnBehalfOfLabel;

/**
 提示语
 */
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

/**
 微信支付按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *weiChatPayButton;

/**
 支付宝支付按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *aLiPayButton;

/**
 银联支付按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *unionPayButton;

/**
 当前选中支付方式
 */
@property (nonatomic, strong) UIButton *currentButton;

/**
 按钮高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payButtonHeightCons;

/**
 网络支付扫码提示
 */
@property (weak, nonatomic) IBOutlet UILabel *netPayTipsLabel;

/**
 确认提交按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *suerButton;
@end

@implementation YXImmediatelyIdentifiedController

#pragma mark - 点击事件



//** 确认提交 */
- (IBAction)sureButtonClick:(UIButton *)sender
{
    
    if ([sender.titleLabel.text isEqualToString:@"扫码支付"]) {
        //** 网络请求成功，回调，监听到用户点击 */
        if ([self.delegate respondsToSelector:@selector(immediatelyIdentifiedController:changeRestPageON:)]) {
            [self.delegate immediatelyIdentifiedController:self changeRestPageON:YES];
        }
        [self PushZBarPaymentVC];
    }else if ([sender.titleLabel.text isEqualToString:@""]) {
        
    }
}

//** 支付方式按钮 */
- (IBAction)payTypesButtonClick:(UIButton *)sender
{
    self.currentButton.enabled = YES;
    sender.enabled = NO;
    
    //if (sender.tag == 1003) {
      //  self.netPayTipsLabel.hidden = NO;
        //[self.suerButton setTitle:@"扫码支付" forState:UIControlStateNormal];
    //}else{
      //  self.netPayTipsLabel.hidden = YES;
        //[self.suerButton setTitle:@"确认提交" forState:UIControlStateNormal];
    //}
    
    //self.currentButton = sender;
}

/**
 * push扫码界面
 */
-(void)PushZBarPaymentVC
{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        YXPayZBarViewController *reader = [YXPayZBarViewController new];
                        reader.formePCPayurlBlock = ^(NSString *url){
                            
                            YXLog(@"======扫码结果====++===%@===",url);
                            
                            NSString *clientID;
                            NSString *URL;
                            
                            if (url) {
                                
                                NSArray *urlarr = [url componentsSeparatedByString:@"?"];
                                if (urlarr.count>1) {
                                    
                                    URL = urlarr[0];
                                    
                                    NSArray *clientIDarr = [urlarr[1] componentsSeparatedByString:@"="];
                                    if (clientIDarr.count>1) {
                                        
                                        clientID = clientIDarr[1];
                                    }
                                }
                            }
                            if (URL) {
                                
                                [self requeatPayZBar:URL clientID:clientID];
                            }
                            
                        };
                        [self.navigationController pushViewController:reader animated:YES];
                        YXLog(@"主线程 - - %@", [NSThread currentThread]);
                    });
                    YXLog(@"当前线程 - - %@", [NSThread currentThread]);
                    
                    // 用户第一次同意了访问相机权限
                    YXLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    YXLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            YXPayZBarViewController *reader = [YXPayZBarViewController new];
            reader.formePCPayurlBlock = ^(NSString *url){
                
                YXLog(@"======扫码结果====++===%@===",url);
                
                NSString *clientID;
                NSString *URL;
                
                if (url) {
                    
                    NSArray *urlarr = [url componentsSeparatedByString:@"?"];
                    if (urlarr.count>1) {
                        
                        URL = urlarr[0];
                        
                        NSArray *clientIDarr = [urlarr[1] componentsSeparatedByString:@"="];
                        if (clientIDarr.count>1) {
                            
                            clientID = clientIDarr[1];
                        }
                    }
                }
                if (URL) {
                    
                    [self requeatPayZBar:URL clientID:clientID];
                }
                
            };
            [self.navigationController pushViewController:reader animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            YXLog(@"%@", @"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关");
        } else if (status == AVAuthorizationStatusRestricted) {
            YXLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        YXLog(@"%@", @"未检测到您的摄像头, 请在真机上测试");
    }
    
}

#pragma mark  ******************* 扫码支付 发送请求**********************
-(void)requeatPayZBar:(NSString *)url clientID:(NSString *)clientID
{
    NSString *userID = [YXUserDefaults objectForKey:@"userID"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"orderType"] = @"1";
    
    if (self.sendAuctionHoldTestModel.orderId) {
        
        param[@"orderId"] = [NSString stringWithFormat:@"%lld",self.sendAuctionHoldTestModel.orderId];
    }
    
    //** 支付鉴定费修改 */
    param[@"clientId"] = clientID;
    param[@"id"] = userID;
    
    [YXRequestTool requestDataWithType:POST url:url params:param success:^(id objc, id respodHeader) {
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            
            
            YXLog(@"--扫码结果---%@======",objc);
            
            
            NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
            dataDict[@"type"] = @"1";
            dataDict[@"OrderID"] = [NSString stringWithFormat:@"%lld",self.sendAuctionHoldTestModel.orderId];
            dataDict[@"goodsName"] = self.sendAuctionHoldTestModel.prodName;
            dataDict[@"AllPrice"] = [NSString stringWithFormat:@"%ld",(long)self.sendAuctionHoldTestModel.identifyMoney];
            dataDict[@"AlearlyPrice"] = @"";
            dataDict[@"ShouldPrice"] = [NSString stringWithFormat:@"%ld",(long)self.sendAuctionHoldTestModel.identifyMoney];
            dataDict[@"isPartPay"] = @"";
            
            YXZBarPaySuccessOrFailResultViewController *zbarpayResultVC = [[YXZBarPaySuccessOrFailResultViewController alloc]init];
            zbarpayResultVC.dataDict = dataDict;
            [self.navigationController pushViewController:zbarpayResultVC animated:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"立即鉴定";
    
    //--控件赋值
    self.paymentsOnBehalfOfLabel.text = [NSString stringWithFormat:@"¥ %@", [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%zd", self.sendAuctionHoldTestModel.identifyMoney / 100]]];
    
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle2.lineSpacing = 6;
    NSString *psText = [NSString stringWithFormat:@"您提交的鉴定编号:（%lld）需要进行官方正品鉴定才可以进行售卖，鉴定过程中会产生部分鉴定费用，请提交鉴定费用，以便我们更好地为您服务。", self.sendAuctionHoldTestModel.orderId];
    NSMutableAttributedString *attributes2 = [[NSMutableAttributedString alloc] initWithString:psText];
    NSDictionary *allAttributes = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:12],
                                    NSParagraphStyleAttributeName:paragraphStyle2
                                    };
    [attributes2 addAttributes:allAttributes range:NSMakeRange(0, psText.length)];
    [attributes2 addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(9, [NSString stringWithFormat:@"%lld", self.sendAuctionHoldTestModel.orderId].length+2)];
    
    self.tipsLabel.attributedText = attributes2;
    
    
    //--设置默认支付方式
    [self payTypesButtonClick:self.weiChatPayButton];

    
    //** 屏幕适配 */
    self.payButtonHeightCons.constant = 156.0f / 244.0f * ((self.view.width - 4 * 6) / 3);
    
    //** 配置网络支付提示 */
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = 6;
    NSString *urlString = [NSString stringWithFormat:@"%@/pay", kOuternet];
    NSString *tipsText = [NSString stringWithFormat:@"电脑打开%@扫描二维码即可在线支付。",
                          urlString];
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:tipsText];
    NSDictionary *allAttribute = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:12],
                                    NSParagraphStyleAttributeName:paragraphStyle
                                    };
    [attributes addAttributes:allAttribute range:NSMakeRange(0, tipsText.length)];
    [attributes addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x419bef) range:NSMakeRange(4, urlString.length)];
    self.netPayTipsLabel.attributedText = attributes;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"popToRootViewController" object:nil];
}


@end
