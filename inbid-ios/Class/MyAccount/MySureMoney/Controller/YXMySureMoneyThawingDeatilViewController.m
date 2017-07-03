//
//  YXMySureMoneyThawingDeatilViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySureMoneyThawingDeatilViewController.h"
#import "YXOrderDetailViewController.h"
#import "UILabel+Extension.h"

@interface YXMySureMoneyThawingDeatilViewController ()
{
    NSArray *paytypearr;
    
}
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;
/*
 @brief 支付方式
 */
@property (weak, nonatomic) IBOutlet UILabel *paytypeLable;
@property (weak, nonatomic) IBOutlet UILabel *payRouteTitleLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payRouteTtitleHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dingdantimeTopcontent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payrouteTopContent;


@property (weak, nonatomic) IBOutlet UILabel *payRouteLable;
@property (weak, nonatomic) IBOutlet UILabel *payRouteLable1;
@property (weak, nonatomic) IBOutlet UILabel *payRouteLable2;

@property (weak, nonatomic) IBOutlet UILabel *createodertimetitlelable;
@property (weak, nonatomic) IBOutlet UILabel *creatordertimeLable;

@property (weak, nonatomic) IBOutlet UILabel *odermoneycoutTitleLable;

@property (weak, nonatomic) IBOutlet UILabel *odermoneycountLable;

@property (weak, nonatomic) IBOutlet UIView *bigbackview;
@property (weak, nonatomic) IBOutlet UIView *topview;


/*
 @brief bigview的高度和下单时间距上的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigbackviewcontant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *creatordertitlelalecontant;

/*
 @brief desclable and backview
 */
@property (weak, nonatomic) IBOutlet UIView *descbackbigview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descbackbigviewcontantheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desclablecontantheight;
@property (weak, nonatomic) IBOutlet UILabel *desclable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desclablecontanty;

@property (weak, nonatomic) IBOutlet UIButton *gotoseeorderbtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gotoseeorderdeatilcontantY;

@property(nonatomic,strong) NSDictionary * datadict;

@end

@implementation YXMySureMoneyThawingDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
     @brief 冻结中 详情
     */
    self.navigationItem.title = @"保证金详情";
    
    [self requestData];
    
    
}
-(void)requestData
{
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"marginId"] = self.marginId;
    [YXRequestTool requestDataWithType:POST url:@"/api/margin/detail" params:parm success:^(id objc, id respodHeader) {
          if (objc!=nil) {
            self.datadict = objc;
            [self setUIdata:objc];
          }
    } failure:^(NSError *error) {
        
        
    }];
    
}


