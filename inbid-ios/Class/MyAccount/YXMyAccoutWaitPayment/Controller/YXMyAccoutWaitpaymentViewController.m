//
//  YXMyAccoutWaitpaymentViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccoutWaitpaymentViewController.h"
#import "YXMyAccoutWaitPaymentBaseview.h"

#import "YXMyAccountGOPaymentConfirmAddressViewController.h"
#import "YXMyAddressListController.h"

#import "YXPayMarginPriceSuccessView.h"
#import "YXGoPayMentPushingView.h"
#import "YXHelpViewController.h"
#import "YXFenBiPaymentingView.h"

#import "YXHomeAuctionDeatilViewCotroller.h"

#import "MQChatViewManager.h"

#import "YXPayZBarViewController.h"


#import "YXZBarPaySuccessOrFailResultViewController.h"

#import "YXMyAccoutWaitPayModle.h"



@interface YXMyAccoutWaitpaymentViewController ()<UIScrollViewDelegate,addMarginPriceSuccessViewDelegate,payPushingViewDelegate>
@property(nonatomic,strong) UIScrollView * scrollerview;
@property(nonatomic,strong) YXMyAccoutWaitPaymentBaseview * waitpaymentbaseview;

/*
 @brief 支付保证金成功view
 */
@property(nonatomic,strong) YXPayMarginPriceSuccessView * paymarginPriceSuccessView;
/*
 @brief 支付跳转中
 */
@property(nonatomic,strong) YXGoPayMentPushingView * gopayPushingView;

/*
 @brief 分笔支付跳转中
 */
@property(nonatomic,strong) YXFenBiPaymentingView * fenbipaymentingView;




@property(nonatomic,assign) NSInteger  textfieldstr;

/*
 @brief 1全额   2分笔
 */
@property(nonatomic,strong) NSString * choosepaytype;

@property(nonatomic,strong) NSString * develyType;
@property(nonatomic,strong) UIButton * boombtn;

/*
 @brief 最小支付金额   保证金的时候，（支付过：剩余的金额大于2000 允许分笔支付，但是不得低于2000； 没有支付过：保证金小于2000的需全部支付，不得分笔支付；  ）
 */
@property(nonatomic,assign) NSInteger  MinPaymentPirce;

@property(nonatomic,assign) NSInteger  shengyuprice;


/*
 @brief 去付款页面 的数据模型
 */
@property(nonatomic,strong) YXMyAccoutWaitPayModle * DingdanDataModle;



@property(strong,nonatomic) NSString *ShouldPricestr;
@property(nonatomic,strong) NSString * AlearlyPricestr;


@end

@implementation YXMyAccoutWaitpaymentViewController


-(UIScrollView*)scrollerview
{
    if (!_scrollerview) {
        _scrollerview = [[UIScrollView alloc]init];
        _scrollerview.delegate= self;
        _scrollerview.frame = CGRectMake(0,0, YXScreenW, YXScreenH);
        _scrollerview.contentSize =CGSizeMake(YXScreenW, YXScreenH);
        
    }
    
    return _scrollerview;
}

-(YXMyAccoutWaitPaymentBaseview*)waitpaymentbaseview
{
    if (!_waitpaymentbaseview) {
        _waitpaymentbaseview = [[YXMyAccoutWaitPaymentBaseview alloc]init];
        _waitpaymentbaseview.frame = self.view.bounds;
        _waitpaymentbaseview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        
    }
    return _waitpaymentbaseview;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    self.waitpaymentbaseview.isPartPay = self.isPartPay;
    
    if(self.fomreVC!=1){
        
        [self requestwaitpaymentdata];
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    self.navigationItem.title = @"待付款";
    
    UIImage *image = [UIImage imageNamed:@"ic_returnGood_message"];
    // 取消渲染
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(ClickrightItem)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setUI];
    

    if (self.isPartPay!=1) {
        
        self.choosepaytype = @"1";
    }
    
    
    
    /*
     @brief 扫码支付完成后，如果是分笔支付后，到这个页面 刷新该页面到价钱
     */
    [YXNotificationTool addObserver:self selector:@selector(RefreshPrice:) name:@"POSTPAYDICT" object:nil];
    
    /*
     @brief 选择 微信 支付宝 银联
     */
    [YXNotificationTool addObserver:self selector:@selector(changePayType:) name:@"CHOOSEPAYTYPE" object:nil];
    /*
     @brief 选择 分笔 全额支付
     */
    [YXNotificationTool addObserver:self selector:@selector(choosePayType:) name:@"PAYTYPETAG" object:nil];
    /*
     @brief 自提  物流
     */
    [YXNotificationTool addObserver:self selector:@selector(develyType:) name:@"develyType" object:nil];
    if (self.fomreVC==1) {
        
//        self.waitpaymentbaseview.dict = self.dict;
        self.waitpaymentbaseview.NoPayMarginPriceOrderModle = self.NoPayMarginPriceOrderModle;
        
//        self.shengyuprice = [self jisuanMINshengyumoneyCount:self.dict];
        self.OrderID = self.NoPayMarginPriceOrderModle.NopaymentId ;
    }
    
}
/*
 @brief 点击右item
 */
