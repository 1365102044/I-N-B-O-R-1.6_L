//
//  YXPlatformRecoveryController.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPlatformRecoveryController.h"
#import "YXMySendAuctionHoldTest.h"
#import "YXMyAccountNetRequestTool.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "YXAppraisalReportController.h"
#import "YXAppraisaReportIdentifyModel.h"
#import "YXAlertViewTool.h"
#import "YXOrderDetailModel.h"

@interface YXPlatformRecoveryController ()<YBAttributeTapActionDelegate>

/**
 商品品牌及名称
 */
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;

/**
 系统提供的起拍价
 */
@property (weak, nonatomic) IBOutlet UILabel *systemPriceLabel;

/**
 官方提示label
 */
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

/**
 查看鉴定报告
 */
@property (weak, nonatomic) IBOutlet UILabel *checkReportLabel;

@end

@implementation YXPlatformRecoveryController


/**
 UILabel点击文字事件
 
 @param string 点击的文字
 @param range  范围
 @param index  下标
 */
- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index
{
//    YXAppraisalReportController *appraisalReportController = [[YXAppraisalReportController alloc] init];
//    if (self.appraisaReportIdentifyModel) {
//        appraisalReportController.identifyId = self.appraisaReportIdentifyModel.indentifyOrderId;
//    }else if (self.sendAuctionHoldTestModel){
//        appraisalReportController.identifyId = self.sendAuctionHoldTestModel.orderId;
//    }
//    [self.navigationController pushViewController:appraisalReportController animated:YES];
}



#pragma mark - 响应事件



//** 同意回收 */
- (IBAction)sureRecoveryButtonClick:(UIButton *)sender
{
    if (self.appraisaReportIdentifyModel) {
        [self loadRequestWithOrderId:self.appraisaReportIdentifyModel.indentifyOrderId];
    }else if (self.orderDetailModel){
        [self loadRequestWithOrderId:self.orderDetailModel.orderId.longLongValue];
    }
}

/**
 同意回收网络请求

 @param oderId oderId 订单号
 */
- (void)loadRequestWithOrderId:(long long)oderId
{
    if ([self.type isEqualToString:@"一口价"]) {
        [YXAlertViewTool showAlertView:self title:@"提示" message:@"可在“我的”-“我的鉴定”中查看平台回收处理进度" cancelTitle:@"取消" otherTitle:@"确定" cancelBlock:^{
            
        } confrimBlock:^{
            [[YXMyAccountNetRequestTool sharedTool] setBuyoutChooseConfirmWIthId:self.appraisaReportIdentifyModel.indentifyOrderId type:3 saleDay:nil buyoutPrice:nil success:^(id objc, id respodHeader) {
                if ([objc isEqualToString:@"提交成功"] || [respodHeader[@"Status"] isEqualToString:@"1"]) {
                    [self showAlertWithTitle:@"回收请求已成功提交，请耐心等待"];
                }else{
                    [self showAlertWithTitle:@"网络繁忙，请稍后重试"];
                }
            } failure:^(NSError *error) {
                
            }];
        }];
        return;
    }
    
    [[YXMyAccountNetRequestTool sharedTool] confirmRecycleWithIdentifyId:oderId success:^(id objc, id respodHeader) {
        
        if ([objc isEqualToString:@"提交成功"] || [respodHeader[@"Status"] isEqualToString:@"1"]) {
            [self showAlertWithTitle:@"回收请求已成功提交，请耐心等待"];
        }else{
            [self showAlertWithTitle:@"网络繁忙，请稍后重试"];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"平台回收";
    
    if (self.appraisaReportIdentifyModel) {
        
        //--赋值
        self.goodNameLabel.text = self.appraisaReportIdentifyModel.prodName;
        self.systemPriceLabel.text = [NSString stringWithFormat:@"系统给出的回收价格为 ¥%@", [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%zd", self.appraisaReportIdentifyModel.recycleMoney / 100]]];
        
        //设置提示文案行间距
        NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle2.lineSpacing = 6;
        NSString *psText = @"同意回收后，即为达成交易，系统会在5个工作日之内将钱款打至您绑定的银行卡内，请留意短信提醒。";
        NSMutableAttributedString *attributes2 = [[NSMutableAttributedString alloc] initWithString:psText];
        NSDictionary *allAttributes = @{
                                        NSFontAttributeName:[UIFont systemFontOfSize:11],
                                        NSParagraphStyleAttributeName:paragraphStyle2
                                        };
        [attributes2 addAttributes:allAttributes range:NSMakeRange(0, psText.length)];
        self.tipsLabel.attributedText = attributes2;
        
        [self setTipsText:@"经官方鉴定，您的商品符合售卖规定。"];
        
    }else if(self.orderDetailModel) {
        //--赋值
        self.goodNameLabel.text = self.orderDetailModel.prodName;
        self.systemPriceLabel.text = [NSString stringWithFormat:@"系统给出的回收价格为 ¥%@", [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%zd",
                                                                                                                       self.orderDetailModel.recycleMoney / 100]]];
        
        //设置提示文案行间距
        NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle2.lineSpacing = 6;
        NSString *psText = @"同意回收后，即为达成交易，系统会在5个工作日之内将钱款打至您绑定的银行卡内，请留意短信提醒。";
        NSMutableAttributedString *attributes2 = [[NSMutableAttributedString alloc] initWithString:psText];
        NSDictionary *allAttributes = @{
                                        NSFontAttributeName:[UIFont systemFontOfSize:11],
                                        NSParagraphStyleAttributeName:paragraphStyle2
                                        };
        [attributes2 addAttributes:allAttributes range:NSMakeRange(0, psText.length)];
        self.tipsLabel.attributedText = attributes2;
        
        [self setTipsText:@"经官方鉴定，您的商品符合售卖规定。"];
    }
    
}

/**
  更新提示标签文案
  
  @param tipsText 传入提示文字
  */
- (void)setTipsText:(NSString *)tipsText
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;
    NSString *psText = tipsText;
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:psText];
    NSDictionary *allAttributes = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:13],
                                    NSParagraphStyleAttributeName:paragraphStyle
                                    };
    [attributes addAttributes:allAttributes range:NSMakeRange(0, psText.length)];
    //[attributes addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:151.0/255.0 green:29.0/255.0 blue:20.0/255.0 alpha:1.0] range:NSMakeRange(17, 8)];
    
    self.checkReportLabel.attributedText = attributes;
    self.checkReportLabel.lineBreakMode=NSLineBreakByWordWrapping;
    //--添加点击事件
    [self.checkReportLabel yb_addAttributeTapActionWithStrings:@[@"（查看鉴定报告）"] delegate:self];
}



//** 弹出登录或未登录alert */
- (void)showAlertWithTitle:(NSString *)title
{
    UIAlertAction *defaultAction;
    if ([title isEqualToString:@"回收请求已成功提交，请耐心等待"]) {
        defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){
            [self popToListViewController];
        }];
    }else if ([title isEqualToString:@"网络繁忙，请稍后重试"]){
        defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
    [self presentViewController: alert animated:YES completion:nil];
    
}

/**
 回到列表控制器
 */
- (void)popToListViewController
{
    NSArray *navigationControllersArray = self.navigationController.childViewControllers;
    [self.navigationController popToViewController:navigationControllersArray[1] animated:YES];
    //** 监听到用户完成操作 */
    if ([self.delegate respondsToSelector:@selector(platformRecoveryController:changeRestPageON:)]) {
        [self.delegate platformRecoveryController:self changeRestPageON:YES];
    }
}



@end
