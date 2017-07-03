//
//  YXSendAuctionInformationController.m
//  YXSendAuction
//
//  Created by 郑键 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionInformationController.h"
#import "YXSendAuctionInformationSectionHeaderView.h"
#import "YXSendAuctionInformationImagesCell.h"
#import "YXSendAuctionInformationDetailCell.h"
#import "YXSendAuctionDoneController.h"
#import "YXMySendAuctionSubTableViewController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXMySendAuctionHoldTest.h"
#import "YXSendAuctionGetIdentifuDetails.h"
#import "YXMySendAuctionHomeController.h"
#import "YXMySendAuctionTimeListCell.h"
#import "YXAppraisalReportController.h"
#import "YXMyAccoutBindBankCardViewController.h"
#import "YXMyAucctionRealnameAndBindbankCardViewController.h"
#import "YXNewsDingdanNotiListViewController.h"
#import "YXImmediatelyIdentifiedController.h"
#import "YXPlatformOnBehalfOfSellingController.h"
#import "YXPlatformRecoveryController.h"
#import "YXImmediatelyMailController.h"
#import "YXReturnGoodsViewController.h"
#import "AppDelegate.h"
#import "YXSendAuctionImageManager.h"
#import "YXApprasisalReportContentTableViewController.h"
#import "YXAppraisalReportController.h"
#import "YXPaymentHomePageController.h"
#import "YXPayMentResultViewController.h"
#import "YXMyAccountMainViewController.h"
#import "YXPayMentResultViewController.h"
#import "YXNewsDingdanNotiListViewController.h"
#import "YXWeChatPayManager.h"
#import "YXOrderDetailModel.h"
#import "YXMyOrderListViewController.h"
#import "YXMeMainViewController.h"
#import "YXNewsViewController.h"
//** 等待鉴定_时间轴cell重用标志 */
static NSString *const kYXMySendAuctionTimeListCellReuseIdentifier = @"kYXMySendAuctionTimeListCellReuseIdentifier";
static NSString * const kYXSendAuctionInformationSectionHeaderReID = @"kYXSendAuctionInformationSectionHeaderReID";
static NSString * const kYXSendAuctionInformationImagesCellReID = @"kYXSendAuctionInformationImagesCellReID";
static NSString * const kYXSendAuctionInformationDetailCellReID = @"kYXSendAuctionInformationDetailCellReID";

@interface YXSendAuctionInformationController ()<UITableViewDelegate, UITableViewDataSource, YXMySendAuctionTimeListCellDelegate, YXImmediatelyIdentifiedControllerDelegate, YXPlatformOnBehalfOfSellingControllerDelegate, YXPlatformRecoveryControllerDelegate, YXImmediatelyMailControllerDelegate, YXReturnGoodsViewControllerDelegate, YXMyAccoutBindBankCardViewControllerDelegate, YXMyAucctionRealnameAndBindbankCardViewControllerDelegate>

/**
 内容视图
 */
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

/**
 界面数据数组
 */
@property (nonatomic, strong) NSArray *dataArray;

/**
 详情数据
 */
@property (nonatomic, strong) YXSendAuctionGetIdentifuDetails *identificationDetail;

/**
 底部功能按钮父视图
 */
@property (weak, nonatomic) IBOutlet UIView *bottomFuncView;

//** 提示文字label */
@property (weak, nonatomic) IBOutlet UILabel *tipsTextLabel;
//** 重新提交按钮 */
@property (nonatomic, strong) UIButton *reSubmitButton;
//** 立即验证按钮 */
@property (nonatomic, strong) UIButton *nowVerificationButton;
//** 立即鉴定 */
@property (nonatomic, strong) UIButton *nowAppraisalButton;
//** 平台代卖按钮 */
@property (nonatomic, strong) UIButton *platformSellButton;
//** 平台回收 */
@property (nonatomic, strong) UIButton *platformRecoveryButton;
//** 立即邮寄 */
@property (nonatomic, strong) UIButton *nowMailButton;
//** 鉴定中lable */
@property (nonatomic, strong) UILabel *identificationLabel;
//** 我要寄回 */
@property (nonatomic, strong) UIButton *mailBackButton;
//** 刷新界面开关 */
@property (nonatomic, assign) BOOL isRestCurrentpage;
@end

