//
//  YXMeMainViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/14.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMeMainViewController.h"
#import "YXMeMainTableHeaderView.h"
#import "YXMeMainTableOrderView.h"
#import "YXMeMainTableWalletView.h"
#import "YXMeMainTableCell.h"
#import "YXMeMainTapGestureRecognizer.h"
#import "YXMyPassWordViewController.h"
#import "YXMyAccountThridPartyViewController.h"
#import "YXPickUpPersonListViewController.h"
#import "YXHelpViewController.h"
#import "YXChatViewManger.h"
#import "YXMyInformationController.h"
#import "YXLoginStatusTool.h"
#import "YXLoginViewController.h"
#import "YXNavigationController.h"
#import "YXMySendAuctionHomeController.h"
#import "YXMyOrderListViewController.h"
#import "YXMyAuctionHomeController.h"
#import "YXMyAccountDeatilViewController.h"
#import "YXLoginRequestTool.h"
#import "YXMyAccountBaseData.h"
#import "YXMyWalletAgreementViewController.h"
#import "YXMyWalletMainViewController.h"

static CGFloat ODERVIEWHEIGHT = 125;
static CGFloat WALLTVIEWHEIGHT = 110;
static CGFloat BOOMCELLHEIGHT = 50;
static CGFloat TABLEHEADERHEIGHT = 170;
@interface YXMeMainViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,strong) UITableView * mytableview;
@property(nonatomic,strong) YXMeMainTableHeaderView * headerview;
@property(nonatomic,strong) YXMeMainTableWalletView * tableWalletView;
@property(nonatomic,strong) YXMeMainTableOrderView * tableOrderView;
@property(nonatomic,strong) YXMeMainTableCell * tableCell;
@property(nonatomic,strong) NSArray * seactionNameArr;
/**
 保存naviBar的图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarImage;

/**
 保存naviBar背景图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarBackgroundImage;
@property(nonatomic,strong) UIView * AlphaNaviBarView;
@property(nonatomic,strong) UIView  * NaviIconAndNameView;
@property(nonatomic,assign) BOOL  isCanWallt;
@property(nonatomic,strong) UIButton * setBtn;
@property(nonatomic,strong) YXMyInformationController * myInformationController;
@property(nonatomic,assign) CGFloat  navalpha;
/**
 基本信息
 */
@property (nonatomic, strong) YXMyAccountBaseData *baseDataModel;
@property(nonatomic,strong) UIImageView * headericon;
@end

@implementation YXMeMainViewController

#pragma mark - Setter

- (void)setPushViewController:(NSInteger)pushViewController
{
    _pushViewController = pushViewController;
    
    /**
     *  跳转我的鉴定列表
     */
    if (_pushViewController == 1) {
        [self orderSeactionview:myReleaseSEL];
        
    }
}

#pragma mark  *** 点击事件
/**
 NaviIconAndNameView icon name setbtn
 */
-(void)clickicon:(YXMeMainTapGestureRecognizer *)tap{
    YXLog(@"----icon--");
    [self pushInfrormationVC];

}
-(void)Clickname:(UIButton *)sender{
    YXLog(@"--%@",sender.titleLabel.text);
    [self pushInfrormationVC];

}
//设置的事件
-(void)ClicksetBtn:(UITapGestureRecognizer *)sender{
    
    YXLog(@"--++设置++");
    
    [self clickSetBtnSelector];
}
/**
 点击headerview的事件
 */
-(void)clicktableHeaderview:(headerviewSleEnum )enums
{
    switch (enums) {
        case colectSLE: //收藏
        {
            YXMyAuctionHomeController*guanzhu = [[YXMyAuctionHomeController alloc]init];
            guanzhu.index = 2001;
            [self.navigationController pushViewController:guanzhu animated:YES];
        }
            break;
        case recordSLE: //足迹
        {
            YXMyOrderListViewController *myorderlistVC = [[YXMyOrderListViewController alloc]init];
            myorderlistVC.sourViewControllerType = MyBrowsRecord;
            [self.navigationController pushViewController:myorderlistVC animated:YES];

        }
            break;
        case setSLE: //设置
        {
            [self clickSetBtnSelector];
        }
            break;
        default:  // 头像 // 名字
        {
            [self pushInfrormationVC];
        }
            break;
    }
}
/**
 orderview 事件
 myReleaseSEL = 1,  //我发布的
 mySelloutSEL,       //我卖出的
 myBuySEL,           //我买到的
 myCheckupSEL,        //我鉴定的
 alearlyReturnSEL,     //已退回商品
 */
