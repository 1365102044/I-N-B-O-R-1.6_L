//
//  YXLoginViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/31.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXLoginViewController.h"
#import <AFNetworking.h>
#import "YXAlearFormMyView.h"
#import "YXThridPartyLoginView.h"
#import "YXNavigationController.h"
#import "YXLoginRequestTool.h"
#import "YXThridPartyLoginManger.h"
#import "YXWeChatPayManager.h"
#import "YXSaveLoginDataTool.h"
#import "YXKeyBoardTool.h"
//** loginAndRegister_1.5.0 */
#import "YXInputPhoneNumberViewController.h"
#import "twlt_uuid_util.h"
#import "YXShortcutLoginViewController.h"
#import "YXHelpViewController.h"
@interface YXLoginViewController ()<UITextFieldDelegate,YXWeChatPayManagerDelegate,YXTencentLoginDelegate,YXKeyboardWillShowDelegate>
@property (weak, nonatomic) IBOutlet UITextField *LoginPhoneTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *LoginPwdTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *GoToLoginBtn;
@property(nonatomic,strong) UIButton * eyeBtn;
@property (weak, nonatomic) IBOutlet UIView *imageSMSCoderBackView;
@property (weak, nonatomic) IBOutlet UIImageView *SMSimageview;
@property (weak, nonatomic) IBOutlet UITextField *imageSMSCoderTextfiled;
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;
/*
 @brief 自己判读的提示view
 */
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

@property(nonatomic,strong) YXThridPartyLoginView * ThridPartyView;

@property (strong, nonatomic) IBOutlet UIView *selfview;

@property(nonatomic,assign) YXThridLoginType  MyThridLoginType;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoimageTopContant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneTopContant;
/**
 登录按钮top.traling
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GotoLoginBtnContant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *forgetPasswordContant;

/**
 保存naviBar的图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarImage;

/**
 保存naviBar背景图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarBackgroundImage;
@property(nonatomic,strong) NSDictionary  * GoodsDict;
@end

@implementation YXLoginViewController

-(YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
         [self.view addSubview:self.alearMyview];
        _alearMyview.alpha = 0;
    }
    return _alearMyview;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [YXUserDefaults setObject:nil forKey:@"TimeCount"];
    self.LoginPhoneTextfiled.text = nil;
    self.LoginPwdTextfiled.text = nil;
    
    self.defaultNaviBarImage                            = self.navigationController.navigationBar.shadowImage;
    self.defaultNaviBarBackgroundImage                  = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [YXNetworkHUD dismiss];
    [self.navigationController.navigationBar setBackgroundImage:self.defaultNaviBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:self.defaultNaviBarImage];
    
}


#pragma mark  *** 第三方登录 *********

-(void)GotoLogin:(NSInteger)tag
{
    if (tag==1) {
        
        [YXWeChatPayManager sharedManager].delegate = self;
        [YXThridPartyLoginManger senWeiChatAuthRequestScope];
        self.MyThridLoginType = YXWeiChatLogin;

//        [YXWeChatPayManager sharedManager].delegate = self;
//        [[YXThridPartyLoginManger shared] ShareWeiChatWithTitie:@"title-test" shareDesc:@"desc-test" shareImage:[UIImage imageNamed:@"icon_touxiang"] shareURL:@"http://192.168.1.124:8020/details/details.html?prodId=770051584848047&prodBidId=170051584885015" shareSence:0];
        
        
    }else if (tag ==2)
    {
        [YXThridPartyLoginManger shared].YXTenceLoginDelegate = self;
        [[YXThridPartyLoginManger shared] TencetnOAuthLogin];
        self.MyThridLoginType = YXQQLogin;
        
    }
}

/**
 下面的 第三方登录图标
 */
