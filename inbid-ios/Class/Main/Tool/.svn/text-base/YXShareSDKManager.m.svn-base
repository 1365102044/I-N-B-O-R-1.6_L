//
//  YXShareSDKManager.m
//  inbid-ios
//
//  Created by 郑键 on 17/1/9.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXShareSDKManager.h"
#import "YXAlertViewTool.h"
#import "YXAlearFormMyView.h"
#import <Social/Social.h>
#import "inbid_ios-Swift.h"

@interface YXShareSDKManager() <YXShareSDKBridgeManagerDelegate>

/**
 商品id
 */
@property (nonatomic, copy) NSString *prodId;

/**
 拍卖id
 */
@property (nonatomic, copy) NSString *prodBidId;

/**
 商品名称
 */
@property (nonatomic, copy) NSString *goodName;

/**
 商品描述
 */
@property (nonatomic, copy) NSString *goodDetail;

/**
 分享的图片
 */
@property (nonatomic, copy) NSString *imageURLString;

/**
 分享链接
 */
@property (nonatomic, copy) NSString *urlString;

/**
 控制器
 */
@property (nonatomic, weak) UIViewController *sourceController;

/*
 @brief 自己判读的提示view
 */
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

@end

@implementation YXShareSDKManager

/**
 获取单利
 
 @return 对象
 */
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static YXShareSDKManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YXShareSDKManager alloc] init];
    });
    return instance;
}

/**
 注册sdk
 */
- (void)registerApp
{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"1aa3a9d4fea50"
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            //@(SSDKPlatformTypeCopy),
                            //@(SSDKPlatformTypeQQ),
                            //@(SSDKPlatformTypeRenren),
                            //@(SSDKPlatformTypeGooglePlus)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"644464596"
                                           appSecret:@"14d11d5d45a6ad6820a8a161a2663cdc"
                                         redirectUri:@"https://www.inbornpai.com"
                                            authType:SSDKAuthTypeBoth];
                 break;
                 
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxf86bce5c6d2ffbf4"
                                       appSecret:@"5f1a8779a6d9d4faee3e2017c51bd66d"];
                 break;
             default:
                 break;
         }
     }];
}

/**
 分享
 
 @param imageURLString          商品图片
 @param goodNamed               商品名称
 @param goodDetal               商品描述
 @param prodId                  商品id
 @param prodBidId               拍品id
 */
- (void)shareGoodWithImageURLString:(NSString *)imageURLString
                       andGoodNamed:(NSString *)goodNamed
                      andGoodDetail:(NSString *)goodDetal
                          andProdId:(NSString *)prodId
                       andProdBidId:(NSString *)prodBidId
                  andViewController:(UIViewController *)viewController
{
    self.imageURLString     = imageURLString;
    self.prodId             = prodId;
    self.prodBidId          = prodBidId;
    self.goodName           = goodNamed;
    self.goodDetail         = goodDetal;
    self.urlString          = [NSString stringWithFormat:@"%@/share/details.html?prodId=%@&prodBidId=%@",
                               kOuternet,
                               prodId,
                               prodBidId];
    self.sourceController   = viewController;
    
    YXShareSDKBridgeManager *shareSDKBridgeManager = [[YXShareSDKBridgeManager alloc] init];
    shareSDKBridgeManager.delegate = self;
    [shareSDKBridgeManager showShareMenu];
}

/**
 展示结果提示
 
 @param text 文字
 */
- (void)showResultAlertViewWithText:(NSString *)text
                  andViewController:(UIViewController *)viewController
{
    [YXAlertViewTool showAlertView:viewController title:nil message:text confrimBlock:^{
        
    }];
}

#pragma mark <YXShareSDKBridgeManagerDelegate>

/**
 分享菜单点击事件
 
 @param shareSDKBridgeManager 分享菜单桥接文件
 @param button 点击的按钮
 */
