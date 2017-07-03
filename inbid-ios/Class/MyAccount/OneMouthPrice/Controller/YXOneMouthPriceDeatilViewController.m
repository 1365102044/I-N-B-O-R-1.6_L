//
//  YXOneMouthPriceDeatilViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/16.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOneMouthPriceDeatilViewController.h"
#import "YXOneMouthPriceDeatilBaseView.h"
#import "YXOneMouthPriceConfirmOrderViewController.h"
#import "YXHomeDeatilModle.h"
#import "YXTimeCountDownManger.h"
#import "YXNavigationController.h"
#import "YXLoginViewController.h"
#import "PBViewController.h"
#import "YXOnePriceDingjinBtn.h"
#import "YXGoodsDeatilRequestTool.h"
#import "YXAddStatusPictureView.h"
#import "YXOrderDetailViewController.h"
#import "YXLoginStatusTool.h"
#import "YXShareSDKManager.h"
#import "YXSaveLoginDataTool.h"
#import "YXProjectImageConfigManager.h"
@interface YXOneMouthPriceDeatilViewController ()<UITableViewDelegate,UITableViewDataSource, PBViewControllerDataSource, PBViewControllerDelegate>
@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,strong) YXOneMouthPriceDeatilBaseView * baseView;
@property(nonatomic,strong) UIButton * qianggou;
@property(nonatomic,strong) UIButton * guangzhu;
@property(nonatomic,strong) YXHomeDeatilModle * OneMouthPriceDeatilData;
/**
 轮播器图片url数组
 */
@property (nonatomic, strong) NSArray *imageUrlStringArray;
/*
 @brief 关注
 */
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;
@property(nonatomic,strong) YXOnePriceDingjinBtn * DingjinBtn;
@property(nonatomic,strong) YXAddStatusPictureView * AddStatusView;
@property(nonatomic,strong) UIView * boomview;

@property (nonatomic, copy) NSString *clickFuncName;

@property(nonatomic,strong) UIView * navigationBarView;

/**
 custom navigation titleLabel
 */
@property (nonatomic, strong) UILabel *navigationLabel;

/**
 custom navigation backButton
 */
@property (nonatomic, strong) UIButton *backButton;

/**
 custom navigation shareButton
 */
@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation YXOneMouthPriceDeatilViewController

-(YXAddStatusPictureView*)AddStatusView
{
    if (!_AddStatusView) {
        _AddStatusView = [[YXAddStatusPictureView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _AddStatusView.size = CGSizeMake(100, 100);
        _AddStatusView.centerX = self.baseView.adPictureCarouseView.centerX;
        _AddStatusView.centerY = self.baseView.adPictureCarouseView.centerY;
    }
    return _AddStatusView;
}

-(YXMyOrderSuccessAlerview*)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

-(UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, YXScreenH-46)];
        _tableview.rowHeight = 0;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _tableview.showsHorizontalScrollIndicator= NO;
        _tableview.showsVerticalScrollIndicator= NO;
    }
    return _tableview;
}

-(YXOneMouthPriceDeatilBaseView*)baseView
{
    if (!_baseView) {
        _baseView = [[YXOneMouthPriceDeatilBaseView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, YXScreenH)];
        
    }
    return _baseView;
}

/**
 社会化分享点击事件

 @param sender 社会化分享按钮
 */
