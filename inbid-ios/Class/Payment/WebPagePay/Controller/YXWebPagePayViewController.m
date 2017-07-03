//
//  YXWebPagePayViewController.m
//  Payment
//
//  Created by 郑键 on 16/12/1.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXWebPagePayViewController.h"
#import "YXPaymentDetailCell.h"
#import "YXPaymentTypeHeaderView.h"
#import "YXWebPagePCPayLogoCell.h"
#import "YXWebPagePCPayFooterView.h"
#import "YXPayZBarViewController.h"
#import "YXPCUniconPayZabrViewController.h"
#import "YXAlertViewTool.h"
@interface YXWebPagePayViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 内容视图
 */
@property (nonatomic, strong) UITableView *contentTableView;

@end

@implementation YXWebPagePayViewController

//** 重用标志 */
static NSString * const kYXPaymentHomePageControllerDetailCellReusableIdentifier = @"kYXPaymentHomePageControllerDetailCellReusableIdentifier";
static NSString * const kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier = @"kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier";
static NSString * const kYXPaymentWebPagePayControllerPCPayLogoCellReusableIdentifier = @"kYXPaymentWebPagePayControllerPCPayLogoCellReusableIdentifier";
static NSString * const kYXPaymentWebPagePayControllerPCPayFooterViewReusableIdentifier = @"kYXPaymentWebPagePayControllerPCPayFooterViewReusableIdentifier";

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark <UITableViewDataSource>


/**
 分笔支付后 跳转这个界面后 改变应付价格
 */
-(void)FormeFenbiPayChangeShouldPayprice:(NSNotification *)noti
{
    
    self.dataModel.alreadyPayAmount = noti.userInfo[@"alreadyPayAmount"];
    
    [self.contentTableView reloadData];
}

/**
 返回组
 
 @param tableView tableView
 
 @return 组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 返回行
 
 @param tableView tableView
 @param section   section
 
 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

/**
 自定义cell
 
 @param tableView tableView
 @param indexPath indexPath
 
 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        YXPaymentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXPaymentHomePageControllerDetailCellReusableIdentifier forIndexPath:indexPath];
        cell.deatilmodle = self.dataModel;
        
        return cell;
    }
    
    //** logoCell */
    if (indexPath.row == 1) {
        YXWebPagePCPayLogoCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXPaymentWebPagePayControllerPCPayLogoCellReusableIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YXPaymentTypeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier];
    if (!headerView) {
        headerView = [[YXPaymentTypeHeaderView alloc] initWithReuseIdentifier:kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier];
    }
    //headerView.dingdanNumber = self.dataModel.orderId;
    if (section == 0) headerView.type = YXPaymentTypeHeaderViewDetailHeader;
    headerView.baseModel = self.dataModel;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    YXWebPagePCPayFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYXPaymentWebPagePayControllerPCPayFooterViewReusableIdentifier];
    
    __weak typeof(self)weakself = self;
    footerView.clicksurebtnblock= ^(){
        
        // 1、 获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if (device) {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusNotDetermined) {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            YXPayZBarViewController *zbarvc =[[YXPayZBarViewController alloc]init];
                            zbarvc.formePCPayurlBlock = ^(NSString *url){
                                [weakself GetPayUrlWithZbar:url];
                            };
                            [weakself.navigationController pushViewController:zbarvc animated:YES];
                            YXLog(@"主线程 - - %@", [NSThread currentThread]);
                        });
                        YXLog(@"当前线程 - - %@", [NSThread currentThread]);
                        
                        // 用户第一次同意了访问相机权限
                        YXLog(@"用户第一次同意了访问相机权限");
                        
                    } else {
                        
                        // 用户第一次拒绝了访问相机权限
                        YXLog(@"用户第一次拒绝了访问相机权限");
                    }
                }];
            } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
                YXPayZBarViewController *zbarvc =[[YXPayZBarViewController alloc]init];
                zbarvc.formePCPayurlBlock = ^(NSString *url){
                    [weakself GetPayUrlWithZbar:url];
                };
                [weakself.navigationController pushViewController:zbarvc animated:YES];
                
            } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
                YXLog(@"%@", @"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关");
            } else if (status == AVAuthorizationStatusRestricted) {
                YXLog(@"因为系统原因, 无法访问相册");
            }
        } else {
            YXLog(@"%@", @"未检测到您的摄像头, 请在真机上测试");
        }
        
        
        };
    if (!footerView) {
        footerView = [[YXWebPagePCPayFooterView alloc] initWithReuseIdentifier:kYXPaymentWebPagePayControllerPCPayFooterViewReusableIdentifier];
    }
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 64.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 121.f;
    if (indexPath.row == 1) return 132.f;
    return 0;
}

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PC网银扫码支付";
    [self.view addSubview:self.contentTableView];
    [self registerSubViews];
    
    //分笔支付后 （未支付完）跳到这个页面 改变应付金额
    [YXNotificationTool addObserver:self selector:@selector(FormeFenbiPayChangeShouldPayprice:) name:@"FROMEFENBIPAYCHANGESHOULDPAYPRICE" object:nil];
}

