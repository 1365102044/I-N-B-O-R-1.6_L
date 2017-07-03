//
//  YXPlatformOnBehalfOfSellingContentController.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPlatformOnBehalfOfSellingContentController.h"
#import "YXMySendAuctionHoldTest.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXSurePlatformOnBehalfOfSellingView.h"
#import "YXKeyboardToolbar.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "YXAppraisalReportController.h"
#import "NSString+File.h"
#import "YXStringFilterTool.h"
#import "YXOrderDetailModel.h"

@interface YXPlatformOnBehalfOfSellingContentController ()<YXSurePlatformOnBehalOfSellingViewDelegate, YBAttributeTapActionDelegate>

/**
 商品品牌及名称
 */
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;

/**
 系统给出起拍价范围label
 */
@property (weak, nonatomic) IBOutlet UILabel *systemStartPriceRangeLabel;

/**
 用户输入的起拍金额
 */
@property (weak, nonatomic) IBOutlet UITextField *userInputPriceTextField;

/**
 确定回收界面
 */
@property (nonatomic, strong) YXSurePlatformOnBehalfOfSellingView *suerPlatformOnBehalfOfSellingView;

/**
 辅助视图
 */
@property (nonatomic, strong) YXKeyboardToolbar *customAccessoryView;

/**
 官方提示label
 */
@property (weak, nonatomic) IBOutlet UILabel *officTipsLabel;

/**
 佣金提示label
 */
@property (weak, nonatomic) IBOutlet UILabel *commissionTipsLabel;

@end

@implementation YXPlatformOnBehalfOfSellingContentController



#pragma mark - 点击事件

#pragma mark --YXSurePlatformOnBehalOfSellingViewDelegate

