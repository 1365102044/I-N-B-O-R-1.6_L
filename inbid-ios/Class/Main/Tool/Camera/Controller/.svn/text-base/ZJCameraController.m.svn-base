//
//  ZJCameraController.m
//  Project
//
//  Created by 郑键 on 17/3/2.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "ZJCameraController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZJCameraMaskView.h"
#import "ZJCamerBorderView.h"
#import "UIImage+fixOrientation.h"

@interface ZJCameraController ()

/**
 多媒体设备
 */
@property (nonatomic, strong) AVCaptureDevice *device;

/**
 输入设备
 */
@property (nonatomic, strong) AVCaptureDeviceInput *input;

/**
 输出
 */
@property (nonatomic, strong) AVCaptureStillImageOutput *output;

/**
 会话
 */
@property (nonatomic, strong) AVCaptureSession *session;

/**
 图像预览层，实时预览图片
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

/**
 覆盖层视图
 */
@property (nonatomic, strong) ZJCameraMaskView *cameraMaskView;

/**
 bottomFuncView
 */
@property (nonatomic, strong) UIView *bottomShutterFuncView;

/**
 截取区域
 */
@property (nonatomic, assign) CGRect currentImageRect;

/**
 结束回调
 */
@property (nonatomic, copy) CameraCompliteBlock compliteBlock;

/**
 保存naviBar的图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarImage;

/**
 保存naviBar背景图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarBackgroundImage;

@end

@implementation ZJCameraController

#pragma mark - Zero.Const

/**
 *  底部功能按钮栏高度
 */
CGFloat camerControllerBottomFuncViewHeight = 70;

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 点击返回按钮

 @param sender sender
 */
- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 照相按钮点击事件

 @param sender sender
 */
- (void)shutterButtonClick:(UIButton *)sender
{
    AVCaptureConnection *conntion = [self.output connectionWithMediaType:AVMediaTypeVideo];
    if (!conntion) {
        
        return;
    }
    
    __weak ZJCameraController *weakSelf = self;
    [self.output captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        image = [image fixOrientation];
        UIImage *origal = [self image:image scaleToSize:CGSizeMake(self.view.width,
                                                                   self.view.height)];
        UIImage *currentImage = [self imageFromImage:origal inRect:self.currentImageRect];
        
        weakSelf.compliteBlock(origal, currentImage);
    }];
}

/**
 *  将图片缩放到指定的CGSize大小
 *  UIImage image 原始的图片
 *  CGSize size 要缩放到的大小
 */
- (UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.控制器生命周期

/**
 实例化自定义相机对象
 
 @param compliteBlock       compliteBlock
 @return                    相机
 */
+ (instancetype)cameraControllerCompliteBlock:(CameraCompliteBlock)compliteBlock
{
    ZJCameraController *cameraController        = [[ZJCameraController alloc] init];
    cameraController.compliteBlock              = compliteBlock;
    return cameraController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  配置界面
     */
    [self setupCustomUI];
    
    /**
     *  开始取景
     */
    [self.session startRunning];
}

/**
 视图即将出现
 
 @param animated                                animated
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.defaultNaviBarImage                            = self.navigationController.navigationBar.shadowImage;
    self.defaultNaviBarBackgroundImage                  = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

/**
 视图即将离开界面
 
 @param animated                                animated
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:self.defaultNaviBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:self.defaultNaviBarImage];
}

#pragma mark - Sixth.界面配置

/**
 配置界面
 */
- (void)setupCustomUI
{
    self.view.backgroundColor           = [UIColor darkGrayColor];
    [self.view insertSubview:self.cameraMaskView atIndex:0];
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    [self.view addSubview:self.bottomShutterFuncView];
    [self.bottomShutterFuncView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(camerControllerBottomFuncViewHeight + 20));
    }];
    
    /**
     *  NavigationLeft按钮
     */
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_wallet_close"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

#pragma mark - Seventh.懒加载

- (UIView *)bottomShutterFuncView
{
    if (!_bottomShutterFuncView) {
        
        /**
         *  初始化配置底部照相功能视图
         */
        _bottomShutterFuncView                      = [[UIView alloc] init];
        _bottomShutterFuncView.backgroundColor      = [UIColor clearColor];
        
        /**
         *  照相按钮
         */
        UIButton *shutterButton = [[UIButton alloc] init];
        [shutterButton addTarget:self
                          action:@selector(shutterButtonClick:)
                forControlEvents:UIControlEventTouchUpInside];
        [shutterButton setBackgroundImage:[UIImage imageNamed:@"ic_wallet_camer_shutter"] forState:UIControlStateNormal];
        
        [_bottomShutterFuncView addSubview:shutterButton];
        [shutterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_bottomShutterFuncView);
            make.width.height.mas_equalTo(camerControllerBottomFuncViewHeight);
            make.bottom.mas_equalTo(_bottomShutterFuncView).mas_offset(ADJUST_PERCENT_FLOAT(-20));
        }];
    }
    return _bottomShutterFuncView;
}

- (ZJCameraMaskView *)cameraMaskView
{
    if (!_cameraMaskView) {
        
        /**
         *  配置界面中间空白视图尺寸
         */
        CGFloat borderWidth                         = self.view.bounds.size.width - 15;
        CGFloat borderHeight                        = (borderWidth / 85.6) * 54;
        
        /**
         *  创建borderView
         */
        ZJCamerBorderView *borderView               = [[ZJCamerBorderView alloc] initWithFrame:CGRectMake(0,
                                                                                                          0,
                                                                                                          borderWidth,
                                                                                                          borderHeight)];
        borderView.center                           = self.view.center;
        borderView.tintColor                        = self.navigationController.navigationBar.tintColor;
        
        [self.view addSubview:borderView];
        
        /**
         *  保存裁剪视图范围
         */
        self.currentImageRect                       = borderView.frame;
        
        /**
         *  创建蒙版视图
         */
        _cameraMaskView                             = [ZJCameraMaskView maskViewWithFrame:self.view.bounds
                                                                                 cropRect:borderView.frame];
    }
    return _cameraMaskView;
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    if (!_previewLayer) {
        _previewLayer                       = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        _previewLayer.frame                 = self.view.bounds;
        _previewLayer.videoGravity          = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}

- (AVCaptureSession *)session
{
    if (!_session) {
        _session                            = [[AVCaptureSession alloc] init];
        _session.sessionPreset              = AVCaptureSessionPreset1280x720;
        
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
        }
    }
    return _session;
}

- (AVCaptureStillImageOutput *)output
{
    if (!_output) {
        _output                             = [[AVCaptureStillImageOutput alloc] init];
    }
    return _output;
}

- (AVCaptureDeviceInput *)input
{
    if (!_input) {
        _input                              = [[AVCaptureDeviceInput alloc] initWithDevice:self.device
                                                                                     error:nil];
    }
    return _input;
}

- (AVCaptureDevice *)device
{
    if (!_device) {
        NSArray *devices                    = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        [devices enumerateObjectsUsingBlock:^(AVCaptureDevice *  _Nonnull device,
                                              NSUInteger idx,
                                              BOOL * _Nonnull stop) {
            if (device.position == AVCaptureDevicePositionBack) {
                _device                     = device;
                *stop                       = YES;
            }
        }];
    }
    return _device;
}

@end