-(void)setUIdata:(NSMutableDictionary*)objc
{
    if (objc==nil) {
        return;
    }
    
    self.gotoseeorderbtn.layer.masksToBounds = YES;
    self.gotoseeorderbtn.layer.cornerRadius = 3;
    
    self.descbackbigview.hidden = YES;
    if (self.isPartPay == 0) {
        self.paytypeLable.text = @"全额支付";
    }else if (self.isPartPay == 1)
    {
        self.paytypeLable.text = @"分笔支付";
    }
    
    if (self.marginStatus == 6) {
        
        self.statusLable.text = @"已抵扣";
        self.descbackbigview.hidden = NO;
    }else if (self.marginStatus == 5)
    {
        self.descbackbigview.hidden = NO;
        self.statusLable.text = @"已罚扣";
    
    }

    
   
    
    self.titleLable.text = objc[@"prodName"];
    
    NSString  *ordermoneypricestr = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",[objc[@"marginPrice"] integerValue]/100] ];

    self.odermoneycountLable.text = [NSString stringWithFormat:@"￥%@",ordermoneypricestr];
    
    
    

    
    self.creatordertimeLable.text = [YXStringFilterTool transformfromenumbertoTiemstr:[objc[@"createTime"] longLongValue]];
    
    paytypearr = objc[@"payType"];
    
    
    
    switch (paytypearr.count) {
        case 0:
            self.payRouteLable1.hidden = YES;
            self.payRouteLable2.hidden = YES;
            self.payRouteLable.hidden = YES;
            self.payRouteTtitleHeight.constant = 0;
            self.payrouteTopContent.constant = 0;
            self.dingdantimeTopcontent.constant = 0;
            self.bigbackviewcontant.constant = 145;
            self.creatordertitlelalecontant.constant = 10;
            
            break;
        case 1:
            
            /**
             * 支付路径: 1 手机PC网银，2 手机微信，3手机支付宝
             */
            if ([paytypearr[0] integerValue] == 1) {
                
                self.payRouteLable.text = @"PC网银";
                
            }else if ([paytypearr[0] integerValue] == 2) {
                
                self.payRouteLable.text = @"微信";
                
            }else if ([paytypearr[0] integerValue] == 3) {
                
                self.payRouteLable.text = @"支付宝";
            }
            
            
            self.payRouteLable1.hidden = YES;
            self.payRouteLable2.hidden = YES;
            self.bigbackviewcontant.constant = 160;
            
            self.creatordertitlelalecontant.constant = 10;
            
            break;
        case 2:
            if ([paytypearr[0] integerValue] == 1) {
                
                self.payRouteLable.text = @"PC网银";
            }else if ([paytypearr[0] integerValue] == 2) {
                
                self.payRouteLable.text = @"微信";
            }else if ([paytypearr[0] integerValue] == 3) {
                
                self.payRouteLable.text = @"支付宝";
            }
            
            if ([paytypearr[1] integerValue] == 1) {
                
                self.payRouteLable1.text = @"PC网银";
            }else if ([paytypearr[1] integerValue] == 2) {
                
                self.payRouteLable1.text = @"微信";
            }else if ([paytypearr[1] integerValue] == 3) {
                
                self.payRouteLable1.text = @"支付宝";
            }
            
            self.payRouteLable2.hidden = YES;
            self.bigbackviewcontant.constant = 175;
            self.creatordertitlelalecontant.constant = 35;
            
            break;
        case 3:
            if ([paytypearr[0] integerValue] == 1) {
                
                self.payRouteLable.text = @"PC网银";
            }else if ([paytypearr[0] integerValue] == 2) {
                
                self.payRouteLable.text = @"微信";
            }else if ([paytypearr[0] integerValue] ==3) {
                
                self.payRouteLable.text = @"支付宝";
            }
            
            if ([paytypearr[1] integerValue] == 1) {
                
                self.payRouteLable1.text = @"PC网银";
            }else if ([paytypearr[1] integerValue] == 2) {
                
                self.payRouteLable1.text = @"微信";
            }else if ([paytypearr[1] integerValue] == 3) {
                
                self.payRouteLable1.text = @"支付宝";
            }
            
            if ([paytypearr[2] integerValue] == 1) {
                
                self.payRouteLable2.text = @"PC网银";
            }else if ([paytypearr[2] integerValue] == 2) {
                
                self.payRouteLable2.text = @"微信";
                
            }else if ([paytypearr[2] integerValue] == 3) {
                
                self.payRouteLable2.text = @"支付宝";
            }
            
             self.creatordertitlelalecontant.constant = 55;
            break;
            
        default:
            break;
    }
    self.odermoneycoutTitleLable.y = self.createodertimetitlelable.bottom+5;
    self.odermoneycountLable.y = self.odermoneycoutTitleLable.y;
 
    
    NSString *descstr;
    if (self.marginStatus == 6) {
        descstr = [NSString stringWithFormat:@"您已成功拍下 (%@) 商品，保证金已抵扣为商品金额，生成订单后，应付金额会自动减去保证金金额。",objc[@"prodName"]];
    }else if (self.marginStatus == 5)
    {
        descstr = [NSString stringWithFormat:@"您已成功拍下 (%@) 商品，但未在规定时间内付款，造成商品流拍，保证金依据竞拍规则，予以罚扣。",objc[@"prodName"]];
    }
    
    if (self.marginStatus ==6 ||self.marginStatus ==5) {
        
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc]initWithString:descstr];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:2.0];
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [attrStr length])];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor mainThemColor] range:NSMakeRange(6, [objc[@"prodName"] length]+3 )];
        [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(13) range:NSMakeRange(0, [attrStr length])];
        self.desclable.attributedText = attrStr;


        CGFloat descHeight = [self.desclable heightWithWidth:YXScreenW-25];
        
        self.desclablecontantheight.constant = descHeight;
        self.descbackbigviewcontantheight.constant = descHeight+30+10;
    }

    
}

/*
 @brief 查看订单详情
 */
- (IBAction)ClickgotoseeorderdeatilBtn:(id)sender {
    
    NSString *orderID = self.datadict[@"orderId"];
    YXOrderDetailViewController *VC= [YXOrderDetailViewController orderDetailViewControllerWithOrderId:[orderID longLongValue] andExtend:nil];
    [self.navigationController pushViewController:VC animated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
