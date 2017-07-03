//
//  YXMyAccountController.m
//  MyAccount
//
//  Created by 郑键 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountController.h"
#import "YXMyOrderController.h"
#import "YXMyInformationController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXMyAccountBaseData.h"
#import <UIImageView+WebCache.h>
#import "YXMyAccountNetRequestTool.h"
#import "YXMyAccountFollowAuction.h"
#import "YXLoginViewController.h"
#import "YXNavigationController.h"
#import <MJExtension.h>
#import "YXMyAccountRealNameViewController.h"
#import "YXMyAccoutBindBankCardViewController.h"
#import "YXMyAucctionRealnameAndBindbankCardViewController.h"
#import "YXMyAccountDeatilViewController.h"
#import "YXMyAccountSetPaymengPasswordViewController.h"
#import "YXMyAccountChangePaymentPasswordViewController.h"
#import "YXMySendAuctionHomeController.h"
#import "YXMyAuctionHomeController.h"
#import "YXMySureMoneyThawingViewController.h"
#import "YXMySureMoneyInFreezingViewController.h"
#import "YXMySureMoneyNoPaymentViewController.h"
#import "UIImage+YXExtension.h"
#import "YXMySendAuctionSubTableViewController.h"

#import "YXHelpViewController.h"

@interface YXMyAccountController ()

//** 账号信息按钮 */
@property (weak, nonatomic) IBOutlet UIButton *accountDetailsButton;
//** 账号信息指示箭头 */
@property (weak, nonatomic) IBOutlet UIImageView *accountImageView;
//** 账号信息指示箭头点击事件View */
@property (weak, nonatomic) IBOutlet UIView *accountView;
//** 我的竞拍控制器 */
@property (nonatomic, strong) YXMyAuctionHomeController *myAuctinController;
//** 我的订单控制器 */
@property (nonatomic, strong) YXMyOrderController *myOrderController;
//** 我的寄拍控制器 */
@property (nonatomic, strong) YXMySendAuctionHomeController *mySendAuctionController;
//** 我的个人信息控制器 */
@property (nonatomic, strong) YXMyInformationController *myInformationController;
//** 基本信息模型 */
@property (nonatomic, strong) YXMyAccountBaseData *baseDataModel;


//** 基本信息控件 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//** 当前登录状态 */
@property (nonatomic, assign) NSInteger currentLoginStatus;
//** 当前账号是否绑定银行卡 */
@property (nonatomic, assign) NSInteger cardStatus;

@property (nonatomic,assign) BOOL statusBarColorIsBlack;
/*
 @brief 自定义的导航栏
 */
@property(strong,nonatomic) UIView * MynavBarView;
@property(assign,nonatomic) BOOL dismissStatusBool;

@property(nonatomic,strong) UIButton *rightimage ;
@property(nonatomic,strong) UILabel * titlelable;
@property(nonatomic,strong) UIButton * rightbtn;
@property(nonatomic,strong) UIButton * iconbtn;
@property(nonatomic,assign) CGFloat    Myalpha;



@property (weak, nonatomic) IBOutlet UILabel *setPassWordRightLable;
@property (weak, nonatomic) IBOutlet UILabel *setRealNameRightLable;
@property (weak, nonatomic) IBOutlet UILabel *setYinHangCardRightLable;






@end

@implementation YXMyAccountController


#pragma mark - 赋值

- (void)setBaseDataModel:(YXMyAccountBaseData *)baseDataModel
{
    _baseDataModel = baseDataModel;
    
    //TODO:赋值
    self.myInformationController.accountBaseDataModel = baseDataModel;
    
    self.nameLabel.text = baseDataModel.nickname;
    NSArray *arr = [baseDataModel.head componentsSeparatedByString:@"?"];
    if (arr.count>1) {
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:baseDataModel.head]];
        
    }else{
        
        if (baseDataModel.head) {
            self.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@", baseDataModel.head]];
        }else{
            self.iconImageView.image = [UIImage imageNamed:@"ic_default"];
        }
    }
}




#pragma mark - 点击事件

