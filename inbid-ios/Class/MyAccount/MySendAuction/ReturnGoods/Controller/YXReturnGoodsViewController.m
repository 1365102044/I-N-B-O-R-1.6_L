//
//  YXReturnGoodsViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/17.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXReturnGoodsViewController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXImmediatelyMailMyAddressModel.h"
#import "YXStringFilterTool.h"
#import "YXMyAddressList.h"
#import "YXMyAddressListController.h"
#import "YXNavigationController.h"
#import "YXMySendAuctionEndBid.h"
#import "YXMySendAuctionHoldTest.h"
#import "YXAddNewAddressViewController.h"
#import "MQChatViewManager.h"
#import "YXMyOrderSuccessAlerview.h"
#import "YXHelpViewController.h"
#import "YXMyAccountSetPaymengPasswordViewController.h"
#import  <MeiQiaSDK/MQManager.h>
#import "YXMyAccountURLMacros.h"
#import "YXOrderDetailModel.h"
#import "YXVerificationReturnGoodViewController.h"
#import "YXAlertViewTool.h"

@interface YXReturnGoodsViewController ()<YXVerificationReturnGoodViewControllerDelegate>

/**
 物品名称label
 */
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;

/**
 物流快递按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *logisticsExpressButton;

/**
 自取
 */
@property (weak, nonatomic) IBOutlet UIButton *pickUpButton;

/**
 收货人
 */
@property (weak, nonatomic) IBOutlet UILabel *consigneeLabel;

/**
 收货人姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *consigneeContentLabel;

/**
 电话号码
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

/**
 电话号码内容
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberContentLabel;

/**
 收货地址
 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

/**
 收货地址内容
 */
@property (weak, nonatomic) IBOutlet UILabel *addressContentLabel;

/**
 信息父控件
 */
@property (weak, nonatomic) IBOutlet UIView *detailSuperView;

/**
 是否可以点击指示按钮
 */
@property (weak, nonatomic) IBOutlet UIImageView *canClickImageView;

/**
 地址模型
 */
@property (nonatomic, strong) YXImmediatelyMailMyAddressModel *myAddressModel;

/**
 用户地址列表
 */
@property (nonatomic, strong) NSArray *addressListArray;

/**
 提示添加默认收货地址视图
 */
@property (weak, nonatomic) IBOutlet UIView *addDefaultAddressTipsView;

/**
 当前选中button
 */
@property (nonatomic, strong) UIButton *currentButton;

/**
 添加新地址
 */
@property (weak, nonatomic) IBOutlet UIButton *addNewAddressButton;

/**
 弹窗
 */
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

/*
 @brief 输入的图片验证码
 */
@property(nonatomic,strong) NSString * imagecodestr;

@end

@implementation YXReturnGoodsViewController

#pragma mark - 赋值

- (void)setAddNewAddressDict:(NSDictionary *)addNewAddressDict
{
    _addNewAddressDict = addNewAddressDict;
//    self.addDefaultAddressTipsView.hidden = YES;
//    if (addNewAddressDict) {
//        self.canClickImageView.hidden = NO;
//    }else{
//        self.canClickImageView.hidden = YES;
//    }
//    
//    self.consigneeContentLabel.text = addNewAddressDict[@"name"];
//    self.phoneNumberContentLabel.text = [YXStringFilterTool replaceStringWithAsterisk:addNewAddressDict[@"phone"] startLocation:3 lenght:4];
//    self.addressContentLabel.text = [NSString stringWithFormat:@"%@ %@ %@", addNewAddressDict[@"province"], addNewAddressDict[@"city"], addNewAddressDict[@"consigneeAddressDetail"]];
}

- (void)setAddressList:(YXMyAddressList *)addressList
{
    _addressList = addressList;
    
    if (!addressList) {
        self.addDefaultAddressTipsView.hidden = NO;
        self.canClickImageView.hidden = YES;
        self.addressId = addressList.addressId;
        return;
    }
    
    self.canClickImageView.hidden = NO;
    self.consigneeContentLabel.text = addressList.consigneeName;
    self.phoneNumberContentLabel.text = [YXStringFilterTool replaceStringWithAsterisk:addressList.consigneeMobile startLocation:3 lenght:4];
    self.addressContentLabel.text = [NSString stringWithFormat:@"%@ %@ %@", addressList.consigneeProvince, addressList.consigneeCity, addressList.consigneeAddressDetail];
}

