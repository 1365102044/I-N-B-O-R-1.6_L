
//
//  YXOneMouthPriceConfirmOrderViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXOneMouthPriceConfirmOrderViewController.h"
#import "YXKeyboardToolbar.h"
#import "YXOneMouthPriceTopView.h"
#import "YXOneMouthPriceGoodsDeatilView.h"
#import "UILabel+Extension.h"
#import "ZYNumberKeyboard.h"
#import "YXOneMouthPriceConfirmOrderModle.h"
#import "YXMyAddressListController.h"
#import "YXPickUpPersonListModle.h"
#import "YXZiTiInformationModle.h"
#import "YXPickUpPersonListViewController.h"
#import "YXPaymentHomePageController.h"
#import "YXChoosePeiSongTypeViewController.h"
#import "YXDingjinAgreementView.h"
#import "YXAlertViewTool.h"
#import "YXResginsterAgreenmentViewController.h"
#import "YXGoodsDeatilRequestTool.h"

@interface YXOneMouthPriceConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,YXKeyboardToolbarDelegate>

@property(nonatomic,strong) YXOneMouthPriceTopView * OnemouthPriceTopView;

@property(nonatomic,strong) YXOneMouthPriceGoodsDeatilView * OneMouthPriceGoodsDeatilView;

@property(nonatomic,strong) UITableView * tableview;

@property(nonatomic,strong) UILabel * shouldpriceLable;
/*
 @brief 配送方式
 */
@property(nonatomic,strong) NSString * peisongtypestr;

/*
 @brief 填写身份证号的视图
 */
@property(nonatomic,strong) UIView * IDCardBackBigview;
@property(nonatomic,strong) UIView * IDCardSmallView;
@property(nonatomic,strong) UITextField * IDcardtextfiled;
/*
 @brief 填写提货人信息
 */
//**数字键盘**/
@property (strong, nonatomic) ZYNumberKeyboard *numberKb;

@property(nonatomic,assign) NSInteger  keyboardhight;


@property(nonatomic,strong) YXOneMouthPriceConfirmOrderModle * OneMouthPriceConfirmModel;

/*
 @brief 是否时身份证的textfiled
 */
@property(nonatomic,assign) BOOL  IDCardTextfiledBool;

@property(nonatomic,strong) YXKeyboardToolbar * customAccessoryView;

@property(nonatomic,strong) UITextField * zitinameTextfiled;
@property(nonatomic,strong) UITextField * zitiphoneTextfiled;
@property(nonatomic,strong) UITextField * zitiIDcardTextfiled;


@property(nonatomic,strong) YXMyOrderSuccessAlerview*RemindGoodsView;

/*
 @brief 地址ID
 */
@property(nonatomic,strong) NSString*  addressID;

//**自提人信息的模型**/
@property(nonatomic,strong) YXZiTiInformationModle  * ZiTiInformModle;

@property(nonatomic,strong) UIButton * qinggouBtn;

@property(nonatomic,strong) NSString * ZiTiXinXiID;

@property(nonatomic,strong) NSString*  haveaddress;

@property(nonatomic,strong) YXDingjinAgreementView * agreementView;

//** 服务协议是否同意 默认是yes */
@property(nonatomic,assign) BOOL  agreementBool;
@property (nonatomic, strong) UIView * boombackView;
@end

@implementation YXOneMouthPriceConfirmOrderViewController


#pragma mark  ******************* 点击抢购*********************
/*
 @brief 点击支付
 */
/**
 * @param prodBidId 商品拍卖编号
 * @param deliveryType 物流配送方式，0表示快递，1表示自提
 * @param addressId 收货地址编号
 * @param pickupId 自提信息编号
 */