//** 接收到通知跳转界面 */
- (void)toSendAuctionViewControlelr
{
    self.tabBarController.selectedIndex = 1;
}

//** 账户详情右侧箭头手势 */
- (void)accountImageViewClick
{
    [self accountDetailsButtonClick:self.accountDetailsButton];
}

//** 账号详情点击事件 */
- (IBAction)accountDetailsButtonClick:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"立即登录"]) {
        YXLoginViewController *loginVC = [[YXLoginViewController alloc]init];
        YXNavigationController *navi = [[YXNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navi animated:YES completion:nil];
    }else if ([sender.titleLabel.text isEqualToString:@"账户详情"]){
        [self.navigationController pushViewController:self.myInformationController animated:YES];
    }
}

/*
 @brief 我的保证金
 */
- (IBAction)MySureMoneyBtnClick:(UIButton*)sender {
    
    if (self.currentLoginStatus == 3 || self.currentLoginStatus == 6|| self.currentLoginStatus ==0) {
        [self showAlert];
        return;
    }
    UIViewController *pushvc;
    
    switch (sender.tag) {
        case 4001:
            
        {
            pushvc = [[YXMySureMoneyNoPaymentViewController alloc]init];
        }
            
            break;
        case 4002:
            //--加载冻结中
        {
            pushvc = [[YXMySureMoneyThawingViewController alloc]init];
        }
            break;
        case 4003:
            //--加载已解冻
            pushvc = [[YXMySureMoneyInFreezingViewController alloc]init];
            
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:pushvc animated:YES];
    
}

//** 我的订单按钮事件 */
- (IBAction)myOrderButtonClick:(UIButton *)sender
{
    if (self.currentLoginStatus == 3 || self.currentLoginStatus == 6|| self.currentLoginStatus ==0) {
        [self showAlert];
        return;
    }
    
    switch (sender.tag) {
        case 1001:
            [[YXMyAccountNetRequestTool sharedTool] loadMyQueryAccountInfoWithSuccess:^(id objc, id respodHeader) {
                YXLog(@"%@---%@", objc, respodHeader);
            } failure:^(NSError *error) {
                YXLog(@"%@", error);
            }];
            //--加载待付款
            break;
        case 1002:
            //--加载待收货
            break;
        case 1003:
            //--加载全部订单
            break;
        default:
            break;
    }
    [self myOrderPushController:sender];
}

//** 我的订单push控制器 */
- (void)myOrderPushController:(UIButton *)sender
{
    if (self.currentLoginStatus == 3 || self.currentLoginStatus == 6|| self.currentLoginStatus ==0) {
        [self showAlert];
        return;
    }
    
    self.myOrderController.title = sender.titleLabel.text;
    self.myOrderController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.myOrderController animated:YES];
    
    self.myOrderController.hidesBottomBarWhenPushed = NO;
}


//** 我的竞拍按钮点击事件 */
- (IBAction)myAuctionButtonClick:(UIButton *)sender
{
    if (self.currentLoginStatus == 3 || self.currentLoginStatus == 6|| self.currentLoginStatus ==0) {
        [self showAlert];
        return;
    }
    
    [self myAuctionPushController:sender];
}

//** 我的竞拍push控制器 */
- (void)myAuctionPushController:(UIButton *)sender
{
    self.myAuctinController.index = sender.tag;
    [self.navigationController pushViewController:self.myAuctinController animated:YES];
}


//** 我的寄拍按钮点击事件 */
- (IBAction)myMailAuctionButtonClick:(UIButton *)sender
{
    if (self.currentLoginStatus == 3 || self.currentLoginStatus == 6 || self.currentLoginStatus ==0) {
        [self showAlert];
        return;
    }
    [self mySendAuctionPushController:sender];
}

//** 我的寄拍push控制器 */
- (void)mySendAuctionPushController:(UIButton *)sender
{
    YXMySendAuctionHomeController *sendAuctionHomeController = [[YXMySendAuctionHomeController alloc] init];
    sendAuctionHomeController.index = sender.tag;
    [self.navigationController pushViewController:sendAuctionHomeController animated:YES];
}

