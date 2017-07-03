//
//  ViewController.m
//  MyAccountView
//
//  Created by 胤讯测试 on 16/11/19.
//  Copyright © 2016年 胤讯--LWQ. All rights reserved.
//

#import "YXMyAccountMainViewController.h"

#import "YXMyAccountHeaderview.h"
#import "YXMyAccountCollectionViewCell.h"
#import "YXMyInformationController.h"
#import "YXMyAccountDeatilViewController.h"
#import "YXNetworkTool.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXLoginViewController.h"
#import "YXNavigationController.h"
#import "YXMySendAuctionHomeController.h"
#import "YXMyAuctionHomeController.h"
#import "YXMyAccoutBindBankCardViewController.h"
#import "YXMyAucctionRealnameAndBindbankCardViewController.h"
#import "YXHelpViewController.h"
#import "YXMyAccountSetPaymengPasswordViewController.h"
#import "YXMyAccountChangePaymentPasswordViewController.h"
#import "YXMyAccountRealNameViewController.h"
#import "YXMyInformationPwdController.h"
#import "YXMyAccountSureMoneyBaseViewController.h"
#import "MQChatViewManager.h"
#import "YXPickUpPersonListViewController.h"
#import "YXMyAccountBaseData.h"
#import "YXChatViewManger.h"
#import "YXMyOrderListViewController.h"
#import "YXLoginStatusTool.h"
#import "YXMyAccountThridPartyViewController.h"
#define cellIndenfine @"seactionTwoIndentfine"
#define headerviewIndentfine @"seactionHeaderIndentfine"

#warning +++
#import "YXMeMainViewController.h"

@interface YXMyAccountMainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
//** 我的个人信息控制器 */

/**
 内容视图
 */
@property(nonatomic,strong) UICollectionView * collectview;


@property(nonatomic,strong) YXMyAccountHeaderview * header;

@property (nonatomic, strong) YXMyInformationController *myInformationController;

@property(nonatomic,strong) NSArray * nameArr;

@property(nonatomic,strong) NSArray * imageArr;


@property(nonatomic,assign) NSInteger  currentLoginStatus;
/**
 基本信息
 */
@property (nonatomic, strong) YXMyAccountBaseData *baseDataModel;

@property(nonatomic,assign) BOOL  haveIconBool;

@property(nonatomic,assign) BOOL  isformepayVC;

/**
 保存naviBar的图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarImage;

/**
 保存naviBar背景图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarBackgroundImage;

@property(nonatomic,strong) NSString * headericonurl;
@end

@implementation YXMyAccountMainViewController

- (void)setFuncItem:(NSInteger)funcItem
{
    NSUInteger log = self.currentLoginStatus ;
    self.currentLoginStatus = 1;
    
    _funcItem = funcItem;
    self.isformepayVC = YES;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:funcItem inSection:0];
    [self collectionView:self.collectview didSelectItemAtIndexPath:indexPath];
    self.currentLoginStatus = log;
}

-(UICollectionView*)collectview
{
    if (!_collectview) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(YXScreenW, 150);
        layout.itemSize = CGSizeMake((([UIScreen mainScreen].bounds.size.width-2)) /3, 125);
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        _collectview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -20, YXScreenW, YXScreenH+20) collectionViewLayout:layout];
        
        //代理设置
        _collectview.delegate=self;
        _collectview.dataSource = self;
        
    }
    return _collectview;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    self.nameArr = @[@{@"title":@"我的鉴定"},
                     @{@"title":@"我出售的"},
                     @{@"title":@"我买到的"},
                     @{@"title":@"我关注的"},
                     @{@"title":@"基本资料"},
                     @{@"title":@"实名认证"},
                     @{@"title":@"地址管理"},
                     @{@"title":@"提货人管理"},
                     @{@"title":@"绑定银行卡"},
                     @{@"title":@"登录密码"},
                     @{@"title":@"支付密码"},
                     @{@"title":@"第三方绑定"},
                     @{@"title":@"帮助中心"},
                     @{@"title":@"联系客服"},
                     @{@"title":@"设置"},
                     ];

    
    [self addcollectview];
    
    //--加载数据
    [self loadBaseData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    
    [YXNotificationTool addObserver:self selector:@selector(PushMycountThirdParyViewController:) name:@"FormeMycountThirdParyViewController" object:nil];
}
/**
 绑定完成后 返回的第三方绑定和解绑的界面
 */