-(void)ClickrightItem
{
    [self pushKeFuVC];
}
#pragma mark  ******************* 通知方法**********************


-(void)changePayType:(NSNotification*)noti
{
    NSString *paytype = noti.userInfo[@"paytypetag"];
    
    YXLog(@"--选择了微信 支付宝 银联－－－-%@-",paytype);
    
    if ([paytype isEqualToString:@"3"]) {
        
        [self.boombtn setTitle:@"扫码支付" forState:UIControlStateNormal];
    }else
    {
        if ([self.choosepaytype isEqualToString:@"1"]) {
            [self.boombtn setTitle:@"全额支付" forState:UIControlStateNormal];
        }else if ([self.choosepaytype isEqualToString:@"2"])
        {
            [self.boombtn setTitle:@"分笔支付" forState:UIControlStateNormal];
        }else{
            
            [self.boombtn setTitle:@"确认提交" forState:UIControlStateNormal];
        }
        
    }
    
}

-(void)choosePayType:(NSNotification*)noti
{
    self.choosepaytype = noti.userInfo[@"SELECTINDEX"];
    YXLog(@"--self.choosepaytype---%@",self.choosepaytype);
    
    if ([self.boombtn.titleLabel.text isEqualToString:@"扫码支付"]) {
        return;
    }
    if ([self.choosepaytype isEqualToString:@"1"]) {
        [self.boombtn setTitle:@"全额支付" forState:UIControlStateNormal];
    }else if ([self.choosepaytype isEqualToString:@"2"])
    {
        [self.boombtn setTitle:@"分笔支付" forState:UIControlStateNormal];
    }
}

-(void)develyType:(NSNotification*)noti
{
    self.develyType = noti.userInfo[@"tag"];
//    YXLog(@"--self.develyType---%@",self.develyType);
    
}
/*
 @brief 刷新页面的价额 数据
 */
-(void)RefreshPrice:(NSNotification*)noti
{
    self.isPartPay =1;

    
//    [self.dict setValue:noti.userInfo[@"alreadyPay"] forKey:@"alreadyPayAmount"];

    
//    self.ShouldPricestr = noti.userInfo[@"shouldAmt"];
    
}
-(void)setUI{
    
    [self.view addSubview:self.scrollerview];
    [self.scrollerview addSubview:self.waitpaymentbaseview];
    
    self.waitpaymentbaseview.fomreVC = self.fomreVC;
    
    
    __weak typeof(self)weakself = self;
    
    self.waitpaymentbaseview.baseviewheightblock = ^(CGFloat basehight){
        
        weakself.waitpaymentbaseview.height = basehight;
        weakself.boombtn.y = basehight+10;
        if (basehight>YXScreenH) {
            
            weakself.scrollerview.contentSize = CGSizeMake(YXScreenW, basehight);
        }
    };
    
    self.waitpaymentbaseview.textfieldSatusblock =^(NSInteger EditingStatus,NSInteger paycount){
        
        weakself.textfieldstr = paycount;
        
        YXLog(@"--weakself.textfieldstr---%ld",(long)weakself.textfieldstr);
        
        if (EditingStatus == 1) {
            
            
            [UIView animateWithDuration:0.25 animations:^{
                CGFloat moveheight  ;
                
                if (YXScreenH <=568) {
                    moveheight = 30;
                }else if (YXScreenH > 568)
                {
                    moveheight=20;
                }
                weakself.scrollerview.y = weakself.scrollerview.y-moveheight;
                
            }];
            
        }else if (EditingStatus ==2)
        {
            [UIView animateWithDuration:0.25 animations:^{
                CGFloat moveheight  ;
                
                if (YXScreenH <=568) {
                    moveheight = 30;
                }else if (YXScreenH > 568)
                {
                    moveheight=20;
                }
                weakself.scrollerview.y = weakself.scrollerview.y+moveheight;
            }];
            
        }
    };
    
    [self setBoombtn];
    
    
}