- (void)shareButtonClickWithShareSDKBridgeManager:(YXShareSDKBridgeManager *)shareSDKBridgeManager
                                           button:(UIButton *)button
{
    [shareSDKBridgeManager dismissShareMenu];
    //1、创建分享参数
    NSArray* imageArray = @[self.imageURLString];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        if ([button.titleLabel.text isEqualToString:@"复制链接"]) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = [NSString stringWithFormat:@"%@%@",
                                 self.goodDetail,
                                 self.urlString];
            self.alearMyview.alearstr = @"已复制到剪切板";
            return;
        }
        
        NSString *contentText;
        SSDKPlatformType shareType = SSDKPlatformTypeUnknown;
        
        if ([button.titleLabel.text isEqualToString:@"微信朋友圈"]) {
            contentText = self.goodDetail;
            shareType = SSDKPlatformSubTypeWechatTimeline;
        }
        
        if ([button.titleLabel.text isEqualToString:@"微信好友"]) {
            contentText = self.goodDetail;
            shareType = SSDKPlatformSubTypeWechatSession;
        }
        
        if ([button.titleLabel.text isEqualToString:@"新浪微博"]) {
            contentText = [NSString stringWithFormat:@"%@%@",
                           self.goodDetail,
                           self.urlString];
            shareType = SSDKPlatformTypeSinaWeibo;
        }
        
        if ([button.titleLabel.text isEqualToString:@"系统分享"]) {
            //初始化分享控件
            UIActivityViewController *activeViewController = [[UIActivityViewController alloc]initWithActivityItems:@[self.goodDetail,[NSURL URLWithString:self.urlString]] applicationActivities:nil];
            //不显示哪些分享平台(具体支持那些平台，可以查看Xcode的api)
            activeViewController.excludedActivityTypes = @[UIActivityTypeAirDrop,UIActivityTypeCopyToPasteboard,UIActivityTypeAddToReadingList];
            [self.sourceController presentViewController:activeViewController animated:YES completion:nil];
            //分享结果回调方法
            UIActivityViewControllerCompletionWithItemsHandler myblock = ^(UIActivityType __nullable activityType,
                                                                           BOOL completed,
                                                                           NSArray * __nullable returnedItems,
                                                                           NSError * __nullable activityError)
            {
                YXLog(@"%@\n%zd\n%@\n%@",activityType, completed, returnedItems, activityError);
            };
            activeViewController.completionWithItemsHandler = myblock;
            return;
        }
        
        if ([button.titleLabel.text isEqualToString:@"信息"]) {
            contentText = [NSString stringWithFormat:@"%@%@",
                           self.goodDetail,
                           self.urlString];
            shareType = SSDKPlatformTypeSMS;
        }
        
        if ([button.titleLabel.text isEqualToString:@"邮件"]) {
            contentText = [NSString stringWithFormat:@"%@%@",
                           self.goodDetail,
                           self.urlString];
            shareType = SSDKPlatformTypeMail;
        }
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:contentText
                                         images:imageArray //传入要分享的图片
                                            url:[NSURL URLWithString:self.urlString]
                                          title:self.goodName
                                           type:SSDKContentTypeAuto];
        
        [ShareSDK share:shareType //传入分享的平台类型
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
             [shareSDKBridgeManager dismissShareMenu];
             switch (state) {
                 case SSDKResponseStateSuccess:
                     [self showResultAlertViewWithText:@"分享成功" andViewController:self.sourceController];
                     break;
                 case SSDKResponseStateFail:
                     [self showResultAlertViewWithText:@"分享失败" andViewController:self.sourceController];
                     break;
                 default:
                     break;
             }
         }];
    }
}

#pragma mark - 懒加载

- (YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
        _alearMyview.backgroundColor = [UIColor mainThemColor];
        [self.sourceController.view addSubview:_alearMyview];
        _alearMyview.frame = CGRectMake(YXScreenW*0.5 - YXScreenW*0.4*0.5, YXScreenH / 2 - 15, YXScreenW*0.4, 30);
        _alearMyview.alpha = 0;
        _alearMyview.time = 2.0f;
    }
    return _alearMyview;
}

@end
