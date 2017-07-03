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
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIEditorViewStyle.h>
#import <Social/Social.h>
#import "inbid_ios-Swift.h"

static NSString * const ShareSDKAPPKey = @"1ab50ca89464a";

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
    [ShareSDK registerApp:ShareSDKAPPKey
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
                                         redirectUri:kOuternet
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
    
    if (([UIDevice currentDevice].systemVersion.floatValue >= 9.3f)) {
        YXShareSDKBridgeManager *shareSDKBridgeManager = [[YXShareSDKBridgeManager alloc] init];
        shareSDKBridgeManager.delegate = self;
        [shareSDKBridgeManager showShareMenu];
    }else{
        //1、创建分享参数
        NSArray* imageArray = @[imageURLString];
        //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
        if (imageArray) {
            
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:@""
                                             images:imageArray
                                                url:[NSURL URLWithString:self.urlString]
                                              title:goodNamed
                                               type:SSDKContentTypeAuto];
            
            
            [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@%@",
                                                              goodNamed,
                                                              self.urlString]
                                                       title:goodNamed
                                                       image:[UIImage imageNamed:@"ic_default"]
                                                         url:nil
                                                    latitude:0
                                                   longitude:0
                                                    objectID:nil
                                                        type:SSDKContentTypeAuto];
            
            //自定义分享菜单样式
            [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSystem];
            [SSUIShareActionSheetStyle isCancelButtomHidden:NO];
            [SSUIShareActionSheetStyle setCancelButtonLabelColor:[UIColor mainThemColor]];
            
            //2、分享（可以弹出我们的分享菜单和编辑界面）
            [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                     items:@[
                                             @(SSDKPlatformSubTypeWechatSession),
                                             @(SSDKPlatformSubTypeWechatTimeline),
                                             //@(SSDKPlatformTypeSinaWeibo)
                                             //@(SSDKPlatformTypeMail),
                                             //@(SSDKPlatformTypeSMS),
                                             //@(SSDKPlatformTypeCopy),
                                             //@(SSDKPlatformTypeQQ),
                                             //@(SSDKPlatformTypeRenren),
                                             //@(SSDKPlatformTypeGooglePlus)
                                             ]
                               shareParams:shareParams
                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                           
                           switch (state) {
                               case SSDKResponseStateSuccess:
                                   [self showHUDWithStatus:YES
                                                   andText:@"分享成功"
                                                     error:error];
                                   break;
                               case SSDKResponseStateFail:
                                   [self showHUDWithStatus:NO
                                                   andText:@"分享失败"
                                                     error:error];
                                   break;
                               default:
                                   break;
                           }
                       }];
        }
    }
    
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
            [self showHUDWithStatus:YES
                            andText:@"已复制到剪切板"
                              error:nil];
            return;
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
        
        NSString *contentText;
        SSDKPlatformType shareType      = SSDKPlatformTypeUnknown;
        NSString *failedText            = @"分享失败";
        
        if ([button.titleLabel.text isEqualToString:@"微信朋友圈"]) {
            contentText = self.goodName;
            shareType = SSDKPlatformSubTypeWechatTimeline;
        }
        
        if ([button.titleLabel.text isEqualToString:@"微信好友"]) {
            contentText = self.goodName;
            shareType = SSDKPlatformSubTypeWechatSession;
        }
        
        if ([button.titleLabel.text isEqualToString:@"新浪微博"]) {
            contentText = [NSString stringWithFormat:@"%@%@",
                           self.goodName,
                           self.urlString];
            shareType = SSDKPlatformTypeSinaWeibo;
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
            failedText = @"分享失败，请检查系统邮箱登录状态";
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
             YXLog(@"%@\n%@\n%@", error, userData, contentEntity);
             switch (state) {
                 case SSDKResponseStateSuccess:
                     [self showHUDWithStatus:YES
                                     andText:@"分享成功"
                                       error:error];
                     break;
                 case SSDKResponseStateFail:
                     [self showHUDWithStatus:NO
                                     andText:failedText
                                       error:error];
                     break;
                 default:
                     break;
             }
         }];
    }
}

/**
 显示提示文字

 @param status  当前提示状态
 @param text    提示文字内容
 */
- (void)showHUDWithStatus:(BOOL)status
                  andText:(NSString *)text
                    error:(NSError *)error
{
    if (status) {
        [SVProgressHUD showSuccessWithStatus:text];
    }else{
        if (error.code == 208) {
//            [YXAlertViewTool showAlertView:self.sourceController
//                                     title:@"分享失败"
//                                   message:@"您当前的设备未安装微信客户端，如需安装点击前往下载。"
//                               cancelTitle:@"取消"
//                                otherTitle:@"前往下载"
//                               cancelBlock:^{
//                                   
//                               } confrimBlock:^{
//                                   //** 跳转appStore下载微信 */
//                                   [UIApplication sharedApplication] openURL:<#(nonnull NSURL *)#> options:<#(nonnull NSDictionary<NSString *,id> *)#> completionHandler:<#^(BOOL success)completion#>
//                               }];
            text = @"您的设备未安装微信客户端";
        }
        [SVProgressHUD showErrorWithStatus:text];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
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