- (void)shareButtonClick:(id)sender
{
    [[YXShareSDKManager sharedManager] shareGoodWithImageURLString:[self.OneMouthPriceDeatilData.prodImgs.firstObject imgUrl]
                                                      andGoodNamed:self.OneMouthPriceDeatilData.prodName
                                                     andGoodDetail:self.OneMouthPriceDeatilData.prodDetailContent
                                                         andProdId:self.OneMouthPriceDeatilData.prodId
                                                      andProdBidId:self.OneMouthPriceDeatilData.prodBidId
                                                 andViewController:self];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [kCountDownManager stopTime];
    [YXNetworkHUD dismiss];
    
    [self.navigationBarView removeFromSuperview];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 启动倒计时管理
//    [kCountDownManager start];
    
    for (UIView *subview in self.navigationController.navigationBar.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            if (subview.tag == 1001) {
                [subview removeFromSuperview];
            }
        }
    }
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden= YES;
    [self.view addSubview:self.tableview];
    [self requestOneMouthPriceData];
    
    [self.view addSubview:self.navigationBarView];
    [self.view bringSubviewToFront:self.navigationBarView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    self.title = @"商品详情";
    [self addtableview];
    
    [self setboomview];
    
    [self.baseView addSubview:self.AddStatusView];
    
    [YXNotificationTool addObserver:self selector:@selector(pictureCarousrClick:) name:@"goodDetailViewControllerPictureCarouselClick" object:nil];

    
    //** 社会化分享按钮 */
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClick:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    /**
     未登录的时候，点击抢购登录成功后，直接触发对应的方法；未登录的返回，不做操作
     */
    [YXNotificationTool addObserver:self selector:@selector(ClickfromeloginSel:) name:@"OnemouthPriceGoodsDeatilVcWithClickfromeloginSel" object:nil];
    
    /**
     未登录 记录probidid
     */
    if (![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus]) {
        
        [[YXSaveLoginDataTool shared] saveMyBrowsRecordWith:self.prodBidId];
    }
}

-(void)ClickfromeloginSel:(NSNotification *)noti{
    
    NSString *islogin = noti.userInfo[@"islogin"];
    
    if ([islogin isEqualToString:@"YES"]) {
        //2、将方法名转换为SEL
        SEL selector = NSSelectorFromString(self.clickFuncName);
        //3、通过消息，调用方法
        [self performSelectorOnMainThread:selector withObject:nil waitUntilDone:NO];
    }
    
}

/**
 接收到轮播器图片点击事件通知
 
 @param no no 通知参数
 */
- (void)pictureCarousrClick:(NSNotification *)no
{
    NSIndexPath *indexPath = no.userInfo[@"indexPath"];
    self.imageUrlStringArray = no.userInfo[@"imageUrlStringArray"];
    
    PBViewController *pbViewController = [PBViewController new];
    pbViewController.pb_dataSource = self;
    pbViewController.pb_delegate = self;
    pbViewController.pb_startPage = indexPath.row;
    [self presentViewController:pbViewController animated:YES completion:nil];
}

#pragma mark - PBViewControllerDataSource

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController {
    return self.imageUrlStringArray.count;
}

- (void)viewController:(PBViewController *)viewController presentImageView:(UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger, NSInteger))progressHandler {
    
    NSString *imageUrl = self.imageUrlStringArray[index];
    imageUrl = [NSString stringWithFormat:@"%@",[imageUrl componentsSeparatedByString:@"?"].firstObject];
    imageUrl = [YXProjectImageConfigManager projectImageConfigManagerWithImageUrlString:imageUrl configType:YXProjectImageConfigLarge];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString: imageUrl]
                 placeholderImage:nil
                        completed:^(UIImage * _Nullable image,
                                    NSError * _Nullable error,
                                    SDImageCacheType cacheType,
                                    NSURL * _Nullable imageURL) {
        
    }];
}

#pragma mark - PBViewControllerDelegate

- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(UIImage *)presentedImage {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)addtableview
{
    self.tableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestOneMouthPriceData)];
    
    __weak typeof(self)weakself  = self;
    self.baseView.heightBlock = ^(CGFloat height){
        
        weakself.baseView.height = height;
        weakself.tableview.tableHeaderView = weakself.baseView;
    };
}



#pragma mark  ***点击底部视图的btn的方法
-(void)clickDingjinBtn
{
    [self clickDingjinOrQianggou:1];
    
//    self.clickFuncName = [NSString stringWithFormat:@"%s",__FUNCTION__];
//    1、保存方法名
    self.clickFuncName = @"clickDingjinBtn";
}
/*
 @brief 点击立即购买
 */