-(void)ClickqiangouBnt
{

    NSArray *peiosngarr = [self.peisongtypestr componentsSeparatedByString:@"\n"];
    
    if ([peiosngarr[0] isEqualToString:@"定金支付"]) {
        
        if (!self.agreementBool) {
            [YXAlertViewTool showAlertView:self title:@"" message:@"请阅读并勾选协议，否则无法下单支付" confrimBlock:^{
                
            }];
            
            return;
        }
    }
    
    if (peiosngarr.count<2) {
         [YXAlearMnager ShowAlearViewWith:@"请选择配送方式" Type:2];
        return;
    }
    NSString *deliverytypestr ;
    if ([peiosngarr[1] isEqualToString:@"快递送货"]) {
        if (!self.addressID.length) {
            [YXAlearMnager ShowAlearViewWith:@"请选择收货地址" Type:2];
            return;
        }
        deliverytypestr = @"0";
    }else if ([peiosngarr[1] isEqualToString:@"来店自提"])
    {
        if (!self.ZiTiXinXiID.length) {
            [YXAlearMnager ShowAlearViewWith:@"请设置提货人信息" Type:2];
            return;
        }
        deliverytypestr = @"1";
    }
    self.qinggouBtn.enabled = NO;
    [[YXGoodsDeatilRequestTool sharedTool] GotoPayWithprodBidId:self.OneMouthPriceConfirmModel.prodBidId DeliverType:deliverytypestr addressId:self.addressID PickId:self.ZiTiXinXiID orderPayType:peiosngarr[0]  Success:^(id objc, id respodHeader) {
        
        self.qinggouBtn.enabled = YES;
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            YXPaymentHomePageController *paymentController = [YXPaymentHomePageController loadPaymentControllerWithProdId:[objc longLongValue] andType:[self orderpaytypewithbtnStr:peiosngarr[0]]];
            [self.navigationController pushViewController:paymentController animated:YES];
            
        }else{
            
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }

    } failure:^(NSError *error) {
        self.qinggouBtn.enabled = YES;
        
    }];
    
}
/**
 - YXPaymentHomePageControllerFixGood:                          一口价-全款
 - YXPaymentHomePageControllerFixGood_partPayment:              一口价-分笔
 - YXPaymentHomePageControllerDeposit:                          定金
 - YXPaymentHomePageControllerLineTransfer:                     线下转账对账
 */
-(YXPaymentHomePageControllerType )orderpaytypewithbtnStr:(NSString *)title
{
    if ([title isEqualToString:@"全额支付"]) {
     
        return  YXPaymentHomePageControllerFixGood;
    }else  if ([title isEqualToString:@"定金支付"]) {
        
        return YXPaymentHomePageControllerDeposit;
    }else  if ([title isEqualToString:@"分笔支付"]) {
        
        return  YXPaymentHomePageControllerFixGood_partPayment;
    }else  if ([title isEqualToString:@"转账汇款"]) {
        
        return  YXPaymentHomePageControllerLineTransfer;
    }else  if ([title isEqualToString:@"订金+刷卡"]) {
        
    }
    return 100;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.agreementBool = YES;
    self.title = @"确认订单";
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    [self.view addSubview:self.tableview];
    
    [self setUI];
    
    [self requestOneMouthPriceData];

    if (self.morenpaytype == 1) {
        self.peisongtypestr = @"定金支付\n快递送货";
    }else if (self.morenpaytype == 2)
    {
        self.peisongtypestr = @"全额支付\n快递送货";
    }
    
    //** 是否同意 协议 */
    [YXNotificationTool addObserver:self selector:@selector(clickxieyinoti:) name:@"clickxieyinoti" object:nil];
    
    [YXNotificationTool addObserver:self selector:@selector(wanshanZitiInformation:) name:@"wanshanZitiInformatioN" object:nil];
    
    [YXNotificationTool addObserver:self selector:@selector(choolsetihuorenxixin) name:@"choosezitipersoninfomation" object:nil];
    
}

//** 是否同意 服务协议 */
-(void)clickxieyinoti:(NSNotification *)noti
{
    if ([noti.userInfo[@"isornot"] integerValue] ==1) {
        
        self.agreementBool = YES;
    }else{
        self.agreementBool = NO;
    }
}

/**
 点击了服务协议
 */
-(void)agreemtentxieyi
{
    YXLog(@"====点击了服务协议=");
    YXResginsterAgreenmentViewController*reginsterAgreetmentVC = [[YXResginsterAgreenmentViewController alloc]init];
    [self.navigationController pushViewController:reginsterAgreetmentVC animated:YES];
}

