//
//  YXZBarViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "ZJScanningController.h"
@class YXZBarViewController;

@protocol YXZBarViewControllerDelegate <NSObject>

/**
 扫描快递条码回调

 @param zBarViewController 扫码控制器
 @param text               识别文字
 */
- (void)zBarViewController:(YXZBarViewController *)zBarViewController andText:(NSString *)text;

@end

@interface YXZBarViewController : ZJScanningController

/**
 代理
 */
@property (nonatomic, weak) id<YXZBarViewControllerDelegate> delegate;

@end