@implementation YXSendAuctionInformationController



#pragma mark - 赋值

- (void)setIdentificationDetail:(YXSendAuctionGetIdentifuDetails *)identificationDetail
{
    _identificationDetail = identificationDetail;
    
    //** 初始化控件 */
//    [self.reSubmitButton removeFromSuperview];
//    [self.nowAppraisalButton removeFromSuperview];
//    [self.nowVerificationButton removeFromSuperview];
//    [self.platformSellButton removeFromSuperview];
//    [self.mailBackButton removeFromSuperview];
//    [self.platformRecoveryButton removeFromSuperview];
//    [self.nowMailButton removeFromSuperview];
    
    
    /**
     * 订单状态
     * 1为刚提交，2为审核不通过，3为审核通过 ，4部分付款，5待发货，6待确认收货，7交易完成，8交易取消
     */
    //private Integer orderStatus;
    //@property (nonatomic, assign) NSInteger orderStatus;
    if (identificationDetail.orderStatus == 1) {
        
        self.bottomFuncView.hidden = YES;
        
    }else if (identificationDetail.orderStatus == 2) {
        
        //添加重新提交按钮
        [self.bottomFuncView addSubview:self.reSubmitButton];
        [self.reSubmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bottomFuncView);
            make.width.mas_equalTo(77.5);
            make.height.mas_equalTo(25);
            make.right.mas_equalTo(self.bottomFuncView).mas_offset(-13);
        }];
        
        
    }else if (identificationDetail.orderStatus == 3) {
        
        
        if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"cardStatus"]] isEqualToString:@"1"]) {
            
            //添加立即鉴定按钮
            [self.bottomFuncView addSubview:self.nowAppraisalButton];
            [self.nowAppraisalButton  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.bottomFuncView);
                make.width.mas_equalTo(77.5);
                make.height.mas_equalTo(25);
                make.right.mas_equalTo(self.bottomFuncView).mas_offset(-13);
            }];
            
        }else{
            
            //添加立即验证按钮
            [self.bottomFuncView addSubview:self.nowVerificationButton];
            [self.nowVerificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.bottomFuncView);
                make.width.mas_equalTo(77.5);
                make.height.mas_equalTo(25);
                make.right.mas_equalTo(self.bottomFuncView).mas_offset(-13);
            }];
        }
        
        
        
    }else if (identificationDetail.orderStatus == 4) {

    }else if (identificationDetail.orderStatus == 5) {
        //添加立即邮寄按钮
        [self.bottomFuncView addSubview:self.nowMailButton];
        [self.nowMailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bottomFuncView);
            make.width.mas_equalTo(77.5);
            make.height.mas_equalTo(25);
            make.right.mas_equalTo(self.bottomFuncView).mas_offset(-13);
        }];
        
    }else if (identificationDetail.orderStatus == 6) {
        //--已邮寄
        self.bottomFuncView.hidden = YES;

    }else if (identificationDetail.orderStatus == 7) {
        
        /**
         * 鉴定状态
         * 0待鉴定 1为鉴定中，2为鉴定成功；3为鉴定失败
         */
        //private Integer identifyStatus;
        //@property (nonatomic, assi-gn) NSInteger identifyStatus;
        if (identificationDetail.identifyStatus == 0) {
            //添加鉴定中按钮
            self.bottomFuncView.hidden = YES;
        }else if (identificationDetail.identifyStatus == 1) {
            //添加鉴定中按钮
            self.bottomFuncView.hidden = YES;
            
        }else if (identificationDetail.identifyStatus == 2) {
            
            //添加平台代卖和平台回收及我要寄回
            [self.bottomFuncView addSubview:self.platformSellButton];
            //[self.bottomFuncView addSubview:self.mailBackButton];
            
            //if (identificationDetail.recycleMoney == 0) {
            
            [self.platformSellButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.bottomFuncView);
                make.width.mas_equalTo(77.5);
                make.height.mas_equalTo(25);
                make.right.mas_equalTo(self.bottomFuncView).mas_offset(-13);
            }];
            
            /**
             * 退回状态,1,未申请 2,已申请,3,退回中,4,已退回
             */
            //private Integer refundStatus;
            if (identificationDetail.refundStatus == 1) {
                
                /**
                 * 对商品的处理状态
                 * 1为不同意交易；2为平台寄拍；3为回收价卖给平台,4=平台已打款
                 */
                //private Integer manageStatus;
                
                if (identificationDetail.manageStatus == 1) {
                    //添加已申请
                    //self.bottomFuncView.hidden = YES;
                    
                }else if (identificationDetail.manageStatus == 2) {
                    
                    //添加已同意寄拍
                    //self.bottomFuncView.hidden = YES;
                }else if (identificationDetail.manageStatus == 3) {
                    //添加回收
                    //self.bottomFuncView.hidden = YES;
                }else if (identificationDetail.manageStatus == 4) {
                    //添加回收
                    //self.bottomFuncView.hidden = YES;
                }else if (identificationDetail.manageStatus == 0){
                    
                }
                
            }else if (identificationDetail.refundStatus == 2) {
                //添加已申请
                //self.bottomFuncView.hidden = YES;
            }else if (identificationDetail.refundStatus == 3) {
                //添加已申请
                //self.bottomFuncView.hidden = YES;
            }else if (identificationDetail.refundStatus == 4) {
                //添加已申请
                //self.bottomFuncView.hidden = YES;
            }
            
            
            
        }else if (identificationDetail.identifyStatus == 3) {
            
            //添加平台代卖和平台回收及我要寄回
            [self.bottomFuncView addSubview:self.platformSellButton];
            
            [self.platformSellButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.bottomFuncView);
                make.width.mas_equalTo(77.5);
                make.height.mas_equalTo(25);
                make.right.mas_equalTo(self.bottomFuncView).mas_offset(-13);
            }];
            
            
            
            /**
             * 退回状态,1,未申请 2,已申请,3,退回中,4,已退回
             */
            //private Integer refundStatus;
            if (identificationDetail.refundStatus == 1) {
                
                [self.bottomFuncView addSubview:self.mailBackButton];
                [self.mailBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(self.bottomFuncView);
                    make.width.mas_equalTo(77.5);
                    make.height.mas_equalTo(25);
                    make.right.mas_equalTo(self.platformSellButton.mas_left).mas_offset(-13);
                }];
            }else if (identificationDetail.refundStatus == 2) {
                //添加已申请
                //self.bottomFuncView.hidden = YES;
            }else if (identificationDetail.refundStatus == 3) {
                //添加已申请
                //self.bottomFuncView.hidden = YES;
            }else if (identificationDetail.refundStatus == 4) {
                //添加已申请
                //self.bottomFuncView.hidden = YES;
            }
            
        }
        
    }else if (identificationDetail.orderStatus == 8) {
        
    }
    [self.contentTableView reloadData];
}