- (void)setMyAddressModel:(YXImmediatelyMailMyAddressModel *)myAddressModel
{
    _myAddressModel = myAddressModel;
    
}

#pragma mark - 代理

/**
 验证付款界面按钮点击事件
 
 @param sender                              点击的按钮
 @param loginPassword                       登录密码
 @param idCard                              身份证后八位
 */
- (void)verificationReturnGoodViewController:(YXVerificationReturnGoodViewController *)verificationReturnGoodViewController
                                 clickButton:(UIButton *)sender
                               loginPassword:(NSString *)loginPassword
                                      idCard:(NSString *)idCard
{
    if ([sender.titleLabel.text isEqualToString:@"确认"]) {
        
        //** 判断是我的鉴定还是流拍结束寄拍 */
        long long orderId = 0;
        NSInteger refundType = 0;
        
        if (self.detailModel) {
            //** 鉴定退货 */
            orderId = self.detailModel.orderNumber.longLongValue;
            if (self.detailModel.identifyStatus == 2) {
                //** 成功退回 */
                refundType = 3;
            }else if (self.detailModel.identifyStatus == 3) {
                //** 失败退回 */
                refundType = 1;
            }
        }else if (self.fixGoodReturnId) {
            //** 一口价流拍退货啊 */
            orderId = self.fixGoodReturnId;
            refundType = 4;
        }
        
        //** 判断邮寄方式 */
        NSInteger deliveryType = 0;
        if (self.currentButton.tag == 1001) {
            deliveryType = 0;
        }else if (self.currentButton.tag == 1002){
            deliveryType = 1;
        }
        
        
        [[YXMyAccountNetRequestTool sharedTool] returnGoodWithPayPassword:loginPassword
                                                             deliveryType:[NSString stringWithFormat:@"%zd", deliveryType]
                                                               refundType:[NSString stringWithFormat:@"%zd", refundType]
                                                                  orderId:[NSString stringWithFormat:@"%lld",orderId]
                                                                   prodId:[NSString stringWithFormat:@"%lld",self.prodId]
                                                                 buyoutId:[NSString stringWithFormat:@"%lld", self.buyoutId]
                                                                   idCard:idCard
                                                              consigneeId:[NSString stringWithFormat:@"%lld", self.addressId]
                                                                  success:^(id objc, id respodHeader) {
                                                                      [objc[@"status"] isEqualToString:@"1"] ? [self returnGoodSuccessWithObjc:objc] : [self showTipsWithObjc:objc];
                                                                  }
                                                                  failure:^(NSError *error) {
                                                                      
                                                                  }];
        return;
    }
}

/**
 退款成功

 @param objc 响应体
 */
- (void)returnGoodSuccessWithObjc:(id)objc
{
    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 4] animated:YES];
}

/**
 回到列表控制器
 */
- (void)popToListViewController
{
    NSArray *navigationControllersArray = self.navigationController.childViewControllers;
    if ([self.delegate respondsToSelector:@selector(returnGoodsViewController:changeRestPageON:)]) {
        [self.delegate returnGoodsViewController:self changeRestPageON:YES];
    }
    [self.navigationController popToViewController:navigationControllersArray[1] animated:YES];
}

#pragma mark  ******************* 请求图片验证码 是否显示的接口 **********************
-(void)requestforgetimageSMSCodeISshow
{
//    [YXRequestTool requestDataWithType:POST url:PAYMENTPASSWORDHIEENDORNOT_URL params:nil success:^(id objc, id respodHeader) {
//        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
//            
//            if ([objc isEqualToString:@"false"]) {
//                
//                self.verificationPaymentPwdView.imagecodeshowStatus = YES;
//                
//            }else if ([objc isEqualToString:@"true"])
//            {
//                
//                self.verificationPaymentPwdView.imagecodeshowStatus = NO;
//                
//                [self requestchangePayPasswordImageCode];
//            }
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
}