-(void)orderSeactionview:(OrderViewSelEnum)enums{
    
    YXMyOrderListViewController *myorderlistVC = [[YXMyOrderListViewController alloc]init];
    if (enums == myReleaseSEL) myorderlistVC.sourViewControllerType = MyReleaseType;
    else if(enums == mySelloutSEL)  myorderlistVC.sourViewControllerType = MySellOutType;
    else if (enums == myBuySEL)  myorderlistVC.sourViewControllerType = MyBuyOrderType;
    else if (enums == myCheckupSEL)  myorderlistVC.sourViewControllerType = MyCheckOutType;
    else if (enums == alearlyReturnSEL)  myorderlistVC.sourViewControllerType = MyReturnType;
    else if (enums == MyPlaformReturnSEL) myorderlistVC.sourViewControllerType = MyPlaformReturnType;
    [self.navigationController pushViewController:myorderlistVC animated:YES];
}
/**
 跳到我的订单中不同位置
 */
-(void)MyOrderVCWithindex:(NSInteger)tag{
    YXMyOrderListViewController *myorderlistVC = [[YXMyOrderListViewController alloc]init];
    myorderlistVC.sourViewControllerType = MyBuyOrderType;
    myorderlistVC.PushToIndex =  (tag == 5)? 0 : tag;
    [self.navigationController pushViewController:myorderlistVC animated:YES];
}
// 跳转个人资料
-(void)pushInfrormationVC
{
    if (![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus]) {
        [self pushLoginVc];
        return ;
    }
    self.myInformationController.accountBaseDataModel = self.baseDataModel;
    [self.navigationController pushViewController:self.myInformationController animated:YES];

}
//所有的设置事件
-(void)clickSetBtnSelector{
  
    YXMyAccountDeatilViewController *myaccountdeatilVC = [[YXMyAccountDeatilViewController alloc]init];
    [self.navigationController pushViewController:myaccountdeatilVC animated:YES];
}
//登录VC
-(void)pushLoginVc{
    YXLoginViewController *loginVC = [[YXLoginViewController alloc]init];
    YXNavigationController *navi = [[YXNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navi animated:YES completion:nil];

}
#pragma mark  *** 网络请求
-(void)requestData{

    if(![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus]) return;
    
    [[YXLoginRequestTool sharedTool] RequestMeMainAccountInformationSuccess:^(id objc, id respodHeader) {
        YXLog(@"----%@--",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.baseDataModel = [YXMyAccountBaseData mj_objectWithKeyValues:objc[@"data"]];
            self.isCanWallt = self.baseDataModel.isShowMoney? YES: NO;
            self.headerview.dataModle = self.baseDataModel;
            [self.mytableview reloadData];
            [self SaveLoginData:self.baseDataModel];
        }
        
        [self.mytableview.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        
        [self.mytableview.mj_header endRefreshing];
    }];
}

/**
 登录成功后 需要保持的一些信息
 */
-(void)SaveLoginData:(YXMyAccountBaseData *)modle
{
    /**
     * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
     */
    [YXUserDefaults setObject:[NSString stringWithFormat:@"%ld",(long)modle.validateStatus] forKey:@"validateStatus"];
    /**
     * 绑定银行卡 0未绑定 1表示绑定
     */
    [YXUserDefaults setObject:[NSString stringWithFormat:@"%ld",(long)modle.cardStatus] forKey:@"cardStatus"];
    /*
     @brief 设置支付密码
     */
    [YXUserDefaults setObject:[NSString stringWithFormat:@"%ld",(long)modle.isPaymentCode] forKey:@"isPaymentCode"];
    [YXUserDefaults setObject:modle.head forKey:@"head"];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    self.defaultNaviBarImage                            = self.navigationController.navigationBar.shadowImage;
    self.defaultNaviBarBackgroundImage                  = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
     [self addNaviBarView];
    self.AlphaNaviBarView.alpha = self.navalpha;
    [self requestData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:self.defaultNaviBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:self.defaultNaviBarImage];
    [self.AlphaNaviBarView removeFromSuperview];
    self.navigationController.navigationBar.hidden = NO;
    self.navalpha = self.AlphaNaviBarView.alpha;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    self.seactionNameArr = @[@[@"我发布的",@"我的鉴定",@"我卖出的",@"平台回收",@"退回商品"],@[@"账号安全",@"第三方登录",@"实名认证",@"地址管理",@"提货人管理"],@[@"帮助中心",@"联系客服"]];
    
    //    默认不显示钱包
    self.isCanWallt = NO;
    
    [self.view addSubview:self.mytableview];
    self.mytableview.tableHeaderView = self.headerview;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClicksetBtn:)];
    self.headerview.setBtn.tag = 10;
    tap.delegate = self;
    [self.headerview.setBtn addGestureRecognizer:tap];
    
    
    __weak typeof(self)weakself = self;
    self.headerview.headerBlock = ^(headerviewSleEnum eunum){
        [weakself clicktableHeaderview:eunum];
    };
    
    self.mytableview.mj_header =  [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    
    //钱包开通后，跳转到钱包的界面
    [YXNotificationTool addObserver:self selector:@selector(pushMywalletMianVC:) name:@"pushMywalletMianVC" object:nil];

    //我发布的列表（查看鉴定）->鉴定列表
    [YXNotificationTool addObserver:self selector:@selector(PushMyCheckOutGoodsList:) name:@"PushMyCheckOutGoodsList" object:nil];
    
}
-(void)PushMyCheckOutGoodsList:(NSNotification *)noti{

    YXMyOrderListViewController *myorderlistVC = [[YXMyOrderListViewController alloc]init];
    myorderlistVC.sourViewControllerType = MyCheckOutType;
    [self.navigationController pushViewController:myorderlistVC animated:NO];
}
//钱包开通后/重置完密码后->银行列表—>钱包，跳转到钱包的界面
-(void)pushMywalletMianVC:(NSNotification *)noti{
    
    YXMyWalletMainViewController *walletHomePage = [YXMyWalletMainViewController new];
    [self.navigationController pushViewController:walletHomePage animated:NO];
}
/**
    tableview.delegate
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.seactionNameArr.count+2 ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) return 1;
    else if (section==1) return  self.isCanWallt ? 1:0;
    else if (section>1) return [self.seactionNameArr[section-2] count];
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str;
    if (indexPath.section<2) {
        str = @"cell";
    }else{
        str = [NSString stringWithFormat:@"%ld%ld",indexPath.section,indexPath.row];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    if (indexPath.section == 0) {
        self.tableOrderView.frame = CGRectMake(0, 0, YXScreenW, ODERVIEWHEIGHT);
        __weak typeof(self)weakself = self;
        self.tableOrderView.clickItemBlock = ^(NSInteger tag){
            [weakself MyOrderVCWithindex:tag];
        };
        self.tableOrderView.orderViewModle = self.baseDataModel;
        [cell.contentView addSubview:self.tableOrderView];
        
    }else if (indexPath.section==1){
        if (!self.isCanWallt) return cell;
        
        YXMeMainTableCell *tableCell = [[YXMeMainTableCell alloc]init];
        tableCell.frame = CGRectMake(0, 0, YXScreenW, BOOMCELLHEIGHT);
        tableCell.backgroundColor = [UIColor whiteColor];
        [tableCell SetBaseMyAccountInforModle:self.baseDataModel indexPath:indexPath titleArr:self.seactionNameArr];
        [cell.contentView addSubview:tableCell];
    }else{
        
        YXMeMainTableCell *tableCell = [[YXMeMainTableCell alloc]init];
        tableCell.frame = CGRectMake(0, 0, YXScreenW, BOOMCELLHEIGHT);
        tableCell.backgroundColor = [UIColor whiteColor];
        [tableCell SetBaseMyAccountInforModle:self.baseDataModel indexPath:indexPath titleArr:self.seactionNameArr];
        [cell.contentView addSubview:tableCell];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) return ODERVIEWHEIGHT;
    else if (indexPath.section==1) return self.isCanWallt ? BOOMCELLHEIGHT : 0;
    else  return BOOMCELLHEIGHT;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section<1) return;
    if (indexPath.section==1) {

        /**
         *  判断是否已经开通钱包，如已经开通，直接跳转钱包首页，如未开通钱包跳转协议页面
         */
        if (self.baseDataModel.openingStatus) {
            YXMyWalletMainViewController *walletHomePage = [YXMyWalletMainViewController new];
            [self.navigationController pushViewController:walletHomePage animated:YES];
        }else{
            YXMyWalletAgreementViewController *mywalletVC =[[YXMyWalletAgreementViewController alloc]init];
            [self.navigationController pushViewController:mywalletVC animated:YES];
        }
        return;
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) [self orderSeactionview:myReleaseSEL];
        else if (indexPath.row==1) [self orderSeactionview:myCheckupSEL];
        else if (indexPath.row==2) [self orderSeactionview:mySelloutSEL];
        else if (indexPath.row==3) [self orderSeactionview:MyPlaformReturnSEL];
        else if (indexPath.row==4) [self orderSeactionview:alearlyReturnSEL];
    }
    if (indexPath.section==3) {
        switch (indexPath.row) {
            case 0: //账户安全
            {
                YXMyPassWordViewController *account = [[YXMyPassWordViewController alloc]init];
                account.SourVcEnum = AccountSecurity;
                [self.navigationController pushViewController:account animated:YES];
            }
                break;
            case 1: //第三方登录
            {
                YXMyAccountThridPartyViewController *myaccountThridpartyvc = [[YXMyAccountThridPartyViewController alloc]init];
                [self.navigationController pushViewController:myaccountThridpartyvc animated:YES];

            }
                break;
            case 2:  //实名认证
            {
                YXMyPassWordViewController *account = [[YXMyPassWordViewController alloc]init];
                account.SourVcEnum = RealName;
                [self.navigationController pushViewController:account animated:YES];
            }

                break;
            case 3:  //地址管理
            {
                [self.navigationController pushViewController: [[UIStoryboard storyboardWithName:@"myAddressList" bundle:nil] instantiateInitialViewController] animated:YES];

            }
                break;
            case 4:  //提货人管理
            {
                YXPickUpPersonListViewController *vc =[[YXPickUpPersonListViewController alloc]init];
                vc.sourceController = self;
                [self.navigationController pushViewController:vc animated:YES];

            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section==4){
    
        switch (indexPath.row) {
            case 0:
            {
                YXHelpViewController *helpVC =[[YXHelpViewController alloc]init];
                helpVC.helpIndex = 0;
                [self.navigationController pushViewController:helpVC animated:YES];
            }
                break;
            case 1:
            {
                [self KefuAlearview];
            }
                break;
            default:
                break;
        }
    }
}
-(void)KefuAlearview
{
    //创建AlertController对象 preferredStyle可以设置是AlertView样式或者ActionSheet样式
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:@"联系客服" preferredStyle:UIAlertControllerStyleActionSheet];
    //创建取消按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"在线客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[YXChatViewManger sharedChatviewManger] LoadChatView];
        [[YXChatViewManger sharedChatviewManger] presentMQChatViewControllerInViewController:self];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"电话客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clickphone];
        
    }];
    //添加按钮
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:action3];
    //显示
    [self presentViewController:alertC animated:YES completion:nil];
    
}
-(void)clickphone
{
    NSString *phonestr = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phonestr];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    [self.view addSubview:callWebview];
    [self.view bringSubviewToFront:callWebview];
    
}
/**
 滚动代理
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat myalpha = offsetY/60;
    if (myalpha>=1) myalpha = 1;

    if (offsetY<=60) {
        self.AlphaNaviBarView.alpha = myalpha;
    }else{
        self.AlphaNaviBarView.alpha = 1;
        [self preferredStatusBarStyle];
    }
    if (myalpha<0.05) {
        self.navigationController.navigationBar.hidden = YES;
    }else{
        self.navigationController.navigationBar.hidden = NO;
    }
    self.NaviIconAndNameView.alpha = myalpha;
    self.navalpha = myalpha;
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
     return UIStatusBarStyleLightContent;
}
-(void)addNaviBarView{
    
    self.AlphaNaviBarView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, YXScreenW,64)];
    self.AlphaNaviBarView.backgroundColor =  UIColorFromRGB(0x251011);
    self.AlphaNaviBarView.alpha = 0;
    [self.navigationController.navigationBar insertSubview:self.AlphaNaviBarView atIndex:0];
    
    [self.AlphaNaviBarView addSubview:[self setNaviIconAndNameView]];
    self.navigationController.navigationBar.hidden = YES;
    if (self.navalpha>=0.1) {
        self.navigationController.navigationBar.hidden = NO;
    }
}
-(UIView *)setNaviIconAndNameView{
    UIView *NaviIconAndNameView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, YXScreenW, 40)];
    NaviIconAndNameView.backgroundColor = [UIColor clearColor];
    self.NaviIconAndNameView = NaviIconAndNameView;
    
    UIButton *SetBtn = [[UIButton alloc]initWithFrame:CGRectMake(YXScreenW-80, 7, 60, 30)];
    [SetBtn setTitle:@"设置" forState:UIControlStateNormal];
    SetBtn.titleLabel.font = YXSFont(15);
    [SetBtn addTarget:self action:@selector(ClicksetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [SetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [NaviIconAndNameView addSubview:SetBtn];
    self.setBtn = SetBtn;
    
    CGFloat iconW = NaviIconAndNameView.height-10;
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(20,(NaviIconAndNameView.height-10-iconW)/2 , iconW, iconW)];
//    icon.image = [UIImage imageNamed:@"icon_touxiang"];
    icon.userInteractionEnabled = YES;
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = iconW/2;
    [NaviIconAndNameView addSubview:icon];
    self.headericon = icon;

    
    UIButton * namebtn = [[UIButton alloc]initWithFrame:CGRectMake(iconW+30, 5, YXScreenW-iconW-SetBtn.width-50, iconW)];
    [namebtn setTitle:@"" forState:UIControlStateNormal];
    [namebtn addTarget:self action:@selector(Clickname:) forControlEvents:UIControlEventTouchUpInside];
    namebtn.titleLabel.font = YXSFont(18);
    [namebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    namebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [NaviIconAndNameView addSubview:namebtn];
    
    
    NSString *headerstr = [YXUserDefaults objectForKey:@"head"];
    NSString *str  = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100", [[YXUserDefaults objectForKey:@"head"] componentsSeparatedByString:@"?"].firstObject];
    [icon sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"ic_default"]];
    if (headerstr.length==0) {
        icon.image = [UIImage imageNamed:@"ic_default"];
    }
    NSString *namestr = [YXUserDefaults objectForKey:@"nickname"];
    [namebtn setTitle:namestr forState:UIControlStateNormal];
    
    icon.centerY = SetBtn.centerY;
    namebtn.centerY = SetBtn.centerY;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickicon:)];
    [icon addGestureRecognizer:tap];
    return NaviIconAndNameView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) return  0.0000001;
    if (section==1) return self.isCanWallt ? 10 : 0.00001;
    else return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==4) return 10;
    return 0.000001;
}
/**
 懒加载
 */
