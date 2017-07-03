//
//  ZJScanningController.m
//  Project
//
//  Created by 郑键 on 17/2/28.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "ZJScanningController.h"
#import "ZJScanningManager.h"
#import "ZJScanningView.h"

/**
 *  最大检测次数
 */
#define kMaxDetectedCount   10

@interface ZJScanningController ()

/**
 链接对象（会话对象）
 */
@property (nonatomic, strong) AVCaptureSession *session;

/**
 预览层Layer
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

/**
 扫描视图
 */
@property (nonatomic, strong) ZJScanningView *scanningView;

@end

@implementation ZJScanningController

#pragma mark - Zero.Other

/**
 失败后重新开启会话
 */
- (void)restartSession
{
    [self.session startRunning];
    
}

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

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
    /**
     *  扫描成功之后的提示音
     */
    [self playSoundEffect:@"ScanLoginSuccess.wav"];
    
    /**
     *  如果扫描完成，停止会话
     */
    [self.session stopRunning];
}

/**
 播放音效文件

 @param name 音效文件名
 */
- (void)playSoundEffect:(NSString *)name{
    
    /**
     *  获取音效
     */
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    /**
     *  获得系统声音ID
     */
    SystemSoundID soundID = 0;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    /**
     *  如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
     */
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    /**
     *  播放音频
     */
    AudioServicesPlaySystemSound(soundID);
}

/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    NSLog(@"播放完成...");
}

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigation];
    [self setupScanning];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

#pragma mark - Sixth.界面配置

- (void)setupNavigation
{
    self.navigationItem.title = @"扫一扫";
}

- (void)setupScanning
{
    /**
     *  添加扫描视图
     */
    [self.view addSubview:self.scanningView];
    
    [ZJScanningManager zj_scanningCodeWithOutsideViewController:self
                                                        session:self.session
                                                   previewLayer:self.previewLayer];
}

#pragma mark - Seventh.懒加载

- (ZJScanningView *)scanningView
{
    if (!_scanningView) {
        _scanningView = [ZJScanningView scanningQRCodeViewWithFrame:self.view.frame
                                                   outsideViewLayer:self.view.layer];
    }
    return _scanningView;
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _previewLayer;
}

- (AVCaptureSession *)session
{
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}

@end