#pragma mark  ******************* 请求图片验证码接口 **********************
-(void)requestchangePayPasswordImageCode
{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    
//    [YXRequestTool requestImageCoderDataWithType:POST url:SETPAYMENTPASSWORDIMAGECODE_URL params:param success:^(id objc, id respodHeader) {
//        
//        if(![respodHeader[@"Status"] isEqualToString:@"1"])
//        {
//            
//            [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
//            self.RemindGoodsView.longinVCStr = objc;
//            self.RemindGoodsView.frame = self.view.bounds;
//            __weak typeof (self) wealself = self;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [wealself dimssview];
//            });
//            
//        }else{
//            
//            UIImage *image = [UIImage imageWithData:objc];
//            self.verificationPaymentPwdView.imagecode = image;
//            
//        }
//        
//    } failure:^(NSError *error) {
//        
//        
//    }];
    
}

/**
 取消弹窗
 */
-(void)dimssview
{
    [self.RemindGoodsView removeFromSuperview];
    self.RemindGoodsView = nil;
}

#pragma mark - 点击事件

/**
 确认回退按钮

 @param IBAction 确认回退按钮

 */
- (IBAction)sureRetureGoodButtonClick:(UIButton *)sender
{
    //** 判断当前是否有地址，如果没有弹窗提示 */
    if (!self.addressId && self.currentButton.tag == 1001) {
//        [self showAlertWithText:@"邮寄地址为空" andTitle:@"您当前还没有邮寄地址，点击添加邮寄地址或选择自取方式"];
        [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
        self.RemindGoodsView.Type = @"邮寄地址为空";
        self.RemindGoodsView.frame = self.view.bounds;
        __weak typeof (self) wealself = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [wealself dimssview];
        });

        return;
    }
    
    /**
     *  网络校验
     */
    long long orderId = 0;
    NSInteger refundType = 0;
    
    if (self.detailModel) {
        //** 鉴定退货 */
        orderId = self.detailModel.orderNumber.longLongValue;
        if (self.detailModel.identifyStatus == 2) {
            //** 成功退回 */
            refundType = 3;
        }else if (self.detailModel.identifyStatus == 3) {
            //** 失败退回 */
            refundType = 1;
        }
    }else if (self.fixGoodReturnId) {
        //** 一口价流拍退货啊 */
        orderId = self.fixGoodReturnId;
        refundType = 4;
    }
    
    //** 判断邮寄方式 */
    NSInteger deliveryType = 0;
    if (self.currentButton.tag == 1001) {
        deliveryType = 0;
    }else if (self.currentButton.tag == 1002){
        deliveryType = 1;
    }
    
    //** 鉴定 orderId 一口价  */
    [[YXMyAccountNetRequestTool sharedTool] returnGoodWithDeliveryType:[NSString stringWithFormat:@"%zd", deliveryType]
                                                            refundType:[NSString stringWithFormat:@"%zd", refundType]
                                                               orderId:[NSString stringWithFormat:@"%lld", orderId]
                                                                prodId:[NSString stringWithFormat:@"%lld", self.prodId]
                                                              buyoutId:[NSString stringWithFormat:@"%lld", self.buyoutId]
                                                           consigneeId:[NSString stringWithFormat:@"%lld", self.addressId]
                                                               success:^(id objc, id respodHeader) {
                                                                   
                                                                   [objc[@"status"] isEqualToString:@"1"] ? [self returnGoodExpectedVerificationSuccessWithObjc:objc] : [self showTipsWithObjc:objc];

                                                               }
                                                               failure:^(NSError *error) {
                                                                   YXLog(@"%@", error);
                                                               }];
}

/**
 请求退货成功

 @param objc 响应体
 */