#pragma mark  *** 配置UI
-(void)setUI
{
    __weak typeof(self)weakself = self;
    //** 定金的时候 显示开关 */
    if (self.morenpaytype==1) {
        self.agreementView.fuwuxieyiblock = ^(){
            [weakself agreemtentxieyi];
        };
        self.tableview.tableFooterView  = self.agreementView;
        self.agreementView.hidden = YES;
    }else{
    
        self.tableview.tableFooterView.hidden = YES;
    }
    
    
    //**改变高度**/
    self.OnemouthPriceTopView.heightblock =^(CGFloat height){
        weakself.OnemouthPriceTopView.height = height;
        weakself.tableview.tableHeaderView = weakself.OnemouthPriceTopView;
        
    };
    self.OnemouthPriceTopView.morenpaytype = self.morenpaytype;
        //**填写身份证号码**/
        self.OnemouthPriceTopView.IDCardblock =^(){
            
            [weakself setIDCardTextfiledView];
    };
    
    //**切换地址**/
    self.OnemouthPriceTopView.changeAddressBlock = ^(){
        YXMyAddressListController *vc = [[UIStoryboard storyboardWithName:@"myAddressList" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        vc.sourceController = weakself;
        vc.modleblock =^(YXMyAddressList *modle){
            
            weakself.addressID =  [NSString stringWithFormat:@"%lld",modle.addressId];
            weakself.haveaddress = @"1";
            weakself.OnemouthPriceTopView.chooseaddressmodle = modle;
        };
        
        [weakself.navigationController pushViewController: vc animated:YES];
        
    };
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotochoosepeisongtype)];
    [self.OnemouthPriceTopView.topbarview addGestureRecognizer:tap];
    
    [self addboomeView];

}



#pragma mark  ******************* 更改提货人信息**********************
-(void)choolsetihuorenxixin
{

    YXPickUpPersonListViewController*pickuppersonVC = [[YXPickUpPersonListViewController alloc]init];
    pickuppersonVC.sourceController = self;

    pickuppersonVC.onemouchpricemodleblock = ^(YXPickUpPersonListModle *modle){

        [YXNotificationTool postNotificationName:@"choolsetihuorenData" object:nil userInfo:[self GetDictWithModle:modle]];
            self.ZiTiXinXiID = modle.myID;
    };
    [self.navigationController pushViewController:pickuppersonVC animated:YES];
}

-(NSMutableDictionary *)GetDictWithModle:(YXPickUpPersonListModle *)modle{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"name"] = modle.name;
    dict[@"mobile"] = modle.mobile;
    dict[@"idcard"] = modle.idcard;
    dict[@"IsHaveData"] = modle.IsHaveData?@"1":@"0";
    return dict;
}

#pragma mark  ******************* 自提的时候 填写自提人的个人信息**********************
-(void)wanshanZitiInformation:(NSNotification*)noti
{
    [self choolsetihuorenxixin];
    
}

#pragma mark  ******************* 设置身份证号码的接口**********************
-(void)requestCheckIDCardData
{
    
    if (self.IDcardtextfiled.text.length) {
        if (![YXStringFilterTool filterCheckIDCard:self.IDcardtextfiled.text]) {
            
            [YXAlearMnager ShowAlearViewWith:@"身份证格式不对" Type:2];
            return;
        }
    }
    
    [[YXGoodsDeatilRequestTool sharedTool] SetIdCardNumberWithAddressId:self.addressID Idcard:self.IDcardtextfiled.text Success:^(id objc, id respodHeader) {
        
        YXLog(@"----设置身份证号--%@---",objc);
        if([respodHeader[@"Status"] isEqualToString:@"1"])
        {
            [YXNotificationTool postNotificationName:@"shezhiSUCCESSIDCard" object:self userInfo:@{@"IDCADRDS":self.IDcardtextfiled.text}];
            
            [self clickcacleBtn];
            
        }else{
            
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }

    } failure:^(NSError *error) {
    }];
    
}

