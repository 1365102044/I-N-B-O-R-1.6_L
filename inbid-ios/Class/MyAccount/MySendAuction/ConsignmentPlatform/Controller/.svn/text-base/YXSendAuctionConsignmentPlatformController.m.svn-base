//
//  YXSendAuctionConsignmentPlatformController.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionConsignmentPlatformController.h"
#import "YXYXSendAuctionConsignmentPlatformContentController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXMyOrderSuccessAlerview.h"
#import "YXAppraisaReportIdentifyModel.h"
#import "YXMySendAuctionSubTableViewController.h"
#import "YXStringFilterTool.h"
#import "YXAlearFormMyView.h"

@interface YXSendAuctionConsignmentPlatformController ()

/**
 嵌入的子控制器
 */
@property (nonatomic, weak) YXYXSendAuctionConsignmentPlatformContentController *contentTableViewController;

/**
 确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

/**
 弹窗
 */
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

/*
 自己判读的提示view
 */
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

@end

@implementation YXSendAuctionConsignmentPlatformController

#pragma mark - Zero.获取子控制器

/**
 获取嵌入的子控制器

 @param segue  segue
 @param sender sender 
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //** 获取目标控制器 */
    _contentTableViewController = segue.destinationViewController;
    if (self.type == kYXSendAuctionConsignmentPlatformControllerLoadConsignment) _contentTableViewController.type = kYXSendAuctionConsignmentPlatformContentControllerLoadConsignment;
    if (self.type == kYXSendAuctionConsignmentPlatformControllerLoadReConsignment) _contentTableViewController.type = kYXSendAuctionConsignmentPlatformContentControllerLoadReConsignment;
    //** 赋值子界面 */
    _contentTableViewController.appraisaReportIdentifyModel = self.appraisaReportIdentifyModel;
}

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 界面数据

 @param appraisaReportIdentifyModel appraisaReportIdentifyModel
 */
- (void)setAppraisaReportIdentifyModel:(YXAppraisaReportIdentifyModel *)appraisaReportIdentifyModel
{
    _appraisaReportIdentifyModel = appraisaReportIdentifyModel;
}

#pragma mark - Third.点击事件

/**
 确定按钮点击事件

 @param sender sender
 */
- (IBAction)sureButtonClick:(id)sender
{
    //** 如果没有设置价格，提示 */
    if ([self.contentTableViewController.selaMoneyTextField.text isEqualToString:@""] || self.contentTableViewController.selaMoneyTextField.text.length == 0) {
        [self showRemindGoodsViewWithType:@"一口价不能为空"];
        return;
    }
    
    //** 如果没有设置天数，提示 */
    if ([self.contentTableViewController.showDayPickerLabel.text isEqualToString:@"1天"]) {
        //** 提示，为最小天数 */
    }
    
    NSString *day;
    if ([self.contentTableViewController.showDayPickerLabel.text isEqualToString:@"1天"]) {
        day = @"1";
    }else if ([self.contentTableViewController.showDayPickerLabel.text isEqualToString:@"2天"]) {
        day = @"2";
    }else if ([self.contentTableViewController.showDayPickerLabel.text isEqualToString:@"3天"]) {
        day = @"3";
    }else if ([self.contentTableViewController.showDayPickerLabel.text isEqualToString:@"4天"]) {
        day = @"4";
    }else if ([self.contentTableViewController.showDayPickerLabel.text isEqualToString:@"5天"]) {
        day = @"5";
    }else if ([self.contentTableViewController.showDayPickerLabel.text isEqualToString:@"6天"]) {
        day = @"6";
    }else if ([self.contentTableViewController.showDayPickerLabel.text isEqualToString:@"7天"]) {
        day = @"7";
    }
    
    if (self.contentTableViewController.selaMoneyTextField.text.longLongValue > 99999999999) {
        self.alearMyview.alearstr = @"金额不能大于11位";
        return;
    }
    
    if (self.type == kYXSendAuctionConsignmentPlatformControllerLoadConsignment) {
        
        [[YXMyAccountNetRequestTool sharedTool] setBuyOutPriceWithIdentifyId:self.contentTableViewController.appraisaReportIdentifyModel.indentifyOrderId
                                                                     saleDay:day
                                                                 buyoutPrice:[NSString stringWithFormat:@"%@00",self.contentTableViewController.selaMoneyTextField.text]
                                                                     success:^(id objc, id respodHeader) {
            
            if ([objc isEqualToString:@"一口价天数不能为空"]) return;
            
            if ([objc isEqualToString:@"设置成功"]) {
                [self popToListViewController];
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    }else{
    
        [[YXMyAccountNetRequestTool sharedTool] setBuyoutChooseConfirmWIthId:self.contentTableViewController.appraisaReportIdentifyModel.indentifyOrderId
                                                                        type:2
                                                                     saleDay:day
                                                                 buyoutPrice:[NSString stringWithFormat:@"%zd",self.contentTableViewController.selaMoneyTextField.text.longLongValue * 100]
                                                                     success:^(id objc, id respodHeader) {
            
            if ([objc isEqualToString:@"提交失败"]) return;
            
            if ([objc isEqualToString:@"提交成功"]) {
                [self popToListViewController];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
}

/**
 跳转到列表界面，并刷新当前数据
 */
- (void)popToListViewController
{
    NSArray *navigationControllerArray = self.navigationController.childViewControllers;
    YXMySendAuctionSubTableViewController *mySendAuctionSubTableViewController = navigationControllerArray[1];
    if ([self.delegate respondsToSelector:@selector(sendAuctionConsignmentPlatformController:changeRestPageON:)]) {
        [self.delegate sendAuctionConsignmentPlatformController:self changeRestPageON:YES];
    }
    [self.navigationController popToViewController:mySendAuctionSubTableViewController animated:YES];
}

#pragma mark - Fourth.代理方法

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 配置界面 */
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"设置寄卖方式";
    self.view.backgroundColor = [UIColor themLightGrayColor];
    
    //** 判断当前是哪种界面， 做个性化操作 */
    if (self.type == kYXSendAuctionConsignmentPlatformControllerLoadReConsignment) {

    }else if (self.type == kYXSendAuctionConsignmentPlatformControllerLoadConsignment) {
        
    }
    
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    self.sureButton.backgroundColor = [UIColor mainThemColor];
    
    //** 赋值子界面 */
    _contentTableViewController.appraisaReportIdentifyModel = self.appraisaReportIdentifyModel;
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

-(YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
        [self.view addSubview:self.alearMyview];
        
        _alearMyview.frame = CGRectMake(YXScreenW*0.2, CGRectGetMinY([self.contentTableViewController.selaMoneyTextField convertRect:self.contentTableViewController.selaMoneyTextField.bounds toView:self.view]) - self.contentTableViewController.selaMoneyTextField.height * 0.5, YXScreenW*0.6, 30);
        _alearMyview.alpha = 0;
        _alearMyview.time = 5.0f;
    }
    return _alearMyview;
}


/**
 弹窗
 
 @param type 弹窗的样式
 */
- (void)showRemindGoodsViewWithType:(NSString *)type
{
    //--弹窗
    [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
    self.RemindGoodsView.Type = type;
    self.RemindGoodsView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    __weak typeof (self) wealself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wealself dimssview];
    });
}


//** 取消弹窗 */
-(void)dimssview
{
    [self.RemindGoodsView removeFromSuperview];
    self.RemindGoodsView = nil;
}


- (YXMyOrderSuccessAlerview *)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

@end