-(void)setBoombtn
{
    
    CGFloat BtnW ;
    if (YXScreenW<=320) {
        BtnW = 230;
    }else if (YXScreenW==375)
    {
        BtnW = 260;
    }else if (YXScreenW>=414)
    {
        BtnW= 290;
    }
    
    UIButton *boombtn = [[UIButton alloc]initWithFrame:CGRectMake((YXScreenW-BtnW)/2, YXScreenH-44,BtnW, 44)];
    [boombtn setTitle:@"扫码支付" forState:UIControlStateNormal];
    [boombtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    boombtn.backgroundColor=[UIColor mainThemColor];
    boombtn.titleLabel.font = YXRegularfont(17);
    [boombtn addTarget:self action:@selector(cliclkBoomBtn) forControlEvents:UIControlEventTouchUpInside];
    boombtn.layer.masksToBounds = YES;
    boombtn.layer.cornerRadius = 10;
    self.boombtn = boombtn;
    [self.scrollerview addSubview:boombtn];
    
}

/*
 https://inborn.com/pay/loginAuth?clientId=61df4e90a8c62014afb44ba2a44206279ac1609496a0bf2ed969867b14c0e5c3b725c5ee81501b8af6c50046dbcb04dd
 */
#pragma mark  ******************* 点击提交**********************
-(void)cliclkBoomBtn
{
    
    /*
     @brief 扫码支付
     */
    if ([self.boombtn.titleLabel.text isEqualToString:@"扫码支付"]) {
        
        [self PushZBarPaymentVC];
        
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyAccoutPayMentTextfieldEndEditing" object:nil];
    
    if (self.MinPaymentPirce>=200000) {
        
        
        if ([self.self.choosepaytype isEqualToString:@"1"]) {
            
        }else{
            
            if(self.textfieldstr*100 < self.MinPaymentPirce)
            {
                [YXNotificationTool postNotificationName:@"moneycounttishiyu" object:self userInfo:@{@"dayuORxiaoyu":@"1"}];
                
                
            }else if (self.textfieldstr*100 > self.shengyuprice)
            {
                [YXNotificationTool postNotificationName:@"moneycounttishiyu" object:self userInfo:@{@"dayuORxiaoyu":@"2"}];
                //               return;
            }
        }
    }
    
    
    
    if (self.fomreVC==1) {
        
        [self addMarginPriceSuccessView];
        
        if ([self.choosepaytype isEqualToString:@"1"]) {
            
            YXLog(@"-保证金－全额支付－－－-应支付的金额数量---%ld",(long)self.shengyuprice);
            
        }else{
            
            if (self.shengyuprice <= self.MinPaymentPirce) {
                
                YXLog(@"-保证金－－分笔－－-应支付的金额数量---%ld",(long)self.shengyuprice);
            }else{
                
                YXLog(@"-保证金-－－分笔－－-应支付的金额数量---%ld",(long)self.textfieldstr);
            }
            
        }
        
        
    }else{
        
        //        分笔
        if(self.isPartPay == 1 || [self.choosepaytype isEqualToString:@"2"])
        {
            [self addFenbiPaymentingView];
            
            if (self.shengyuprice <= self.MinPaymentPirce) {
                
                YXLog(@"-订单－分笔－－-应支付的金额数量---%ld",(long)self.shengyuprice);
            }else{
                
                YXLog(@"-订单－分笔－－－-应支付的金额数量---%ld",(long)self.textfieldstr);
            }
            
            
        }else if([self.choosepaytype isEqualToString:@"1"])  //全额支付
        {
            [self addGopayPushing];
            YXLog(@"-订单----全额支付－－－%ld",(long)self.shengyuprice);
        }
        else{
            //            [self addGopayPushing];
        }
    }
}


#pragma mark  ******************* 跳到 扫码 界面**********************
-(void)PushZBarPaymentVC
{
    YXPayZBarViewController *reader = [YXPayZBarViewController new];
    reader.formePCPayurlBlock = ^(NSString *url){
        
        YXLog(@"======扫码结果====++===%@===",url);
        
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
        
    };
    [self.navigationController pushViewController:reader animated:YES];
    
}

#pragma mark  ******************* 扫码支付 发送请求**********************
-(void)requeatPayZBar:(NSString *)url clientID:(NSString *)clientID
{
    // fomreVC  判读是否 是保证金  1 保证金支付   2其他的是订单支付    3鉴定订单
    //**type (1鉴定订单，2拍卖订单，3保证金)**/
    NSInteger type;
    
    NSString *userID = [YXUserDefaults objectForKey:@"TokenID"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.fomreVC==1) {
        type = 3;
    }else if (self.fomreVC==3)
    {
        type  = 1;
    }else if (self.fomreVC==4)
    {
        type = 4;
    }
    else
    {
        type = 2;
    }
    
    
    param[@"orderType"] = [NSString stringWithFormat:@"%ld",(long)type];
    
    if (self.orderId) {
        
        param[@"orderId"] = [NSString stringWithFormat:@"%@",self.orderId];
    }
    
    param[@"clientId"] = clientID;
    param[@"id"] = userID;
    
    [YXRequestTool requestDataWithType:POST url:url params:param success:^(id objc, id respodHeader) {
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            YXLog(@"--扫码结果---%@======",objc);
            if ([objc isEqualToString:@"登录成功"]) {
                
                
                NSString *allPricestr;
                NSString *orderIDstr;
                NSString *goodsNamestr;
                if (self.fomreVC==1) {
                    
                    NSInteger should = self.NoPayMarginPriceOrderModle.marginPrice - self.NoPayMarginPriceOrderModle.alreadyPayAmount;
                    self.ShouldPricestr = [NSString stringWithFormat:@"%ld",(long)should];
                    
                    self.AlearlyPricestr = [NSString stringWithFormat:@"%ld",(long)self.NoPayMarginPriceOrderModle.alreadyPayAmount];
                    
                    allPricestr = [NSString stringWithFormat:@"%ld",(long)self.NoPayMarginPriceOrderModle.marginPrice];
                    
                    orderIDstr = [NSString stringWithFormat:@"%lld",self.NoPayMarginPriceOrderModle.NopaymentId];
                    
                    goodsNamestr = self.NoPayMarginPriceOrderModle.prodName;
                    
                }else
                {

                  self.ShouldPricestr =   [NSString stringWithFormat:@"%ld",([self.DingdanDataModle.orderPayAmount integerValue] - [self.DingdanDataModle.alreadyPayAmount integerValue]) ];
                    
                    self.AlearlyPricestr = self.DingdanDataModle.alreadyPayAmount;
                    
                     allPricestr = self.DingdanDataModle.orderPayAmount;
                    
                    orderIDstr = self.DingdanDataModle.orderID;
                    
                    goodsNamestr = self.DingdanDataModle.prodName;
                    
                }
                
                NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
                dataDict[@"type"] = [NSString stringWithFormat:@"%ld",(long)type];
                dataDict[@"OrderID"] = orderIDstr;
                dataDict[@"goodsName"] = goodsNamestr;
                dataDict[@"AllPrice"] = allPricestr;
                dataDict[@"AlearlyPrice"] = self.AlearlyPricestr;
                dataDict[@"ShouldPrice"] =self.ShouldPricestr;
                dataDict[@"isPartPay"] = [NSString stringWithFormat:@"%ld",(long)self.isPartPay];
                
                YXZBarPaySuccessOrFailResultViewController *zbarpayResultVC = [[YXZBarPaySuccessOrFailResultViewController alloc]init];
                zbarpayResultVC.dataDict = dataDict;
                [self.navigationController pushViewController:zbarpayResultVC animated:YES];
                
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyAccoutPayMentTextfieldEndEditing" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyAccoutPayMentTextfieldEndEditing" object:nil];
}



#pragma mark  ******************* 粉笔支付 回调的view  带倒计时的view**********************

-(void)addFenbiPaymentingView
{
    __weak typeof(self)weakself = self;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.fenbipaymentingView];
    self.fenbipaymentingView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    self.fenbipaymentingView.frame = self.view.bounds;
    self.fenbipaymentingView.dismissviewblock = ^(){
        
        [weakself.fenbipaymentingView removeFromSuperview];
        weakself.fenbipaymentingView = nil;
    };
    
    /*
     @brief view定时消失
     */
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //        [weakself.fenbipaymentingView removeFromSuperview];
    //        weakself.fenbipaymentingView = nil;
    //
    //    });
    
}




#pragma mark  ******************* 保证金支付成功弹出视图**********************

-(void)addMarginPriceSuccessView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.paymarginPriceSuccessView];
    self.paymarginPriceSuccessView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    self.paymarginPriceSuccessView.frame = self.view.bounds;
    __weak typeof(self)weakself = self;
    self.paymarginPriceSuccessView.pushhelpblock = ^(){
        
        [weakself.paymarginPriceSuccessView removeFromSuperview];
        weakself.paymarginPriceSuccessView = nil;
        
        YXHelpViewController *helpvc =[[YXHelpViewController alloc]init];
        [weakself.navigationController pushViewController:helpvc animated:YES];
    };
    
    
    self.paymarginPriceSuccessView.gotojingpaiblock = ^(NSInteger probidId){
        
        
        [weakself.paymarginPriceSuccessView removeFromSuperview];
        weakself.paymarginPriceSuccessView = nil;
        
        /*
         @brief 参与竞拍  跳回商品详情
         */
        //        YXHomeAuctionDeatilViewCotroller *deatilVC = [[YXHomeAuctionDeatilViewCotroller alloc]init];
        //
        //        deatilVC.ProBidId = weakself.ProBidId;
        //
        //        [weakself.navigationController pushViewController:deatilVC animated:YES];
        
        [weakself.navigationController popViewControllerAnimated:YES];
        
        
    };
    
}

/*
 @brief 保证金支付成功 view delegate方法
 */
-(void)addmarginpriceSuccessViewDelegate:(YXPayMarginPriceSuccessView *)myAuctionPostBoundsView cancelButtonClick:(UIButton *)sender
{
    [self.paymarginPriceSuccessView removeFromSuperview];
    self.paymarginPriceSuccessView = nil;
}


#pragma mark  ******************* 支付跳转中。。。**********************

-(void)addGopayPushing{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.gopayPushingView];
    self.gopayPushingView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    self.gopayPushingView.frame = self.view.bounds;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.gopayPushingView removeFromSuperview];
        self.gopayPushingView = nil;
        
    });
    
    
}

