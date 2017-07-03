//
//  YXMySureMoneyNopayMentDeatilViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySureMoneyNopayMentDeatilViewController.h"
#import "YXMySureMoneyNopaymentModle.h"
#import "YXPaymentHomePageController.h"
//#import "YXInbornTickByTickPayView.h"
#import "YXPaymentHomepageViewDataModel.h"
#import "YXWebPagePayViewController.h"
@interface YXMySureMoneyNopayMentDeatilViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pronameLable;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *timetitleLable;
@property (weak, nonatomic) IBOutlet UILabel *suremoneyLable;
@property (weak, nonatomic) IBOutlet UILabel *alearlymoneytitleLable;
@property (weak, nonatomic) IBOutlet UILabel *alearlymoneyLable;
@property (weak, nonatomic) IBOutlet UILabel *shengyumoneytitleLable;
@property (weak, nonatomic) IBOutlet UILabel *shengyumoneyLable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigbakcivewContant;

@property(nonatomic,strong) NSDictionary * datadict;

/*
 @brief 保证金未付款订单 详情的数据模型
 */
@property(nonatomic,strong) YXMySureMoneyNopaymentModle * NoPayMarginPriceOrderModle;

/*
 @brief requestDataModle
 */
@property(nonatomic,strong) YXPaymentHomepageViewDataModel * RequestDataModle;

@end

@implementation YXMySureMoneyNopayMentDeatilViewController




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    /*
     @brief 未支付 详情
     */
    self.navigationItem.title = @"保证金详情";
    
   
}
-(void)requestData
{
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"marginId"] = self.marginId;
    [YXRequestTool requestDataWithType:POST url:@"/api/margin/detail" params:parm success:^(id objc, id respodHeader) {
      if (objc!=nil) {

          self.NoPayMarginPriceOrderModle = [YXMySureMoneyNopaymentModle mj_objectWithKeyValues:objc];
          
          [self setUIdata:self.NoPayMarginPriceOrderModle];
          
      }
    } failure:^(NSError *error) {
        
        
    }];
    
}

-(void)setUIdata:(YXMySureMoneyNopaymentModle*)modle
{
    self.pronameLable.text = modle.prodName;
    NSInteger status = modle.marginStatus;
    
    if (status == 1) {
        self.statusLable.text = @"未支付";
        
        self.alearlymoneyLable.hidden = YES;
        self.shengyumoneyLable.hidden = YES;
        self.alearlymoneytitleLable.hidden = YES;
        self.shengyumoneytitleLable.hidden = YES;
        self.bigbakcivewContant.constant = 115;
        
    }else if (status == 2)
    {
        self.statusLable.text = @"部分支付";
    
    }else if (status == 7)
    {
        
        self.statusLable.text = @"已取消";
        self.statusLable.textAlignment = NSTextAlignmentRight;
        self.alearlymoneyLable.hidden = YES;
        self.shengyumoneyLable.hidden = YES;
        self.alearlymoneytitleLable.hidden = YES;
        self.shengyumoneytitleLable.hidden = YES;
        _timetitleLable.text = @"提交时间";
        
        self.bigbakcivewContant.constant = 115;
        
    }else if(status ==3)
    {
        self.statusLable.text = @"已支付";
        
    }
    
    NSString  *suremoneypricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",modle.marginPrice/100] ];
    self.suremoneyLable.text = [NSString stringWithFormat:@"￥%@",suremoneypricestr];
    
    NSString  *alearlymoneypricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",modle.alreadyPayAmount/100] ];
    
    self.alearlymoneyLable.text = [NSString stringWithFormat:@"￥%@",alearlymoneypricestr];
    
    NSInteger NOmoneyprice = (modle.marginPrice- modle.alreadyPayAmount )/100;
    
    NSString  *NOmoneypricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld", (long)NOmoneyprice]];
    
    self.shengyumoneyLable.text = [NSString stringWithFormat:@"￥%@",NOmoneypricestr];
    
    
    self.timeLable.text = [YXStringFilterTool transformfromenumbertoTiemstr:[modle.createTime longLongValue]];
    
    
    [self addboomview:status];
    

}

