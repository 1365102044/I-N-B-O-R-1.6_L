//
//  ZJCameraController.h
//  Project
//
//  Created by 郑键 on 17/3/2.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CameraCompliteBlock)(UIImage *original, UIImage *currentImage);

@interface ZJCameraController : UIViewController

/**
 实例化自定义相机对象

 @param compliteBlock       compliteBlock
 @return                    相机
 */
+ (instancetype)cameraControllerCompliteBlock:(CameraCompliteBlock)compliteBlock;

@end