#pragma mark  ******************* 进来后 请求订单的数据**********************
-(void)requestOneMouthPriceData
{
    
    [[YXGoodsDeatilRequestTool sharedTool] LoadConfirmOrderDataWithProBidId:self.prodBidId Success:^(id objc, id respodHeader) {
        
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            [self IsNeedHiddenSubviewWith:NO];
            self.tableview.tableHeaderView = self.OnemouthPriceTopView;
            
            YXLog(@"----一口价确认订单%@---",objc);
            
            self.OneMouthPriceConfirmModel = [YXOneMouthPriceConfirmOrderModle mj_objectWithKeyValues:objc];
            self.OneMouthPriceConfirmModel.depositPrice = self.dingjinPrice;
            
            if(self.morenpaytype==1){
            
                [self setShouldPriceWithIsDingjin:1];
            }else{
                [self setShouldPriceWithIsDingjin:2];
            }
            
            self.OnemouthPriceTopView.OneMouthPriceConfirmModel = self.OneMouthPriceConfirmModel;
            
            self.addressID = self.OneMouthPriceConfirmModel.consigneeId;
            self.haveaddress = self.OneMouthPriceConfirmModel.hasAddress;
            self.OnemouthPriceTopView.haveaddress = self.haveaddress;
            
            self.agreementView.OneMouthPriceConfirmModel = self.OneMouthPriceConfirmModel;
            [self.tableview reloadData];
        }else
        {
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        [self.tableview.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        
        [self.tableview.mj_header endRefreshing];
        [self IsNeedHiddenSubviewWith:YES];
    }];
}

/*
 @brief 是否隐藏子视图
 */
-(void)IsNeedHiddenSubviewWith:(BOOL)Bool
{
    self.agreementView.hidden = Bool;
    self.tableview.tableHeaderView.hidden = Bool;
    self.boombackView.hidden = Bool;

}
/**
 给应付金额 赋值
 */
-(void)setShouldPriceWithIsDingjin:(NSInteger )isDingjin
{
    NSInteger shouldpre;
    if (isDingjin==1) {
        self.tableview.tableFooterView.hidden = NO;
        shouldpre = self.OneMouthPriceConfirmModel.depositPrice;
        
    }else if (isDingjin == 2)
    {
        self.tableview.tableFooterView.hidden = YES;
        shouldpre = [self.OneMouthPriceConfirmModel.orderTotalAmount integerValue] + self.OneMouthPriceConfirmModel.carriage+self.OneMouthPriceConfirmModel.protectPrice-self.OneMouthPriceConfirmModel.orderDiscountAmount;
    
    }
    NSString *shouldpricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",shouldpre/100]];
    NSString *shouldprice = [NSString  stringWithFormat:@"    应付金额：¥%@",shouldpricestr];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:shouldprice];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x999999) range:NSMakeRange(0, 9)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xad0810) range:NSMakeRange(9, attrStr.length-9)];
    self.shouldpriceLable.attributedText = attrStr;

}

-(void)clickcacleBtn
{
    self.editing = NO;
    [self.IDcardtextfiled resignFirstResponder];
    [self.IDCardBackBigview removeFromSuperview];
    [self.IDCardSmallView removeFromSuperview];

}