//** 弹出登录或未登录alert -- 修改为直接弹出登录视图 */
- (void)showAlert
{
    //    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"未登录" message:@"您当前的状态为未登录，请登陆后重试" preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
    //    [alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
    //    [self presentViewController: alert animated:YES completion:nil];
    YXLoginViewController *loginVC = [[YXLoginViewController alloc]init];
    YXNavigationController *navi = [[YXNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navi animated:YES completion:nil];
}


/*
 @brief 点击头像 切换 头像图片
 */
- (IBAction)ClickiconChangeTouXiang:(id)sender {
    
    if (self.currentLoginStatus == 3 || self.currentLoginStatus == 6|| self.currentLoginStatus ==0) {
        [self showAlert];
        return;
    }
    [self.navigationController pushViewController:self.myInformationController animated:YES];

}


#pragma mark - 加载网络数据

//** 加载基本资料 */
- (void)loadBaseData
{
    /*
     @brief 未登录的时候 不再频繁的请求person 接口了
     */
    NSString *tokenIDstr= [YXUserDefaults objectForKey:@"TokenID"];
    if (tokenIDstr.length ==0) {
        
        [self.accountDetailsButton setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.rightbtn setTitle:@"立即登录" forState:UIControlStateNormal];        
        self.nameLabel.text = @"未登录";
        self.iconImageView.image = [UIImage imageNamed:@"ic_default"];

        return;
    }

    [[YXMyAccountNetRequestTool sharedTool] loadBaseDataWithSuccess:^(id objc, id respodHeader) {
        
        YXLog(@"--xingbie---%@",objc);
        
        if ([respodHeader[@"Status"] integerValue] == 1) {
            
            NSString *iconstr = objc[@"head"] ;
            NSArray *arr = [iconstr componentsSeparatedByString:@"?"];
            if (arr.count>1) {
                NSString *str = [NSString stringWithFormat:@"%@x-oss-process=image/resize,w_100",arr[0]];

                
                UIImageView *iconimage = [[UIImageView alloc]init];
                [iconimage sd_setImageWithURL:[NSURL URLWithString:str]];
                [self.iconbtn setImage:iconimage.image forState:UIControlStateNormal];
                
            }else{
                
                if (iconstr.length) {
                    self.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@", iconstr]];
                    
                    NSString *iconstr = [NSString stringWithFormat:@"ic_%@",objc[@"head"]];
                    [self.iconbtn setImage:[UIImage imageNamed:iconstr] forState:UIControlStateNormal];
                }else{
                    
                    [self.iconbtn setImage:[UIImage imageNamed:@"ic_default"] forState:UIControlStateNormal];
                }
            }

            
            
            if ([objc[@"isPaymentCode"] integerValue] == 1) {
                self.setPassWordRightLable.text= @"修改支付密码";
            }else{
                self.setPassWordRightLable.text= @"设置支付密码";
            }
            
            if ([objc[@"validateStatus"] integerValue] == 2) {
                self.setRealNameRightLable.text= @"已完成认证";
            }else
            {
                self.setRealNameRightLable.text= @"实名认证";
            }
            
            if ([objc[@"cardStatus"] integerValue] == 1) {
                
                self.setYinHangCardRightLable.text= @"已绑定银行卡";
            }else{
                self.setYinHangCardRightLable.text= @"绑定银行卡";
            }
            
            /**
             * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
             */
            [YXUserDefaults setObject:[NSString stringWithFormat:@"%@",objc[@"validateStatus"]] forKey:@"validateStatus"];
            /**
             * 绑定银行卡 0未绑定 1表示绑定
             */
            [YXUserDefaults setObject:[NSString stringWithFormat:@"%@",objc[@"cardStatus"]] forKey:@"cardStatus"];
            
            /*
             @brief 设置支付密码
             */
            [YXUserDefaults setObject:[NSString stringWithFormat:@"%@",objc[@"isPaymentCode"]] forKey:@"isPaymentCode"];
            
            self.nameLabel.hidden = NO;
            self.baseDataModel = [YXMyAccountBaseData mj_objectWithKeyValues:objc];
            [self.accountDetailsButton setTitle:@"账户详情" forState:UIControlStateNormal];
            
            [self.rightbtn setTitle:@"账户详情" forState:UIControlStateNormal];
            
        } else if ([respodHeader[@"Status"] integerValue] == 3||[respodHeader[@"Status"] integerValue] == 6){
            [self.accountDetailsButton setTitle:@"立即登录" forState:UIControlStateNormal];
            [self.rightbtn setTitle:@"立即登录" forState:UIControlStateNormal];
            
            self.nameLabel.text = @"未登录";
            self.iconImageView.image = [UIImage imageNamed:@"ic_default"];
        } else if ([respodHeader[@"Status"] integerValue] == 6){
            [self.accountDetailsButton setTitle:@"立即登录" forState:UIControlStateNormal];
            self.nameLabel.text = @"未登录";
            self.iconImageView.image = [UIImage imageNamed:@"ic_default"];
        }
        self.currentLoginStatus = [respodHeader[@"Status"] integerValue];
        
        if (![respodHeader[@"Status"] isEqualToString:@"1"]) {
            self.setPassWordRightLable.text= @"设置支付密码";
            self.setRealNameRightLable.text= @"实名认证";
            self.setYinHangCardRightLable.text= @"绑定银行卡";
        }
        
        if(![respodHeader[@"Status"] isEqualToString:@"1"])
        {
            [YXUserDefaults setObject:nil forKey:@"TokenID"];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [YXNotificationTool addObserver:self selector:@selector(PushLoginVC) name:@"modalLoginController" object:nil];
    
}

-(void)PushLoginVC
{
    YXLoginViewController *loginvc = [[YXLoginViewController alloc]init];
    [self presentViewController:loginvc animated:YES completion:nil];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //** 跳转帮助中心 */
    if(indexPath.section == 3 && indexPath.row==6)
    {
        YXHelpViewController *helpVC =[[YXHelpViewController alloc]init];
        [self.navigationController pushViewController:helpVC animated:YES];
        return;
    }
    
    //** 判断登录状态 */
    if (self.currentLoginStatus == 3 || self.currentLoginStatus == 6 || self.currentLoginStatus ==0) {
        [self showAlert];
        return;
    }
    
    //** 跳转设置界面 */
    if (indexPath.section == 3 && indexPath.row == 7) {
        
        YXMyAccountDeatilViewController *myaccountdeatilVC = [[YXMyAccountDeatilViewController alloc]init];
        
        [self.navigationController pushViewController:myaccountdeatilVC animated:YES];
        return;
    }
    
    //** 跳转个人信息界面 */
    if (indexPath.section == 3 && indexPath.row == 1) {
        
        [self.navigationController pushViewController:self.myInformationController animated:YES];
    }
    
    //** 跳转地址管理界面 */
    if (indexPath.section == 3 && indexPath.row == 2) {
        
        [self.navigationController pushViewController: [[UIStoryboard storyboardWithName:@"myAddressList" bundle:nil] instantiateInitialViewController] animated:YES];
    }
    //** 跳转设置支付密码界面 */
    if (indexPath.section == 3 && indexPath.row == 3) {
        
        if ([[YXUserDefaults objectForKey:@"isPaymentCode"] integerValue] ==0) {
            
            YXMyAccountSetPaymengPasswordViewController *setpaymentpasswordVC = [[YXMyAccountSetPaymengPasswordViewController alloc]init];
            
            [self.navigationController pushViewController:setpaymentpasswordVC animated:YES];
            
        }else if ([[YXUserDefaults objectForKey:@"isPaymentCode"] integerValue] ==1)
        {
            YXMyAccountChangePaymentPasswordViewController *changepaymentpasswordVC = [[YXMyAccountChangePaymentPasswordViewController alloc]init];
            [self.navigationController pushViewController:changepaymentpasswordVC animated:YES];
        }
        
    }
    
    //** 实名认证界面 */
    if (indexPath.section == 3 && indexPath.row == 4) {
        
        if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"2"]){
            
            YXMyAccountRealNameViewController * realnameVC = [[YXMyAccountRealNameViewController alloc]init];
            realnameVC.realnameStatus = @"REALNAME";
            [self.navigationController pushViewController:realnameVC animated:YES];
            
        }else{
            
            YXMyAccountRealNameViewController * realnameVC = [[YXMyAccountRealNameViewController alloc]init];
            //            realnameVC.realnameStatus = @"NOTREALNAME";
            [self.navigationController pushViewController:realnameVC animated:YES];
        }
    }
    //** 绑定银行卡界面 */
    if (indexPath.section == 3 && indexPath.row == 5) {
        /**
         * 绑定银行卡 0未绑定 1表示绑定
         */
        if([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"cardStatus"]] isEqualToString:@"1"]){
            
            YXMyAccoutBindBankCardViewController * bindbankcardVC = [[YXMyAccoutBindBankCardViewController alloc]init];
            bindbankcardVC.bindbankStatus = @"BINDBANK";
            [self.navigationController pushViewController:bindbankcardVC animated:YES];
            
            
        }else{
            
            /**
             * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
             */
            if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"2"]) {
                
                YXMyAccoutBindBankCardViewController * bindbankcardVC = [[YXMyAccoutBindBankCardViewController alloc]init];
                [self.navigationController pushViewController:bindbankcardVC animated:YES];
                
            }else if([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"0"] || [[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"3"]){
                
                YXMyAucctionRealnameAndBindbankCardViewController *allrealnameAndbindbankcardVC = [[YXMyAucctionRealnameAndBindbankCardViewController alloc]init];
                [self.navigationController pushViewController:allrealnameAndbindbankcardVC animated:YES];
            }
        }
    }
    
}


