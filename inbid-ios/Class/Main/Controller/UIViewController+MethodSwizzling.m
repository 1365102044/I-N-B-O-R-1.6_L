//
//  UIViewController+MethodSwizzling.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/25.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "UIViewController+MethodSwizzling.h"
#import "BaiduMobStat.h"

@implementation UIViewController (MethodSwizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        {
            Method originMethodViewDidApper = class_getInstanceMethod([self class], @selector(viewDidAppear:));
            Method swizzledMethodViewDidApper = class_getInstanceMethod([self class], @selector(swizzling_viewDidAppear:));
            method_exchangeImplementations(originMethodViewDidApper, swizzledMethodViewDidApper);
            
            Method originMethodViewDidDisapper = class_getInstanceMethod([self class], @selector(viewDidDisappear:));
            Method swizzledMethodViewDidDisapper = class_getInstanceMethod([self class], @selector(swizzling_viewDidDisappear:));
            method_exchangeImplementations(originMethodViewDidDisapper, swizzledMethodViewDidDisapper);
        }
    });
}

/**
 视图出现在界面上

 @param animated animated
 */
- (void)swizzling_viewDidAppear:(BOOL)animated
{
    [self swizzling_viewDidAppear:animated];
    
    //** 添加统计代码 */
    NSString *titlestr;
    if (self.title.length) {
        titlestr = self.title;
    }else
    {
        titlestr = self.navigationItem.title;
    }
    
    NSString* cName = [NSString stringWithFormat:@"ControllerName:%@\ntitlename:%@", NSStringFromClass([self class]),titlestr, nil];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

/**
 视图离开界面

 @param animated animated
 */
- (void)swizzling_viewDidDisappear:(BOOL)animated
{
    [self swizzling_viewDidDisappear:animated];
    [YXNetworkHUD dismiss];
    
    NSString *titlestr;
    if (self.title.length) {
        titlestr = self.title;
    }else
    {
        titlestr = self.navigationItem.title;
        
    }
    NSString* cName = [NSString stringWithFormat:@"ControllerName:%@\ntitlename:%@",NSStringFromClass([self class]), titlestr, nil];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];

}



//
//// 进入页面，建议在此处添加
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSString* cName = [NSString stringWithFormat:@"%@", self.title, nil];
//    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
//    
//}
//
//// 退出页面，建议在此处添加
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    NSString* cName = [NSString stringWithFormat:@"%@", self.title, nil];
//    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
//}
@end