-(void)setThridPartyView
{
    __weak typeof(self)weakself = self;
    self.ThridPartyView.ClickQQblock = ^(){
        [weakself GotoLogin:2];
    };
    self.ThridPartyView.ClickWXblock = ^(){
        
        [weakself GotoLogin:1];
    };
    self.ThridPartyView.clickHelpblock = ^(){
    
        YXHelpViewController *helpVC =[[YXHelpViewController alloc]init];
        helpVC.helpIndex = 0;
        [weakself.navigationController pushViewController:helpVC animated:YES];
    };
    if (![[YXThridPartyLoginManger shared] iphoneQQorWXInstalledWith:@"QQ"]) {
        //** 没有安装QQ */
    }
    if (![[YXThridPartyLoginManger shared] iphoneQQorWXInstalledWith:@"WX"]){
        //** 没有安装微信 */
        self.ThridPartyView.iscanhiddenView = @"WX";
    }
  [_selfview addSubview:self.ThridPartyView];

}
-(void)pushBindingPhoneWithopenid:(NSString *)openid
{
//    YXBindingPhoneViewController *BindingVC = [[YXBindingPhoneViewController alloc]init];
//    BindingVC.openid = openid;
//    BindingVC.loginType = self.MyThridLoginType;
//    [self.navigationController pushViewController:BindingVC animated:NO];

    YXInputPhoneNumberViewController*inputPhoneVC = [YXInputPhoneNumberViewController inputPhoneNumberViewControllerWithType:YXLoginViewControllerTypeBinding andExtend:nil];
    YXThirdPartyBindingModle *bindModle = [[YXThirdPartyBindingModle alloc]init];
    bindModle.openid = openid;
    bindModle.loginType = self.MyThridLoginType;
    bindModle.sourViewController = self;
    [inputPhoneVC formeThirdAccountWith: bindModle];
    [self.navigationController pushViewController:inputPhoneVC animated:YES];
}

#pragma mark  *** 微信登录 回调代理  ****
/**
 ErrCode	ERR_OK = 0(用户同意)
 ERR_AUTH_DENIED = -4（用户拒绝授权）
 ERR_USER_CANCEL = -2（用户取消）
 */
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    
    if (response.errCode== -4) {
        
        [YXAlearMnager ShowAlearViewWith:@"登录授权拒绝" Type:2];
        return;
    }else if (response.errCode == -2){
        [YXAlearMnager ShowAlearViewWith:@"登录取消" Type:2];
        return;
    }
    
    [self requestWeiChatWithCode:response.code];
    
//    NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", response.code, response.state, response.errCode];
    
//    YXLog(@"+请求结果++%@",strMsg);
 
}