#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    if (scrollView.contentOffset.y <= 0) {
    //        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    //    }
    
    if (!self.dismissStatusBool) {
        
        CGFloat offsetY = scrollView.contentOffset.y;
        
        if (offsetY > 0) {
            CGFloat alpha = offsetY/100;
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:_MynavBarView];
            
            self.MynavBarView.alpha = alpha;
            self.Myalpha = alpha;
            
            if (alpha > 0.5 && !_statusBarColorIsBlack) {
                
                self.rightbtn.alpha = alpha;
                self.rightimage.alpha = alpha;
                self.titlelable.alpha = alpha;
                self.iconbtn.alpha = alpha;
                
                
            } else if (alpha <= 0.5 &&! _statusBarColorIsBlack) {
                self.rightbtn.alpha = 0;
                self.rightimage.alpha = 0;
                self.titlelable.alpha = 0;
                self.iconbtn.alpha = 0;
                
            }
        } else {
            
            self.rightbtn.alpha = 0;
            self.rightimage.alpha = 0;
            self.titlelable.alpha = 0;
            self.MynavBarView.alpha = 0;
            self.iconbtn.alpha = 0;
            self.Myalpha = 0;
            _statusBarColorIsBlack = NO;
            
        }
    }
}

#pragma mark - 控制器生命周期

