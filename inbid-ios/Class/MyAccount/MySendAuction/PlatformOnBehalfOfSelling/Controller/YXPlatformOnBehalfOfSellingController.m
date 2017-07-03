//
//  YXPlatformOnBehalfOfSellingController.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPlatformOnBehalfOfSellingController.h"
#import "YXMySendAuctionHoldTest.h"
#import "YXPlatformOnBehalfOfSellingContentController.h"

@interface YXPlatformOnBehalfOfSellingController ()<YXPlatformOnBehalfOfSellingContentControllerDelegate>

/**
 嵌入的内容控制器
 */
@property (nonatomic, strong) YXPlatformOnBehalfOfSellingContentController *contentController;

@end

@implementation YXPlatformOnBehalfOfSellingController


#pragma mark - 响应事件


/**
 系统跳转控制器调用

 @param segue  segue
 @param sender sender
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //** 获取来源控制器 */
    _contentController = segue.destinationViewController;
    _contentController.detailModel = self.detailModel;
    _contentController.commissionRatio = self.commissionRatio;
    _contentController.obsverDelegate = self;
}

#pragma mark - 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"平台寄拍";
    self.automaticallyAdjustsScrollViewInsets = NO;

}



#pragma mark - 代理方法

- (void)platformOnBehalfOfSellingContentController:(YXPlatformOnBehalfOfSellingContentController *)platformOnBehalfOfSellingContentController changeRestPageON:(BOOL)isRestPage
{
    if ([self.delegate respondsToSelector:@selector(platformOnBehalfOfSellingController:changeRestPageON:)]) {
        [self.delegate platformOnBehalfOfSellingController:self changeRestPageON:isRestPage];
    }
}

@end
