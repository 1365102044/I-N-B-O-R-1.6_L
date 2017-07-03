//
//  YXPayZBarViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/1.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "ZJScanningController.h"
@class YXPayZBarViewController;

/**
 扫描快递条码回调
 
 @param zBarViewController 扫码控制器
 @param text               识别文字
 */

typedef void(^GetFormPCPayUrlBlock)(NSString *URL);


@interface YXPayZBarViewController : ZJScanningController


@property(nonatomic,copy) GetFormPCPayUrlBlock  formePCPayurlBlock;

@property(nonatomic,strong) NSString * vctitle;



@end