-(void)clickGianggouBtn
{
    [self clickDingjinOrQianggou:2];
    self.clickFuncName = @"clickGianggouBtn";
}

/*
 @brief 点击关注
 */
-(void)clickGuanzhuBtn
{
    self.clickFuncName = @"clickGuanzhuBtn";
    
    if(![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus])
    {
        YXLoginViewController *longin = [[YXLoginViewController alloc]init];
        YXNavigationController *nav = [[YXNavigationController alloc]initWithRootViewController:longin];
        [self presentViewController:nav animated:YES completion:nil];
        
    }else{
        
        if ([self.guangzhu.titleLabel.text isEqualToString:@"关注"]) {
            
            [self attentionGoods];
            
        }else if([self.guangzhu.titleLabel.text isEqualToString:@"已关注"])
        {
            [self cancleAttentionGoods];
            
        }
    }

}
-(void)clickDingjinOrQianggou:(NSInteger)type
{

    if(![[YXLoginStatusTool sharedLoginStatus] GetCureentLoginStatus])
    {
        YXLoginViewController *longin = [[YXLoginViewController alloc]init];
        YXNavigationController *nav = [[YXNavigationController alloc]initWithRootViewController:longin];
        [self presentViewController:nav animated:YES completion:nil];
        
    }else{
        
        NSString *str = self.qianggou.titleLabel.text;
        if([str isEqualToString:@"已售罄"]){
            
            [YXAlearMnager  ShowAlearViewWith:@"商品已售罄" Type:4];
            return;
        }else if ([str isEqualToString:@"已下架"]){
            
            [YXAlearMnager ShowAlearViewWith:@"商品已下架" Type:4];
            return;
        }
            
        
        //已下过订单
        if([self.OneMouthPriceDeatilData.bidStatus integerValue] ==3){
            //** 1本人 继续支付 ， 2 不是本人*/
            if (self.OneMouthPriceDeatilData.continuePay == 1) {
                
                if (type == 1) {
                    
                    [[YXAlearViewTool sharedAlearview] ShowAlearViewWith:@"继续支付" Type:3];
                    
                }else{
                
                    [self dingjinORqianggouMother:type];
                }
                
            }else{
            
                [[YXAlearViewTool sharedAlearview] ShowAlearViewWith:@"商品付款中" Type:3];
                return;
            }
            
        }else{
        
            //**1 自营  0 个人**/
            if (self.OneMouthPriceDeatilData.isSelf == 1) {
                
                [self dingjinORqianggouMother:type];
                
            }else{
                
                [self CheckIsCanBugGoods:type];
                
            }
        
        }
        
    }
}
/**
 点击支付
 */
-(void)dingjinORqianggouMother:(NSInteger)type
{
    
    //已下过订单
    if([self.OneMouthPriceDeatilData.bidStatus integerValue] ==3)
    {
        YXOrderDetailViewController *OrderDeatilController = [YXOrderDetailViewController orderDetailViewControllerWithOrderId:[self.OneMouthPriceDeatilData.orderId longLongValue] andExtend:nil];
        [self.navigationController pushViewController:OrderDeatilController animated:YES];

    }else{
    
        //**  1定金 2支付 */
        YXOneMouthPriceConfirmOrderViewController *onemouthpriceVC = [[YXOneMouthPriceConfirmOrderViewController alloc]init];
        onemouthpriceVC.prodBidId = self.OneMouthPriceDeatilData.prodBidId;
        onemouthpriceVC.morenpaytype = type;
        onemouthpriceVC.iscandingjin = self.OneMouthPriceDeatilData.isAllowDepositPay;
        onemouthpriceVC.dingjinPrice = [self.OneMouthPriceDeatilData.depositPrice integerValue];
        [self.navigationController pushViewController:onemouthpriceVC animated:YES];
        
    }

}


/**
 请求后 更新 boom上btn的状态
 */