-(void)requestWeiChatWithCode:(NSString *)code
{
    [[YXLoginRequestTool sharedTool] RequestWeiChatLoginAccess_tokenWithCode:code Success:^(id objc, id respodHeader) {
//        YXLog(@"=====objc==%@===",objc);
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            if ([objc isKindOfClass:[NSNull class]]|| objc == nil) {
                
                return ;
            }
            NSString *openid = objc[@"openid"];
            if (openid.length) {
            
                [self pushBindingPhoneWithopenid:objc[@"openid"]];

            }else{
                [[YXSaveLoginDataTool shared] SaveLoginDataWithObjc:objc responseheaderID:respodHeader[@"id"] phone:self.LoginPhoneTextfiled.text];
                
                [self poptorootvcfromethridlogin];
            }
        
        }else{
            
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark  *** QQ 代理

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    
    [[YXLoginRequestTool sharedTool] RequestQQLoginWith:[YXThridPartyLoginManger shared].tencentOAuth.openId access_token:[YXThridPartyLoginManger shared].tencentOAuth.accessToken Success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            NSString *openid = objc[@"openid"];
            if (openid.length) {
                
                [self pushBindingPhoneWithopenid:objc[@"openid"]];
                 
            }else{
                
                [[YXSaveLoginDataTool shared] SaveLoginDataWithObjc:objc responseheaderID:respodHeader[@"id"] phone:self.LoginPhoneTextfiled.text];

                [self poptorootvcfromethridlogin];
            }
            
        }else{
            
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
    } failure:^(NSError *error) {
    }];
}
/**
 第三方 登录成功后 返回 我的主页面
 */
-(void)poptorootvcfromethridlogin
{
    [self dismissViewControllerAnimated:NO completion:nil];

}

/*
 @brief 注册成功后的返回
 */
-(void)dismissRootVC
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled)
    {
        [YXAlearMnager ShowAlearViewWith:@"登录取消" Type:2];
        
    }
    else
    {
        [YXAlearMnager ShowAlearViewWith:@"登录失败" Type:2];
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{

    [YXAlearMnager ShowAlearViewWith:@"无网络连接，请设置网络" Type:2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YXBackMainColor;
    [self setNavItemView];
    [self setUI];
    [self setThridPartyView];
    self.imageSMSCoderBackView.hidden= YES;
    
    /*
     @brief 注册成功后的返回
     */
    [YXNotificationTool addObserver:self selector:@selector(dismissRootVC) name:@"zhucesuccess" object:nil];
   //** 第三方登录 成功后的 */
    [YXNotificationTool addObserver:self selector:@selector(poptorootvcfromethridlogin) name:@"fromethridloginpoptorootvc" object:nil];
    
    [[YXKeyBoardTool sharedKeyBoard] RegisterNotification];
    [YXKeyBoardTool sharedKeyBoard].delegate = self;
    
    /**
     控制logo图的位置
     */
    
    if (YXScreenW <=320 ) {
        self.phoneTopContant.constant = 25;
        self.logoimageTopContant.constant = 65;
//        self.forgetPasswordContant.constant = 10;
    }

    
    [self setGotOloginBtnTopTraling:YES];
    
    self.defaultNaviBarImage                            = self.navigationController.navigationBar.shadowImage;
    self.defaultNaviBarBackgroundImage                  = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    
    [YXNotificationTool addObserver:self selector:@selector(textViewEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

/**
 *  当 text field 文本内容改变时 会调用此方法
 *
 *  @param notification
 */
-(void)textViewEditChanged:(NSNotification *)notification{
    
    // 拿到文本改变的 text field
    UITextField *textField = (UITextField *)notification.object;
    
    if (textField == self.LoginPwdTextfiled) {
        
        [[[YXStringFilterTool alloc]init] limitTextFiledEditChange:textField LimitNumber:20];
    }
    if (textField == self.LoginPhoneTextfiled) {
        [[[YXStringFilterTool alloc]init] limitTextFiledEditChange:textField LimitNumber:11];
    }
    if(textField == self.imageSMSCoderTextfiled)
    {
        [[[YXStringFilterTool alloc]init] limitTextFiledEditChange:textField LimitNumber:6];
    }
    
    
    
}
/**
 根据smsimage.hidden 设置登录按钮的top-traling
 */
-(void)setGotOloginBtnTopTraling:(BOOL)SmsImageIsHidden
{
    if (SmsImageIsHidden) {
        [UIView animateWithDuration:0.5 animations:^{
            self.GotoLoginBtnContant.constant = 30;
        }];
    }else{
        CGFloat topinsting = 90;
        if (YXScreenW<=320) {
            topinsting = 70;
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.GotoLoginBtnContant.constant = topinsting;
        }];
    }
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat boomtaring = YXScreenH - self.GoToLoginBtn.bottom  -30 ;
        
        if (boomtaring < 260) {
            
            self.view.y = boomtaring - 260;
        }
    }];
}
#pragma mark  *** 键盘 弹出通知 ****
-(void)KeyboardWillShowDelegateHeight:(CGFloat)heigth animationtime:(CGFloat)time{

//    [UIView animateWithDuration:time animations:^{
//        
//        CGFloat boomtaring = YXScreenH - self.GotoLoginBtnContant.constant - 44 -10;
//        
//        if (boomtaring < heigth) {
//            
//            self.view.y = boomtaring - heigth;
//        }
//    }];

}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat boomtaring = YXScreenH - self.GoToLoginBtn.bottom  -10 ;
    
    if (boomtaring < 260) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.view.y = boomtaring - 260;
        }];
        
    }
    
     if (textField == _LoginPwdTextfiled) {
        if (self.LoginPhoneTextfiled.text.length ==0) {
            
            self.alearMyview.alearstr = @"手机号不能为空";
            return;
        }
        if(![YXStringFilterTool filterByPhoneNumber:self.LoginPhoneTextfiled.text])
        {
            self.alearMyview.alearstr = @"手机号的格式不对";
            return;
        }
        [self requestimageSMSCodeISshow];
    }
    
  
}