#pragma mark - 响应事件

/**
 下线通知，退回到主界面
 */
- (void)popToRootViewController
{
    if ([self.sourceViewController isKindOfClass:[YXSendAuctionDoneController class]]
        || [self.sourceViewController isKindOfClass:[YXPaymentHomePageController class]]
        ||[self.formeNoti isEqualToString:@"formeNoti"]) {
        
        /**
         *  跳转到我的鉴定列表
         */
        UITabBarController *mainTabBarController = (UITabBarController *)[[UIApplication sharedApplication].keyWindow rootViewController];
        mainTabBarController.selectedIndex = 3;
        UINavigationController *navigationController = mainTabBarController.viewControllers.lastObject;
        YXMeMainViewController *accountController = (YXMeMainViewController *) navigationController.viewControllers.firstObject;
        accountController.pushViewController = 1;
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 功能按钮点击

 @param sender 点击的按钮
 */
- (void)otherFunctionButtonClick:(UIButton *)sender
{
    self.isRestCurrentpage = NO;
    //** 监听用户操作 */
//    if ([self.delegate respondsToSelector:@selector(sendAuctionInformationController:changeRestPageON:)]) {
//        [self.delegate sendAuctionInformationController:self changeRestPageON:YES];
//    }
    
    
    
    
    if ([sender.titleLabel.text isEqualToString:@"重新提交"]) {
        //--跳转到寄拍模块,发送通知
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.tabBarController.selectedIndex = 1;
        
    }else if ([sender.titleLabel.text isEqualToString:@"立即验证"]){
        //--跳转到身份验证模块
        /**
         * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
         */
        if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"2"]) {
            
            YXMyAccoutBindBankCardViewController * bindbankcardVC = [[YXMyAccoutBindBankCardViewController alloc]init];
            bindbankcardVC.delegate = self;
            [self.navigationController pushViewController:bindbankcardVC animated:YES];
            
        }else if([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"0"] || [[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"3"]){
            
            YXMyAucctionRealnameAndBindbankCardViewController *allrealnameAndbindbankcardVC = [[YXMyAucctionRealnameAndBindbankCardViewController alloc]init];
            allrealnameAndbindbankcardVC.delegate = self;
            [self.navigationController pushViewController:allrealnameAndbindbankcardVC animated:YES];
        }
        
    }else if ([sender.titleLabel.text isEqualToString:@"立即鉴定"]){
        
        if ([self.sourceViewController isKindOfClass:[YXPayMentResultViewController class]]) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
        }else{
            YXPaymentHomePageController *paymentController = [YXPaymentHomePageController loadPaymentControllerWithProdId:self.orderDeatailModel.orderNumber.longLongValue andType:YXPaymentHomePageControllerIdentifyCost];
            [self.navigationController pushViewController:paymentController animated:YES];
        }
        
    }else if ([sender.titleLabel.text isEqualToString:@"平台寄拍"]){
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PlatformOnBehalfOfSelling" bundle:nil];
        YXPlatformOnBehalfOfSellingController *platformOnBehalfOfSellingController = [sb instantiateInitialViewController];
        platformOnBehalfOfSellingController.commissionRatio = self.commissionRatio;
        platformOnBehalfOfSellingController.detailModel = self.orderDeatailModel;
        platformOnBehalfOfSellingController.delegate = self;
        [self.navigationController pushViewController: platformOnBehalfOfSellingController animated:YES];
        
    }else if ([sender.titleLabel.text isEqualToString:@"平台回收"]){
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PlatformRecovery" bundle:nil];
        YXPlatformRecoveryController *platformRecoveryController = [sb instantiateInitialViewController];
        platformRecoveryController.orderDetailModel = self.orderDeatailModel;
        platformRecoveryController.delegate = self;
        [self.navigationController pushViewController: platformRecoveryController animated:YES];
        
    }else if ([sender.titleLabel.text isEqualToString:@"立即邮寄"]){
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ImmediatelyMailController" bundle:nil];
        YXImmediatelyMailController *mailController = [sb instantiateInitialViewController];
        mailController.orderDetailModel = self.orderDeatailModel;
        mailController.delegate = self;
        [self.navigationController pushViewController: mailController animated:YES];
        
    }else if ([sender.titleLabel.text isEqualToString:@"我要退回"]){
        //push我要退回界面
        YXReturnGoodsViewController *returnGoodsViewController = [[YXReturnGoodsViewController alloc] init];
        returnGoodsViewController.detailModel = self.orderDeatailModel;
        returnGoodsViewController.delegate = self;
        [self.navigationController pushViewController:returnGoodsViewController animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"鉴定报告"]){
        //** 跳转鉴定报告界面 */
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YXAppraisalReportController" bundle:nil];
        YXAppraisalReportController *appraisalReportController = [sb instantiateInitialViewController];
        appraisalReportController.identifyId = self.orderDeatailModel.orderNumber.longLongValue;
        appraisalReportController.isShowOtherFuncView = YES;
        [self.navigationController pushViewController:appraisalReportController animated:YES];
    }
    
}


