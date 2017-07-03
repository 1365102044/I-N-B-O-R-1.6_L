//
//  YXMyAccountThridPartyViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 2017/1/13.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyAccountThridPartyViewController.h"
#import "YXMyAccountThridPartyTableViewCell.h"
#import "YXLoginRequestTool.h"
#import "YXThridPartyLoginManger.h"
#import "YXWeChatPayManager.h"
#import "YXLoginViewController.h"
#import "YXAlertViewTool.h"
#import "YXThirdPartyBindingModle.h"
#import "YXInputPhoneNumberViewController.h"
#import "YXInputPhoneNumberViewController.h"
#import "YXInputVerificationCodeViewController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXMessageCountDownManager.h"

@interface YXMyAccountThridPartyViewController ()<UITableViewDelegate,UITableViewDataSource,YXTencentLoginDelegate,YXWeChatPayManagerDelegate>

@property(nonatomic,strong) UITableView * tableview;

@property(nonatomic,strong) NSMutableArray * dataArr;
@property(nonatomic,assign) YXThridLoginType  MyThridLoginType;
@end

@implementation YXMyAccountThridPartyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"第三方登录";
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    [self.view addSubview:self.tableview];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self QueryBindingThirdAccount];
    
}

#pragma mark  *** 网络请求
/**
 查询绑定的账户请求
 */