-(void)PushMycountThirdParyViewController:(NSNotification *)noti{

    [self.navigationController.navigationBar setBackgroundImage:self.defaultNaviBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:self.defaultNaviBarImage];
    
    YXMyAccountThridPartyViewController *myaccountThridpartyvc = [[YXMyAccountThridPartyViewController alloc]init];
    [self.navigationController pushViewController:myaccountThridpartyvc animated:NO];

}

-(void)addcollectview
{
    
    [self.view addSubview:self.collectview];
    self.collectview.backgroundColor = UIColorFromRGB(0xe5e5e5);
    
    [self.collectview registerClass:[YXMyAccountHeaderview class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerviewIndentfine];
    [self.collectview registerClass:[YXMyAccountCollectionViewCell class] forCellWithReuseIdentifier:cellIndenfine];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.nameArr.count;
}

/*
 @brief 组头的方法
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        // header类型
        
        // 从重用队列里面获取
        YXMyAccountHeaderview *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerviewIndentfine forIndexPath:indexPath];
        self.header = header;
        __weak typeof(self)weakself = self;
        if (self.currentLoginStatus== 1) {
            
            [self ChangeCollectHearViewSubviewStatus:YES];
        }else{

            [self ChangeCollectHearViewSubviewStatus:NO];
        }
        header.clickiconblock = ^(){
        
            if (self.currentLoginStatus!=1) {
                
                [weakself PushLoginVC];
                return ;
            }
            self.myInformationController.accountBaseDataModel = self.baseDataModel;
            self.myInformationController.changeImageblock = ^(NSString *headerUrl,NSData *imagedata){
                if([headerUrl componentsSeparatedByString:@"?"].count>1)
                {
                    headerUrl = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100", [headerUrl componentsSeparatedByString:@"?"].firstObject];
                }else{
                    
                    headerUrl = headerUrl;
                }

                weakself.headericonurl = headerUrl;
                if ([weakself.baseDataModel.head isEqualToString:headerUrl]) {
                    return ;
                }
                weakself.baseDataModel.head = headerUrl;
                UIImage *image = [[UIImage alloc]init];
                image = [UIImage imageWithData:imagedata];
                weakself.header.iconimageview.image = image;
                
            };
             [self.navigationController pushViewController:self.myInformationController animated:YES];
            
        };
        
        header.clickzhuanghublock = ^(){
            
            if (self.currentLoginStatus!=1) {
                
                [weakself PushLoginVC];
                return ;
            }
             self.myInformationController.accountBaseDataModel = self.baseDataModel;
            [self.navigationController pushViewController:self.myInformationController animated:YES];
            
        };
        
        
        return header;
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
    }
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentLoginStatus!=1) {
    
        if (indexPath.row ==12||indexPath.row==13||indexPath.row==14) {
            
            [self ClickCellPushVC:indexPath.row];
            
        }else{
        
            [self PushLoginVC];
        }
        return;
    }
       [self ClickCellPushVC:indexPath.row];
}

//这是正确的方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YXMyAccountCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndenfine  forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.dict = self.nameArr[indexPath.row];
    return cell;
}


- (YXMyInformationController *)myInformationController
{
    if (!_myInformationController) {
        _myInformationController = [[UIStoryboard storyboardWithName:@"MyInformation" bundle:nil] instantiateInitialViewController];
    }
    return _myInformationController;
}


#pragma mark  ******************* 网络请求**********************

#pragma mark - 加载网络数据

//** 加载基本资料 */
- (void)loadBaseData
{
    /*
     @brief 未登录的时候 不再频繁的请求person 接口了
     */
    
    if (![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus]) {
        
        self.currentLoginStatus= 0;
        
        [self ChangeCollectHearViewSubviewStatus:NO];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        return;
    }
    
    [[YXMyAccountNetRequestTool sharedTool] loadBaseDataWithSuccess:^(id objc, id respodHeader) {
        
        YXLog(@"--xingbie---%@",objc);
        
        if ([respodHeader[@"Status"] integerValue] == 1) {
            
            //** 字典转模型 */
            self.baseDataModel = [YXMyAccountBaseData mj_objectWithKeyValues:objc];

            [self ChangeCollectHearViewSubviewStatus:YES];

            [self SaveLoginData:self.baseDataModel];
            
        }else
        {
            [self ChangeCollectHearViewSubviewStatus:NO];
        }
        self.currentLoginStatus = [respodHeader[@"Status"] integerValue];
    

        if(![respodHeader[@"Status"] isEqualToString:@"1"])
        {
            //[YXUserDefaults removeObjectForKey:@"TokenID"];
            [[YXLoginStatusTool sharedLoginStatus] removeTokenId];
        }

        [self.collectview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

/**
 更新 collectVeiwHeaderView
 */
-(void)ChangeCollectHearViewSubviewStatus:(BOOL)LoginBool
{
    if (LoginBool) {
        
        self.header.namelable.text = self.baseDataModel.nickname;
        [self.header.xiangqingBtn setTitle:@"账户详情" forState:UIControlStateNormal];
        
    }else{
        self.header.iconimageview.image = [UIImage imageNamed:@"ic_default"];
        self.header.namelable.text = @"未登录";
        [self.header.xiangqingBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        self.baseDataModel = nil;
    }
   
    if ([self.baseDataModel.head isEqualToString:self.headericonurl]) {
        
        return;
    }
    
    NSString *iconstr = self.baseDataModel.head ;
    NSArray *arr = [iconstr componentsSeparatedByString:@"?"];
    if (arr.count>1) {
        NSString *str = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100",arr[0]];
        
        [self.header.iconimageview sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"ic_default"]];
        
    }else{
        if (iconstr.length) {
            NSString *str1 =[NSString stringWithFormat:@"ic_%@",self.baseDataModel.head];
            self.header.iconimageview.image = [UIImage imageNamed:str1];
            
        }else{
            
            self.header.iconimageview.image = [UIImage imageNamed:@"ic_default"];
        }
    }
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

-(void)PushLoginVC
{
    YXLoginViewController *loginVC = [[YXLoginViewController alloc]init];
    YXNavigationController *navi = [[YXNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navi animated:YES completion:nil];

}

-(void)ClickCellPushVC:(NSInteger)indexPath
{
    if (indexPath==0) // 我的鉴定
    {
        
        YXMySendAuctionHomeController *sendAuctionHomeController = [[YXMySendAuctionHomeController alloc] init];
        sendAuctionHomeController.index = 3001;
        [self.navigationController pushViewController:sendAuctionHomeController animated:YES];

    }else if (indexPath==1)//我的卖出
    {
        YXMySendAuctionHomeController *sendAuctionHomeController = [[YXMySendAuctionHomeController alloc] init];
        sendAuctionHomeController.index = 3003;
        [self.navigationController pushViewController:sendAuctionHomeController animated:YES];

    }else if (indexPath==2)//我的购买
    {
        YXMyOrderListViewController *myorderlistVC = [[YXMyOrderListViewController alloc]init];
        [self.navigationController pushViewController:myorderlistVC animated:YES];
        
    }else if (indexPath==3)//我的关注
    {
        YXMyAuctionHomeController*guanzhu = [[YXMyAuctionHomeController alloc]init];
        guanzhu.index = 2001;
        [self.navigationController pushViewController:guanzhu animated:YES];
        
    }else if (indexPath==4)//基本资料---》我的保证金
    {
//        YXMyAccountSureMoneyBaseViewController*suremoney = [[YXMyAccountSureMoneyBaseViewController alloc]init];
//        [self.navigationController pushViewController:suremoney animated:YES];

        self.myInformationController.accountBaseDataModel = self.baseDataModel;
        [self.navigationController pushViewController:self.myInformationController animated:YES];

    }else if (indexPath==5)//实名认证----》基本资料
    {

//        self.myInformationController.accountBaseDataModel = self.baseDataModel;
//        [self.navigationController pushViewController:self.myInformationController animated:YES];
        if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"2"]){
            
            YXMyAccountRealNameViewController * realnameVC = [[YXMyAccountRealNameViewController alloc]init];
            realnameVC.realnameStatus = @"REALNAME";
            [self.navigationController pushViewController:realnameVC animated:YES];
            
        }else{
            
            YXMyAccountRealNameViewController * realnameVC = [[YXMyAccountRealNameViewController alloc]init];
            //            realnameVC.realnameStatus = @"NOTREALNAME";
            [self.navigationController pushViewController:realnameVC animated:YES];
        }
        

        
    }else if (indexPath==6)//地址管理
    {
      [self.navigationController pushViewController: [[UIStoryboard storyboardWithName:@"myAddressList" bundle:nil] instantiateInitialViewController] animated:YES];
        
    }else if (indexPath==7)//提货人管理
    {
        YXPickUpPersonListViewController *vc =[[YXPickUpPersonListViewController alloc]init];
        vc.sourceController = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath==8)//绑定银行卡
    {
        [self bangdingYinhangka];
        
    }else if (indexPath==9)//登录密码
    {
          [self.navigationController pushViewController: [[UIStoryboard storyboardWithName:@"MyInformation" bundle:nil] instantiateViewControllerWithIdentifier:@"loginPwd"] animated:YES];

        
    }else if (indexPath==10)//支付密码
    {
        if ([[YXUserDefaults objectForKey:@"isPaymentCode"] integerValue] ==0) {
            
            YXMyAccountSetPaymengPasswordViewController *setpaymentpasswordVC = [[YXMyAccountSetPaymengPasswordViewController alloc]init];
            
            [self.navigationController pushViewController:setpaymentpasswordVC animated:YES];
            
        }else if ([[YXUserDefaults objectForKey:@"isPaymentCode"] integerValue] ==1)
        {
            YXMyAccountChangePaymentPasswordViewController *changepaymentpasswordVC = [[YXMyAccountChangePaymentPasswordViewController alloc]init];
            [self.navigationController pushViewController:changepaymentpasswordVC animated:YES];
        }

    }else if (indexPath==11)//第三方
    {
        YXMyAccountThridPartyViewController *myaccountThridpartyvc = [[YXMyAccountThridPartyViewController alloc]init];
        [self.navigationController pushViewController:myaccountThridpartyvc animated:YES];
//        if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"2"]){
//            
//            YXMyAccountRealNameViewController * realnameVC = [[YXMyAccountRealNameViewController alloc]init];
//            realnameVC.realnameStatus = @"REALNAME";
//            [self.navigationController pushViewController:realnameVC animated:YES];
//            
//        }else{
//            
//            YXMyAccountRealNameViewController * realnameVC = [[YXMyAccountRealNameViewController alloc]init];
//            //            realnameVC.realnameStatus = @"NOTREALNAME";
//            [self.navigationController pushViewController:realnameVC animated:YES];
//        }
//        
        
    }else if (indexPath==12)//帮助中心
    {
        YXHelpViewController *helpVC =[[YXHelpViewController alloc]init];
        helpVC.helpIndex = 0;
        [self.navigationController pushViewController:helpVC animated:YES];
    }else if (indexPath==13)//联系客服
    {
        [self showalearview];
        
    }else if (indexPath==14)//设置
    {
        YXMyAccountDeatilViewController *myaccountdeatilVC = [[YXMyAccountDeatilViewController alloc]init];
        
        [self.navigationController pushViewController:myaccountdeatilVC animated:YES];
    }

}

-(void)showalearview
{
    
    //创建AlertController对象 preferredStyle可以设置是AlertView样式或者ActionSheet样式
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:@"联系客服" preferredStyle:UIAlertControllerStyleActionSheet];
    //创建取消按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"在线客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pushKeFuVC];
        
    
        
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
    
    [self.collectview addSubview:callWebview];
    
}
-(void)bangdingYinhangka
{
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

/*
 @brief 跳转客服控制器
 */
-(void)pushKeFuVC
{
    [[YXChatViewManger sharedChatviewManger] LoadChatView];
    [[YXChatViewManger sharedChatviewManger] presentMQChatViewControllerInViewController:self];

    
}
-(void)dealloc
{
    [YXNotificationTool removeObserver:self name:@"FormeMycountThirdParyViewController" object:nil];
    
}
@end
