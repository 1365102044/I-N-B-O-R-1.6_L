//
//  YXImmediatelyMailController.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXImmediatelyMailController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXMySendAuctionHoldTest.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXImmediatelyMailMyAddressModel.h"
#import "YXKeyboardToolbar.h"
#import "YXImmediatelyMailContentController.h"
#import "YXOrderDetailModel.h"

@interface YXImmediatelyMailController ()

//** 地址模型 */
@property (nonatomic, strong) YXImmediatelyMailMyAddressModel *myAddressModel;
/**
 内容视图
 */
@property (nonatomic, strong) YXImmediatelyMailContentController *contentController;

@end

@implementation YXImmediatelyMailController

#pragma mark - 代理方法
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /** 获取来源控制器 */
    _contentController = segue.destinationViewController;
    _contentController.orderDetailModel = self.orderDetailModel;

}

#pragma mark - 赋值

- (void)setMyAddressModel:(YXImmediatelyMailMyAddressModel *)myAddressModel
{
    _myAddressModel = myAddressModel;
    
}


#pragma mark - 点击事件



//** 确认提交 */
- (IBAction)sureButtonClick:(UIButton *)sender
{
    NSString *deliverNum;
    NSString *deliveryMerchant;
    if (self.contentController.currentButton.tag == 1) {
        deliverNum = nil;
        deliveryMerchant = nil;
    }else{
        
        if ([self.contentController.expressNameTextField.text isEqualToString:@""] || self.contentController.expressNameTextField.text.length == 0) {
            [self showAlertWithTitle:@"快递商品需要输入快递名称"];
            return;
        }
        
        if ([self.contentController.expressOrderNumberTextField.text isEqualToString:@""] || self.contentController.expressOrderNumberTextField.text.length == 0) {
            [self showAlertWithTitle:@"快递商品需要输入快递单号"];
            return;
        }
        
        deliverNum = self.contentController.expressOrderNumberTextField.text;
        deliveryMerchant = [NSString stringWithFormat:@"%zd", self.contentController.currentExpressId];
    }
    
    [[YXMyAccountNetRequestTool sharedTool] mailNowWithOrderIdentifyId:self.orderDetailModel.orderNumber.longLongValue withIsDelivery:self.contentController.currentButton.tag withDeliverNum:deliverNum withDeliveryMerchant:deliveryMerchant success:^(id objc, id respodHeader) {
#warning TODO:立即邮寄弹窗效果或者直接返回上级菜单
        if ([objc isEqualToString:@"提交成功"] && [respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            //** 打开我的鉴定刷新开关 */
            if ([self.delegate respondsToSelector:@selector(immediatelyMailController:changeRestPageON:)]) {
                [self.delegate immediatelyMailController:self changeRestPageON:YES];
            }
            
            if (self.contentController.currentButton.tag == 1) {
            [self showAlertWithTitle:@"请尽快将物品送至收货点"];
            }else{
            [self showAlertWithTitle:@"信息已提交 等待平台签收"];
            }
        }else{
            [self showAlertWithTitle:@"网络繁忙，请稍后再试"];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - 获取网络数据

- (void)loadMyAddress
{
    [[YXMyAccountNetRequestTool sharedTool] mailNowLoadMyAddressWithSuccess:^(id objc, id respodHeader) {
        
        self.myAddressModel = [YXImmediatelyMailMyAddressModel mj_objectWithKeyValues:objc];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - table delegate
    


#pragma mark - 控制器生命周期

//** 视图加载完毕 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"立即邮寄";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

//** 弹出登录或未登录alert */
- (void)showAlertWithTitle:(NSString *)title
{
    UIAlertAction *defaultAction;
    if ([title isEqualToString:@"请尽快将物品送至收货点"] || [title isEqualToString:@"信息已提交 等待平台签收"]) {
        defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *actoin){
            //** push会根视图 */
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else if ([title isEqualToString:@"网络繁忙，请稍后再试"]) {
        defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){
            
        }];
    }else{
        defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){
            
        }];
    }
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
    [self presentViewController: alert animated:YES completion:nil];
    

}


@end
