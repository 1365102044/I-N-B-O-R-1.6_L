//
//  YXTabBarController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXTabBarController.h"
#import "YXNavigationController.h"
#import "YXHomePageController.h"
#import "YXNewsViewController.h"
#import "YXSendAuctionController.h"
#import "YXSearchViewController.h"
#import "YXLoginViewController.h"
#import "YXMeMainViewController.h"
#import "YXMyAccountMainViewController.h"
#import "YXChatViewManger.h"
#import "YXLocalSystemNotificationManager.h"

@interface YXTabBarController ()<UITabBarControllerDelegate>

@property(readonly, nonatomic) NSUInteger lastSelectedIndex;
@property(readonly,nonatomic) NSUInteger currentSelectIndex;
@end

@implementation YXTabBarController
@synthesize lastSelectedIndex=_lastSelectedIndex;

#pragma mark - Notification

- (void)didReceiveNewMQMessages:(NSNotification *)notification
{
    /**
     *  广播中的消息数组
     */
    NSArray *messages = [notification.userInfo objectForKey:@"messages"];
    
    /**
     *  判断是否在通知界面，如果不在发送本地通知
     */
    if ([YXChatViewManger sharedChatviewManger].showSystemNofification) {
        for (MQMessage *message in messages) {
            [YXLocalSystemNotificationManager registerNotification:1
                                                             title:@"客服消息"
                                                              body:message.content];
        }
    }
}

- (void)didReceiveChatViewDisapper:(NSNotification *)notification
{
    [YXChatViewManger sharedChatviewManger].showSystemNofification = YES;
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    //判断是否相等,不同才设置
    if (self.selectedIndex != selectedIndex) {
        //设置最近一次
        _lastSelectedIndex = self.selectedIndex;
//        YXLog(@"1 OLD:%lu , NEW:%lu",(unsigned long)self.lastSelectedIndex,(unsigned long)selectedIndex);
    }
    
    //调用父类的setSelectedIndex
    [super setSelectedIndex:selectedIndex];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //获得选中的item
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    _currentSelectIndex = tabIndex;
    if (tabIndex != self.selectedIndex) {
        //设置最近一次变更
        _lastSelectedIndex = self.selectedIndex;
//        YXLog(@"2 OLD:%lu , NEW:%lu",(unsigned long)self.lastSelectedIndex,(unsigned long)tabIndex);
    }
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     @brief 修改tabbar的背景色
     */
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YXScreenW, 49)];
    backView.backgroundColor = [UIColor whiteColor];
    
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor colorWithWhite:229.0/255.0 alpha:1.0].CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:backView.frame].CGPath;
    border.frame = CGRectMake(0, 0, backView.bounds.size.width, 1);
    border.lineWidth = 1.f;
    [backView.layer addSublayer:border];
    
    [self.tabBar insertSubview:backView atIndex:0];
//    self.tabBar.opaque = NO;
     [self.tabBar setClipsToBounds:YES];
    
    self.delegate = self;
    
    // 添加所有的子控制器
    [self setupChildVcs];
    
    //设置item属性
    [self setupItemTextAttrs];
    
    /**
     *  注册通知
     */
    [self registerNotification];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MQ_RECEIVED_NEW_MESSAGES_NOTIFICATION
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MQAudioPlayerDidInterruptNotification
                                                  object:nil];
}

/**
 注册通知
 */