-(void)changeboomBtn
{
    //** 0 不能定金支付， 1 可以 */
    if (!self.OneMouthPriceDeatilData.isAllowDepositPay) {
        
        self.DingjinBtn.frame = CGRectMake(0, 0, 0, 0);
        self.DingjinBtn.hidden = YES;
        
        self.qianggou.frame = CGRectMake(self.guangzhu.width, 0, YXScreenW-self.guangzhu.width, 45);
        
    }else{
        
        self.DingjinBtn.hidden = NO;
        CGFloat DingbtnW = (YXScreenW-self.guangzhu.width)/2;
        CGFloat QiangBtnW = DingbtnW;
        if (YXScreenW<=320) {
            DingbtnW = 132;
            QiangBtnW = 110;
        }
        self.DingjinBtn.frame = CGRectMake(YXScreenW-DingbtnW-QiangBtnW, 0, DingbtnW, 45);
        self.qianggou.frame = CGRectMake(self.DingjinBtn.right,0 ,QiangBtnW, 45);
        self.guangzhu.width = YXScreenW-DingbtnW-QiangBtnW;
    
        self.DingjinBtn.titleText = self.OneMouthPriceDeatilData.depositPrice;
    
    }
    
    /*
     @brief 已售罄 拍卖状态,1:未开拍,2:拍卖中,3:中拍未支付；4:拍卖完成  5:流拍----   prodStatus 3 已下架
     */
            self.AddStatusView.hidden =    NO;
    if ([self.OneMouthPriceDeatilData.bidStatus integerValue] == 4 ) {
        
        [self.qianggou setTitle:@"已售罄" forState:UIControlStateNormal];
        self.AddStatusView.endstatus = @"已售罄";
        
    }else if([self.OneMouthPriceDeatilData.prodStatus integerValue] ==3 || [self.OneMouthPriceDeatilData.bidStatus integerValue] == 5){
        
        [self.qianggou setTitle:@"已下架" forState:UIControlStateNormal];
        self.AddStatusView.endstatus = @"已下架";
        
    }else if([self.OneMouthPriceDeatilData.bidStatus integerValue] ==3) //已下过订单
    {
        //** 1本人 继续支付 ， 2 不是本人*/
        if (self.OneMouthPriceDeatilData.continuePay == 1) {
        
            [self.qianggou setTitle:@"继续支付" forState:UIControlStateNormal];
            
        }else{
        
            [self.qianggou setTitle:@"已被抢走" forState:UIControlStateNormal];
        }
        self.AddStatusView.endstatus = @"付款中";
        
    }else{
            [self.qianggou setTitle:@"立即购买" forState:UIControlStateNormal];
            self.AddStatusView.hidden = YES;
    }
    
    if (self.OneMouthPriceDeatilData.isCollect == 1) {
        
        [self.guangzhu setTitle:@"已关注" forState:UIControlStateNormal];
        [self.guangzhu setImage:[UIImage imageNamed:@"onemouthpriceguanzhu"] forState:UIControlStateNormal];
    }else{
        
        [self.guangzhu setTitle:@"关注" forState:UIControlStateNormal];
        [self.guangzhu setImage:[UIImage imageNamed:@"onemouthpriceweiguanzhu"] forState:UIControlStateNormal];
    }

}

#pragma mark  ******************* tableview代理 **********************

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ******************* 网络请求**********************
/**
 * @param  prodId 商品编号 必填
	* @param  prodBidId 商品拍卖编号 必填
 */
-(void)requestOneMouthPriceData
{
    
    [[YXGoodsDeatilRequestTool sharedTool] LoadDeatilDataWithProBidId:self.prodBidId ProId:self.prodId Success:^(id objc, id respodHeader) {
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            [self IsNeedHiddenSubviewWith:NO];
            
            self.tableview.tableHeaderView = self.baseView;
            
//            YXLog(@"+++%@++",objc);
            
            self.OneMouthPriceDeatilData = [YXHomeDeatilModle mj_objectWithKeyValues:objc];
            self.baseView.OneMouthPriceDeatilData = self.OneMouthPriceDeatilData;
            [self changeboomBtn];
            
        }else{
        
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
            
            [self IsNeedHiddenSubviewWith:YES];
        }
        [self.tableview.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        
        [self IsNeedHiddenSubviewWith:YES];
        [self.tableview.mj_header endRefreshing];

    }];
    
}

