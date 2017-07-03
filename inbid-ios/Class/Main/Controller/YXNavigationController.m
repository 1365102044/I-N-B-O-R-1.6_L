//
//  YXNavigationController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "YXSearchResultListViewController.h"
#import "YXMyAccountGOPaymentConfirmAddressViewController.h"
#import "YXOneMouthPriceConfirmOrderViewController.h"
#import "YXPaymentHomePageController.h"
@interface YXNavigationController ()<UIGestureRecognizerDelegate>

@property(nonatomic,assign) NSInteger  VCindex;


@end

@implementation YXNavigationController
/**
 登录异常 或被挤掉线
 */
-(void)PopToRootVc
{
    [self popToRootViewControllerAnimated:YES];
}
/**
 隐藏所在控制器的键盘
 */
-(void)hiddenAllKeyboard
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [YXNotificationTool addObserver:self selector:@selector(PopToRootVc) name:@"popToRootViewController" object:nil];
    
//    YXLog(@"路径%@",NSHomeDirectory());
    
    [YXNotificationTool addObserver:self selector:@selector(hiddenAllKeyboard) name:@"hiddenAllKeyboard" object:nil];
    
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        // 默认每个push进来的控制器左边都有返回按钮
        UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"icon_fanhui" highImage:@"icon_fanhui"];
        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
    
}

/**
 *  返回到上一个控制器
 */
-(void)back
{
    
    for (UIViewController *controller in self.viewControllers) {
        
        NSArray *VCarr = self.viewControllers;
        NSInteger vcCount = VCarr.count;
        UIViewController *lastVC = VCarr[vcCount-2];//最后一个vc是自己，倒数第二个是上一个控制器
        //**选择地址后 到支付界面，返回不再经过地址选择界面**/
        if ([controller isKindOfClass:[YXPaymentHomePageController class]]) {
            if ([lastVC  isKindOfClass:[YXMyAccountGOPaymentConfirmAddressViewController class]]
                ||[lastVC  isKindOfClass:[YXOneMouthPriceConfirmOrderViewController class]]) {
                
                [self popToViewController:[VCarr objectAtIndex:(vcCount-3)] animated:YES];
                
                return;
                
            }else
            {
                [self popViewControllerAnimated:YES];
                return;
            }
            
            
            return;
            
        }
        
        
    }
  
    [self popViewControllerAnimated:YES];

    
}


@end