/**
 扫码完成的 拿到的URL 和 参数
 */
-(void)GetPayUrlWithZbar:(NSString *)url
{
//    YXLog(@"======扫码结果====++===%@===",url);
    if (![url containsString:@"pcPay/loginAuth"]) {
        
        [YXAlearMnager ShowAlearViewWith:@"无效二维码" Type:2];
        return ;
    }
    NSString *clientID;
    NSString *URL;
    if (url) {
        NSArray *urlarr = [url componentsSeparatedByString:@"?"];
        if (urlarr.count>1) {
            URL = urlarr[0];
            NSArray *clientIDarr = [urlarr[1] componentsSeparatedByString:@"="];
            if (clientIDarr.count>1) {
                clientID = clientIDarr[1];
            }
        }
    }
    if (URL) {
        
        [self requeatPayZBar:URL clientID:clientID];
    }
}

#pragma mark  ******************* 扫码支付 发送请求**********************
-(void)requeatPayZBar:(NSString *)url clientID:(NSString *)clientID
{
    
    //**type (1鉴定订单，2拍卖订单，3保证金 4一口价)**/
    //NSString *userID = [YXUserDefaults objectForKey:@"TokenID"];
    NSString *userID = [[YXLoginStatusTool sharedLoginStatus] getTokenId];
    if (userID.length==0) {
        [YXAlertViewTool showAlertView:self title:@"提示" message:@"登录异常，请重新登录" confrimBlock:^{}];
        return;
    }
    
    [[YXPayMentNetRequestTool sharedTool] loadPayMentZbarPayDataWithOrderId:self.dataModel.orderId andorderType:self.dataModel.transType andUserID:userID andclientID:clientID andUrl:url success:^(id objc, id respodHeader) {
        YXLog(@"--------success--%@",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            YXPCUniconPayZabrViewController *zbarPayResult =[[YXPCUniconPayZabrViewController alloc]init];
            zbarPayResult.dataModel = self.dataModel;
            [self.navigationController pushViewController:zbarPayResult animated:YES];
        }
    } failure:^(NSError *error) {
        
        YXLog(@"--------error--%@",error);
        
    }];
}



/**
 注册子控件
 */
- (void)registerSubViews
{
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXPaymentDetailCell class]) bundle:nil] forCellReuseIdentifier:kYXPaymentHomePageControllerDetailCellReusableIdentifier];
    [self.contentTableView registerClass:[YXPaymentTypeHeaderView class] forHeaderFooterViewReuseIdentifier:kYXPaymentHomePageControllerPaymentTypeHeaderViewReusableIdentifier];
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXWebPagePCPayLogoCell class]) bundle:nil] forCellReuseIdentifier:kYXPaymentWebPagePayControllerPCPayLogoCellReusableIdentifier];
    [self.contentTableView registerClass:[YXWebPagePCPayFooterView class] forHeaderFooterViewReuseIdentifier:kYXPaymentWebPagePayControllerPCPayFooterViewReusableIdentifier];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

- (UITableView *)contentTableView
{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _contentTableView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    
}
@end