-(void)IsNeedHiddenSubviewWith:(BOOL)bools
{
    self.tableview.tableHeaderView.hidden = bools;
    self.boomview.hidden = bools;
    self.qianggou.enabled = !bools;
}


#pragma mark  ******************* 关注 和 取消关注**********************
/*
 @brief 关注
 */
-(void)attentionGoods
{
    [[YXGoodsDeatilRequestTool sharedTool] AttenOrCancleAttentWithProId:self.OneMouthPriceDeatilData.prodId type:1 Success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            [YXAlearMnager ShowAlearViewWith:@"关注成功" Type:1];
            [self.guangzhu setTitle:@"已关注" forState:UIControlStateNormal];
            [self.guangzhu setImage:[UIImage imageNamed:@"onemouthpriceguanzhu"] forState:UIControlStateNormal];
            
        }else if([respodHeader[@"Status"] isEqualToString:@"3"]||[respodHeader[@"Status"] isEqualToString:@"6"])
        {
            self.tabBarController.hidesBottomBarWhenPushed = YES;
            YXLoginViewController *longin = [[YXLoginViewController alloc]init];
            YXNavigationController *nav = [[YXNavigationController alloc]initWithRootViewController:longin];
            [self presentViewController:nav animated:YES completion:nil];
        }
    
    } failure:^(NSError *error) {
        
    }];
    
}
/*
 @brief  取消关注
 */
-(void)cancleAttentionGoods
{
    
    [[YXGoodsDeatilRequestTool sharedTool] AttenOrCancleAttentWithProId:self.OneMouthPriceDeatilData.prodId type:2 Success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            [YXAlearMnager ShowAlearViewWith:@"取消关注成功" Type:1];
            [self.guangzhu setTitle:@"关注" forState:UIControlStateNormal];
            [self.guangzhu setImage:[UIImage imageNamed:@"onemouthpriceweiguanzhu"] forState:UIControlStateNormal];
            
        }else if([respodHeader[@"Status"] isEqualToString:@"3"]||[respodHeader[@"Status"] isEqualToString:@"6"])
        {
            self.tabBarController.hidesBottomBarWhenPushed = YES;
            YXLoginViewController *longin = [[YXLoginViewController alloc]init];
            YXNavigationController *nav = [[YXNavigationController alloc]initWithRootViewController:longin];
            [self presentViewController:nav animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
    
    }];
    
}

#pragma mark  *** 检查是否 是本人上传的商品，本人的商品不能购买
-(void)CheckIsCanBugGoods:(NSInteger)type
{
    [[YXGoodsDeatilRequestTool sharedTool] CheckIsSelfGoodsWithProBidId:self.OneMouthPriceDeatilData.prodBidId Success:^(id objc, id respodHeader) {
//        YXLog(@"--ceshi-%@",objc);
        //**1 可以购买  0 不能购买**/
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            if ([objc[@"success"] integerValue] == 1) {
                
                [self dingjinORqianggouMother:type];
                
            }else{
                
                [[YXAlearViewTool sharedAlearview] ShowAlearViewWith:@"不能购买自己的商品" Type:2];
            }
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}
-(void)setboomview
{
    UIView *boomview = [[UIView alloc]initWithFrame:CGRectMake(0, YXScreenH-45, YXScreenW, 45)];
    boomview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:boomview];
    self.boomview = boomview;
    self.boomview.hidden = YES;
    
    UIButton *guangzhu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, boomview.height)];
    [guangzhu setTitle:@"关注" forState:UIControlStateNormal];
    [guangzhu setTitleColor:UIColorFromRGB(0x535353) forState:UIControlStateNormal];
    [guangzhu setImage:[UIImage imageNamed:@"onemouthpriceweiguanzhu"] forState:UIControlStateNormal];
    [guangzhu addTarget:self action:@selector(clickGuanzhuBtn) forControlEvents:UIControlEventTouchUpInside];
    guangzhu.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    guangzhu.titleLabel.font = YXSFont(15);
    self.guangzhu = guangzhu;
    guangzhu.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    guangzhu.layer.borderWidth = 0.5;
    [boomview addSubview:guangzhu];
    
    
    CGFloat btnW = (YXScreenW-guangzhu.width)/2;

    YXOnePriceDingjinBtn *dingjinbtn = [[YXOnePriceDingjinBtn alloc]initWithFrame:CGRectMake(guangzhu.right, 0, btnW, boomview.height)];
    [dingjinbtn addTarget:self action:@selector(clickDingjinBtn) forControlEvents:UIControlEventTouchUpInside];