-(UITableView *)mytableview{
    if (!_mytableview) {
         CGFloat NAVIBARHEIGHT = 45;
        _mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, self.view.height-NAVIBARHEIGHT) style:UITableViewStyleGrouped];
        _mytableview.backgroundColor =  UIColorFromRGB(0xf9f9f9);
        [_mytableview setSeparatorColor:UIColorFromRGB(0xe5e5e5)];
        _mytableview.delegate = self;
        _mytableview.dataSource = self;
    }
    return _mytableview;
}
-(YXMeMainTableHeaderView *)headerview{
    if (!_headerview) {
        _headerview = [[YXMeMainTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, TABLEHEADERHEIGHT)];
        _headerview.backgroundColor = [UIColor grayColor];
    }
    return _headerview;
}
-(YXMeMainTableOrderView *)tableOrderView{
    if (!_tableOrderView) {
        _tableOrderView = [[YXMeMainTableOrderView alloc]init];
    }
    return _tableOrderView;
}
-(YXMeMainTableWalletView *)tableWalletView{
    if (!_tableWalletView) {
        _tableWalletView = [[YXMeMainTableWalletView alloc]init];
    }
    return _tableWalletView;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (YXMyInformationController *)myInformationController
{
    if (!_myInformationController) {
        _myInformationController = [[UIStoryboard storyboardWithName:@"MyInformation" bundle:nil] instantiateInitialViewController];
    }
    return _myInformationController;
}
@end
