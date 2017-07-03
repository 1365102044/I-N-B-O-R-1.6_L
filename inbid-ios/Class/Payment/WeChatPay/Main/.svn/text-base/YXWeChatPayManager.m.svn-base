//
//  YXWeChatPayManager.m
//  Payment
//
//  Created by 郑键 on 16/12/2.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXWeChatPayManager.h"
#import "YXSeverSignInformationModel.h"


static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthOpenID = @"wxf86bce5c6d2ffbf4";
static NSString *kAuthState = @"1230";

@interface YXWeChatPayManager() <WXApiDelegate>

@end

@implementation YXWeChatPayManager

/**
 获取单利

 @return 对象
 */
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static YXWeChatPayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YXWeChatPayManager alloc] init];
    });
    return instance;
}

/**
 注册微信支付app
 */
- (void)weChatPayRegisterApp
{
    //** 向微信注册支持的文件类型 */
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
    
    //** appID&描述 */
    [WXApi registerApp:@"wxf86bce5c6d2ffbf4" withDescription:@"胤宝"];
}

/**
 发起支付
 
 @param requestParams 支付参数
 */
- (BOOL)weChatPay:(YXSeverSignInformationModel *)requestParams
{
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = requestParams.partnerId;
    req.prepayId            = requestParams.prepayId;
    req.nonceStr            = requestParams.nonceStr;
    req.timeStamp           = requestParams.timeStamp.intValue;
    req.package             = requestParams.packageStr;
    req.sign                = requestParams.sign;

    return [WXApi sendReq:req];
}

/**
 发起微信支付
 
 @param url url
 @return 返回状态
 */
- (BOOL)handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - 代理方法

#pragma mark <WXApiDelegate>

- (void)onResp:(BaseResp *)resp
{
   
    //**微信分享**/
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)]) {
            SendMessageToWXResp *sendMessageResp = (SendMessageToWXResp *)resp;
            [_delegate managerDidRecvMessageResponse:sendMessageResp];
        }
    }
    
    //**微信登录**/
     if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)]) {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            [_delegate managerDidRecvAuthResponse:authResp];
        }
    }
    
    //** 返回PayResp 类型 */
    if ([resp isKindOfClass:[PayResp class]]) {
        if (!_delegate) return;
        if ([_delegate respondsToSelector:@selector(managerDidPayResponse:)]) {
            PayResp *payResp = (PayResp *)resp;
            [_delegate managerDidPayResponse:payResp];
        }
    }
}

- (void)onReq:(BaseReq *)req
{
    //** 返回PayResp 类型 */
    if ([req isKindOfClass:[PayResp class]]) {
        if (!_delegate) return;
        if ([_delegate respondsToSelector:@selector(managerDidPayResponse:)]
            && _delegate) {
            PayResp *payReq = (PayResp *)req;
            [_delegate managerDidPayResponse:payReq];
        }
    }
}

- (NSMutableArray *)navigationControllerArray
{
    if (!_navigationControllerArray) {
        _navigationControllerArray = [NSMutableArray array];
    }
    return _navigationControllerArray;
}

//- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
//    
//    NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
//    NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", response.code, response.state, response.errCode];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
//                                                    message:strMsg
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil, nil];
//    [alert show];
//}



//-(void)sendAuthRequest:(UIViewController *)viewcontroller
//{
//    //构造SendAuthReq结构体
//    SendAuthReq* req =[[SendAuthReq alloc ] init ];
//    req.scope = kAuthScope;
//    req.state = kAuthState;
//    req.openID = kAuthOpenID;
//    //第三方向微信终端发送一个SendAuthReq消息结构
//    [WXApi sendReq:req];
//
//}
@end
