//
//  YXMyAccountGOPaymentConfirmAddressViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/11.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountGOPaymentConfirmAddressViewController.h"
#import "NSString+File.h"
#import "YXMyAddressListController.h"
#import "YXAddNewAddressViewController.h"
#import "YXNavigationController.h"
#import "YXMyAccountRealNameViewController.h"
#import "YXPaymentHomePageController.h"
@interface YXMyAccountGOPaymentConfirmAddressViewController ()

@property (weak, nonatomic) IBOutlet UIView *dingdanhaoview;

@property (weak, nonatomic) IBOutlet UIView *titlenameview;
@property (weak, nonatomic) IBOutlet UIView *addressbigview;

@property (weak, nonatomic) IBOutlet UILabel *dingdanlable;
@property (weak, nonatomic) IBOutlet UILabel *namelable;

@property (weak, nonatomic) IBOutlet UIButton *wuliutypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *zititypeBtn;
@property (weak, nonatomic) IBOutlet UILabel *personnameAndPhonelable;
@property (weak, nonatomic) IBOutlet UILabel *addresscontentlable;

@property (weak, nonatomic) IBOutlet UIImageView *jiantouimageview;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addresslablecontantsHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressbigviewcontantsHeight;

@property(nonatomic,strong) NSDictionary * wuliuaddressDICT;
@property(nonatomic,strong) NSDictionary * zitiaddressDICT;
@property (weak, nonatomic) IBOutlet UILabel *phonelable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *personnamelablecontantsWitdh;


@property(nonatomic,assign) CGFloat  oldaddressheight;

/*
 @brief  0 物流   1自提
 */
@property(assign,nonatomic) NSInteger paytypeStatus;

/*
 @brief 没有地址的view
 */
@property(nonatomic,strong) UILabel * nohaveaddressdesc;
@property(nonatomic,strong) UIButton * nohaveaddressaddbtn;
@property(nonatomic,assign) NSInteger  haveaddressStatus;  //1 有地址  2 没有地址



/*
 @brief 发通知回来的，就需要 物流 请求的数据了，不然会显示 默认的地址
 */
@property(nonatomic,assign) NSInteger  NOTIstatus;


@end

@implementation YXMyAccountGOPaymentConfirmAddressViewController