/**
 返回按钮的点击事件

 @param sender 点击按钮
 */
- (void)backButtonClick:(UIButton *)sender
{
    if ([self.sourceViewController isKindOfClass:[YXPayMentResultViewController class]]) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        return;
    }
    
    if ([self.sourceViewController isKindOfClass:[YXSendAuctionDoneController class]]
        || [self.sourceViewController isKindOfClass:[YXPaymentHomePageController class]]
        ) {
        
        /**
         *  跳转到我的鉴定列表
         */
        UITabBarController *mainTabBarController = (UITabBarController *)[[UIApplication sharedApplication].keyWindow rootViewController];
        mainTabBarController.selectedIndex = 3;
        UINavigationController *navigationController = mainTabBarController.viewControllers.lastObject;
        YXMeMainViewController *accountController = (YXMeMainViewController *) navigationController.viewControllers.firstObject;
        accountController.pushViewController = 1;
        
        [self dismissViewControllerAnimated:YES completion:^{
           
        }];
        
    }else if ([self.formeNoti isEqualToString:@"formeNoti"]){
        /**
         *  跳转到我的鉴定列表(17.2.28)
         */
//        UITabBarController *mainTabBarController = (UITabBarController *)[[UIApplication sharedApplication].keyWindow rootViewController];
//        mainTabBarController.selectedIndex = 2;
//        UINavigationController *navigationController = mainTabBarController.viewControllers.lastObject;
//        YXNewsViewController *accountController = (YXNewsViewController *) navigationController.viewControllers.firstObject;
//  accountController.pushViewController = 1;
    
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];

    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark - 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return self.identificationDetail.timeList.count;
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *reID;
    UITableViewCell *cell;
    if (indexPath.section == 1) {
        
        reID = kYXSendAuctionInformationImagesCellReID;
        cell = [tableView dequeueReusableCellWithIdentifier:reID forIndexPath:indexPath];
        YXSendAuctionInformationImagesCell *imagesCell = (YXSendAuctionInformationImagesCell *)cell;
        imagesCell.identifuDetailModel = self.identificationDetail;
        imagesCell.sourceController = self.sourceViewController;
        
    }else if (indexPath.section == 2){
        
        reID = kYXSendAuctionInformationDetailCellReID;
        cell = [tableView dequeueReusableCellWithIdentifier:reID forIndexPath:indexPath];
        YXSendAuctionInformationDetailCell *detailCell = (YXSendAuctionInformationDetailCell *)cell;
        detailCell.identifuDetailModel = self.identificationDetail;
        detailCell.sourceController = self.sourceViewController;
        
    }else if (indexPath.section == 3){
        
        YXMySendAuctionTimeListCell *timeListCell = [tableView dequeueReusableCellWithIdentifier:kYXMySendAuctionTimeListCellReuseIdentifier];
        
        timeListCell.identifuDetails = self.identificationDetail;
        timeListCell.mySendAuctionTimeListModel = self.identificationDetail.timeList[indexPath.row];
        timeListCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            timeListCell.isLastTimeListStatus = YES;
        }
        timeListCell.delegate = self;
        return timeListCell;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YXSendAuctionInformationSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYXSendAuctionInformationSectionHeaderReID];
    
    headerView.dataDict = self.dataArray[section];
    if (section == 0) {
        headerView.identifuDetails = self.identificationDetail;
    }
    //headerView.sourceController = self.sourceViewController;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41.0f;
}