//    dingjinbtn.titleText = @"200000";
    dingjinbtn.descText = @"余款可在48小时内支付";
    dingjinbtn.backgroundColor = UIColorFromRGB(0xa90311);
    [boomview addSubview:dingjinbtn];

    self.DingjinBtn = dingjinbtn;
    self.DingjinBtn.hidden = YES;
    
    
    UIButton *qianggou = [[UIButton alloc]initWithFrame:CGRectMake(guangzhu.right, 0, YXScreenW-guangzhu.width, boomview.height)];
    [qianggou setTitle:@"立即购买" forState:UIControlStateNormal];
    [qianggou addTarget:self action:@selector(clickGianggouBtn) forControlEvents:UIControlEventTouchUpInside];
    [qianggou setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qianggou.titleLabel.font = YXSFont(15);
    self.qianggou = qianggou;
    qianggou.backgroundColor = [UIColor mainThemColor];
    [boomview addSubview:qianggou];
    
}

-(void)dealloc{
    /**
     登录完成后，操作
     */
    [YXNotificationTool removeObserver:self name:@"OnemouthPriceGoodsDeatilVcWithClickfromeloginSel" object:nil];
}


/**
  滚动代理
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollerY = scrollView.contentOffset.y;
    if (scrollerY <= 64) {
        self.navigationBarView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:scrollerY/64];
        self.navigationLabel.alpha = scrollerY/64;
        if (scrollerY <= 0) {
            self.shareButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
            self.backButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
        }else{
            self.backButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:scrollerY/64];
            self.shareButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:scrollerY/64];
        }
    }else {
        self.navigationBarView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
        self.navigationLabel.alpha = 1;
    }
}

-(UIView *)navigationBarView{
    if (!_navigationBarView) {
        _navigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 64)];
        _navigationBarView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0];
        
        UILabel *navigationTitle = [[UILabel alloc]initWithFrame:CGRectMake((YXScreenW-100)/2, 20, 100, 44)];
        navigationTitle.text = @"商品详情";
        navigationTitle.textColor = [UIColor mainThemColor];
        navigationTitle.textAlignment = NSTextAlignmentCenter;
        navigationTitle.alpha = 0;
        self.navigationLabel = navigationTitle;
        [_navigationBarView addSubview:navigationTitle];
        
        UIButton *backitemt = [[UIButton alloc]initWithFrame:CGRectMake(4, 20, 44, 44)];
        [backitemt setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
        [backitemt addTarget:self action:@selector(clickbackitemt) forControlEvents:UIControlEventTouchUpInside];
        backitemt.layer.cornerRadius = 22;
        backitemt.layer.masksToBounds = YES;
        backitemt.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
        self.backButton = backitemt;
        [_navigationBarView addSubview:backitemt];
        
        UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(YXScreenW-4-44, 20, 44, 44)];
        [shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [shareButton setImage:[UIImage imageNamed:@"ic_share"] forState:UIControlStateNormal];
        shareButton.layer.cornerRadius = 22;
        shareButton.layer.masksToBounds = YES;
        shareButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
        self.shareButton = shareButton;
        [_navigationBarView addSubview:shareButton];
      }
    return _navigationBarView;
}
-(void)clickbackitemt{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