- (void)returnGoodExpectedVerificationSuccessWithObjc:(id)objc
{
    /**
     *  安全验证
     */
    YXVerificationReturnGoodViewController *verificationReturnGoodViewCongtroller = [[YXVerificationReturnGoodViewController alloc] init];
    verificationReturnGoodViewCongtroller.delegate = self;
    [self.navigationController pushViewController:verificationReturnGoodViewCongtroller animated:YES];
}

/**
 显示提示
 
 @param objc objc
 */
- (void)showTipsWithObjc:(id)objc
{
    if ([objc[@"errorMsg"] isKindOfClass:[NSString class]]) {
        
        [YXAlertViewTool showAlertView:self title:@"提示" message:objc[@"errorMsg"] confrimBlock:^{
            
        }];
        
        return;
    }
    
    NSDictionary *errorMsg;
    NSString *ret_msg;
    @try {
        errorMsg = objc[@"errorMsg"];
        ret_msg = errorMsg[@"ret_msg"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    [YXAlertViewTool showAlertView:self title:@"提示" message:ret_msg confrimBlock:^{
        
    }];
}


/**
 添加按钮点击

 @param sender 添加按钮
 */
- (IBAction)addAddressButtonClick:(UIButton *)sender
{
    //** 跳转添加地址界面 */
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"addNewAddress" bundle:nil];
    YXAddNewAddressViewController *toTableViewController = [sb instantiateInitialViewController];
    toTableViewController.sourceController = self;
    YXNavigationController *navigationController = [[YXNavigationController alloc] initWithRootViewController:toTableViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

/**
 自取点击

 @param sender 自取按钮
 */
- (IBAction)pickUpButtonClick:(UIButton *)sender
{
    self.currentButton.selected = NO;
    sender.selected = YES;
    self.currentButton = sender;
    
    //** 切换信息 */
    self.consigneeLabel.text = @"联系人：";
    self.phoneNumberLabel.text = @"电话：";
    self.addressLabel.text = @"取货地址：";
    self.canClickImageView.hidden = YES;
    
    
    self.consigneeContentLabel.text = [YXLoadZitiData objectZiTiWithforKey:@"consigneeName"];
    self.phoneNumberContentLabel.text = [YXLoadZitiData objectZiTiWithforKey:@"consigneePhone"];
    self.addressContentLabel.text = [YXLoadZitiData objectZiTiWithforKey:@"consigneeAddress"];
    
    self.addDefaultAddressTipsView.hidden = YES;
}

/**
 物流快递点击

 @param sender 物流快递按钮
 */
- (IBAction)logisticsExpressButtonClick:(UIButton *)sender
{
    self.currentButton.selected = NO;
    sender.selected = YES;
    self.currentButton = sender;
    
    //** 切换信息 */
    self.consigneeLabel.text = @"收货人：";
    self.phoneNumberLabel.text = @"电话：";
    self.addressLabel.text = @"收货地址：";
    self.canClickImageView.hidden = NO;
    
    //** 判断是否有地址 */
    if (self.addressListArray.count == 0 || !self.addressListArray) {
        self.addDefaultAddressTipsView.hidden = NO;
    }else{
        
        if (!self.addressList) {
            
            self.addDefaultAddressTipsView.hidden = YES;
            YXMyAddressList *addressList = self.addressListArray[0];
            self.consigneeContentLabel.text = addressList.consigneeName;
            self.phoneNumberContentLabel.text = [YXStringFilterTool replaceStringWithAsterisk:addressList.consigneeMobile startLocation:3 lenght:4];
            self.addressContentLabel.text = [NSString stringWithFormat:@"%@ %@ %@", addressList.consigneeProvince, addressList.consigneeCity, addressList.consigneeAddressDetail];
            self.addressId = addressList.addressId;
            
        }else{
            
            self.addDefaultAddressTipsView.hidden = YES;
            self.consigneeContentLabel.text = self.addressList.consigneeName;
            self.phoneNumberContentLabel.text = [YXStringFilterTool replaceStringWithAsterisk:self.addressList.consigneeMobile startLocation:3 lenght:4];
            self.addressContentLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.addressList.consigneeProvince, self.addressList.consigneeCity, self.addressList.consigneeAddressDetail];
            self.addressId = self.addressList.addressId;
        }
    }
}

/**
 地址点击事件

 @param tap 手势
 */
- (void)detailSuperViewClick:(UIGestureRecognizer *)tap
{
    //** 判断是否可以点击 */
    if (self.canClickImageView.hidden) return;
    if (self.addressListArray.count == 0) return;
    
    //** 跳转地址管理列表界面 */
    YXMyAddressListController *addressListController = [[UIStoryboard storyboardWithName:@"myAddressList" bundle:nil] instantiateInitialViewController];
    YXNavigationController *navigationController = [[YXNavigationController alloc] initWithRootViewController:addressListController];
    addressListController.sourceController = self;
    [self presentViewController:navigationController animated:YES completion:nil];
}

/**
 消息按钮点击

 @param sender 点击的按钮
 */
- (void)messageButtonClick:(UIButton *)sender
{
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc]init];
    
    //    //**顾客头像**/
    NSString *sexstr = [YXUserDefaults objectForKey:@"head"];
    UIImage *avatar = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@",sexstr]];
    
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
    //    [chatViewManager.chatViewStyle setIncomingMsgSoundFileName:@"MQNewMessageRingStyleTwo.wav"];
    [chatViewManager enableMessageSound:true];
    
    [chatViewManager setNavTitleText:@"胤宝客服"];
    //    [chatViewManager setLoginCustomizedId:@"122322"];
    //开启同步消息
    [chatViewManager enableSyncServerMessage:true];
    [chatViewManager pushMQChatViewControllerInViewController:self];
}

