//
//  YXThridPartyLoginManger.h
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/4.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>

/**
 * \brief TencentLoginDelegate iOS Open SDK 1.3 API回调协议
 *
 * 第三方应用实现登录的回调协议
 */
@protocol YXTencentLoginDelegate <NSObject>

@required

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin;

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled;

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork;

@optional
/**
 * 登录时权限信息的获得
 */
- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams;

/**
 * unionID获得
 */
- (void)didGetUnionID;

@end

@interface YXThridPartyLoginManger : NSObject


@property(nonatomic,weak) id<YXTencentLoginDelegate> YXTenceLoginDelegate;
@property(nonatomic,strong) TencentOAuth * tencentOAuth;

+(instancetype)shared;

/**
 获取Code
 */
+(BOOL)senWeiChatAuthRequestScope;

/**
 QQ登录
 */
-(void)TencetnOAuthLogin;

/**
 * 判断用户手机上是否安装手机QQ
 * \return YES:安装 NO:没安装
 * @return 微信已安装返回YES，未安装返回NO。
 */
-(BOOL)iphoneQQorWXInstalledWith:(NSString *)LoginType;


- (BOOL)TencehandleOpenURL:(NSURL *)url;


/**
 sence 0 聊天界面 ，1 朋友圈  2 收藏
 */
-(BOOL)ShareWeiChatWithTitie:(NSString *)title shareDesc:(NSString *)desc shareImage:(UIImage *)image shareURL:(NSString *)url shareSence:(NSInteger)sence;

@end