-(void)payPushingViewDelegate:(YXGoPayMentPushingView *)myAuctionPostBoundsView cancelButtonClick:(UIButton *)sender
{
    [self.gopayPushingView removeFromSuperview];
    self.gopayPushingView = nil;
}



#pragma mark  ******************* 网络请求**********************

-(void)requestwaitpaymentdata
{
    NSMutableDictionary *param =[NSMutableDictionary dictionary];
    param[@"orderId"] = self.orderId;
    [YXRequestTool requestDataWithType:POST url:@"/api/order/payInfo" params:param success:^(id objc, id respodHeader) {
        
        if([respodHeader[@"Status"] isEqualToString:@"1"])
        {
            
            self.DingdanDataModle = [YXMyAccoutWaitPayModle mj_objectWithKeyValues:objc];
            
            self.waitpaymentbaseview.DingdanDataModle = self.DingdanDataModle;
         
            
            self.dict = objc;
            
            YXLog(@"=====daifukuan=====%@=",objc);
            

            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark  ******************* 当剩余金额<2000¥的时候，计算支付的最小值金额 **********************
//-(NSInteger)jisuanMINshengyumoneyCount:(NSDictionary*)dict
//{
//    NSString *pricestr = dict[@"alreadyPayAmount"];
//    NSString *allpricestr = dict[@"orderPayAmount"];
//    
//    NSInteger alearyprice = [pricestr integerValue];
//    NSInteger allprice = [allpricestr integerValue];
//    
//    NSInteger shengyuprice = allprice - alearyprice;
//    if (shengyuprice<200000) {
//        self.MinPaymentPirce = shengyuprice;
//    }else{
//        self.MinPaymentPirce = 200000;//分 为单位
//    }
//    return shengyuprice;
//}

#pragma mark  ******************* 懒加载**********************
/*
 @brief 分笔支付跳转中
 */
-(YXFenBiPaymentingView*)fenbipaymentingView
{
    if (!_fenbipaymentingView) {
        _fenbipaymentingView = [[YXFenBiPaymentingView alloc]init];
        //        _fenbipaymentingView.cancledelegate = self;
    }
    return _fenbipaymentingView;
}
/*
 @brief 支付保证金成功view
 */
-(YXPayMarginPriceSuccessView*)paymarginPriceSuccessView
{
    if (!_paymarginPriceSuccessView) {
        _paymarginPriceSuccessView = [[YXPayMarginPriceSuccessView alloc]init];
        _paymarginPriceSuccessView.cancledelegate = self;
    }
    return _paymarginPriceSuccessView;
}
/*
 @brief 支付跳转中
 */
-(YXGoPayMentPushingView*)gopayPushingView
{
    if (!_gopayPushingView) {
        _gopayPushingView = [[YXGoPayMentPushingView alloc]init];
        _gopayPushingView.cancledelegate = self;
    }
    return _gopayPushingView;
}


/*
 @brief 跳转客服控制器
 */
-(void)pushKeFuVC
{
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc]init];
    /*
     @brief 显示在pc端的用户昵称
     */
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"name"] = [YXUserDefaults objectForKey:@"nickname"];
    [chatViewManager setClientInfo:param override:YES];
    
    
    //    //**顾客头像**/
    NSString *sexstr = [YXUserDefaults objectForKey:@"head"];
    UIImage *avatar;
    NSArray *arr = [sexstr componentsSeparatedByString:@"?"];
    if (arr.count>1) {
        NSData *headimagedata = [YXUserDefaults objectForKey:@"headimagedata"];
        avatar = [UIImage imageWithData:headimagedata];
    }else{
        
        avatar = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@",sexstr]];
    }
    
    MQChatViewStyle *chatViewStyle = [chatViewManager chatViewStyle];
    
    //    设置发送过来的message的文字颜色；
    [chatViewStyle setIncomingMsgTextColor:UIColorFromRGB(0x050505)];
    //    设置发送过来的message气泡颜色
    [chatViewStyle setIncomingBubbleColor:[UIColor whiteColor]];
    //    设置发送出去的message的文字颜色；
    [chatViewStyle setOutgoingMsgTextColor:UIColorFromRGB(0x050505)];
    //    设置发送的message气泡颜色
    [chatViewStyle setOutgoingBubbleColor:UIColorFromRGB(0xb0e46e)];
    //    是否开启圆形头像；默认不支持
    [chatViewStyle setEnableRoundAvatar:true];
    //    设置顾客的头像图片；
    [chatViewManager setoutgoingDefaultAvatarImage:avatar];
    //     设置客服的名字
    [chatViewManager setAgentName:@"Angle"];
    
    chatViewStyle.navBackButtonImage = [UIImage imageNamed:@"icon_fanhui"];
    chatViewManager.chatViewStyle.navBarTintColor = UIColorFromRGB(0x050505);
    
    [chatViewManager setMessageLinkRegex:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|([a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
    [chatViewManager enableMessageSound:true];
    [chatViewManager setNavTitleText:@"胤宝客服"];
    //开启同步消息
    [chatViewManager enableSyncServerMessage:true];
    [chatViewManager pushMQChatViewControllerInViewController:self];
    
    
}


-(void)dealloc
{
    [YXNotificationTool removeObserver:self];
}
@end
