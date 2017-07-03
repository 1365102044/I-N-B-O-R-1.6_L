//
//  YXRefundMySureMoneyViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXRefundMySureMoneyViewController.h"
#import "UILabel+YBAttributeTextTapAction.h"

@interface YXRefundMySureMoneyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *proNameLable;

@property (weak, nonatomic) IBOutlet UILabel *StatusLable;

@property (weak, nonatomic) IBOutlet UIButton *sureMoneyBtn;

@property (weak, nonatomic) IBOutlet UILabel *payTypeLable;

@property (weak, nonatomic) IBOutlet UILabel *payTypeLable1;

@property (weak, nonatomic) IBOutlet UILabel *payTypeLable2;


@property (weak, nonatomic) IBOutlet UILabel *refundmoneystatusTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *RefundMoneySatatusLable;


@property (weak, nonatomic) IBOutlet UILabel *creattimetitleLable;
@property (weak, nonatomic) IBOutlet UILabel *CreatTimeLable;

@property (weak, nonatomic) IBOutlet UILabel *DescLable;

@property (weak, nonatomic) IBOutlet UIView *boomlineview;
/*
 @brief 大的view
 */
@property (weak, nonatomic) IBOutlet UIView *bigbackview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigbackviewheightconstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *refundstatustitleconstant;

@end

@implementation YXRefundMySureMoneyViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
     @brief 已解冻
     */
    self.navigationItem.title = @"保证金详情";
    
    [self requestData];

}

-(void)setUIdata:(NSDictionary*)objc
{
    if(objc==nil||objc.count==0)
    {
        return;
    }
    self.proNameLable.text = objc[@"prodName"];
    NSInteger status = [objc[@"marginStatus"] integerValue];
    
    NSString *descstr;
   

    NSString *phonestr = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    if (status  == 4) {
        
        
        self.StatusLable.text = @"退款完成";
       descstr = [NSString stringWithFormat:@"款项说明：退款已处理，预计1-3个工作日到账。如有疑问请联系客服 %@",phonestr];
        self.RefundMoneySatatusLable.text = @"已完成";

    }else
    {
        self.StatusLable.text = @"等待退款";
        self.RefundMoneySatatusLable.text = @"处理中";
        
       descstr = [NSString stringWithFormat:@"款项说明：未成功竞拍，竞拍结束后预计1-3个工作日退回保证金。如有疑问请联系客服 %@",phonestr];

        
    }
    
     NSMutableAttributedString* currenattrStr = [[NSMutableAttributedString alloc]initWithString:descstr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5.0];
    [currenattrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [currenattrStr length])];
   [currenattrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(descstr.length-12, 12)];
    self.DescLable.attributedText = currenattrStr;

    /*
     @brief 打电话
     */
    [self.DescLable yb_addAttributeTapActionWithStrings:@[phonestr] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSString *phone =string;
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];

        
    }];
    
    NSInteger suremoney = [objc[@"marginPrice"] integerValue]/100;
       NSString  *suremoneypricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",suremoney] ];
    [self.sureMoneyBtn setTitle:[NSString stringWithFormat:@" 保证金：￥%@",suremoneypricestr] forState:UIControlStateNormal];

    
    
    self.CreatTimeLable.text = [YXStringFilterTool transformfromenumbertoTiemstr:[objc[@"createTime"] doubleValue]];

    
    NSArray *paytypearr = objc[@"payType"];


    switch (paytypearr.count) {
        case 0:
            
            self.payTypeLable1.hidden = YES;
            self.payTypeLable2.hidden = YES;
            self.bigbackviewheightconstant.constant = 240;
            self.refundstatustitleconstant.constant = 5;
            
            break;
        case 1:
            /**
             * 支付路径: 1 手机网银支付，2 手机微信支付，3手机支付宝支付
             */
            if ([paytypearr[0] isEqual:@"1"]) {
                
                self.payTypeLable.text = @"PC网银";
            }else if ([paytypearr[0] isEqual:@"2"]) {
                
                self.payTypeLable.text = @"微信";
            }else if ([paytypearr[0] isEqual:@"3"]) {
                
                self.payTypeLable.text = @"支付宝";
            }
            
            
            self.payTypeLable1.hidden = YES;
            self.payTypeLable2.hidden = YES;
            self.bigbackviewheightconstant.constant = 240;
            self.refundstatustitleconstant.constant = 5;

            
            break;
        case 2:
            if ([paytypearr[0] integerValue ] == 1) {
                
                self.payTypeLable.text = @"PC网银";
            }else if ([paytypearr[0] integerValue ] == 2) {
                
                self.payTypeLable.text = @"微信";
            }else if ([paytypearr[0] integerValue ] == 3) {
                
                self.payTypeLable.text = @"支付宝";
            }
            
            if ([paytypearr[1] integerValue ] == 1) {
                
                self.payTypeLable1.text = @"PC网银";
            }else if ([paytypearr[1] integerValue ] == 2) {
                
                self.payTypeLable1.text = @"微信";
            }else if ([paytypearr[1] integerValue ] == 3) {
                
                self.payTypeLable1.text = @"支付宝";
            }
            
        
            self.payTypeLable2.hidden = YES;
            self.bigbackviewheightconstant.constant = 255;
            self.refundstatustitleconstant.constant = 25;
            break;
        case 3:
            if ([paytypearr[0] integerValue ] == 1) {
                
                self.payTypeLable.text = @"PC网银";
            }else if ([paytypearr[0] integerValue ] == 2) {
                
                self.payTypeLable.text = @"微信";
            }else if ([paytypearr[0] integerValue ] == 3) {
                
                self.payTypeLable.text = @"支付宝";
            }
            
            if ([paytypearr[1] integerValue ] == 1) {
                
                self.payTypeLable1.text = @"PC网银";
            }else if ([paytypearr[1] integerValue ] == 2) {
                
                self.payTypeLable1.text = @"微信";
            }else if ([paytypearr[1] integerValue ] == 3) {
                
                self.payTypeLable1.text = @"支付宝";
            }
            
            if ([paytypearr[2] integerValue ] == 1) {
                
                self.payTypeLable2.text = @"PC网银";
            }else if ([paytypearr[2] integerValue ] == 2) {
                
                self.payTypeLable2.text = @"微信";
            }else if ([paytypearr[2] integerValue ] == 3) {
                
                self.payTypeLable2.text = @"支付宝";
            }
      
            self.bigbackviewheightconstant.constant = 275;
            self.refundstatustitleconstant.constant = 45;
            break;
           
        default:
            break;
    }
    self.creattimetitleLable.y = self.refundmoneystatusTitleLable.bottom+5;
    self.CreatTimeLable.y = self.creattimetitleLable.y;
    self.boomlineview.y = self.creattimetitleLable.bottom+10;
    self.DescLable.frame = CGRectMake(10, self.boomlineview.bottom+5, YXScreenW-20, 40);

}


-(void)requestData
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"marginId"] = self.marginId;
    [YXRequestTool requestDataWithType:POST url:@"/api/margin/detail" params:parm success:^(id objc, id respodHeader) {

        if (objc!=nil) {
            
            [self setUIdata:objc];
        }else{
        
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