-(void)addboomview:(NSInteger )status
{

    UIView *boomview = [[UIView alloc]initWithFrame:CGRectMake(-1, self.bigbakcivewContant.constant+74+38, YXScreenW+2, 50)];
    boomview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:boomview];
    boomview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    boomview.layer.borderWidth = 0.5;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(YXScreenW-80-10, 15, 80, 25)];
    [boomview addSubview:btn];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = YXRegularfont(14);
    btn.backgroundColor = [UIColor mainThemColor];
    if (status ==1) {
        [btn setTitle:@"立即支付" forState:UIControlStateNormal];
    }else if (status == 2){

        [btn setTitle:@"继续支付" forState:UIControlStateNormal];
        
    }else if (status == 7)
    {
        [btn setTitle:@"已取消" forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [btn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        btn.enabled = NO;
        btn.backgroundColor = [UIColor clearColor];

    }else if (status ==3)
    {
        [btn setTitle:@"已支付" forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [btn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        btn.enabled = NO;
        btn.backgroundColor = [UIColor clearColor];

    }else if(status ==4){
        
        self.statusLable.text = @"已退回";
        [btn setTitle:@"已退回" forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [btn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        btn.enabled = NO;
        btn.backgroundColor = [UIColor clearColor];
        
    }else if (status==5)
    {
        self.statusLable.text = @"已罚扣";
        [btn setTitle:@"已罚扣" forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [btn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        btn.enabled = NO;
        btn.backgroundColor = [UIColor clearColor];
    }else if (status==6)
    {
        self.statusLable.text = @"已抵扣";
        [btn setTitle:@"已抵扣" forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [btn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        btn.enabled = NO;
        btn.backgroundColor = [UIColor clearColor];
    }
    
    btn.tag = status;
    [btn addTarget:self action:@selector(clikcbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)clikcbtn:(UIButton*)sender
{
    if (self.NoPayMarginPriceOrderModle.marginStatus == 7 ) {
        
        return;
    }
    
    NSInteger type ;
    if (sender.tag==1) {
        type=2;
    }else if (sender.tag ==2)
    {
        type=1;
    }
    
    [self GoToPayVc:[NSString stringWithFormat:@"%lld",self.NoPayMarginPriceOrderModle.NopaymentId] payType:type name:self.NoPayMarginPriceOrderModle.prodName marginprice:[NSString stringWithFormat:@"%ld",(long)self.NoPayMarginPriceOrderModle.marginPrice] alearlyprice:[NSString stringWithFormat:@"%ld",(long)self.NoPayMarginPriceOrderModle.alreadyPayAmount]];
    
}

-(void)GoToPayVc:(NSString *)cellId payType:(NSInteger)type name:(NSString *)proname marginprice:(NSString *)marginPrice alearlyprice:(NSString *)alearlyprice
{
    
    //    1 支付过  2 未支付过
    if (type==1) {
        
            [self PushScanVC:cellId];
        
    }else if (type== 2)
    {
        YXPaymentHomePageController *paymentController = [YXPaymentHomePageController loadPaymentControllerWithProdId:[cellId longLongValue] andType:YXPaymentHomePageControllerBond];
        [self.navigationController pushViewController:paymentController animated:YES];
    }
}

/**
 继续支付 跳转扫码支付
 */
-(void)PushScanVC:(NSString * )cellID
{
    
    [[YXPayMentNetRequestTool sharedTool] loadPayMentHomePageDataWithOrderId:[cellID longLongValue] andPaymentType:3 success:^(id objc, id respodHeader) {
        YXLog(@"---zhifus----%@",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.RequestDataModle = [YXPaymentHomepageViewDataModel mj_objectWithKeyValues:objc];
            self.RequestDataModle.transType = 3;
            //** 跳转相应的控制器 */
            YXWebPagePayViewController *controller = [[YXWebPagePayViewController alloc]init];
            controller.dataModel = self.RequestDataModle;
            [self.navigationController pushViewController:controller animated:YES];
            
        }
    } failure:^(NSError *error) {
        YXLog(@"---error--%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