#pragma mark --YXMySendAuctionTimeListCellDelegate

- (void)mySendAuctionTimeListCell:(YXMySendAuctionTimeListCell *)mySendAuctionTimeListCell clickText:(NSString *)text andIdentifyId:(long long)identifyId
{
    YXAppraisalReportController *appraisalReportController = [[YXAppraisalReportController alloc] init];
    //appraisalReportController.identifyId = identifyId;
    
    [self.navigationController pushViewController:appraisalReportController animated:YES];
}


#pragma mark --YXSendAuctionInformationControllerDelegate

/**
 打开刷新开关
 
 @param sendAuctionInformationController 详情控制器
 @param isRestPage                       开关
 */
- (void)sendAuctionInformationController:(YXSendAuctionInformationController *)sendAuctionInformationController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentpage = isRestPage;
    if ([self.delegate respondsToSelector:@selector(sendAuctionInformationController:changeRestPageON:)]) {
        [self.delegate sendAuctionInformationController:self changeRestPageON:isRestPage];
    }
}

#pragma mark --YXImmediatelyIdentifiedControllerDelegate

/**
 打开刷新开关
 
 @param immediatelyIdentifiedController 支付鉴定费
 @param isRestPage                      开关
 */
- (void)immediatelyIdentifiedController:(YXImmediatelyIdentifiedController *)immediatelyIdentifiedController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentpage = isRestPage;
    if ([self.delegate respondsToSelector:@selector(sendAuctionInformationController:changeRestPageON:)]) {
        [self.delegate sendAuctionInformationController:self changeRestPageON:isRestPage];
    }
}

