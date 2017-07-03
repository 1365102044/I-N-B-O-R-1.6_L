//
//  YXThridPartyLoginManger.m
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/4.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXThridPartyLoginManger.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "YXWeChatPayManager.h"
#import "YXLoginRequestTool.h"


static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthOpenID = @"wxf86bce5c6d2ffbf4";
//static NSString *kAuthState = @"1230";
static NSString *TenceAppId = @"1105919178";
//1105919178
@interface YXThridPartyLoginManger ()<TencentSessionDelegate>



@end
@implementation YXThridPartyLoginManger

+(instancetype)shared{

    static dispatch_once_t onceToken;
    static YXThridPartyLoginManger *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YXThridPartyLoginManger alloc]init];
        
    });
    return instance;

}
/**
 微信 获取code
 */
+(BOOL)senWeiChatAuthRequestScope{
    
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = kAuthScope;
    req.state = [[self shared] getRandomNumber:1 to:9999];
    req.openID = kAuthOpenID;
    return  [WXApi sendReq:req];

}

-(NSString *)getRandomNumber:(int)from to:(int)to
{
    return [NSString stringWithFormat:@"%d",(int)(from + (arc4random() % (to - from + 1)))];
}
-(void)TencetnOAuthLogin{

    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:TenceAppId andDelegate:self];
    //** 默认可以不用填写。建议不用填写 */
    self.tencentOAuth.redirectURI = @"www.qq.com";
   NSArray * permissions = [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo", @"add_t", nil];
    [self.tencentOAuth authorize:permissions inSafari:NO];
    
}
/**
 * 判断用户手机上是否安装手机QQ
 * \return YES:安装 NO:没安装
  * @return 微信已安装返回YES，未安装返回NO。
 */
-(BOOL)iphoneQQorWXInstalledWith:(NSString *)LoginType
{
    if ([LoginType isEqualToString:@"QQ"]) {
        
        return  [TencentOAuth iphoneQQInstalled];
        
    }else if([LoginType isEqualToString:@"WX"]){
    
        return [WXApi isWXAppInstalled];
    }
    
    return NO;
}



#pragma mark  *** QQ  *****************************
/**
 @param url url
 @return 返回状态
 */
- (BOOL)TencehandleOpenURL:(NSURL *)url
{
    return  [TencentOAuth HandleOpenURL:url];
}
/**
 * \brief TencentLoginDelegate iOS Open SDK 1.3 API回调协议
 *
 * 第三方应用实现登录的回调协议
 */
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    if ([self.YXTenceLoginDelegate respondsToSelector:@selector(tencentDidLogin)]) {
        [self.YXTenceLoginDelegate tencentDidLogin];
    }
    
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{

    if ([self.YXTenceLoginDelegate respondsToSelector:@selector(tencentDidNotLogin:)]) {
        [self.YXTenceLoginDelegate  tencentDidNotLogin:cancelled];
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    /**
      _labelTitle.text=@"无网络连接，请设置网络";
     */
    if ([self.YXTenceLoginDelegate respondsToSelector:@selector(tencentDidNotNetWork)]) {
        [self.YXTenceLoginDelegate  tencentDidNotNetWork];
    }
}

/**
 * unionID获得
 */
- (void)didGetUnionID{

}

/**
 sence 0 聊天界面 ，1 朋友圈  2 收藏  
 */
-(BOOL)ShareWeiChatWithTitie:(NSString *)title shareDesc:(NSString *)desc shareImage:(UIImage *)image shareURL:(NSString *)url shareSence:(NSInteger)sence{
    
    WXMediaMessage *message = [WXMediaMessage  message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:image];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = url;
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = message;
    req.scene = (int)sence;
    
    return  [WXApi sendReq:req];
    
}

// enum WXScene {
//WXSceneSession  = 0,        /**< 聊天界面    */
//WXSceneTimeline = 1,        *< 朋友圈
//WXSceneFavorite = 2,        /**< 收藏       */

@end