#pragma mark - 获取网络数据

/**
 加载自取地址
 */
- (void)loadMyAddress
{
    YXImmediatelyMailMyAddressModel *mailAddressModel = [[YXImmediatelyMailMyAddressModel alloc] init];
    NSString *phonestr = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    mailAddressModel.customerPhone = phonestr;
    mailAddressModel.consigneeAddress = [YXLoadZitiData objectZiTiWithforKey:@"consigneeAddress"];
    mailAddressModel.consigneeName = [YXLoadZitiData objectZiTiWithforKey:@"consigneeName"];
    mailAddressModel.consigneePhone = [YXLoadZitiData objectZiTiWithforKey:@"consigneePhone"];
    mailAddressModel.businessTime = [YXLoadZitiData objectZiTiWithforKey:@"businessTime"];
    
    self.myAddressModel = mailAddressModel;
}

/**
 加载我的物流地址
 */
- (void)loadLogisticsExpressAddress
{
    [[YXMyAccountNetRequestTool sharedTool] loadMyAddressWithCurPage:1 andPageSize:10 success:^(id objc, id respodHeader) {
        
        [YXNetworkHUD dismiss];
        NSArray *dataArray = objc[@"data"];
        self.addressListArray = [YXMyAddressList mj_objectArrayWithKeyValuesArray:dataArray];
        [self logisticsExpressButtonClick:self.logisticsExpressButton];
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 设置title */
    self.navigationItem.title = @"我要退回";
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"ic_returnGood_message"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(messageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    //** 添加点击手势 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailSuperViewClick:)];
    [self.detailSuperView addGestureRecognizer:tap];
    
    //** 赋值 */
    if (self.endBidList) {
        self.goodNameLabel.text = self.endBidList.prodName;
    }else if (self.detailModel) {
        self.goodNameLabel.text = self.detailModel.prodName;
    }else if (self.goodName){
        self.goodNameLabel.text = self.goodName;
    }
    
    //** 画边框 */
    [self.addNewAddressButton.layer setBorderWidth:1.0];
    [self.addNewAddressButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
    CGColorRef color = [UIColor mainThemColor].CGColor;
    [self.addNewAddressButton.layer setBorderColor:color];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //** 获取网络数据 */
    [self loadMyAddress];
    [self loadLogisticsExpressAddress];

}



#pragma mark - 懒加载

- (YXMyOrderSuccessAlerview *)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}


@end
