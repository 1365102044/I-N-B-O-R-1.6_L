//
//  YXZBarPaySuccessOrFailResultViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/1.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXZBarPaySuccessOrFailResultViewController.h"
#import "UILabel+Extension.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "YXMyOrderSuccessAlerview.h"
#import "YXPaySuccessDataModle.h"
#import "YXMyAccountGOPaymentConfirmAddressViewController.h"
#import "YXOneMouthPriceConfirmOrderViewController.h"
@interface YXZBarPaySuccessOrFailResultViewController ()<YBAttributeTapActionDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigbackViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigbackViewGHeight;
@property (weak, nonatomic) IBOutlet UIView *bigbackview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paipinIDLableTop;
@property (weak, nonatomic) IBOutlet UILabel *paipinIDLable;

@property (weak, nonatomic) IBOutlet UILabel *shangpinNameLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shangpinNameLableHeight;



@property (weak, nonatomic) IBOutlet UILabel *shangpinPriceLableTop;

@property (weak, nonatomic) IBOutlet UILabel *shangpinPriceLable;

@property (weak, nonatomic) IBOutlet UILabel *alearlyPriceLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alearlyPriceHeight;

@property (weak, nonatomic) IBOutlet UILabel *shouldPriceLable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shouldPriceLableTop;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shouldPriceLableHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tishiDescLableTop;
@property (weak, nonatomic) IBOutlet UILabel *tishiDescLable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tishiDescLableHeight;


@property (weak, nonatomic) IBOutlet UIButton *successBnt;
@property (weak, nonatomic) IBOutlet UIButton *chongxinBtn;


/*
 @brief 支付结果
*/
@property(nonatomic,strong) YXMyOrderSuccessAlerview*RemindGoodsView;

//**回调数据**/
@property(nonatomic,strong) YXPaySuccessDataModle * reponseModle;
@end