#pragma mark --YXPlatformOnBehalfOfSellingControllerDelegate

/**
 打开刷新开关
 
 @param platformOnBehalfOfSellingController 平台代卖控制器
 @param isRestPage                          开关
 */
- (void)platformOnBehalfOfSellingController:(YXPlatformOnBehalfOfSellingController *)platformOnBehalfOfSellingController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentpage = isRestPage;
    if ([self.delegate respondsToSelector:@selector(sendAuctionInformationController:changeRestPageON:)]) {
        [self.delegate sendAuctionInformationController:self changeRestPageON:isRestPage];
    }
}

#pragma mark --YXPlatformRecoveryControllerDelegate

/**
 打开刷新开关
 
 @param platformRecoveryController 平台回收
 @param isRestPage                 开关
 */
- (void)platformRecoveryController:(YXPlatformRecoveryController *)platformRecoveryController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentpage = isRestPage;
    if ([self.delegate respondsToSelector:@selector(sendAuctionInformationController:changeRestPageON:)]) {
        [self.delegate sendAuctionInformationController:self changeRestPageON:isRestPage];
    }
}

#pragma mark --YXImmediatelyMailControllerDelegate

/**
 打开刷新开关
 
 @param immediatelyMailController 立即邮寄控制器
 @param isRestPage                开关
 */
- (void)immediatelyMailController:(YXImmediatelyMailController *)immediatelyMailController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentpage = isRestPage;
    if ([self.delegate respondsToSelector:@selector(sendAuctionInformationController:changeRestPageON:)]) {
        [self.delegate sendAuctionInformationController:self changeRestPageON:isRestPage];
    }
}

#pragma mark --YXReturnGoodsViewControllerDelegate

/**
 打开刷新开关
 
 @param returnGoodsViewController 我要退回控制器
 @param isRestPage                开关
 */
- (void)returnGoodsViewController:(YXReturnGoodsViewController *)returnGoodsViewController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentpage = isRestPage;
    if ([self.delegate respondsToSelector:@selector(sendAuctionInformationController:changeRestPageON:)]) {
        [self.delegate sendAuctionInformationController:self changeRestPageON:isRestPage];
    }
}

#pragma mark --YXMyAccoutBindBankCardViewControllerDelegate

/**
 打开刷新开关
 
 @param myAccoutBindBankCardViewController 绑定银行卡控制器
 @param isRestPage                         开关
 */
- (void)myAccoutBindBankCardViewController:(YXMyAccoutBindBankCardViewController *)myAccoutBindBankCardViewController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentpage = isRestPage;
    if ([self.delegate respondsToSelector:@selector(sendAuctionInformationController:changeRestPageON:)]) {
        [self.delegate sendAuctionInformationController:self changeRestPageON:isRestPage];
    }
}

#pragma mark --YXMyAucctionRealnameAndBindbankCardViewControllerDelegate

/**
 打开刷新开关
 
 @param myAucctionRealnameAndBindbankCardViewController 实名认证控制器
 @param isRestPage                                      开关
 */
- (void)myAucctionRealnameAndBindbankCardViewController:(YXMyAucctionRealnameAndBindbankCardViewController *)myAucctionRealnameAndBindbankCardViewController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentpage = isRestPage;
    if ([self.delegate respondsToSelector:@selector(sendAuctionInformationController:changeRestPageON:)]) {
        [self.delegate sendAuctionInformationController:self changeRestPageON:isRestPage];
    }
}


#pragma mark - 控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //--配置界面
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableView.bounces = NO;
    self.contentTableView.estimatedRowHeight = 200;
    self.contentTableView.rowHeight = UITableViewAutomaticDimension;
    self.contentTableView.sectionFooterHeight = 5;
    self.contentTableView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
    self.contentTableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    
    //--注册
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXSendAuctionInformationSectionHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:kYXSendAuctionInformationSectionHeaderReID];
    [self. contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXSendAuctionInformationImagesCell class]) bundle:nil] forCellReuseIdentifier:kYXSendAuctionInformationImagesCellReID];
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXSendAuctionInformationDetailCell class]) bundle:nil] forCellReuseIdentifier:kYXSendAuctionInformationDetailCellReID];
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXMySendAuctionTimeListCell class]) bundle:nil] forCellReuseIdentifier:kYXMySendAuctionTimeListCellReuseIdentifier];
    
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [leftButton sizeToFit];
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    self.title = @"预鉴定详情";
    [self loadData];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //** 加载网络数据 */
    if (self.isRestCurrentpage) {
        [self loadData];
    }
}


