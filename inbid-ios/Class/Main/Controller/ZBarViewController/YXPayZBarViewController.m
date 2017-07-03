//
//  YXPayZBarViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/1.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPayZBarViewController.h"
#import "YXAlertViewTool.h"
#import "YXLoginStatusTool.h"
#import "YXNavigationController.h"
#import "YXLoginViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "YXScanCodePCLoginResultViewController.h"
#define SCANVIEW_EdgeTop 40.0

#define SCANVIEW_EdgeLeft 50.0

#define TINTCOLOR_ALPHA 0.2 //浅色透明度

#define DARKCOLOR_ALPHA 0.5 //深色透明度

@interface YXPayZBarViewController (){
    
    SystemSoundID soundFileObject;
}

/**
 扫码登录--登录回来-
 */
@property(nonatomic,strong) NSString *  scanCodeLoginURL;
@end

@implementation YXPayZBarViewController

-(void)dealloc
{
//    [YXNotificationTool removeObserver:self name:@"scancodeTologinformeLoginVC" object:nil];
}
- ( void )viewDidLoad
{
    
    [ super viewDidLoad ];
    
    
    self.title = @"PC网银扫码支付" ;
    if ([self.vctitle isEqualToString:@"扫一扫"]) {
        
        self.title = self.vctitle ;
    }
    
    /**
     * 扫码登录 从登录 返回 --
     * 未登陆直接返回的话，就清空得到的URL，重新扫码；
     * 登陆后返回的话，直接处理扫码结果
     */
//    [YXNotificationTool addObserver:self selector:@selector(formeLoginvc:) name:@"scancodeTologinformeLoginVC" object:nil];
    
  
}

//-(void)formeLoginvc:(NSNotification *)noti
//{
//    NSString *isAlearlyLogin = noti.userInfo[@"ISAlearlyLoginSuccess"];
//    if ([isAlearlyLogin isEqualToString:@"YES"]) {
//        
//        [self GetScancodeUrl:self.scanCodeLoginURL];
//        
//    }else{
//        self.scanCodeLoginURL = nil;
//    }
//    
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark <AVCaptureMetadataOutputObjectsDelegate>

/**
 扫描结果代理
 
 @param captureOutput               captureOutput
 @param metadataObjects             metadataObjects
 @param connection                  connection
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    [super captureOutput:captureOutput
didOutputMetadataObjects:metadataObjects
          fromConnection:connection];
    
    /**
     *  设置界面显示扫描结果
     */
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSLog(@"metadataObjects = %@", metadataObjects);
        
        if ([obj.stringValue hasPrefix:@"http"]) {
            
            /**
             添加音效
             */
            [self playScanLoginSuccessVideo];
            
            if ([self.vctitle isEqualToString:@"扫一扫"]) {
                self.scanCodeLoginURL = obj.stringValue;
                
                [self GetScancodeUrl:obj.stringValue];
                
            }else{
                
                if (self.formePCPayurlBlock) {
                    
                    self.formePCPayurlBlock(obj.stringValue);
                    
                }
            }
            
        } else {
            
            /**
             *  扫描结果为条形码
             */
        }
    }
    
}

-(void)GetScancodeUrl:(NSString *)symbolStr{
    
    if (![symbolStr containsString:@"pcScan/loginAuth"]) {
        
        [YXAlearMnager ShowAlearViewWith:@"无效二维码" Type:2];
        
        [self restartSession];
        
        return ;
    }
    
    if(![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus])
    {
        YXLoginViewController *longin = [[YXLoginViewController alloc]init];
        YXNavigationController *nav = [[YXNavigationController alloc]initWithRootViewController:longin];
        [self presentViewController:nav animated:YES completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        return;
    }
    YXScanCodePCLoginResultViewController *resultvc = [[YXScanCodePCLoginResultViewController alloc]init];
    resultvc.clickBlock =^(NSString *touchtype){
        
        [self handleResult:touchtype url:symbolStr];
    };
    
    [self presentViewController:resultvc animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(void)handleResult:(NSString *)touchtype url:(NSString *)symbolStr
{
    if ([touchtype isEqualToString:@"login"]) {
        
        if (self.formePCPayurlBlock) {
            
            self.formePCPayurlBlock(symbolStr);
            
        }
    }else if ([touchtype isEqualToString:@"cancle"]){ }
    
    [self.navigationController popViewControllerAnimated:NO];

}
/**
 播放音效的
 */
-(void)playScanLoginSuccessVideo{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"ScanLoginSuccess" ofType:@"wav"];
    NSURL *URL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)URL, &soundFileObject);
    AudioServicesPlaySystemSound(soundFileObject);

}
@end
