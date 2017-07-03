//
//  YXAlipayManager.m
//  Payment
//
//  Created by 胤讯测试 on 16/12/2.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXAlipayManager.h"
#import "YXAlipayOrderModle.h"
//#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YXPaymentHomepageViewDataModel.h"
#import "YXSeverSignInformationModel.h"

@implementation YXAlipayManager


+ (instancetype)sharedManager{

    static dispatch_once_t onceToken;
    static YXAlipayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YXAlipayManager alloc]init];
    });
    return instance;
}

 /**
 支付宝 支付 处理支付结果
 */
- (void)handleOpenURL:(NSURL *)url
{
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        [self HandleAlipayCallBack:resultDic];
    }];
}
/**
 支付宝 支付结果 回调处理操作
 */
-(void)HandleAlipayCallBack:(NSDictionary *)resultDic
{
    [SVProgressHUD dismiss];
    NSLog(@"result = %@",resultDic);
    //**回调 操作代码**/
    if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        //**支付成功**/
        YXLog(@"支付宝支付成功");
    }else if([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
        YXLog(@"支付宝支付取消");
    }else{
        
        YXLog(@"支付宝支付失败");
    }
    if ([_delegate respondsToSelector:@selector(alipayManager:andAliPayResult:)]) {
        [_delegate alipayManager:self andAliPayResult:resultDic[@"resultStatus"]];
    }
}


- (void)doAlipayPay:(YXPaymentHomepageViewDataModel*)OrderModle
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
//    NSString *appID = AlipayApp_ID;
//    //NSString *privateKey = OrderModle.privateKey;
//    NSString *privateKey = @"p8u1gkaebk1m46nr80ycz3zs3w22pwjo";
//
//    //partner和seller获取失败,提示
//    if ([appID length] == 0 ||
//        [privateKey length] == 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少appId或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
//    YXAlipayOrderModle* order = [YXAlipayOrderModle new];
//    
//    // NOTE: app_id设置
//    order.app_id = self.signInformationModel.appId;
//    
//    // NOTE: 支付接口名称
//    order.method = self.signInformationModel.method;
//    
//    // NOTE: 参数编码格式
//    order.charset = self.signInformationModel.charset;
//    //order.format = self.signInformationModel.format;
//    // NOTE: 当前时间点
////    NSDateFormatter* formatter = [NSDateFormatter new];
////    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    order.timestamp = self.signInformationModel.timestamp;
//    
//    // NOTE: 支付版本
//    order.version = self.signInformationModel.version;
//    
//    // NOTE: sign_type设置
//    order.sign_type = self.signInformationModel.signType;
//    order.notify_url = self.signInformationModel.notifyUrl;
//    
//    // NOTE: 商品数据
//    order.biz_content = [BizContent new];
//    order.biz_content.body = self.signInformationModel.bizContent.body;
//    order.biz_content.subject = self.signInformationModel.bizContent.subject;
//    order.biz_content.out_trade_no = self.signInformationModel.bizContent.out_trade_no; //订单ID（由商家自行制定）
//    order.biz_content.timeout_express = self.signInformationModel.bizContent.timeout_express; //超时时间设置
//    order.biz_content.product_code = self.signInformationModel.bizContent.product_code;
//#warning +++支付金额 test
//    order.biz_content.total_amount = self.signInformationModel.bizContent.total_amount; //商品价格
////    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [OrderModle.payAmount floatValue]/100]; //商品价格
//    
//    
//    //将商品信息拼接成字符串
//    //NSString *orderInfo = [order orderInfoEncoded:NO];
//    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
//    
//    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
//    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//    //id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    //NSString *signedString = [signer signString:orderInfo];
//    
//    // NOTE: 如果加签成功，则继续执行支付
//    //if (signedString != nil) {
//        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    NSString *appScheme = @"Alipay.com.bjInborn";
    
//    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
    //NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                     //orderInfoEncoded, signedString];
    //NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@", orderInfoEncoded, [self encodeString:self.signInformationModel.sign]];
    //NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@", orderInfoEncoded, self.signInformationModel.sign];
//    NSString *orderString = @"app_id=2016120203756396&biz_content=%7B%22total_amount%22%3A10000%2C%22body%22%3A%22%E6%B5%8B%E8%AF%95%E6%98%93%E6%94%AF%E4%BB%98%E6%94%AF%E4%BB%98%E6%96%B9%E5%BC%8F%22%2C%22timeout_express%22%3A%2230m%22%2C%22subject%22%3A%22%E8%83%A4%E5%AE%9D%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22seller_id%22%3A%22ali2%40inborn.com%22%2C%22out_trade_no%22%3A%2220161212-10516-142143322-IDE190351585058849%22%7D&charset=utf-8&format=JSON&method=alipay.trade.app.pay&notify_url=https%3A%2F%2Ftest.inborn.com%2Fnotice%2Fpay%2FalipayAsyncNotice&sign_type=RSA&timestamp=2016-12-12+14%3A21%3A43&version=1.0&sign=Tke09JMoGEQonSiVW%2FuEYjHogLeaREsfPzFtCHne%2BCBoxaPdzwDQUtVtWI2ljFZOQIG6ZVwp30Hsl%2BSpWwkQ%2FZ5tU6ZzxaJ90n%2B158BbUHG47NScWtHWekXV5b11XVlJk4DPI61O5oS%2Be9HxqMRNhLe94Ww8VB3xHmWi6z4uHKg%3D";
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:self.signInformationModel.content fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        [self HandleAlipayCallBack:resultDic];
    }];
}

- (NSString*)encodeString:(NSString*)unencodedString{
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

@end