-(void)setUI{
    
    UIImageView *leftimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"11"]];
    leftimageview.frame = CGRectMake(0, 0, 40, 50);
    self.LoginPhoneTextfiled.leftViewMode = UITextFieldViewModeAlways;
    self.LoginPhoneTextfiled.leftView = leftimageview;
    self.LoginPhoneTextfiled.layer.masksToBounds = YES;
    self.LoginPhoneTextfiled.layer.cornerRadius = 4;
    self.LoginPhoneTextfiled.layer.borderColor = LineBorderColor.CGColor;
    self.LoginPhoneTextfiled.layer.borderWidth = 0.5;
    
    
    UIImageView *pwdimageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"22"]];
    pwdimageview.frame = CGRectMake(0, 0, 40, 50);
    self.LoginPwdTextfiled.leftViewMode = UITextFieldViewModeAlways;
    self.LoginPwdTextfiled.leftView = pwdimageview;
    self.LoginPwdTextfiled.layer.masksToBounds = YES;
    self.LoginPwdTextfiled.layer.cornerRadius = 4;
    self.LoginPwdTextfiled.layer.borderColor = LineBorderColor.CGColor;
    self.LoginPwdTextfiled.layer.borderWidth = 0.5;
    
    self.imageSMSCoderBackView.layer.borderColor = LineBorderColor.CGColor;
    self.imageSMSCoderBackView.layer.borderWidth = 0.5;
    
    
    UIButton *eyeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,10, 44, 40)];
    [eyeBtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
    [eyeBtn addTarget:self action:@selector(ClickeyeBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.LoginPwdTextfiled.rightViewMode = UITextFieldViewModeWhileEditing;
    self.LoginPwdTextfiled.rightView = eyeBtn;
    self.eyeBtn = eyeBtn;
    
    self.GoToLoginBtn.layer.masksToBounds = YES;
    self.GoToLoginBtn.layer.cornerRadius = 4;
    
    
    [self.LoginPhoneTextfiled setInputAccessoryView:self.customAccessoryView];
    [self.LoginPwdTextfiled setInputAccessoryView:self.customAccessoryView];
    [self.imageSMSCoderTextfiled setInputAccessoryView:self.customAccessoryView];
}

-(void)setNavItemView
{
    UIButton *Rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 30)];
    [Rightbtn setTitle:@"注册" forState:UIControlStateNormal];
    [Rightbtn setTitleColor:UIColorFromRGB(0x108ee9) forState:UIControlStateNormal];
    [Rightbtn addTarget:self action:@selector(GotoReginster1VC) forControlEvents:UIControlEventTouchUpInside];
    Rightbtn.titleLabel.font = YXRegularfont(16);
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:Rightbtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    [self addNavTitle];
}

-(void)addNavTitle
{
    UIButton *leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(clickBackBtnItem1) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftitem;
    leftbtn.imageEdgeInsets = UIEdgeInsetsMake(0, -39, 0, 0);
    leftbtn.backgroundColor = [UIColor clearColor];
}


