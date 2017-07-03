//
//  YXUnionPayManager.m
//  inbid-ios
//
//  Created by 郑键 on 16/12/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXUnionPayManager.h"
#import "LLPaySdk.h"
#import "YXSeverSignInformationModel.h"

@interface YXUnionPayManager() <LLPaySdkDelegate>

/**
 调用控制器
 */
@property (nonatomic, weak) UIViewController *sourceViewController;


@end

@implementation YXUnionPayManager

/**
 支付结果回调

 @param resultCode 结果状态码
 @param dic 结果集
 */
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic {
    
    NSString *msg = @"异常";
    switch (resultCode) {
        case kLLPayResultSuccess: {
            msg = @"成功";
        } break;
        case kLLPayResultFail: {
            msg = @"失败";
        } break;
        case kLLPayResultCancel: {
            msg = @"取消";
        } break;
        case kLLPayResultInitError: {
            msg = @"sdk初始化异常";
        } break;
        case kLLPayResultInitParamError: {
            msg = dic[@"ret_msg"];
        } break;
        default:
            break;
    }
    
    if ([_delegate respondsToSelector:@selector(unionPayManager:andResltCode:)]) {
        [_delegate unionPayManager:self andResltCode:msg];
    }
}

/**
 调用支付
 
 @param type 类型
 */
- (void)setSeverSignInformationModel:(YXSeverSignInformationModel *)severSignInformationModel
{
    _severSignInformationModel = severSignInformationModel;
    
    NSString *signJSONStr = severSignInformationModel.content;
    NSDictionary *param = [self dictionaryWithJsonString:signJSONStr];
    
    [LLPaySdk sharedSdk].sdkDelegate = self;
    [[LLPaySdk sharedSdk] presentLLPaySDKInViewController:self.sourceViewController
                                               withPayType:LLPayTypeVerify
                                             andTraderInfo:param];
}

/**
 开启apple pay
 */
+ (instancetype)startUnionPayWithController:(UIViewController *)viewController
{
    YXUnionPayManager *manager = [YXUnionPayManager new];
    manager.sourceViewController = viewController;
    return manager;
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
