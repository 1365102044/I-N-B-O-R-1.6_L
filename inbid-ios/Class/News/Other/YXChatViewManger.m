//
//  YXChatViewManger.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXChatViewManger.h"

@implementation YXChatViewManger

+(instancetype)sharedChatviewManger
{
    static dispatch_once_t onceToken;
    static YXChatViewManger *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YXChatViewManger alloc]init];
    });
    return instance;
}

/**
 注册客服
 */
- (void)registerCustomSever
{
    //#error 请填写您的美洽 AppKey
    //生产:dfdec3376ff3a865552ffbf319651bd8
    //测试:87f108653fbf6d23c5b8914395523fc3
    [MQManager initWithAppkey:@"87f108653fbf6d23c5b8914395523fc3" completion:^(NSString *clientId, NSError *error) {
        if (!error) {
            [self setScheduledAgentid];
        } else {
            YXLog(@"error:%@",error);
        }
    }];
}

/**
 处理消息推送的客服信息
 
 @param userInfo userInfo
 */
- (void)handleNotificationMessageWithUserInfo:(NSDictionary *)userInfo
{
    [MQManager setClientOffline];
    NSString *customSeverId;
    NSString *agentId;
    NSString *agentGroupId;
    @try {
        customSeverId                       = userInfo[@"refId"];
        agentId                             = [customSeverId componentsSeparatedByString:@"_"].firstObject;
        agentGroupId                        = [customSeverId componentsSeparatedByString:@"_"].lastObject;
        [YXUserDefaults setObject:agentId forKey:@"agentId"];
        [YXUserDefaults setObject:agentGroupId forKey:@"agentGroupId"];
    } @catch (NSException *exception) {
        agentId                             = nil;
        agentGroupId                        = nil;
    } @finally {
        
    }
}

/**
 设置用户客服信息
 */
- (void)setScheduledAgentid
{
    [MQManager setScheduledAgentWithAgentId:[YXUserDefaults objectForKey:@"agentId"]
                               agentGroupId:[YXUserDefaults objectForKey:@"agentGroupId"]
                               scheduleRule:MQScheduleRulesRedirectGroup];
}

-(void)LoadChatView
{
    /**
     *  当前项目中调用客服聊天界面前，都会先行调用界面配置方法，所以在这里认定为要进入消息界面。
     *  修改接收系统本地通知为false
     */
    self.showSystemNofification = NO;
    
//    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc]init];
    
//    MQTextMessageCell		 改变头像图片的fill 不然头像上下留白
    /*
     @brief 显示在pc端的用户昵称
     */
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"name"] = [YXUserDefaults objectForKey:@"nickname"];
    [self setClientInfo:param override:YES];
    
    
    //    //**顾客头像**/
    UIImage* avatar;
    NSData *headerimage  = [YXUserDefaults objectForKey:@"headimagedata"];
    avatar = [UIImage imageWithData:headerimage];
    if (headerimage == nil) {
        avatar = [UIImage imageNamed:@"ic_default"];
    }
    
    MQChatViewStyle *chatViewStyle = [self chatViewStyle];
    
    //    设置发送过来的message的文字颜色；
    [chatViewStyle setIncomingMsgTextColor:UIColorFromRGB(0x050505)];
    //    设置发送过来的message气泡颜色
    [chatViewStyle setIncomingBubbleColor:[UIColor whiteColor]];
    //    设置发送出去的message的文字颜色；
    [chatViewStyle setOutgoingMsgTextColor:UIColorFromRGB(0x050505)];
    //    设置发送的message气泡颜色
    [chatViewStyle setOutgoingBubbleColor:UIColorFromRGB(0xb0e46e)];
    //    是否开启圆形头像；默认不支持
    [chatViewStyle setEnableRoundAvatar:YES];
    //    设置顾客的头像图片；
    [self setoutgoingDefaultAvatarImage:avatar];
    //     设置客服的名字
    [self setAgentName:@"Angle"];
    
    chatViewStyle.navBackButtonImage = [UIImage imageNamed:@"icon_fanhui"];
    self.chatViewStyle.navBarTintColor = UIColorFromRGB(0x050505);
    
    [self setMessageLinkRegex:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|([a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
    [self enableMessageSound:true];
    [self setNavTitleText:@"胤宝客服"];
    //开启同步消息
    [self enableSyncServerMessage:true];
}

@end