#pragma mark  ******************* 选择配送方式 **********************
-(void)gotochoosepeisongtype
{
    __weak typeof(self)weakself = self;
    YXChoosePeiSongTypeViewController *vc = [[YXChoosePeiSongTypeViewController alloc]init];
    vc.peisongblock = ^(NSString *pay, NSString * wuliu){
        
        weakself.peisongtypestr = [NSString stringWithFormat:@"%@\n%@",pay,wuliu];
        weakself.OnemouthPriceTopView.peisongtypestr = weakself.peisongtypestr;
         weakself.OnemouthPriceTopView.haveaddress = self.haveaddress;
        if ([pay isEqualToString:@"定金支付"]) {
            
            self.agreementView.fuwuxieyiblock = ^(){
                [weakself agreemtentxieyi];
            };
            
            [self setShouldPriceWithIsDingjin:1];
        }else{
            weakself.tableview.tableFooterView.hidden = YES;
             [self setShouldPriceWithIsDingjin:2];
        }
        if ([wuliu isEqualToString:@"来店自提"]) {
            
            
            [self requestTiHuoPeopleInformationData];
        }
    };
    vc.orderAllPrice = [self.OneMouthPriceConfirmModel.orderTotalAmount integerValue] + self.OneMouthPriceConfirmModel.carriage+self.OneMouthPriceConfirmModel.protectPrice-self.OneMouthPriceConfirmModel.orderDiscountAmount;
    vc.wuliupeisong = self.peisongtypestr;
    vc.iscanDingjin = self.iscandingjin;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  *******************选择自提后 查询提货人的个人信息**********************
-(void)requestTiHuoPeopleInformationData
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"curPage"] = @"1";
    para[@"pageSize"] = @"1";
    
    [YXRequestTool requestDataWithType:POST url:@"/api/pickup/queryList" params:para success:^(id objc, id respodHeader) {
        
        YXLog(@"+++选择自提后 查询提货人的个人信息*++%@+",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            if ([objc[@"totalRows"] integerValue]) {
                
                NSMutableArray *arr = objc[@"data"];
                self.ZiTiInformModle = [YXZiTiInformationModle mj_objectWithKeyValues:arr[0]];
                self.OnemouthPriceTopView.ZiTiaddressView.zitiiformationModle = self.ZiTiInformModle;
                self.ZiTiXinXiID = self.ZiTiInformModle.ZiTiXinXiID;
            }
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.backgroundColor = UIColorFromRGB(0xf9f9f9);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//在遇到有输入的情况下。由于现在键盘的高度是动态变化的。中文输入与英文输入时高度不同。所以输入框的位置也要做出相应的变化
#pragma mark - keyboardHight

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}


//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    YXLog(@"hight_hitht:%f",kbSize.height); //216  36

    self.keyboardhight = kbSize.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.IDCardSmallView.frame = CGRectMake(0, YXScreenH-self.keyboardhight-100, YXScreenW, self.keyboardhight+100);
        
        
    }];

}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.IDcardtextfiled) {
        
        [self clickcacleBtn];
        [self requestCheckIDCardData];
    }

    
    return YES;
}



//输入结束时调用动画（把按键。背景。输入框都移下去）
-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    //释放
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark  ******************* 添加完善身份证号码的view**********************
/*
 @brief 添加完善身份证号码的view
 */
-(void)setIDCardTextfiledView
{
    UIView *bigview = [[UIView alloc]initWithFrame:self.view.bounds];
    bigview.backgroundColor = [UIColor blackColor];
    bigview.alpha = 0.4;
    self.IDCardBackBigview = bigview;
    [[UIApplication sharedApplication].keyWindow addSubview:self.IDCardBackBigview];
    
    
    
    UIView *view1 = [[UIView alloc]init];
    view1.size = CGSizeMake(YXScreenW, 216+110);
    view1.x = 0;
    view1.y = YXScreenH-view1.height;
    view1.backgroundColor = [UIColor whiteColor];
    self.IDCardSmallView = view1;
    [[UIApplication sharedApplication].keyWindow addSubview:self.IDCardSmallView];
    
    UIButton *cancaleBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [cancaleBtn setImage:[UIImage imageNamed:@"矩形-15-拷贝"] forState:UIControlStateNormal];
    [cancaleBtn addTarget:self action:@selector(clickcacleBtn) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:cancaleBtn];
    
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake((YXScreenW-150)/2, 10, 150, 30)];
    titlelable.text = @"请输入身份证号";
    titlelable.textColor = UIColorFromRGB(0x040404);
    titlelable.font = YXSFont(14);
    titlelable.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:titlelable];
    
    UITextField *IDcardtextfiled = [[UITextField alloc]initWithFrame:CGRectMake(10, titlelable.bottom+5, YXScreenW-20, 30)];
    IDcardtextfiled.delegate = self;
    IDcardtextfiled.placeholder = @"请输入身份证号";
    IDcardtextfiled.font = YXSFont(15);
    IDcardtextfiled.textColor = UIColorFromRGB(0x251011);
    IDcardtextfiled.alpha = 0.6;
    IDcardtextfiled.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    IDcardtextfiled.layer.borderWidth = 0.5;
    [IDcardtextfiled becomeFirstResponder];
    IDcardtextfiled.textAlignment = NSTextAlignmentCenter;
    IDcardtextfiled.returnKeyType = UIReturnKeyDone;
    self.IDcardtextfiled = IDcardtextfiled;
    [IDcardtextfiled setInputAccessoryView:self.customAccessoryView];
    [view1 addSubview:IDcardtextfiled];
    
    
}

