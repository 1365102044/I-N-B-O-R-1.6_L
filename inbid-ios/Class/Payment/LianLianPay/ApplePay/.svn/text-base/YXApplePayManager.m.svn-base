//
//  YXApplePayManager.m
//  inbid-ios
//
//  Created by 郑键 on 16/12/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXApplePayManager.h"
#import "YXSeverSignInformationModel.h"

@interface YXApplePayManager() <LLPaySdkDelegate>

/**
 连连支付sdk
 */
@property (nonatomic, strong) LLAPPaySDK *apSdk;

/**
 类型
 */
@property (nonatomic, assign) YXApplePayManagerType type;

/**
 调用控制器
 */
@property (nonatomic, weak) UIViewController *sourceViewController;

@end

@implementation YXApplePayManager

/**
 *  调用sdk以后的结果回调
 *
 *  @param resultCode 支付结果
 *  @param dic        回调的字典，参数中，ret_msg会有具体错误显示
 */
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic
{
    NSString *msg = @"支付异常";
    switch (resultCode) {
        case kLLPayResultSuccess:
        {
            msg = @"支付成功";
        }
            break;
        case kLLPayResultFail:
        {
            if ([dic[@"ret_code"] isEqualToString:@"0124"]) {
                msg = @"银行卡余额不足";
            }else if ([dic[@"ret_code"] isEqualToString:@"0312"]) {
                msg = @"卡限额超限";
            }else if ([dic[@"ret_code"] isEqualToString:@"0010"]) {
                msg = @"单笔金额超限";
            }else if ([dic[@"ret_code"] isEqualToString:@"0014"]) {
                msg = @"银行交易出错";
            }else{
                msg = @"支付失败";
            }
        }
            break;
        case kLLPayResultCancel:
        {
            msg = @"支付取消";
        }
            break;
        case kLLPayResultInitError:
        {
            msg = @"sdk初始化异常";
        }
            break;
        case kLLPayResultInitParamError:
        {
            msg = dic[@"ret_msg"];
        }
            break;
        default:
            break;
    }
    
    if ([_delegate respondsToSelector:@selector(ApplePayManager:andResltCode:)]) {
        [_delegate ApplePayManager:self andResltCode:msg];
    }
    
}

/**
 *  支付成功后返回的用户信息
 *
 *  @param shippingMessages 用户信息的字典，key值就是LLShippingMessageName等
 */
- (void)paymentSucceededWithShippingMessages: (NSDictionary *)shippingMessages
{
    NSLog(@"用户姓名:%@\n用户地址%@",shippingMessages[LLShippingMessageName],shippingMessages[LLShippingMessageAddress]);
}

/**
 调用支付

 @param type 类型
 */
-(void)setSeverSignInformationModel:(YXSeverSignInformationModel *)severSignInformationModel
{
    _severSignInformationModel = severSignInformationModel;
//    self.sourceViewController = viewcontroller;
    NSString *signJSONStr = severSignInformationModel.content;
    NSDictionary *param = [self dictionaryWithJsonString:signJSONStr];
    
    if (self.type == YXApplePayManagerOrder) {
        [self payWithSignedOrder:param
                   andController:self.sourceViewController];
    }
    
    if (self.type == YXApplePayManagerAuth) {
        [self authWithSignedOrder:param
                    andController:self.sourceViewController];
    }
}

/**
 开启apple pay
 */
+ (instancetype)startApplePayWithType:(YXApplePayManagerType)type
                        andController:(UIViewController *)viewController
{
    YXApplePayManager *manager = [YXApplePayManager new];
    manager.type = type;
    manager.sourceViewController = viewController;
    return manager;
}

/**
 支付订单

 @param signedOrder 加密订单信息
 */
- (void)payWithSignedOrder:(NSDictionary*)signedOrder
             andController:(UIViewController *)viewController
{
    [LLAPPaySDK sharedSdk].sdkDelegate = self;
    [[LLAPPaySDK sharedSdk] payWithTraderInfo:signedOrder
                             inViewController:viewController];
}

/**
 预支付订单

 @param signedOrder 加密
 */
- (void)authWithSignedOrder:(NSDictionary*)signedOrder
              andController:(UIViewController *)viewController
{
    [LLAPPaySDK sharedSdk].sdkDelegate = self;
    [[LLAPPaySDK sharedSdk] preauthWithTraderInfo:signedOrder
                                 inViewController:viewController];
}


/**
 json字典转

 @param jsonString 字典json字符串
 @return 字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

/**
 字典转json

 @param dic 字典
 @return 返回转好的字符串
 */
- (NSString*)jsonStringOfObj:(NSDictionary*)dic{
    NSError *err = nil;
    
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:dic
                                                         options:0
                                                           error:&err];
    
    NSString *str = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    return str;
}

@end