-(NSDictionary*)wuliuaddressDICT{
    if (!_wuliuaddressDICT) {
        _wuliuaddressDICT = [[NSDictionary alloc]init];
    }
    return  _wuliuaddressDICT;
}
-(NSDictionary*)zitiaddressDICT{
    if (!_zitiaddressDICT) {
        _zitiaddressDICT = [[NSDictionary alloc]init];
    }
    return  _zitiaddressDICT;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    
    [self requestzitiAdressdata];
    [self requestAddressList];
    [self setUI];
    self.oldaddressheight = self.addressbigviewcontantsHeight.constant;
    
   
    self.zititypeBtn.selected = NO;
    
  
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.NOTIstatus = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"确认地址";
    
    UILabel *addaddressdesc = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 150, 20)];
    addaddressdesc.font = YXRegularfont(11);
    addaddressdesc.textColor = UIColorFromRGB(0xaaa7a7);
    addaddressdesc.text = @"您没有收货地址，您可以点击";
    [self.addressbigview addSubview:addaddressdesc];
    self.nohaveaddressdesc = addaddressdesc;
    
    UIButton *addbtn = [[UIButton alloc]initWithFrame:CGRectMake(addaddressdesc.right, addaddressdesc.y, 50, 20)];
    [addbtn setTitle:@"添加" forState:UIControlStateNormal];
    addbtn.titleLabel.font = YXRegularfont(12);
    [addbtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    addbtn.layer.borderColor = [UIColor mainThemColor].CGColor;
    addbtn.layer.borderWidth = 1;
    addbtn.layer.masksToBounds = YES;
    addbtn.layer.cornerRadius = 3;
    [addbtn addTarget:self action:@selector(ClickAddAddressBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.addressbigview addSubview:addbtn];
    self.nohaveaddressaddbtn = addbtn;
    
    self.wuliutypeBtn.backgroundColor = [UIColor mainThemColor];
    [self.wuliutypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     self.paytypeStatus = 0;
    
    
    /*
     @brief 选择地址
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickchoosecurrenaddress:) name:@"CHOOSECURRENADDRESS" object:nil];
}
-(void)clickchoosecurrenaddress:(NSNotification*)noti
{
    self.haveaddressStatus = 1;
    self.NOTIstatus = 1;
    self.wuliuaddressDICT = noti.userInfo;
    [self setaddressView:noti.userInfo type:0];
    
}
-(void)setUI
{
    self.dingdanhaoview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.dingdanhaoview.layer.borderWidth = 1;
    self.titlenameview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.titlenameview.layer.borderWidth = 1;
    self.addressbigview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.addressbigview.layer.borderWidth = 1;

    self.wuliutypeBtn.layer.borderColor = [UIColor mainThemColor].CGColor;
    self.wuliutypeBtn.layer.borderWidth = 1;
    self.wuliutypeBtn.layer.masksToBounds = YES;
    self.wuliutypeBtn.layer.cornerRadius = 3;
    self.zititypeBtn.layer.borderColor = [UIColor mainThemColor].CGColor;
    self.zititypeBtn.layer.borderWidth = 1;
    self.zititypeBtn.layer.masksToBounds = YES;
    self.zititypeBtn.layer.cornerRadius = 3;
    
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 5;
    
    
    
    
    
    self.dingdanlable.text = [NSString stringWithFormat:@"订单编号：%@",self.dingdannumber];
    self.namelable.text = self.proname;
    
    
    
}

-(void)NoHaveAddresshiddenView
{
    self.personnameAndPhonelable.hidden =YES;
    self.addresscontentlable.hidden = YES;
    self.jiantouimageview.hidden = YES;
    self.phonelable.hidden = YES;
    
    self.nohaveaddressdesc.hidden = NO;
    self.nohaveaddressaddbtn.hidden = NO;
    
    
   
    
    self.addressbigviewcontantsHeight.constant = 60;
    
}

/*
 @brief 点击 添加地址 按钮
 */
-(void)ClickAddAddressBtn
{
    //** 跳转添加地址界面 */
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"addNewAddress" bundle:nil];
    YXAddNewAddressViewController *toTableViewController = [sb instantiateInitialViewController];
    toTableViewController.sourceController = self;
    YXNavigationController *navigationController = [[YXNavigationController alloc] initWithRootViewController:toTableViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

- (IBAction)clickwuliutypeBtn:(id)sender {
    
    if (self.haveaddressStatus==1) {
        self.personnameAndPhonelable.hidden = NO;
        self.addresscontentlable.hidden = NO;
        self.phonelable.hidden = NO;
        self.nohaveaddressdesc.hidden = YES;
        self.nohaveaddressaddbtn.hidden = YES;
        
         [self setaddressView:self.wuliuaddressDICT type:0];
        
    }else {
        
        [self NoHaveAddresshiddenView];
   
    }
        
    self.zititypeBtn.backgroundColor = [UIColor whiteColor];
    [self.zititypeBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    [self.wuliutypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.wuliutypeBtn.backgroundColor = [UIColor mainThemColor];
    self.paytypeStatus = 0;
   
}

- (IBAction)clickzititypeBtn:(id)sender {
    
    
   

    self.personnameAndPhonelable.hidden = NO;
    self.addresscontentlable.hidden = NO;
    self.phonelable.hidden = NO;
    
    self.wuliutypeBtn.backgroundColor = [UIColor whiteColor];
    [self.wuliutypeBtn setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    [self.zititypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.zititypeBtn.backgroundColor = [UIColor mainThemColor];
    
    [self setaddressView:self.zitiaddressDICT type:1];
    self.paytypeStatus = 1;
    self.jiantouimageview.hidden = YES;
    
    self.nohaveaddressdesc.hidden = YES;
    self.nohaveaddressaddbtn.hidden = YES;
    
}

- (IBAction)clickNextBtn:(id)sender {
    
    [self commitAddressData];
    
}

//跳转
-(void)nexTTOvc
{

    
    if (self.orderType==1) {
        
        YXPaymentHomePageController *paymentController = [YXPaymentHomePageController loadPaymentControllerWithProdId:[self.dingdannumber longLongValue] andType:YXPaymentHomePageControllerBidGood];
        [self.navigationController pushViewController:paymentController animated:YES];
        
    }else if(self.orderType==2)
    {
        YXPaymentHomePageController *paymentController = [YXPaymentHomePageController loadPaymentControllerWithProdId:[self.dingdannumber longLongValue] andType:YXPaymentHomePageControllerFixGood];
        [self.navigationController pushViewController:paymentController animated:YES];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickaddressTAP:(id)sender {
    if (self.paytypeStatus == 1) {
        return;
    }
    
    if (self.nohaveaddressaddbtn.hidden) {
        
        YXMyAddressListController *vc = [[UIStoryboard storyboardWithName:@"myAddressList" bundle:nil] instantiateInitialViewController];
        vc.formetype = 1;
        vc.sourceController = [[YXMyAccountGOPaymentConfirmAddressViewController alloc]init];
        [self.navigationController pushViewController: vc animated:YES];
        
    }
}

/*
 @brief 下一步之前 提交数据
 */
-(void)commitAddressData
{
    /*
     @brief 选择自体的时候
     */
    if (self.paytypeStatus == 1) {
        
        if (![self checkRealName]) {
            return;
        }
    }
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"orderId"] = self.cellid;
    parm[@"deliveryType"] = @(self.paytypeStatus);
    if (self.paytypeStatus==0) {
        
        parm[@"addressId"] = self.wuliuaddressDICT[@"id"];
        
    }else if (self.paytypeStatus==1)
    {
        parm[@"addressId"] = self.zitiaddressDICT[@"id"];
    }
    
    [YXRequestTool requestDataWithType:POST url:@"/api/order/perfect" params:parm success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            [self nexTTOvc];
        }

    } failure:^(NSError *error) {
        
    }];
    
}

/*
 @brief 自提的时候  点击 下一步的 时候，要进行 实名验证和绑定银行卡
 */
-(BOOL)checkRealName
{
        /*
         @brief 实名认证 和 绑定银行卡的 才能弹出保证金的 页面
         */
       NSInteger shimingrenzheng =  [[YXUserDefaults objectForKey:@"validateStatus"] integerValue];
    
        //--跳转到身份验证模块
        /**
         * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
         */
        if (shimingrenzheng ==2 ) {

            return YES ;
            
        }else{

            YXMyAccountRealNameViewController * bindbankcardVC = [[YXMyAccountRealNameViewController alloc]init];

            [self.navigationController pushViewController:bindbankcardVC animated:YES];

            return NO;
}
}


/*
 @brief 请求自提 情况下的数据信息
 */
-(void)requestzitiAdressdata
{
    
    [YXRequestTool requestDataWithType:POST url:@"/api/returnAddress" params:nil success:^(id objc, id respodHeader) {
        
//        YXLog(@"=====returnaddress=====%@=",objc);
        if ([respodHeader[@"Status"]  isEqualToString:@"1"]){
        
            self.zitiaddressDICT = objc;
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

/*
 @brief 查询地址列表
 */
-(void)requestAddressList
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"pageSize"] = @"10";
    param[@"curPage"] = @"1";
    [YXRequestTool requestDataWithType:POST url:@"/api/getAddress" params:param success:^(id objc, id respodHeader) {
        
        YXLog(@"=====mydress=====%@=",objc);
        if ([respodHeader[@"Status"]  isEqualToString:@"1"]) {
            
            NSInteger totalrows = [[NSString stringWithFormat:@"%@",objc[@"totalRows"]] integerValue];
            if (totalrows == 0) {
                
                self.haveaddressStatus = 2;
                [self NoHaveAddresshiddenView];
                
            }else{
                
                self.haveaddressStatus = 1;
                NSArray*addressArr = objc[@"data"];
                if (!self.NOTIstatus) {
                    
                    self.wuliuaddressDICT = addressArr[0];
                    [self setaddressView:addressArr[0] type:0];
                    
                }
                
            }
            
        }
    } failure:^(NSError *error) {
        
        
    }];
}

/*
 @brief 给地址赋值  0物流  1 自提
 */
-(void)setaddressView:(NSDictionary *)addressdic type:(NSInteger)type
{
    
    self.personnameAndPhonelable.hidden = NO;
    self.addresscontentlable.hidden = NO;
    self.phonelable.hidden = NO;
    self.nohaveaddressdesc.hidden = YES;
    self.nohaveaddressaddbtn.hidden = YES;
   
    NSString *addressStr;
    if (type==0) {
        
        NSString *namestr = [NSString stringWithFormat:@"联系人：%@",addressdic[@"consigneeName"]];
        NSString *phonestr =[NSString stringWithFormat:@"联系电话：%@",addressdic[@"consigneeMobile"]];
        CGFloat nameW =  [namestr widthWithFont:YXRegularfont(13)];
        self.addressbigviewcontantsHeight.constant = self.oldaddressheight;
        if (nameW > YXScreenW -40-150) {
            self.personnamelablecontantsWitdh.constant = YXScreenW-190;
        }
        self.personnameAndPhonelable.text = namestr;
        self.phonelable.text = phonestr;
        addressStr = [NSString stringWithFormat:@"收货地址：%@%@%@",addressdic[@"consigneeProvince"],addressdic[@"consigneeCity"],addressdic[@"consigneeAddressDetail"]];
        
        CGFloat W = [addressStr widthWithFont:YXRegularfont(13)];
        if (W>YXScreenW-40) {
            CGFloat addressH = [addressStr heightWithFont:YXRegularfont(13) withinWidth:YXScreenW -40];
            self.addresslablecontantsHeight.constant = addressH;
            
            self.addressbigviewcontantsHeight.constant = addressH+60;
        }else
        {
            self.addresslablecontantsHeight.constant = 20;
            
            self.addressbigviewcontantsHeight.constant = 20+60;
        }
        self.addresscontentlable.text = addressStr;
        
    }else if (type == 1)
    {
        
        NSString *namestr = [NSString stringWithFormat:@"联系人：%@",[YXLoadZitiData objectZiTiWithforKey:@"consigneeName"]];
        NSString *phonestr =[NSString stringWithFormat:@"联系电话：%@",[YXLoadZitiData objectZiTiWithforKey:@"consigneePhone"]];
        CGFloat nameW =  [namestr widthWithFont:YXRegularfont(13)];
        self.addressbigviewcontantsHeight.constant = self.oldaddressheight;
        if (nameW > YXScreenW -40-150) {
            self.personnamelablecontantsWitdh.constant = YXScreenW-190;
        }
        self.personnameAndPhonelable.text = namestr;
        self.phonelable.text = phonestr;
        addressStr = [NSString stringWithFormat:@"收货地址：%@",[YXUserDefaults objectForKey:@"consigneeAddress"]];
    
    
        CGFloat W = [addressStr widthWithFont:YXRegularfont(13)];
        if (W>YXScreenW-40) {
            CGFloat addressH = [addressStr heightWithFont:YXRegularfont(13) withinWidth:YXScreenW -40];
            self.addresslablecontantsHeight.constant = addressH;
            
            self.addressbigviewcontantsHeight.constant = addressH+60;
        }
        self.addresscontentlable.text = addressStr;

    }
    
   
}

@end