#pragma mark  ******************* 添加键盘俯视图**********************
#pragma mark - 懒加载
- (YXKeyboardToolbar *)customAccessoryView
{
    if (!_customAccessoryView) {
        
        _customAccessoryView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YXKeyboardToolbar class]) owner:nil options:nil].firstObject;
        _customAccessoryView.customDelegate = self;
    }
    return _customAccessoryView;
}
#pragma mark - 代理方法

- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    [self clickcacleBtn];
    
    if ([doneButtonClick.title isEqualToString:@"完成"]) {
        
        [self requestCheckIDCardData];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [YXNotificationTool removeObserver:@"wanshanZitiInformatioN"];
//    [YXNotificationTool removeObserver:@"choosezitipersoninfomation"];
    
    [YXNetworkHUD dismiss];
}


/*
 @brief 添加底部视图
 */
-(void)addboomeView
{
    UIView *boombackView = [[UIView alloc]initWithFrame:CGRectMake(0, YXScreenH-45, YXScreenW, 46)];
    boombackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:boombackView];
    self.boombackView = boombackView;
    
    UIButton *qinggouBtn = [[UIButton alloc]initWithFrame:CGRectMake(YXScreenW-130, 0, 130, 45)];
    [boombackView addSubview:qinggouBtn];
    qinggouBtn.backgroundColor = [UIColor mainThemColor];
    [qinggouBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qinggouBtn.titleLabel.font =  YXSFont(16);
    [qinggouBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [qinggouBtn addTarget:self action:@selector(ClickqiangouBnt) forControlEvents:UIControlEventTouchUpInside];
    self.qinggouBtn = qinggouBtn;
    
    
    
    
    UILabel *priceLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, YXScreenW-qinggouBtn.width, 45)];
    NSString *pricestr = [YXStringFilterTool strmethodComma:@""];
    priceLable.text = [NSString  stringWithFormat:@"   应付金额：¥%@",pricestr];
    priceLable.textColor = [UIColor mainThemColor];
    priceLable.font = YXSFont(13);
    [boombackView addSubview:priceLable];
    priceLable.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    priceLable.layer.borderWidth = 0.5;
    self.shouldpriceLable = priceLable;
    
}

/**
 懒加载
 */
-(YXMyOrderSuccessAlerview*)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

-(UITableView*)tableview{
    
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, YXScreenW, YXScreenH-55)];
        _tableview.delegate = self;
        _tableview.dataSource =self;
        _tableview.rowHeight = 10;
        _tableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestOneMouthPriceData)];
        _tableview.tableFooterView = self.agreementView;
        _tableview.tableFooterView.hidden = YES;
    }
    return _tableview;
}

-(YXOneMouthPriceTopView*)OnemouthPriceTopView
{
    if (!_OnemouthPriceTopView) {
        
        _OnemouthPriceTopView = [[YXOneMouthPriceTopView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 250)];
        
    }
    return _OnemouthPriceTopView;
}


-(YXDingjinAgreementView *)agreementView
{
    if (!_agreementView) {
        
        _agreementView = [[YXDingjinAgreementView alloc]initWithFrame:CGRectMake(0, 10, YXScreenW, 94)];
        _agreementView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    }
    return _agreementView;
}
-(void)dealloc
{
    [YXNotificationTool removeObserver:self];

    [YXUserDefaults removeObjectForKey:@"iscanfenbi"];

}

@end
