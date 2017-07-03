//
//  YXOffLineNotificationController.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/31.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOffLineNotificationController.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "YXLoginViewController.h"
#import "YXNavigationController.h"
#import "AppDelegate.h"
#import "YXMyAccountNetRequestTool.h"

@interface YXOffLineNotificationController ()

/**
 提示label
 */
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@end

@implementation YXOffLineNotificationController

#pragma mark - 响应

-(void)setLoginStatus:(NSInteger)LoginStatus
{
    _LoginStatus = LoginStatus;
    
    NSString *AlearStr ;
    if (LoginStatus ==3) {
        
        AlearStr = @"登录失效，请重新登录。\n如需帮助请致电 ";
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    }else if (LoginStatus==6)
    {
        AlearStr = @"    您的账号在另一部手机登录，如非本人操作，则密码可能已经泄露，建议立即修改密码。如需帮助请致电 ";
    }
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle2.lineSpacing = 6;
    NSString *phonestr = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    NSString *psText = [NSString stringWithFormat:@"%@%@", AlearStr,phonestr];
    NSMutableAttributedString *attributes2 = [[NSMutableAttributedString alloc] initWithString:psText];
    NSDictionary *allAttributes = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:11],
                                    NSParagraphStyleAttributeName:paragraphStyle2
                                    };
    [attributes2 addAttributes:allAttributes range:NSMakeRange(0, psText.length)];
    [attributes2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:150.0/255.0 green:193.0/255.0 blue:243.0/255.0 alpha:1.0] range:NSMakeRange(psText.length-phonestr.length, [phonestr length])];
    
    self.tipsLabel.attributedText = attributes2;
    [self.tipsLabel yb_addAttributeTapActionWithStrings:@[phonestr] delegate:self];
    
    
}

/**
 登录成功通知响应
 */
- (void)loginSuccess
{
    self.view.hidden = YES;
    //** 跳转到首页 */
    __weak AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.tabBarController.selectedIndex = 3;
    if (self.GoodsDict!=nil) {
        appDelegate.tabBarController.selectedIndex = 0;
    }
    //** 发送通知，当前界面pop到首页面 */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popToRootViewController" object:nil userInfo:nil];
}

/**
 退出按钮点击事件

 @param sender 退出按钮
 */
- (IBAction)backButtonClick:(UIButton *)sender
{
    //** 退出当前下线通知界面 */
    [self.view removeFromSuperview];
    //** 清空token */
    [[YXLoginStatusTool sharedLoginStatus] removeTokenId];
    //** 跳转到首页 */
    __weak AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.tabBarController.selectedIndex = 0;
    //** 发送通知，当前界面pop到首页面 */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popToRootViewController" object:nil userInfo:nil];
}

/**
 重新登录按钮点击事件

 @param sender 重新登录按钮
 */
- (IBAction)reLoginButtonClick:(UIButton *)sender
{
    //** 弹出登录界面 */
    YXLoginViewController *loginVC = [[YXLoginViewController alloc]init];
    YXNavigationController *navi = [[YXNavigationController alloc] initWithRootViewController:loginVC];
    [loginVC FormeOffLineViewControllerWith:@"FormeOffLineVC" GoodsDict:self.GoodsDict];
    [self presentViewController:navi animated:YES completion:^{}];
}

/**
 电话号码点击事件

 @param string 点击的电话号码
 @param range  范围
 @param index  下标
 */
- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index
{
    //打电话
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",string];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}

/**
 获取当前屏幕中的控制器

 @return 屏幕中间的控制器
 */
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark - 控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 配置界面 */
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
   
    
    //** 添加监听 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    /**
     隐藏所在控制器的键盘
     */
    [YXNotificationTool postNotificationName:@"hiddenAllKeyboard" object:nil];
    //** 判断当前登录状态，如果登录状态为 */
    //[self loadBaseData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hiddenAllKeyboard" object:nil];
}

//** 加载基本资料 */
- (void)loadBaseData
{
    [[YXMyAccountNetRequestTool sharedTool] loadBaseDataWithSuccess:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] integerValue] == 1) {
            [self.view removeFromSuperview];
        } else if ([respodHeader[@"Status"] integerValue] == 3){
            
            
        } else if ([respodHeader[@"Status"] integerValue] == 6){
            
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}


@end