-(void)QueryBindingThirdAccount{

    [[YXLoginRequestTool sharedTool] RequestQueryBindThirdAccountWithSuccess:^(id objc, id respodHeader) {
        
        YXLog(@"=++chaxun++%@++",objc);
        [self.dataArr removeAllObjects];
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            NSMutableDictionary *dictqq = [[NSMutableDictionary alloc]init];
            dictqq[@"title"] = @"微信";
            if ([objc[@"bindWechat"] integerValue] == 1) {
                dictqq[@"subtitle"] = @"解除绑定";
            }else{
                dictqq[@"subtitle"] = @"立即绑定";
            }
            NSMutableDictionary *dictweichat = [[NSMutableDictionary alloc]init];
            dictweichat[@"title"] = @"QQ";
            if ([objc[@"bindQQ"] integerValue] == 1) {
                dictweichat[@"subtitle"] = @"解除绑定";
            }else{
                dictweichat[@"subtitle"] = @"立即绑定";
            }
            [self.dataArr addObject:dictqq];
            [self.dataArr addObject:dictweichat];
        }else{
            
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
        
        [self.tableview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
/**
 微信解绑
 */
-(void)UnbundlingWeiChatAccount{
    
    [[YXLoginRequestTool sharedTool] RequestUnbundlingWeiChatAccountWithSuccess:^(id objc, id respodHeader) {
        
        YXLog(@"=++jiebang weichat++%@++",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            [self requestBindResponse:0];
            [YXAlearMnager ShowAlearViewWith:objc Type:1];
        }else{
            
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
        
    } failure:^(NSError *error) {
    }];
}
/**
 QQ解绑
 */
-(void)UnbundlingQQAccount{
    
    [[YXLoginRequestTool sharedTool] RequestUnbundlingQQAccountWithSuccess:^(id objc, id respodHeader) {
        YXLog(@"=++jebang qq++%@++",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            [self requestBindResponse:1];
            [YXAlearMnager ShowAlearViewWith:objc Type:1];
        }else{
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
    } failure:^(NSError *error) {
    }];
}
-(void)requestBindResponse:(NSInteger)type
{
    self.dataArr[type][@"subtitle"] = @"立即绑定";
    [self.tableview reloadData];
}
/**
 解除和绑定的账户
 */
-(void)UndundlingRequstMethod:(NSString *)type IsBindOrUnbundling:(NSString *)bindOrUnbundling
{
    if ([bindOrUnbundling isEqualToString:@"binding"]) {
        
        if ([type isEqualToString:@"QQ"]) {
            
            [YXThridPartyLoginManger shared].YXTenceLoginDelegate = self;
            [[YXThridPartyLoginManger shared] TencetnOAuthLogin];
            self.MyThridLoginType = YXQQLogin;
            
        }else if([type isEqualToString:@"微信"]){
            
            [YXWeChatPayManager sharedManager].delegate = self;
            [YXThridPartyLoginManger senWeiChatAuthRequestScope];
            self.MyThridLoginType = YXWeiChatLogin;
        }
    }else if ([bindOrUnbundling isEqualToString:@"unbundling"]){
        if ([type isEqualToString:@"QQ"]) {
            
            [self UnbundlingQQAccount];
        }else if([type isEqualToString:@"微信"]){
            
            [self UnbundlingWeiChatAccount];
        }
    }
}

#pragma mark  *** 微信登录 回调代理  ****
/**
 ErrCode	ERR_OK = 0(用户同意)
 ERR_AUTH_DENIED = -4（用户拒绝授权）
 ERR_USER_CANCEL = -2（用户取消）
 */
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    
    if (response.errCode== -4) {
        
        [YXAlearMnager ShowAlearViewWith:@"授权拒绝" Type:2];
        return;
    }else if (response.errCode == -2){
        [YXAlearMnager ShowAlearViewWith:@"授权取消" Type:2];
        return;
    }
    
    [self requestWeiChatWithCode:response.code];

    
}

-(void)requestWeiChatWithCode:(NSString *)code
{
    [[YXLoginRequestTool sharedTool] RequestWeiChatLoginAccess_tokenWithCode:code Success:^(id objc, id respodHeader) {
                YXLog(@"=====objc==%@===",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            if ([objc isKindOfClass:[NSNull class]]|| objc == nil) {
                
                return ;
            }
            
            YXThirdPartyBindingModle *modle = [YXThirdPartyBindingModle mj_objectWithKeyValues:objc];
            modle.loginType = YXWeiChatLogin;
            [self pushBindingPhoneWith:modle objc:objc];
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
               YXLog(@"=====objc==%@===",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            YXThirdPartyBindingModle *modle = [YXThirdPartyBindingModle mj_objectWithKeyValues:objc];
            modle.loginType = YXQQLogin;
            [self pushBindingPhoneWith:modle objc:objc];
            
        }else{
            
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
    } failure:^(NSError *error) {
    }];
}
/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled)
    {
        [YXAlearMnager ShowAlearViewWith:@"授权取消" Type:2];
        
    }
    else
    {
        [YXAlearMnager ShowAlearViewWith:@"授权失败" Type:2];
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    
    [YXAlearMnager ShowAlearViewWith:@"无网络连接，请设置网络" Type:2];
}

/**
 跳转控制器
 */
-(void)pushBindingPhoneWith:(YXThirdPartyBindingModle *)modle objc:(id)objc
{
    if (modle.flag == 1) {
        
        //** 100 跳到短信验证码的界面 的标示，绑定过去的，跳转前不再发送验证码， **/
        YXInputVerificationCodeViewController*inputSMScodevc = [YXInputVerificationCodeViewController inputVerificationCodeViewControllerWithType:YXInputVerificationCodeViewControllerTypeBinding phoneNumber:modle.phone andExtend:@"100"];
        modle.sourViewController = self;
        modle.TheAccountStatus = YXAlearlyRegisterApp;
        [inputSMScodevc formeThirdbindingAccountWith:modle];
        [self.navigationController pushViewController:inputSMScodevc animated:YES];
    }else{
    
        if (modle.openid) {
            
            YXInputPhoneNumberViewController*inputPhoneVC = [YXInputPhoneNumberViewController inputPhoneNumberViewControllerWithType:YXLoginViewControllerTypeBinding andExtend:nil];
            modle.loginType = self.MyThridLoginType;
            modle.sourViewController = self;
            [inputPhoneVC formeThirdAccountWith: modle];
            [self.navigationController pushViewController:inputPhoneVC animated:YES];
        }else{
            
            [[YXAlearViewTool sharedAlearview] ShowAlearViewWith:objc Type:2];
        }
    
    }

    
}




#pragma mark  *** tableview-delegate 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    YXMyAccountThridPartyTableViewCell *cell = [[YXMyAccountThridPartyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.dataDict = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataArr[indexPath.row];
    if ([dict[@"subtitle"] isEqualToString:@"立即绑定"]) {
        
        [self UndundlingRequstMethod:dict[@"title"] IsBindOrUnbundling:@"binding"];
    }else if([dict[@"subtitle"] isEqualToString:@"解除绑定"]){
        
        [YXAlertViewTool showAlertView:self title:@"确定解除绑定？" message:@"" cancelTitle:@"取消" otherTitle:@"确定" cancelBlock:^{
            
        } confrimBlock:^{
            
            [self UndundlingRequstMethod:dict[@"title"] IsBindOrUnbundling:@"unbundling"];
        }];
    }
}


/**
 懒加载
 */
-(UITableView *)tableview{

    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 50;
        _tableview.tableFooterView = [[UIView alloc]init];
    }
    return _tableview;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