- (void)loadData
{
    if ([self.sourceViewController isKindOfClass:[YXMyOrderListViewController class]]) {
        
        [self loadIdentificationDataWithOrderId:self.orderDeatailModel.orderNumber.longLongValue];
        
    }else if ([self.sourceViewController isKindOfClass:[YXNewsDingdanNotiListViewController class]]){
        //** 发送请求，获取详情数据 */
        [self loadIdentificationDataWithOrderId:self.orderID];
    }else if([self.sourceViewController isKindOfClass:[YXApprasisalReportContentTableViewController class]]) {
        [self loadIdentificationDataWithOrderId:self.orderID];
    }else if([self.sourceViewController isKindOfClass:[YXPaymentHomePageController class]]) {
        [self loadIdentificationDataWithOrderId:self.orderID];
    }else if([self.sourceViewController isKindOfClass:[YXPayMentResultViewController class]]) {
        [self loadIdentificationDataWithOrderId:self.orderID];
    }else{
        [self loadIdentificationDataWithOrderId:[YXSendAuctionImageManager defaultManager].orderId.longLongValue];
    }
    
    if (self.formeVC==1) {
        [self loadIdentificationDataWithOrderId:self.orderID];
    }
}

/**
 加载预鉴定数据
 */
- (void)loadIdentificationDataWithOrderId:(long long)orderId
{
    [[YXMyAccountNetRequestTool sharedTool] identifyDetailWithIdentifyId:orderId success:^(id objc, id respodHeader) {
        
        self.identificationDetail = [YXSendAuctionGetIdentifuDetails mj_objectWithKeyValues:objc];
        if ([self.sourceViewController isKindOfClass:[YXNewsDingdanNotiListViewController class]]
            || [self.sourceViewController isKindOfClass:[YXApprasisalReportContentTableViewController class]]
            || [self.sourceViewController isKindOfClass:[YXPaymentHomePageController class]]
            || [self.sourceViewController isKindOfClass:[YXPayMentResultViewController class]]
            || [self.sourceViewController isKindOfClass:[YXMyOrderListViewController class]]) {
            self.orderDeatailModel = [YXOrderDetailModel mj_objectWithKeyValues:objc];
        }
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.sourceViewController isKindOfClass:[YXSendAuctionDoneController class]]) {
        //** 如果来源控制器是寄拍控制器那么，来源控制器pop */
        //[self.sourceViewController.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [[ZJPhotoManager defaultZJPhotoManager].selectedImageURLsArray removeAllObjects];
//    [[ZJPhotoManager defaultZJPhotoManager].selectedAlbumImageArray removeAllObjects];
//    [[ZJPhotoManager defaultZJPhotoManager].selectedTakePhotoImageArray removeAllObjects];
//    [[ZJPhotoManager defaultZJPhotoManager].successSendImageArray removeAllObjects];
//    
//    [YXSendAuctionManager defaultSendAuctionManager].prodName = nil;
//    [YXSendAuctionManager defaultSendAuctionManager].orderContent = nil;
//    [YXSendAuctionManager defaultSendAuctionManager].orderId = nil;
}


#pragma mark - 懒加载

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@{@"title":@"订单号",
                         @"detail":@"......"},
                       @{@"titleImageNamed":@"ic_sendAuction_detailImage",
                         @"title":@"商品图片",
                         @"images":@[]},
                       @{@"titleImageNamed":@"ic_sendAuction_detailEdit",
                         @"title":@"商品描述",
                         @"detail":@"......"},
                       @{@"titleImageNamed":@"ic_sendAuction_timeListDetail",
                         @"title":@"鉴定详情",
                         @"detail":@"......"}];
    }
    return _dataArray;
}


#pragma mark - 懒加载

