//
//  JPush.m
//  test2
//
//  Created by Meiyue on 15/12/26.
//  Copyright © 2016年 Meiyue. All rights reserved.
//

#import "JPush.h"

#import "YXTabBarController.h"
#import "YXNavigationController.h"

//#import "UITabBar+Extension.h"
//#import "UIAlertViewTool.h"
#import <AdSupport/AdSupport.h>
#import <UserNotifications/UserNotifications.h>


static NSString *appKey = @"9868ac2a557a05c7c20e91fe";
static NSString *channel = @"Publish channel";

static JPush* manager = nil;

//** 是否是线上环境 */
#ifdef DEBUG
BOOL isProduction = YES;
#else
BOOL isProduction = YES;
#endif

@implementation JPush

+(JPush *)shareManager
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[JPush alloc] init];
    });
    return manager;
}

/**
 *  注册极光推送
 *
 */
+(void)registerRemotePushService:(UIApplication *)application withOptions:(NSDictionary *)launchOptions delegate:(UIResponder*)delegate{
    
        //Required
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
            JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
            [JPUSHService registerForRemoteNotificationConfig:entity delegate:delegate];
        }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)   categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert)  categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if (resCode==0) {
                YXLog(@"获取registrationID成功");
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            YXLog(@"获取registrationID失败");
        }
        
    }];
    
}



+(void)registerDeviceToken:(NSData *)deviceToken{
     [JPUSHService registerDeviceToken:deviceToken];
}

+(void)handleRemoteNotification:(NSDictionary *)userInfo{
    [JPUSHService handleRemoteNotification:userInfo];
    
}


//UIApplicationStateActive 前台运行  UIApplicationStateInactive 未启动app  UIApplicationStateBackground app在后台
+(void)handleRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    YXLog(@"---ios====+++++++++++++++++======--push=====---%@",userInfo);
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSString *type = [userInfo objectForKey:@"type"];
    NSString *refId = [userInfo objectForKey:@"refId"];
    NSString *name = [userInfo objectForKey:@"name"];
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {// 激活状态，用户正在使用App
        YXLog(@"---------UIApplicationStateActive-----");
        
    }
    else if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) //(不激活状态，用户切换到其他App、按Home键回到桌面、拉下通知中心,点击某条消息)
    {
        YXLog(@"-----UIApplicationStateInactive---------");
        [[JPush shareManager].pushvcDelegate havenotiPushVC:type refId:refId name:name];
        
    }else if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        YXLog(@"---------UIApplicationStateBackground-----");
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}


+ (void)setAlias:(NSString *)alias{

    [JPUSHService setAlias:alias
          callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                    object:self];
}

//  极光推送注册服务回掉函数
+ (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias{
    
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
    [self logSet:tags], alias];
    YXLog(@"TagsAlias回调:%@", callbackString);

}

+ (NSString *)logSet:(NSSet *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    
    [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    return str;
}

+ (NSString *)logDic:(NSDictionary *)dic {
    
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support 回调
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
        
        NSString *type = [userInfo objectForKey:@"type"];
        NSString *refId = [userInfo objectForKey:@"refId"];
        NSString *name = [userInfo objectForKey:@"name"];
        
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {// 激活状态，用户正在使用App
            
            YXLog(@"---------UIApplicationStateActive-----");
            
        }
        else if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) //(不激活状态，用户切换到其他App、按Home键回到桌面、拉下通知中心,点击某条消息)
        {
            YXLog(@"-----UIApplicationStateInactive---------");
            
            [[JPush shareManager].pushvcDelegate havenotiPushVC:type refId:refId name:name];
            
        }else if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
        {
            YXLog(@"---------UIApplicationStateBackground-----");
            
        }

    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        YXLog(@"-222--ios10-push======--%@",userInfo);
        
        //        [self HandleRemoveNotifoication:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}



- (NSString *)modeString
{
#if DEBUG
    [JPUSHService setLogOFF];
    return @"Development (sandbox)";
#else
    return @"Production";
#endif
}


@end