//** 视图加载完毕 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountImageViewClick)];
    [self.accountView addGestureRecognizer:tap];
    
    //--注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSendAuctionViewControlelr) name:kYXMySendAuctionToSendAuctionModulNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //--加载数据
    [self loadBaseData];
    
    self.navigationController.navigationBar.hidden = YES;
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.rightbtn setTitle:@"立即登录" forState:UIControlStateNormal];
    
    self.tabBarController.tabBar.hidden = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.dismissStatusBool = 0;
    
    CGFloat myalpha = [[YXUserDefaults objectForKey:@"MyNavViewAlpha"] floatValue];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_MynavBarView];
    
    if (self.Myalpha>0.2) {
        
        self.MynavBarView.alpha = myalpha;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    [self.MynavBarView removeFromSuperview];
    
    self.dismissStatusBool = 1;
    
    [YXUserDefaults setObject:[NSString stringWithFormat:@"%f",self.Myalpha] forKey:@"MyNavViewAlpha"];
    
    [YXNetworkHUD dismiss];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kYXMySendAuctionToSendAuctionModulNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"modalLoginController" object:nil];
}


#pragma mark - 懒加载

- (YXMyAuctionHomeController *)myAuctinController
{
    if (!_myAuctinController) {
        
        _myAuctinController = [[YXMyAuctionHomeController alloc] init];
        
    }
    return _myAuctinController;
}