- (void)registerNotification
{
    /**
     *  注册美洽接收消息通知
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNewMQMessages:)
                                                 name:MQ_RECEIVED_NEW_MESSAGES_NOTIFICATION
                                               object:nil];
    /**
     *  用户离开客服界面
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveChatViewDisapper:)
                                                 name:MQAudioPlayerDidInterruptNotification
                                               object:nil];
}

/**
 *  添加所有的子控制器
 */
- (void)setupChildVcs{
    
    YXNavigationController *naviC = [[YXNavigationController alloc] initWithRootViewController:[[YXHomePageController alloc] init]];
    naviC.tabBarItem.title = @"首页";
    naviC.tabBarItem.image = [UIImage imageNamed:@"ic_paipin"];
    naviC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_paipin_highlight"];
    [self addChildViewController: naviC];
    
//    [self addChildVC:[[YXHomePageController alloc]init] title:@"拍品" imageName:@"ic_paipin" selIamgeName:@"tab_paipin_highlight"];
    
    
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([YXSendAuctionController class]) bundle:nil];
    YXSendAuctionController *sendAuctionController = [[YXSendAuctionController alloc] init];
    [self addChildVC:sendAuctionController title:@"发布" imageName:@"tab_fabu" selIamgeName:@"tab_fabu_highlight"];
    
    [self addChildVC:[[YXNewsViewController alloc]init] title:@"消息" imageName:@"tab_xiaoxi" selIamgeName:@"tab_xiaoxi_highlight"];
    
    
    [self addChildVC:[[YXMeMainViewController alloc]init] title:@"我的" imageName:@"tab_wode" selIamgeName:@"tab_wode_highlight"];
    
//    [self addChildVC:[[UIStoryboard storyboardWithName:@"MyAccount" bundle:nil] instantiateInitialViewController] title:@"我的" imageName:@"tab_wode" selIamgeName:@"tab_wode_highlight"];
    
    
}
/**
 *  添加一个子控制器
 *
 *  @param vc            控制器
 *  @param title         标题
 *  @param imageName     图标
 *  @param selImageName  选中的图标
 */
-(void)addChildVC:(UIViewController *)VC title:(NSString *)title imageName:(NSString *)imageName selIamgeName:(NSString *)selImageName{
    
    YXNavigationController *nav = [[YXNavigationController alloc]initWithRootViewController:VC];
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    //设置选中状态下图片
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selImageName];
    //添加到tabBarController
    [self addChildViewController:nav];
}
/**
 *  设置item文字属性
 */
- (void)setupItemTextAttrs{
    
    //设置文字属性
    NSMutableDictionary *attrsNomal = [NSMutableDictionary dictionary];
    //文字颜色
    attrsNomal[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //文字大小
    attrsNomal[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    NSMutableDictionary *attrsSelected = [NSMutableDictionary dictionary];
    //文字颜色
    attrsSelected[NSForegroundColorAttributeName] = [UIColor redColor];
    
    //统一整体设置
    UITabBarItem *item = [UITabBarItem appearance]; //拿到底部的tabBarItem
    [item setTitleTextAttributes:attrsNomal forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrsSelected forState:UIControlStateSelected];
}



/*
 @brief 进入个人中心的时候 登录的判断
 */
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if (_currentSelectIndex == 3) {
        
        if(![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus]){
            
            YXLoginViewController *loginVC = [[YXLoginViewController alloc]init];
            YXNavigationController *navi = [[YXNavigationController alloc] initWithRootViewController:loginVC];
            loginVC.fromeVC = @"formeTabarVC";
            loginVC.tabbatlastselectindex = self.lastSelectedIndex;
            loginVC.pushVCBlock = ^(NSString *str){
                self.selectedIndex = 3;
                return YES;
            };
            [self presentViewController:navi animated:YES completion:nil];
            return NO;
        }else{
            return  YES;
        }

    }

    //** 全都不检测登录状态 */
//    if ([viewController.tabBarItem.title isEqualToString:@"我的"])
//    {
//        if(![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus]){
//        
//            YXLoginViewController *loginVC = [[YXLoginViewController alloc]init];
//            YXNavigationController *navi = [[YXNavigationController alloc] initWithRootViewController:loginVC];
//            [self presentViewController:navi animated:YES completion:nil];
//
//            return NO;
//        }else{
//            return  YES;
//        }
//        
//        if ([[YXUserDefaults objectForKey:@"FromeMianLoginSatus"] isEqualToString:@"3"] || [[YXUserDefaults objectForKey:@"FromeMianLoginSatus"] isEqualToString:@"6"]) {
////             loginVC.pushVCBlock = ^(){
////                
////                if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
////                    self.selectedIndex = 3;
////                    
////                }else if ([viewController.tabBarItem.title isEqualToString:@"寄拍"]) {
////                    self.selectedIndex = 1;
////                }else if ([viewController.tabBarItem.title isEqualToString:@"消息"]) {
////                    self.selectedIndex = 2;
////                }
////                
////                return YES;
////            };
////            loginVC.frome = @"tabbar";
////            loginVC.tabbatlastselectindex = self.lastSelectedIndex;
//            
//            return NO;
//        }else
//        {
//            return YES;
//        }
//    }
    return YES;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