//**-------拦截返回方法-------*/
-(void)clickBackBtnItem1
{
    
    if ([self.fromeVC isEqualToString:@"formeTabarVC"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        if(![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus]){
            self.tabBarController.selectedIndex = self.tabbatlastselectindex;
        }else{
            self.tabBarController.selectedIndex = 3;
        }
        return;
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    /**
     扫码登录
     */
    [YXNotificationTool postNotificationName:@"scancodeTologinformeLoginVC" object:nil userInfo:@{@"ISAlearlyLoginSuccess":@"NO"}];
    
    /**
     一口价商品详情，不登录的返回，不做操作
     */
    [YXNotificationTool postNotificationName:@"OnemouthPriceGoodsDeatilVcWithClickfromeloginSel" object:nil userInfo:@{@"islogin":@"NO"}];
    
}

//** -------密码的明文和密文的切换 -----------**/
-(void)ClickeyeBtn:(UIButton*)sender
{
    sender.selected = !sender.selected;
    self.LoginPwdTextfiled.secureTextEntry = !sender.selected;
    if (sender.selected) {
        [self.eyeBtn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
    }else{
        [self.eyeBtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
    }
    NSString *text = self.LoginPwdTextfiled.text;
    self.LoginPwdTextfiled.text = @" ";
    self.LoginPwdTextfiled.text = text;
    if (self.LoginPwdTextfiled.secureTextEntry)
    {
        [self.LoginPwdTextfiled insertText:self.LoginPwdTextfiled.text];
    }
}

//**-----------去注册------------**/
-(void)GotoReginster1VC
{
    YXInputPhoneNumberViewController *inputPhoneNumbeViewController = [YXInputPhoneNumberViewController inputPhoneNumberViewControllerWithType:YXLoginViewControllerTypeRegister andExtend:nil];
    [self.navigationController pushViewController:inputPhoneNumbeViewController animated:YES];
    
}

- (IBAction)clickchangesmsBtn:(id)sender {
    
    [self requestLoginImageCode];
}

#pragma mark  ******************* 请求图片验证码**********************
-(void)requestLoginImageCode
{
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
        [YXRequestTool requestImageCoderDataWithType:POST url:@"/captcha.svl" params:param success:^(id objc, id respodHeader) {
    
            if(![respodHeader[@"Status"] isEqualToString:@"1"])
            {
                
                self.alearMyview.alearstr = objc;

            }else{
    
                UIImage *image = [UIImage imageWithData:objc];
                self.SMSimageview.image = image;
                self.imageSMSCoderTextfiled.text = nil;
            }
    
        } failure:^(NSError *error) {
            
            
        }];
    

}

#pragma mark  ------ 登录-----------------
/*
 * @param phone 手机
 * @param password  密码
 * @param uuid
 */
- (IBAction)ClickGoToLoginBtn:(id)sender {
    
    //先将未到时间执行前的任务取消。
    [[self class]cancelPreviousPerformRequestsWithTarget:self selector:@selector(requstLogin) object:nil];
    [self performSelector:@selector(requstLogin)withObject:nil afterDelay:0.2f];
}

/*
 @brief 添加alearviewcontroller
 */
-(void)addAlearVC:(NSString *)alearstr
{
    
    if([alearstr isKindOfClass:[NSDictionary class]])
    {
        
        alearstr =  [[[YXStringFilterTool alloc]init] dictionaryToJson:(NSDictionary*)alearstr];
        
    }
    UIAlertController *alearVC = [UIAlertController alertControllerWithTitle:alearstr message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    UIAlertAction *sureAction1 = [UIAlertAction actionWithTitle:@"找回密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        YXForgetPasswordViewController *forgetPwdVC = [[YXForgetPasswordViewController alloc]init];
//        [self.navigationController pushViewController:forgetPwdVC animated:YES];
        
        //** 1.5.0 */
        YXInputPhoneNumberViewController *inputPhoneNumberViewController = [YXInputPhoneNumberViewController inputPhoneNumberViewControllerWithType:YXLoginViewControllerTypeResetPwd andExtend:nil];
        [self.navigationController pushViewController:inputPhoneNumberViewController animated:YES];
    }];
    
    [alearVC addAction:sureAction];
    [alearVC addAction:sureAction1];
    [YXNetworkHUD dismiss];
    [self presentViewController:alearVC animated:YES completion:nil];
}

#pragma mark  ******************* 点击登录 对参数的检查**********************
-(BOOL)checkLonginParma
{
    if (self.LoginPhoneTextfiled.text.length == 0) {
        
        self.alearMyview.alearstr = @"手机号不能为空";
        
        return NO;
    }else  if(![YXStringFilterTool filterByPhoneNumber:self.LoginPhoneTextfiled.text])
    {
        self.alearMyview.alearstr = @"手机号的格式不对";
        return NO;
    }
    
    
    else if (self.LoginPwdTextfiled.text.length ==0)
    {
        self.alearMyview.alearstr = @"密码不能为空";
        
        return NO;
    }
    
    if (!self.imageSMSCoderBackView.hidden) {
        
        if(self.imageSMSCoderTextfiled.text.length == 0)
        {
            
            self.alearMyview.alearstr = @"验证码不能为空";
            return NO;
        }
    }

    return YES;
}

#pragma mark  ******************* 请求图片验证码 是否显示的接口 **********************
-(void)requestimageSMSCodeISshow
{
    [YXNetworkHUD dismiss];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = self.LoginPhoneTextfiled.text;
    
    [YXRequestTool requestDataWithType:POST url:@"/api/login/verifyFlag" params:param success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            if ([objc isEqualToString:@"false"]) {
                
                self.imageSMSCoderBackView.hidden= YES;
                
                [self setGotOloginBtnTopTraling:YES];
                
            }else if ([objc isEqualToString:@"true"])
            {
                self.imageSMSCoderBackView.hidden= NO;
                [self setGotOloginBtnTopTraling:NO];
                [self requestLoginImageCode];
            }
        }
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
    }];
    
}


/*
 po objc
	{
	isPaymentCode = 0,
	phone = "18801040890",
	id = 398351384721039,
	nickname = "hahha",
	birthday = "2013-09-09",
	version = 20,
	sex = 2,
	validateStatus = 1,
 }
 */
-(void)requstLogin{
    [self MytextfiledResignFirstResponder];
    if (![self checkLonginParma]) {
        return;
    }
    
    self.GoToLoginBtn.enabled = NO;
    //** -------sha1加密 -----------**/
    NSString *ciphtrTextStr = [YXStringFilterTool getSha1String:self.LoginPwdTextfiled.text];
    [[YXLoginRequestTool sharedTool] RequestLoginWithPhone:self.LoginPhoneTextfiled.text password:ciphtrTextStr verifyCode:self.imageSMSCoderTextfiled.text Success:^(id objc, id respodHeader) {
        self.GoToLoginBtn.enabled = YES;
        if(![respodHeader[@"Status"] isEqualToString:@"1"])
        {
            [YXNetworkHUD dismiss];
            [self addAlearVC:objc];
            [self requestimageSMSCodeISshow];
        }else{
            [YXNetworkHUD dismiss];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
            

            if ([self.fromeVC isEqualToString:@"formeTabarVC"]) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                if (self.pushVCBlock) {
                    self.pushVCBlock(@"Tabbar");
                }
            }else if ([self.fromeVC isEqualToString:@"FormeOffLineVC"]){
            
                [self dismissViewControllerAnimated:YES completion:nil];
                [YXUserDefaults setObject:@"1" forKey:@"FromeMianLoginSatus"];
                [[YXSaveLoginDataTool shared] SaveLoginDataWithObjc:objc responseheaderID:respodHeader[@"id"] phone:self.LoginPhoneTextfiled.text];
                [YXNotificationTool postNotificationName:@"FormeloginVcPushGoodsDeatilVcWhenOutOfAccount" object:nil userInfo:self.GoodsDict];
                return ;
            }
            
            [YXUserDefaults setObject:@"1" forKey:@"FromeMianLoginSatus"];
            [[YXSaveLoginDataTool shared] SaveLoginDataWithObjc:objc responseheaderID:respodHeader[@"id"] phone:self.LoginPhoneTextfiled.text];
        }
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        
            [YXNetworkHUD dismiss];
            self.GoToLoginBtn.enabled = YES;
    }];}

//快捷登录
- (IBAction)ClickShortcutLoginBtn:(id)sender {
    YXShortcutLoginViewController *shortcurVC = [[YXShortcutLoginViewController alloc]init];
    [self.navigationController pushViewController:shortcurVC animated:YES];
}

//**-------------点击忘记密码---------------**/
- (IBAction)ClickForgetPwd:(id)sender {
    
    //** 1.5.0 */
    YXInputPhoneNumberViewController *inputPhoneNumberViewController = [YXInputPhoneNumberViewController inputPhoneNumberViewControllerWithType:YXLoginViewControllerTypeResetPwd andExtend:nil];
    [self.navigationController pushViewController:inputPhoneNumberViewController animated:YES];
    //** 1.5.0 */
    
//    YXForgetPasswordViewController *forgetPwdVC = [[YXForgetPasswordViewController alloc]init];
//    [self.navigationController pushViewController:forgetPwdVC animated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self MytextfiledResignFirstResponder];
}
-(void)MytextfiledResignFirstResponder
{
    [self.LoginPwdTextfiled resignFirstResponder];
    [self.LoginPhoneTextfiled resignFirstResponder];
    [self.imageSMSCoderTextfiled resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.view.y = 0;
    }];
}



-(YXThridPartyLoginView *)ThridPartyView
{
    if (!_ThridPartyView) {
        _ThridPartyView = [[YXThridPartyLoginView alloc]initWithFrame:CGRectMake(0, YXScreenH-140, YXScreenW, 130)];
//        _ThridPartyView.backgroundColor = [UIColor redColor];
    }
    return _ThridPartyView;
    
}
#pragma mark - 代理方法

- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5 animations:^{
        
        self.view.y = 0;
    }];
}

//从挤掉线过来的
-(void)FormeOffLineViewControllerWith:(NSString *)fromeVC GoodsDict:(NSDictionary *)GoodsDict{
    self.fromeVC = fromeVC;
    self.GoodsDict = GoodsDict;
}
@end