- (YXMyOrderController *)myOrderController
{
    if (!_myOrderController) {
        _myOrderController = [[UIStoryboard storyboardWithName:@"MyOrder" bundle:nil] instantiateInitialViewController];
    }
    return _myOrderController;
}

- (YXMySendAuctionHomeController *)mySendAuctionController
{
    if (!_mySendAuctionController) {
        _mySendAuctionController = [[YXMySendAuctionHomeController alloc] init];
    }
    return _mySendAuctionController;
}

- (YXMyInformationController *)myInformationController
{
    if (!_myInformationController) {
        _myInformationController = [[UIStoryboard storyboardWithName:@"MyInformation" bundle:nil] instantiateInitialViewController];
    }
    return _myInformationController;
}



-(UIView*)MynavBarView
{
    //    20  44
    if (!_MynavBarView) {
        _MynavBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 64)];
        _MynavBarView.backgroundColor = [UIColor blackColor];
        
        UIButton *iconbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20+7, 30, 30)];
        [iconbtn setImage:[UIImage imageNamed:@"ic_default"] forState:UIControlStateNormal];
        iconbtn.layer.cornerRadius = 15;
        iconbtn.layer.masksToBounds = YES;
        [iconbtn addTarget:self action:@selector(clickIconimage) forControlEvents:UIControlEventTouchUpInside];
        [_MynavBarView addSubview:iconbtn];
        self.iconbtn = iconbtn;
        
        UIButton *rightimage = [[UIButton alloc]initWithFrame:CGRectMake(YXScreenW-20-35, 20+13, 20, 20)];
        [rightimage addTarget:self action:@selector(clickright) forControlEvents:UIControlEventTouchUpInside];
        [rightimage setImage:[UIImage imageNamed:@"icon_Myaccountfanhui"] forState:UIControlStateNormal];
        rightimage.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -47);
        [_MynavBarView addSubview:rightimage];
        
        UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake((YXScreenW-100)/2, 20+7, 100, 30)];
        titlelable.text =@"我的";
        titlelable.textColor = [UIColor whiteColor];
        titlelable.font = [UIFont systemFontOfSize:16];
        titlelable.textAlignment = NSTextAlignmentCenter;
        [_MynavBarView addSubview:titlelable];
        
        
        UIButton *rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(YXScreenW-40-60, 20+7, 60, 30)];
        //        [rightbtn setTitle:@"账户详情" forState:UIControlStateNormal];
        rightbtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightbtn.titleEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        [rightbtn addTarget:self action:@selector(clickright) forControlEvents:UIControlEventTouchUpInside];
        [_MynavBarView addSubview:rightbtn];
        
        
        
        self.rightimage = rightimage;
        self.titlelable = titlelable;
        self.rightbtn = rightbtn;
        
        
        _MynavBarView.alpha = 0;
        _rightbtn.alpha = 0;
        _rightimage.alpha = 0;
        _titlelable.alpha = 0;
        
    }
    return _MynavBarView;
}


-(void)clickIconimage
{
    if (self.currentLoginStatus == 3 || self.currentLoginStatus == 6|| self.currentLoginStatus ==0) {
        [self showAlert];
        return;
    }
    [self.navigationController pushViewController:self.myInformationController animated:YES];

}

-(void)clickright
{
    if ([self.rightbtn.titleLabel.text isEqualToString:@"账户详情"]) {
        
        //** 到个人信息 */
        [self.navigationController pushViewController:self.myInformationController animated:YES];
        
    }else if ([self.rightbtn.titleLabel.text isEqualToString:@"立即登录"])
    {
        
        YXLoginViewController *loginVC = [[YXLoginViewController alloc]init];
        YXNavigationController *navi = [[YXNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navi animated:YES completion:nil];
        
    }
    
    
}

@end