@implementation YXZBarPaySuccessOrFailResultViewController
-(YXMyOrderSuccessAlerview*)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImage *image = [[UIImage imageNamed:@"backpayItem"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *nilbtn = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.leftBarButtonItem = nilbtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"PC网银扫码支付";
    
    [self setUI];
    
    if(!self.dataDict.count)
    {
        return;
    }
    
    NSString *str ;
    NSString *allpri = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",[self.dataDict[@"AllPrice"] integerValue]/100]];
    //**type (1鉴定订单，2拍卖订单，3保证金)**/
    if([self.dataDict[@"type"] integerValue] == 1)
    {
        self.paipinIDLableTop.constant = 80;
        self.paipinIDLable.text = [NSString stringWithFormat:@"鉴定编号：%@",self.dataDict[@"OrderID"]];
        
        str =[NSString stringWithFormat:@"鉴定金额：¥%@",allpri];
        
        self.shangpinNameLableHeight.constant = 0;
        self.shouldPriceLableTop.constant = 0;
        
    }else if([self.dataDict[@"type"] integerValue] == 2||[self.dataDict[@"type"] integerValue]==4)
    {
        self.paipinIDLable.text = [NSString stringWithFormat:@"订单编号：%@",self.dataDict[@"OrderID"]];
        str =[NSString stringWithFormat:@"商品金额：¥%@",allpri];
        
    }else if ([self.dataDict[@"type"] integerValue] == 3)
    {
        self.paipinIDLable.text = [NSString stringWithFormat:@"保证金编号：%@",self.dataDict[@"OrderID"]];
        str =[NSString stringWithFormat:@"保证金金额：¥%@",allpri];
    }
    
    self.shangpinNameLable.text = [NSString stringWithFormat:@"商品名字：%@",self.dataDict[@"goodsName"]];
    
    NSMutableAttributedString *atter = [[NSMutableAttributedString alloc]initWithString:str];
    
    [atter addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(5, atter.length-5)];
    self.shangpinPriceLable.attributedText = atter;
    
    
    if ([self.dataDict[@"isPartPay"] integerValue] == 1) {
        
        NSString *alearlypri = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",[self.dataDict[@"AlearlyPrice"] integerValue]/100]];
        self.alearlyPriceLable.text = [NSString stringWithFormat:@"已付金额：¥%@",alearlypri];
        
    }else{
        self.shouldPriceLableTop.constant = 0;
        self.alearlyPriceHeight.constant = 0;
        
    }
    
    NSString *shouldpri = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",[self.dataDict[@"ShouldPrice"] integerValue]/100]];
    self.shouldPriceLable.text = [NSString stringWithFormat:@"应付金额：¥%@",shouldpri];
    
    if([self.dataDict[@"type"] integerValue] == 1){
        
        self.shouldPriceLableHeight.constant = 0;
        self.tishiDescLableTop.constant = 0;
    }
    
    
}


-(void)setUI
{
    if (YXScreenW<=320) {
        self.bigbackViewWidth.constant = 270;
    }
    
    self.bigbackview.layer.cornerRadius = 5;
    self.bigbackview.layer.masksToBounds = YES;
    self.bigbackview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.bigbackview.layer.borderWidth = 1;
    
    self.successBnt.layer.cornerRadius = 5;
    self.successBnt.layer.masksToBounds  = YES;
    
    self.chongxinBtn.layer.cornerRadius = 5;
    self.chongxinBtn.layer.masksToBounds  = YES;
    
    //    [self.tishiDescLable setRowSpace:10];
    
    NSString *phonestr = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    NSString *str = [NSString stringWithFormat:@"提示：如果支付遇到问题，请联系客服或致电我们24小时客服人热线：%@",phonestr];
    NSMutableAttributedString *atterstr = [[NSMutableAttributedString alloc]initWithString:str];
    [atterstr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(32, atterstr.length-32)];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5.0];
    [atterstr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [atterstr length])];
    
    self.tishiDescLable.attributedText = atterstr;
    
    NSString *phon = phonestr;
    //--添加点击事件
    [self.tishiDescLable yb_addAttributeTapActionWithStrings:@[phon] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        
        //打开电话
        NSString *phone = phonestr;
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
    }];
    
    if (YXScreenW<=320) {
        self.tishiDescLableHeight.constant = 75;
        self.bigbackViewGHeight.constant = 380;
    }
}
-(void)setDataDict:(NSMutableDictionary *)dataDict
{
    _dataDict = dataDict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickSuccessBtn:(id)sender {
    
    [self requestCheckPayStatus];
}

- (IBAction)ClickChongxinBtn:(id)sender {
    
    [self requestCheckPayStatus];
    
}


#pragma mark  ******************* 点击回调**********************

/*
 forme vc
 waitpay vc
 扫码vc
 自己vc
 */
/*
 @brief 返回的时候，需要查询一下，支付是否 成功。。。。
 */
-(void)requestCheckPayStatus
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.dataDict[@"OrderID"];
    param[@"type"] = self.dataDict[@"type"];
    
    
    [YXRequestTool requestDataWithType:POST url:@"/api/payment/queryIsSuccess" params:param success:^(id objc, id respodHeader) {
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
          self.reponseModle = [YXPaySuccessDataModle mj_objectWithKeyValues:objc];
            
            
            NSArray *VCarr = self.navigationController.viewControllers;
            
            if ([self.reponseModle.success integerValue] == 1 ) {
                    
                    if (VCarr.count>=4) {
                        
                        for (UIViewController *VC in self.navigationController.viewControllers) {
                            
                            if ([VC isKindOfClass:[YXMyAccountGOPaymentConfirmAddressViewController class]]) {
                            //** 经过选择地址 ++和 +返回到一口价详情**/
                                     [self.navigationController popToViewController:[VCarr objectAtIndex:(VCarr.count-5)] animated:YES];
                                
                                return ;
                                
                            }else if ([VC isKindOfClass:[YXOneMouthPriceConfirmOrderViewController class]]){
                                
                                //** 返回到一口价详情**/
                                [self.navigationController popToViewController:[VCarr objectAtIndex:(VCarr.count-5)] animated:YES];
                                
                                return ;
                                
                            }
                           
                        }
                        
                    
                            [self.navigationController popToViewController:[VCarr objectAtIndex:(VCarr.count-4)] animated:YES];
                        
                    }
        
                
            }else{
                
//                [self attentiontype:@"扫码支付失败"];
                
                if (VCarr.count>=3) {
                    /*alreadyPay 已支付
                     shouldAmt 剩余金额
                     */

                        if ([self.reponseModle.alreadyPay integerValue]/100) {
                            
                            [YXNotificationTool postNotificationName:@"POSTPAYDICT" object:nil userInfo:@{@"alreadyPay":self.reponseModle.alreadyPay,@"shouldAmt":self.reponseModle.shouldAmt}];
                            
                        }
                    [self.navigationController popToViewController:[VCarr objectAtIndex:(VCarr.count-3)] animated:YES];

                    //6787  15110082314
                    
                }
            }
            
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

/*
 @brief 结果提示框
 */
-(void)attentiontype:(NSString*)type
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
    self.RemindGoodsView.Type = type;
    self.RemindGoodsView.frame = self.view.bounds;
    __weak typeof (self) wealself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [wealself dimssview];
    });
    
}
/*
 @brief 消失的时候 移除所有的弹出视图
 */
-(void)dimssview
{
    [self.RemindGoodsView removeFromSuperview];
    self.RemindGoodsView = nil;
}
@end