- (void)suerPlatformOnBehalOfSellingView:(YXSurePlatformOnBehalfOfSellingView *)suerPlatformBehalOfsellingView andClickButton:(UIButton *)sender
{
    [suerPlatformBehalOfsellingView removeFromSuperview];
    if ([self.obsverDelegate respondsToSelector:@selector(platformOnBehalfOfSellingContentController:changeRestPageON:)]) {
        [self.obsverDelegate platformOnBehalfOfSellingContentController:self changeRestPageON:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - YXKeyboardToolbarDelegate

- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    [self.view endEditing:YES];
}

/**
 UILabel点击文字事件
 
 @param string 点击的文字
 @param range  范围
 @param index  下标
 */
- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index
{
    //** TODO:鉴定报告跳转 */
//    YXAppraisalReportController *appraisalReportController = [[YXAppraisalReportController alloc] init];
//    appraisalReportController.identifyId = self.sendAuctionHoldTestModel.orderId;
//    [self.navigationController pushViewController:appraisalReportController animated:YES];
}

//** 确认代卖按钮点击 */
- (IBAction)sureButtonClick:(UIButton *)sender
{
    if ([self.userInputPriceTextField.text isEqualToString:@""] || self.userInputPriceTextField.text.length == 0) {
        [self showAlertWithTitle:@"起拍价不能为空"];
        return;
    }
    
    if (self.userInputPriceTextField.text.floatValue < self.detailModel.minSuggestMoney.integerValue / 100 || self.userInputPriceTextField.text.floatValue > self.detailModel.maxSuggestMoney / 100) {
        
        [self showAlertWithTitle:@"您输入的价格不在起拍价格范围之内，请重新输入正确价格"];
        return;
    }
    
    CGFloat userText = self.userInputPriceTextField.text.floatValue;
    userText *= 100;
    
    [[YXMyAccountNetRequestTool sharedTool] sureReplaceSellWithIdentifyId:self.detailModel.orderNumber.longLongValue withSuggestPrice: self.detailModel.suggestMoney withUserSetPrice:[NSString notRounding:userText afterPoint:0] success:^(id objc, id respodHeader) {
        YXLog(@"%@---%@", objc, respodHeader);
        
        if ([objc isEqualToString:@"您输入的起拍价超出了范围！"] && [respodHeader[@"Status"] isEqualToString:@"2"]) {
            
            [self showAlertWithTitle: objc];
        }else{
            [self.tableView endEditing:YES];
            [[UIApplication sharedApplication].keyWindow addSubview:self.suerPlatformOnBehalfOfSellingView];
        }
        
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark - 控制器生命周期

//** 视图加载完毕 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"平台寄拍";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //--赋值
    if (self.detailModel.prodName) {
        self.goodNameLabel.text = self.detailModel.prodName;
    }else{
        self.goodNameLabel.text = @"未从网络获取到物品名称";
    }
    NSString *minSuggestMoney = [NSString stringWithFormat:@"%zd", self.detailModel.minSuggestMoney.integerValue / 100 + 1];
    NSString *maxSuggestMoney = [NSString stringWithFormat:@"%zd", self.detailModel.maxSuggestMoney / 100];
    self.systemStartPriceRangeLabel.text = [NSString stringWithFormat:@"系统给出的起拍价格范围为 ¥%@——¥%@",[YXStringFilterTool strmethodComma:minSuggestMoney] , [YXStringFilterTool strmethodComma:maxSuggestMoney]];
    
    //--配置输入框功能条
    [self.userInputPriceTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.userInputPriceTextField setInputAccessoryView:self.customAccessoryView];
    
    //--配置文本点击事件
    [self setTipsText:@"经官方鉴定，您的商品符合售卖规定。"];
    
    //--配置行间距文本
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;
    NSString *psText = [NSString stringWithFormat:@"提示：竞拍成功后，平台会收取成交金额的%@作为佣金，其余款项会在5个工作日之内打款到您的相应账户。", self.commissionRatio];
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:psText];
    NSDictionary *allAttributes = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:11],
                                    NSParagraphStyleAttributeName:paragraphStyle,
                                    NSForegroundColorAttributeName:[UIColor colorWithRed:190.0/255.0 green:98.0/255.0 blue:98.0/255.0 alpha:1.0]
                                    };
    [attributes addAttributes:allAttributes range:NSMakeRange(0, psText.length)];
    
    self.commissionTipsLabel.attributedText = attributes;
    self.commissionTipsLabel.lineBreakMode=NSLineBreakByWordWrapping;
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
    [attributes addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:151.0/255.0 green:29.0/255.0 blue:20.0/255.0 alpha:1.0] range:NSMakeRange(17, 8)];
    
    self.officTipsLabel.attributedText = attributes;
    self.officTipsLabel.lineBreakMode=NSLineBreakByWordWrapping;
    //--添加点击事件
    [self.officTipsLabel yb_addAttributeTapActionWithStrings:@[@"（查看鉴定报告）"] delegate:self];
}


//** 弹出alert */
- (void)showAlertWithTitle:(NSString *)title
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
    [alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
    [self presentViewController: alert animated:YES completion:nil];
    
}

#pragma mark - 懒加载

- (YXSurePlatformOnBehalfOfSellingView *)suerPlatformOnBehalfOfSellingView
{
    if (!_suerPlatformOnBehalfOfSellingView) {
        _suerPlatformOnBehalfOfSellingView = [[NSBundle mainBundle] loadNibNamed:@"SurePlatformOnBehalfOfSellingView" owner:nil options:nil].lastObject;
        _suerPlatformOnBehalfOfSellingView.frame = [UIScreen mainScreen].bounds;
        _suerPlatformOnBehalfOfSellingView.delegate = self;
    }
    return _suerPlatformOnBehalfOfSellingView;
}

- (YXKeyboardToolbar *)customAccessoryView
{
    if (!_customAccessoryView) {
        
        _customAccessoryView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YXKeyboardToolbar class]) owner:nil options:nil].firstObject;
        _customAccessoryView.customDelegate = self;
    }
    return _customAccessoryView;
}

@end
