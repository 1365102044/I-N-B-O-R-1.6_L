//
//  ZJScanningController.h
//  Project
//
//  Created by 郑键 on 17/2/28.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ZJScanningController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

/**
 失败后重新开启会话
 */
- (void)restartSession;

@end