- (UIButton *)reSubmitButton
{
    if (!_reSubmitButton) {
        _reSubmitButton = [[UIButton alloc] init];
        [_reSubmitButton setTitle:@"重新提交" forState:UIControlStateNormal];
        [_reSubmitButton setBackgroundColor:[UIColor mainThemColor]];
        [_reSubmitButton sizeToFit];
        _reSubmitButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _reSubmitButton.layer.cornerRadius = 2;
        [_reSubmitButton.layer masksToBounds];
        
        [_reSubmitButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reSubmitButton;
}

- (UIButton *)nowVerificationButton
{
    if (!_nowVerificationButton) {
        _nowVerificationButton = [[UIButton alloc] init];
        [_nowVerificationButton setTitle:@"立即验证" forState:UIControlStateNormal];
        [_nowVerificationButton setBackgroundColor:[UIColor mainThemColor]];
        [_nowVerificationButton sizeToFit];
        _nowVerificationButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _nowVerificationButton.layer.cornerRadius = 2;
        [_nowVerificationButton.layer masksToBounds];
        
        [_nowVerificationButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nowVerificationButton;
}

- (UIButton *)nowAppraisalButton
{
    if (!_nowAppraisalButton) {
        _nowAppraisalButton = [[UIButton alloc] init];
        [_nowAppraisalButton setTitle:@"立即鉴定" forState:UIControlStateNormal];
        [_nowAppraisalButton setBackgroundColor:[UIColor mainThemColor]];
        [_nowAppraisalButton sizeToFit];
        _nowAppraisalButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _nowAppraisalButton.layer.cornerRadius = 2;
        [_nowAppraisalButton.layer masksToBounds];
        
        [_nowAppraisalButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nowAppraisalButton;
}

- (UIButton *)platformSellButton
{
    if (!_platformSellButton) {
        _platformSellButton = [[UIButton alloc] init];
        [_platformSellButton setTitle:@"鉴定报告" forState:UIControlStateNormal];
        [_platformSellButton setBackgroundColor:[UIColor mainThemColor]];
        [_platformSellButton sizeToFit];
        _platformSellButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _platformSellButton.layer.cornerRadius = 2;
        [_platformSellButton.layer masksToBounds];
        
        [_platformSellButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _platformSellButton;
}

- (UIButton *)platformRecoveryButton
{
    if (!_platformRecoveryButton) {
        _platformRecoveryButton = [[UIButton alloc] init];
        [_platformRecoveryButton setTitle:@"平台回收" forState:UIControlStateNormal];
        [_platformRecoveryButton setBackgroundColor:[UIColor mainThemColor]];
        [_platformRecoveryButton sizeToFit];
        _platformRecoveryButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _platformRecoveryButton.layer.cornerRadius = 2;
        [_platformRecoveryButton.layer masksToBounds];
        
        [_platformRecoveryButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _platformRecoveryButton;
}

- (UIButton *)nowMailButton
{
    if (!_nowMailButton) {
        _nowMailButton = [[UIButton alloc] init];
        [_nowMailButton setTitle:@"立即邮寄" forState:UIControlStateNormal];
        [_nowMailButton setBackgroundColor:[UIColor mainThemColor]];
        [_nowMailButton sizeToFit];
        _nowMailButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _nowMailButton.layer.cornerRadius = 2;
        [_nowMailButton.layer masksToBounds];
        
        [_nowMailButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nowMailButton;
}

- (UILabel *)identificationLabel
{
    if (!_identificationLabel) {
        _identificationLabel = [[UILabel alloc] init];
        _identificationLabel.text = @"鉴定中";
        _identificationLabel.font = [UIFont systemFontOfSize:14.0];
        _identificationLabel.textColor = [UIColor mainThemColor];
        _identificationLabel.textAlignment = NSTextAlignmentRight;
    }
    return _identificationLabel;
}

- (UIButton *)mailBackButton
{
    if (!_mailBackButton) {
        _mailBackButton = [[UIButton alloc] init];
        [_mailBackButton setTitle:@"我要退回" forState:UIControlStateNormal];
        [_mailBackButton setBackgroundColor:[UIColor mainThemColor]];
        [_mailBackButton sizeToFit];
        _mailBackButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        _mailBackButton.layer.cornerRadius = 2;
        [_mailBackButton.layer masksToBounds];
        
        [_mailBackButton addTarget:self action:@selector(otherFunctionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mailBackButton;
}

@end
