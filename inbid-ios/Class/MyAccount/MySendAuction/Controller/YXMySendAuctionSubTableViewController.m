//
//  YXMySendAuctionSubTableViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySendAuctionSubTableViewController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXMySendAuctionHoldTest.h"
#import "YXMySendAuctionHoldTestHeaderView.h"
#import "YXMySendAuctionIngBidCell.h"
#import "YXMySendAuctionIngBid.h"
#import "YXMySendAuctionEndBidCell.h"
#import "YXMySendAuctionEndBid.h"
#import "YXMySendAuctionTimeListCell.h"
#import "YXHomeAuctionDeatilViewCotroller.h"
#import "YXMySendAuctionHoldTestBaseModel.h"
#import "YXMySendAuctionIngBidBaseModel.h"
#import "YXMySendAuctionEndBidBaseModel.h"
#import "YXNoMoreDataFooterView.h"
#import "YXMyAccoutBindBankCardViewController.h"
#import "YXMyAucctionRealnameAndBindbankCardViewController.h"
#import "YXImmediatelyMailController.h"
#import "YXImmediatelyIdentifiedController.h"
#import "YXPlatformRecoveryController.h"
#import "YXPlatformOnBehalfOfSellingController.h"
#import "YXSendAuctionInformationController.h"
#import "YXAppraisalReportController.h"
#import "YXReturnGoodsViewController.h"
#import "YXAppraisalReportController.h"
#import "YXMySendAuctionFixGoodCell.h"
#import "YXOneMouthPriceDeatilViewController.h"
#import "YXReConsignmentViewController.h"
#import "AppDelegate.h"
#import "YXPaymentHomePageController.h"

//** 通用重用标志 */
static NSString *const kYXMySendAuctionControllerCellReuseIdentifier = @"kYXMySendAuctionControllerCellReuseIdentifier";
//** 等待鉴定_组头重用标志 */
static NSString *const kYXMySendAuctionHeaderViewReuseIdentifier = @"kYXMySendAuctionHeaderViewReuseIdentifier";
//** 等待鉴定_时间轴cell重用标志 */
static NSString *const kYXMySendAuctionTimeListCellReuseIdentifier = @"kYXMySendAuctionTimeListCellReuseIdentifier";
//** 正在寄拍_cell重用标志 */
static NSString *const kYXMySendAuctionIngBidCellReuseIdentifier = @"kYXMySendAuctionIngBidCellReuseIdentifier";
//** 完成寄拍_cell重用标志 */
static NSString *const kYXMySendAuctionEndBidCellReuseIdentifier = @"kYXMySendAuctionEndBidCellReuseIdentifier";
//** 我出售的_cell重用标志 */
static NSString *const kYXMySendAuctionFixGoodCellReuseIdentifier = @"kYXMySendAuctionFixGoodCellReuseIdentifier";



NSInteger const kYXMySendAuctionSubTableViewPageSize = 8;



@interface YXMySendAuctionSubTableViewController ()<YXMySendAuctionHoldTestHeaderViewDelegate, YXMySendAuctionTimeListCellDelegate, YXMySendAuctionEndBidCellDelegate, YXSendAuctionInformationControllerDelegate, YXImmediatelyIdentifiedControllerDelegate, YXPlatformOnBehalfOfSellingControllerDelegate, YXPlatformRecoveryControllerDelegate, YXImmediatelyMailControllerDelegate, YXReturnGoodsViewControllerDelegate, YXMyAccoutBindBankCardViewControllerDelegate, YXMyAucctionRealnameAndBindbankCardViewControllerDelegate, YXMySendAuctionFixGoodCellDelegate, YXAppraisalReportControllerDelegate, YXReConsignmentViewControllerDelegate>

//** 当前indexPath */
@property (nonatomic, assign) NSInteger section;

//** 等待鉴定数据源 */
@property (nonatomic, strong) NSMutableArray *holdTestArray;
//** 正在寄拍数据源 */
@property (nonatomic, strong) NSMutableArray *isSendingAShotArray;
//** 完成寄拍数据源 */
@property (nonatomic, strong) NSMutableArray *doneSendAuctionArray;
//** 当前页总数据 */
@property (nonatomic, strong) NSMutableArray *allMySendAuctionDataArray;
//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;
//** 上拉记录当前页 */
@property (nonatomic, assign) NSInteger pullUpCurPage;
//** 等待鉴定的动态行高 */
@property (nonatomic, assign) CGFloat headerHeight;
//** 动态计算section高度标记 */
@property (nonatomic, assign) BOOL isChangeHeaderHeight;
//** 佣金比例 */
@property (nonatomic, copy) NSString *commissionRatio;
//** 用户离开界面时的屏幕内数据页数 */
@property (nonatomic, assign) NSInteger userDisspaerCurPage;

@end

@implementation YXMySendAuctionSubTableViewController

- (void)setIsDisappear:(BOOL)isDisappear
{
    _isDisappear = isDisappear;
}

/**
 给loadNewData赋值

 @param loadNewData loadNewData
 */
- (void)setLoadNewData:(BOOL)loadNewData
{
    if (loadNewData) {
        [self loadNewMySendAuctionData];
    }
}

#pragma mark - 点击事件

//** 点击push界面 */
- (void)mySendAuctionHoldTestHeaderView:(YXMySendAuctionHoldTestHeaderView *)mySendAuctionHoldTestHeaderView andButton:(UIButton *)sender andHoldTestModel:(YXMySendAuctionHoldTest *)holdTestModel
{
    
    //** 记录当前index */
    NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:mySendAuctionHoldTestHeaderView];
    
    //** 获取当前页码 */
    self.userDisspaerCurPage = [self.holdTestArray[currentIndexPath.row] currentPage];
    
    //** 关闭开关 */
    self.isRestCurrentPage = NO;
    
    if (sender == nil) {
//        YXHomeAuctionDeatilViewCotroller *deatilViewController = [[YXHomeAuctionDeatilViewCotroller alloc] init];
//        deatilViewController.prodId = holdTestModel.prodId;
//        deatilViewController.ProBidId = [NSString stringWithFormat:@"%zd", holdTestModel.];
        return;
    }
    
    NSString *backButtonText;
    if (iPHone5) {
        backButtonText = @"退回";
    }else{
        backButtonText = @"我要退回";
    }
    
    if ([sender.titleLabel.text isEqualToString:@"重新提交"]) {
        //--跳转到寄拍模块,发送通知
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.tabBarController.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:NO];
        
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
        
        YXPaymentHomePageController *paymentController = [YXPaymentHomePageController loadPaymentControllerWithProdId:holdTestModel.orderId andType:YXPaymentHomePageControllerIdentifyCost];
        [self.navigationController pushViewController:paymentController animated:YES];
        
    }else if ([sender.titleLabel.text isEqualToString:@"平台寄拍"]){
        
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PlatformOnBehalfOfSelling" bundle:nil];
//        YXPlatformOnBehalfOfSellingController *platformOnBehalfOfSellingController = [sb instantiateInitialViewController];
//        platformOnBehalfOfSellingController.commissionRatio = self.commissionRatio;
//        platformOnBehalfOfSellingController.sendAuctionHoldTestModel = holdTestModel;
//        platformOnBehalfOfSellingController.delegate = self;
//        [self.navigationController pushViewController: platformOnBehalfOfSellingController animated:YES];
        
    }else if ([sender.titleLabel.text isEqualToString:@"平台回收"]){
        
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PlatformRecovery" bundle:nil];
//        YXPlatformRecoveryController *platformRecoveryController = [sb instantiateInitialViewController];
//        platformRecoveryController.sendAuctionHoldTestModel = holdTestModel;
//        platformRecoveryController.delegate = self;
//        [self.navigationController pushViewController: platformRecoveryController animated:YES];
        
    }else if ([sender.titleLabel.text isEqualToString:@"立即邮寄"]){
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ImmediatelyMailController" bundle:nil];
        YXImmediatelyMailController *mailController = [sb instantiateInitialViewController];
        //mailController.sendAuctionHoldTestModel = holdTestModel;
        mailController.delegate = self;
        [self.navigationController pushViewController: mailController animated:YES];
        
    }else if ([sender.titleLabel.text isEqualToString:backButtonText] || [sender.titleLabel.text isEqualToString:@"我要退回"]){
        //push我要退回界面
        YXReturnGoodsViewController *returnGoodsViewController = [[YXReturnGoodsViewController alloc] init];
        //returnGoodsViewController.holdTest = holdTestModel;
        returnGoodsViewController.delegate = self;
        [self.navigationController pushViewController:returnGoodsViewController animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:backButtonText] || [sender.titleLabel.text isEqualToString:@"鉴定结果"]){
        //鉴定结果，判断鉴定结果为成功或失败
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YXAppraisalReportController" bundle:nil];
        YXAppraisalReportController *appraisalReportController = [sb instantiateInitialViewController];
        appraisalReportController.identifyId = holdTestModel.orderId;
        //appraisalReportController.holdTest = holdTestModel;
        appraisalReportController.delegate = self;
        [self.navigationController pushViewController:appraisalReportController animated:YES];
    }
    
    //** 关闭刷新主界面开关 */
    [self setHomePageAllPageRest:NO];
}

- (void)mySendAuctionHoldTestHeaderView:(YXMySendAuctionHoldTestHeaderView *)mySendAuctionHoldTestHeaderView andHoldTestModel:(YXMySendAuctionHoldTest *)holdTestModel
{
//    //跳转预鉴定详情
//    YXSendAuctionInformationController *informationController = [YXSendAuctionInformationController new];
//    informationController.sourceViewController = self;
//    informationController.holdTest = holdTestModel;
//    informationController.commissionRatio = self.commissionRatio;
//    [self.navigationController pushViewController:informationController animated:YES];
}

- (void)mySendAuctionHoldTestHeaderView:(YXMySendAuctionHoldTestHeaderView *)mySendAuctionHoldTestHeaderView andClickText:(NSString *)text andIdentifyId:(long long)identifyId
{
    YXAppraisalReportController *appraisalReportController = [[YXAppraisalReportController alloc] init];
    //appraisalReportController.identifyId = identifyId;
    [self.navigationController pushViewController:appraisalReportController animated:YES];
}

#pragma mark <YXMySendAuctionFixGoodCellDelegate>

- (void)mySendAuctionFixGoodCell:(YXMySendAuctionFixGoodCell *)mySendAuctionFixGoodCell funcButton:(UIButton *)sender andModel:(YXMySendAuctionHoldTest *)model
{
    if ([sender.titleLabel.text isEqualToString:@"逾期处理"]) {
        NSIndexPath *currentpath= [self.tableView indexPathForCell:mySendAuctionFixGoodCell];
        self.userDisspaerCurPage = [self.holdTestArray[currentpath.row] currentPage];
        self.isRestCurrentPage = NO;
        //** 如果流拍，跳转流拍处理界面 */
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YXReConsignmentViewController" bundle:nil];
        YXReConsignmentViewController *reConsignmentViewController = [sb instantiateInitialViewController];
        reConsignmentViewController.identifyId = model.orderId;
        reConsignmentViewController.delegate = self;
        [self.navigationController pushViewController:reConsignmentViewController animated:YES];
        return;
    }
}

#pragma mark - YXMySendAuctionEndBidCellDelegate

- (void)sendAuctionEndBidCell:(YXMySendAuctionEndBidCell *)sendAuctionEndBidCell
{
    //push我要退回界面
    NSIndexPath *curIndexPath = [self.tableView indexPathForCell:sendAuctionEndBidCell];
    YXReturnGoodsViewController *returnGoodsViewController = [[YXReturnGoodsViewController alloc] init];
    returnGoodsViewController.endBidList = self.doneSendAuctionArray[curIndexPath.row];
    [self.navigationController pushViewController:returnGoodsViewController animated:YES];
}


#pragma mark --YXMySendAuctionTimeListCellDelegate

- (void)mySendAuctionTimeListCell:(YXMySendAuctionTimeListCell *)mySendAuctionTimeListCell clickText:(NSString *)text
{
    YXAppraisalReportController *appraisalReportController = [[YXAppraisalReportController alloc] init];
    
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
    self.isRestCurrentPage = isRestPage;
}

#pragma mark --YXImmediatelyIdentifiedControllerDelegate

/**
 打开刷新开关

 @param immediatelyIdentifiedController 支付鉴定费
 @param isRestPage                      开关
 */
- (void)immediatelyIdentifiedController:(YXImmediatelyIdentifiedController *)immediatelyIdentifiedController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentPage = isRestPage;
}

#pragma mark --YXPlatformOnBehalfOfSellingControllerDelegate

/**
 打开刷新开关

 @param platformOnBehalfOfSellingController 平台代卖控制器
 @param isRestPage                          开关
 */
- (void)platformOnBehalfOfSellingController:(YXPlatformOnBehalfOfSellingController *)platformOnBehalfOfSellingController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentPage = isRestPage;
}

#pragma mark --YXPlatformRecoveryControllerDelegate

/**
 打开刷新开关

 @param platformRecoveryController 平台回收
 @param isRestPage                 开关
 */
- (void)platformRecoveryController:(YXPlatformRecoveryController *)platformRecoveryController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentPage = isRestPage;
}

#pragma mark --YXImmediatelyMailControllerDelegate

/**
 打开刷新开关

 @param immediatelyMailController 立即邮寄控制器
 @param isRestPage                开关
 */
- (void)immediatelyMailController:(YXImmediatelyMailController *)immediatelyMailController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentPage = isRestPage;
}

#pragma mark --YXReturnGoodsViewControllerDelegate

/**
 打开刷新开关

 @param returnGoodsViewController 我要退回控制器
 @param isRestPage                开关
 */
- (void)returnGoodsViewController:(YXReturnGoodsViewController *)returnGoodsViewController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentPage = isRestPage;
}

#pragma mark --YXMyAccoutBindBankCardViewControllerDelegate

/**
 打开刷新开关

 @param myAccoutBindBankCardViewController 绑定银行卡控制器
 @param isRestPage                         开关
 */
- (void)myAccoutBindBankCardViewController:(YXMyAccoutBindBankCardViewController *)myAccoutBindBankCardViewController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentPage = isRestPage;
}

#pragma mark --YXMyAucctionRealnameAndBindbankCardViewControllerDelegate

/**
 打开刷新开关

 @param myAucctionRealnameAndBindbankCardViewController 实名认证控制器
 @param isRestPage                                      开关
 */
- (void)myAucctionRealnameAndBindbankCardViewController:(YXMyAucctionRealnameAndBindbankCardViewController *)myAucctionRealnameAndBindbankCardViewController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentPage = isRestPage;
}

#pragma mark --YXAppraisalReportControllerDelegate>

- (void)appraisalReportController:(YXAppraisalReportController *)appraisalReportController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentPage = isRestPage;
}

#pragma mark --YXReConsignmentViewControllerDelegate

- (void)reConsignmentViewController:(YXReConsignmentViewController *)reConsignmentViewController changeRestPageON:(BOOL)isRestPage
{
    self.isRestCurrentPage = isRestPage;
}

/**
 设置是否刷新主页面开关
 */
- (void)setHomePageAllPageRest:(BOOL)isRest
{
    if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:isRestAllCurPage:)]) {
        [self.delegate mySendAuctionSubTableViewController:self isRestAllCurPage:isRest];
    }
}
#pragma mark - 加载网络数据


//** 下拉刷新数据 */
- (void)loadNewMySendAuctionData
{
    NSInteger curPage = [self.allMySendAuctionDataArray.firstObject curPage] - 1 <= 0 ? 1 : [self.allMySendAuctionDataArray.firstObject curPage] - 1;
    
    if ([self.title isEqualToString:@"我的鉴定"]) {
        [[YXMyAccountNetRequestTool sharedTool] loadMySendAShortWaitIdentifyWithCurPage:curPage andPageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            [self.holdTestArray removeAllObjects];
            [self.allMySendAuctionDataArray removeAllObjects];
            
            YXMySendAuctionHoldTestBaseModel *objcModel = [YXMySendAuctionHoldTestBaseModel mj_objectWithKeyValues:objc];
            self.commissionRatio = objcModel.commissionRatio;
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.holdTestArray addObjectsFromArray: objcModel.dataList];
            [self.allMySendAuctionDataArray addObject:objcModel];
            
            [self checkTempViewIsHidden:self.holdTestArray];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mySendAuctionEndRefresh" object:nil userInfo:nil];
            
        } failure:^(NSError *error) {
            [self checkTempViewIsHidden:self.holdTestArray];
            [self.tableView.mj_header endRefreshing];
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mySendAuctionEndRefresh" object:nil userInfo:nil];
        }];
        
    }else if ([self.title isEqualToString:@"正在寄拍"]){
        
        [[YXMyAccountNetRequestTool sharedTool] loadIngBidListWithCurPage:curPage andPageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            [self.isSendingAShotArray removeAllObjects];
            [self.allMySendAuctionDataArray removeAllObjects];
            
            YXMySendAuctionIngBidBaseModel *objcModel = [YXMySendAuctionIngBidBaseModel mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.isSendingAShotArray addObjectsFromArray: objcModel.dataList];
            [self.allMySendAuctionDataArray addObject:objcModel];
            
            [self checkTempViewIsHidden:self.isSendingAShotArray];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mySendAuctionEndRefresh" object:nil userInfo:nil];
            
        } failure:^(NSError *error) {
            [self checkTempViewIsHidden:self.isSendingAShotArray];
            [self.tableView.mj_header endRefreshing];
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mySendAuctionEndRefresh" object:nil userInfo:nil];
        }];
        
    }else if ([self.title isEqualToString:@"完成寄拍"]){
        
        [[YXMyAccountNetRequestTool sharedTool] loadEndBidListWithCurPage:curPage andPageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            [self.doneSendAuctionArray removeAllObjects];
            [self.allMySendAuctionDataArray removeAllObjects];
            
            YXMySendAuctionEndBidBaseModel *objcModel = [YXMySendAuctionEndBidBaseModel mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.doneSendAuctionArray addObjectsFromArray: objcModel.dataList];
            [self.allMySendAuctionDataArray addObject:objcModel];
            
            [self checkTempViewIsHidden:self.doneSendAuctionArray];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mySendAuctionEndRefresh" object:nil userInfo:nil];
        } failure:^(NSError *error) {
            [self checkTempViewIsHidden:self.doneSendAuctionArray];
            [self.tableView.mj_header endRefreshing];
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mySendAuctionEndRefresh" object:nil userInfo:nil];
        }];
    }else if ([self.title isEqualToString:@"我出售的"]){
        
        [[YXMyAccountNetRequestTool sharedTool] getFixPriceBidListWithBidType:1 curPage:curPage pageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
           
            [self.holdTestArray removeAllObjects];
            [self.allMySendAuctionDataArray removeAllObjects];
            
            YXMySendAuctionHoldTestBaseModel *objcModel = [YXMySendAuctionHoldTestBaseModel mj_objectWithKeyValues:objc];
            self.commissionRatio = objcModel.commissionRatio;
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.holdTestArray addObjectsFromArray: objcModel.dataList];
            [self.allMySendAuctionDataArray addObject:objcModel];
            
            [self checkTempViewIsHidden:self.holdTestArray];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mySendAuctionEndRefresh" object:nil userInfo:nil];
            
        } failure:^(NSError *error) {
            [self checkTempViewIsHidden:self.holdTestArray];
            [self.tableView.mj_header endRefreshing];
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mySendAuctionEndRefresh" object:nil userInfo:nil];
        }];
    }
}

//** 上拉刷新数据 */
- (void)loadMoreMySendAuctionData
{
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    
    if ([self.title isEqualToString:@"我的鉴定"]) {
        
        [self.noMoreDataFooterView removeFromSuperview];
        
        self.pullUpCurPage = [[self.allMySendAuctionDataArray lastObject] curPage] + 1;
        
        [[YXMyAccountNetRequestTool sharedTool] loadMySendAShortWaitIdentifyWithCurPage:self.pullUpCurPage andPageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            YXMySendAuctionHoldTestBaseModel *objcModel = [YXMySendAuctionHoldTestBaseModel mj_objectWithKeyValues:objc];
            
            //判断，当当前页数为最后一页时，关闭刷新
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.holdTestArray addObjectsFromArray:objcModel.dataList];
                [self.allMySendAuctionDataArray addObject:objcModel];
            }
            
            self.pullUpCurPage = objcModel.curPage;
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_footer endRefreshing];
        }];
        
    }else if ([self.title isEqualToString:@"正在寄拍"]){
       
        [self.noMoreDataFooterView removeFromSuperview];
        
        self.pullUpCurPage = [[self.allMySendAuctionDataArray lastObject] curPage] + 1;
        
        [[YXMyAccountNetRequestTool sharedTool] loadIngBidListWithCurPage:self.pullUpCurPage andPageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            YXMySendAuctionIngBidBaseModel *objcModel = [YXMySendAuctionIngBidBaseModel mj_objectWithKeyValues:objc];
            
            //判断，当当前页数为最后一页时，关闭刷新
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.isSendingAShotArray addObjectsFromArray:objcModel.dataList];
                [self.allMySendAuctionDataArray addObject:objcModel];
            }
            
            self.pullUpCurPage = objcModel.curPage;
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_footer endRefreshing];
        }];
        
    }else if ([self.title isEqualToString:@"完成寄拍"]){
        
        [self.noMoreDataFooterView removeFromSuperview];
        
        self.pullUpCurPage = [[self.allMySendAuctionDataArray lastObject] curPage] + 1;
        
        [[YXMyAccountNetRequestTool sharedTool] loadEndBidListWithCurPage:self.pullUpCurPage andPageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            YXMySendAuctionEndBidBaseModel *objcModel = [YXMySendAuctionEndBidBaseModel mj_objectWithKeyValues:objc];
            
            //判断，当当前页数为最后一页时，关闭刷新
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.doneSendAuctionArray addObjectsFromArray:objcModel.dataList];
                [self.allMySendAuctionDataArray addObject:objcModel];
            }
            
            self.pullUpCurPage = objcModel.curPage;
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_footer endRefreshing];
        }];
    }else if ([self.title isEqualToString:@"我出售的"]){
        
        [self.noMoreDataFooterView removeFromSuperview];
        
        self.pullUpCurPage = [[self.allMySendAuctionDataArray lastObject] curPage] + 1;
        
        [[YXMyAccountNetRequestTool sharedTool] loadEndBidListWithCurPage:self.pullUpCurPage andPageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            YXMySendAuctionHoldTestBaseModel *objcModel = [YXMySendAuctionHoldTestBaseModel mj_objectWithKeyValues:objc];
            
            //判断，当当前页数为最后一页时，关闭刷新
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.holdTestArray addObjectsFromArray:objcModel.dataList];
                [self.allMySendAuctionDataArray addObject:objcModel];
            }
            
            self.pullUpCurPage = objcModel.curPage;
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_footer endRefreshing];
        }];
    }
}

/**
 检测是否有数据，是否显示无数据界面
 */
- (void)checkTempViewIsHidden:(NSArray *)array
{
    if (array.count != 0) {
        if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:hiddenTempView:title:)]) {
            [self.delegate mySendAuctionSubTableViewController:self hiddenTempView:YES title:self.title];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:hiddenTempView:title:)]) {
            [self.delegate mySendAuctionSubTableViewController:self hiddenTempView:NO title:self.title];
        }
    }
}



//** 根据用户离开前的页数获取数据 */
- (void)loadUserDisppaerCurPageData
{
    
    [YXNetworkHUD show];
    
    if ([self.title isEqualToString:@"我的鉴定"]) {
        [[YXMyAccountNetRequestTool sharedTool] loadMySendAShortWaitIdentifyWithCurPage:self.userDisspaerCurPage andPageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            [self.holdTestArray removeAllObjects];
            [self.allMySendAuctionDataArray removeAllObjects];
            
            YXMySendAuctionHoldTestBaseModel *objcModel = [YXMySendAuctionHoldTestBaseModel mj_objectWithKeyValues:objc];
            self.commissionRatio = objcModel.commissionRatio;
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.holdTestArray addObjectsFromArray: objcModel.dataList];
            [self.allMySendAuctionDataArray addObject:objcModel];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            [self tableViewScrollToTopWithData:self.holdTestArray];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        }];
        
    }else if ([self.title isEqualToString:@"正在寄拍"]){
        
        [[YXMyAccountNetRequestTool sharedTool] loadIngBidListWithCurPage:self.userDisspaerCurPage andPageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            [self.isSendingAShotArray removeAllObjects];
            [self.allMySendAuctionDataArray removeAllObjects];
            
            YXMySendAuctionIngBidBaseModel *objcModel = [YXMySendAuctionIngBidBaseModel mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.isSendingAShotArray addObjectsFromArray: objcModel.dataList];
            [self.allMySendAuctionDataArray addObject:objcModel];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];

            [self tableViewScrollToTopWithData:self.isSendingAShotArray];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        }];
        
    }else if ([self.title isEqualToString:@"完成寄拍"]){
        
        [[YXMyAccountNetRequestTool sharedTool] loadEndBidListWithCurPage:self.userDisspaerCurPage andPageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            [self.doneSendAuctionArray removeAllObjects];
            [self.allMySendAuctionDataArray removeAllObjects];
            
            YXMySendAuctionEndBidBaseModel *objcModel = [YXMySendAuctionEndBidBaseModel mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.doneSendAuctionArray addObjectsFromArray: objcModel.dataList];
            [self.allMySendAuctionDataArray addObject:objcModel];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            [self tableViewScrollToTopWithData:self.doneSendAuctionArray];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        }];
    }else if ([self.title isEqualToString:@"我出售的"]){
        
        [[YXMyAccountNetRequestTool sharedTool] getFixPriceBidListWithBidType:1 curPage:self.userDisspaerCurPage pageSize:kYXMySendAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            [self.holdTestArray removeAllObjects];
            [self.allMySendAuctionDataArray removeAllObjects];
            
            YXMySendAuctionHoldTestBaseModel *objcModel = [YXMySendAuctionHoldTestBaseModel mj_objectWithKeyValues:objc];
            self.commissionRatio = objcModel.commissionRatio;
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.holdTestArray addObjectsFromArray: objcModel.dataList];
            [self.allMySendAuctionDataArray addObject:objcModel];
            
            [self checkTempViewIsHidden:self.holdTestArray];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mySendAuctionEndRefresh" object:nil userInfo:nil];
            
        } failure:^(NSError *error) {
            [self checkTempViewIsHidden:self.holdTestArray];
            [self.tableView.mj_header endRefreshing];
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"mySendAuctionEndRefresh" object:nil userInfo:nil];
        }];
    }
    
    [self.noMoreDataFooterView removeFromSuperview];
    
}

/**
 滚动视图

 @param data 数据数组
 */
- (void)tableViewScrollToTopWithData:(NSArray *)data
{
    if (data && data.count != 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
}

/**
 检测是否有数据，是否显示无数据界面
 */
- (void)checkTempViewIsHidden
{
    
}


/**
 * 时刻监测footer的状态
 */
- (BOOL)checkFooterStateWithObjc:(id)objcModel
{
    if ([self.title isEqualToString:@"我的鉴定"]) {
        YXMySendAuctionHoldTestBaseModel *holdTestModel = (YXMySendAuctionHoldTestBaseModel *)objcModel;
        //当总数等于当前页面
        if (holdTestModel.totalRows % kYXMySendAuctionSubTableViewPageSize == 0 || holdTestModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
            if (holdTestModel.totalRows / kYXMySendAuctionSubTableViewPageSize == holdTestModel.curPage || holdTestModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
                
                YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
                
                noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
                [self.tableView.mj_footer addSubview:noMoreDataFooterView];
                noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
                _noMoreDataFooterView = noMoreDataFooterView;

                
                if (self.pullUpCurPage == holdTestModel.curPage) {
                    [self.holdTestArray addObjectsFromArray:holdTestModel.dataList];
                    [self.allMySendAuctionDataArray addObject:objcModel];
                }
                
                //            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                return YES;
            }else{
                [self.tableView.mj_footer endRefreshing];
                [self.noMoreDataFooterView removeFromSuperview];
                self.noMoreDataFooterView = nil;
                return NO;
            }
        }else{
            if ((holdTestModel.totalRows - holdTestModel.totalRows % kYXMySendAuctionSubTableViewPageSize) / kYXMySendAuctionSubTableViewPageSize + 1 == holdTestModel.curPage) {
                YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
                
                noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
                [self.tableView.mj_footer addSubview:noMoreDataFooterView];
                noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
                _noMoreDataFooterView = noMoreDataFooterView;
                
                if (self.pullUpCurPage == holdTestModel.curPage) {
                    [self.holdTestArray addObjectsFromArray:holdTestModel.dataList];
                    [self.allMySendAuctionDataArray addObject:objcModel];
                }
                
                //            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                return YES;
            }else{
                [self.tableView.mj_footer endRefreshing];
                [self.noMoreDataFooterView removeFromSuperview];
                self.noMoreDataFooterView = nil;
                return NO;
            }
        }
    }else if ([self.title isEqualToString:@"正在寄拍"]){
        YXMySendAuctionIngBidBaseModel *ingBidModel = (YXMySendAuctionIngBidBaseModel *)objcModel;
        
        //当总数等于当前页面
        if (ingBidModel.totalRows % kYXMySendAuctionSubTableViewPageSize == 0 || ingBidModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
            if (ingBidModel.totalRows / kYXMySendAuctionSubTableViewPageSize == ingBidModel.curPage || ingBidModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
                
                YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
                
                noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
                [self.tableView.mj_footer addSubview:noMoreDataFooterView];
                noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
                _noMoreDataFooterView = noMoreDataFooterView;
                
                if (self.pullUpCurPage == ingBidModel.curPage) {
                    [self.isSendingAShotArray addObjectsFromArray:ingBidModel.dataList];
                    [self.allMySendAuctionDataArray addObject:objcModel];
                }
                
                //            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                return YES;
            }else{
                [self.tableView.mj_footer endRefreshing];
                [self.noMoreDataFooterView removeFromSuperview];
                self.noMoreDataFooterView = nil;
                return NO;
            }
        }else{
            if ((ingBidModel.totalRows - ingBidModel.totalRows % kYXMySendAuctionSubTableViewPageSize) / kYXMySendAuctionSubTableViewPageSize + 1 == ingBidModel.curPage) {
                YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
                
                noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
                [self.tableView.mj_footer addSubview:noMoreDataFooterView];
                noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
                _noMoreDataFooterView = noMoreDataFooterView;
                
                if (self.pullUpCurPage == ingBidModel.curPage) {
                    [self.isSendingAShotArray addObjectsFromArray:ingBidModel.dataList];
                    [self.allMySendAuctionDataArray addObject:objcModel];
                }
                
                //            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                return YES;
            }else{
                [self.tableView.mj_footer endRefreshing];
                [self.noMoreDataFooterView removeFromSuperview];
                self.noMoreDataFooterView = nil;
                return NO;
            }
        }
        
    }else if ([self.title isEqualToString:@"完成寄拍"]){
        YXMySendAuctionEndBidBaseModel *endBidModel = (YXMySendAuctionEndBidBaseModel *)objcModel;
        
        //当总数等于当前页面
        if (endBidModel.totalRows % kYXMySendAuctionSubTableViewPageSize == 0 || endBidModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
            if (endBidModel.totalRows / kYXMySendAuctionSubTableViewPageSize == endBidModel.curPage || endBidModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
                
                YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
                
                noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
                [self.tableView.mj_footer addSubview:noMoreDataFooterView];
                noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
                _noMoreDataFooterView = noMoreDataFooterView;
                
                if (self.pullUpCurPage == endBidModel.curPage) {
                    [self.doneSendAuctionArray addObjectsFromArray:endBidModel.dataList];
                    [self.allMySendAuctionDataArray addObject:objcModel];
                }
                
                //            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                return YES;
            }else{
                [self.tableView.mj_footer endRefreshing];
                [self.noMoreDataFooterView removeFromSuperview];
                self.noMoreDataFooterView = nil;
                return NO;
            }
        }else{
            if ((endBidModel.totalRows - endBidModel.totalRows % kYXMySendAuctionSubTableViewPageSize) / kYXMySendAuctionSubTableViewPageSize + 1 == endBidModel.curPage) {
                YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
                
                noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
                [self.tableView.mj_footer addSubview:noMoreDataFooterView];
                noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
                _noMoreDataFooterView = noMoreDataFooterView;
                
                if (self.pullUpCurPage == endBidModel.curPage) {
                    [self.doneSendAuctionArray addObjectsFromArray:endBidModel.dataList];
                    [self.allMySendAuctionDataArray addObject:objcModel];
                }
                
                //            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                return YES;
            }else{
                [self.tableView.mj_footer endRefreshing];
                [self.noMoreDataFooterView removeFromSuperview];
                self.noMoreDataFooterView = nil;
                return NO;
            }
        }
        
    }else if([self.title isEqualToString:@"我出售的"]){
        YXMySendAuctionHoldTestBaseModel *holdTestModel = (YXMySendAuctionHoldTestBaseModel *)objcModel;
        //当总数等于当前页面
        if (holdTestModel.totalRows % kYXMySendAuctionSubTableViewPageSize == 0 || holdTestModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
            if (holdTestModel.totalRows / kYXMySendAuctionSubTableViewPageSize == holdTestModel.curPage || holdTestModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
                
                YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
                
                noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
                [self.tableView.mj_footer addSubview:noMoreDataFooterView];
                noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
                _noMoreDataFooterView = noMoreDataFooterView;
                
                
                if (self.pullUpCurPage == holdTestModel.curPage) {
                    [self.holdTestArray addObjectsFromArray:holdTestModel.dataList];
                    [self.allMySendAuctionDataArray addObject:objcModel];
                }
                
                //            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                return YES;
            }else{
                [self.tableView.mj_footer endRefreshing];
                [self.noMoreDataFooterView removeFromSuperview];
                self.noMoreDataFooterView = nil;
                return NO;
            }
        }else{
            if ((holdTestModel.totalRows - holdTestModel.totalRows % kYXMySendAuctionSubTableViewPageSize) / kYXMySendAuctionSubTableViewPageSize + 1 == holdTestModel.curPage) {
                YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
                
                noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
                [self.tableView.mj_footer addSubview:noMoreDataFooterView];
                noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
                _noMoreDataFooterView = noMoreDataFooterView;
                
                if (self.pullUpCurPage == holdTestModel.curPage) {
                    [self.holdTestArray addObjectsFromArray:holdTestModel.dataList];
                    [self.allMySendAuctionDataArray addObject:objcModel];
                }
                
                //            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                return YES;
            }else{
                [self.tableView.mj_footer endRefreshing];
                [self.noMoreDataFooterView removeFromSuperview];
                self.noMoreDataFooterView = nil;
                return NO;
            }
        }
    }else{
        return NO;
    }
}

//** 下拉检测footerView */
- (void)whenDroupDownCheckFooterViewStateWithObjc:(id)objcModel
{
    
    if ([self.title isEqualToString:@"我的鉴定"]) {
        YXMySendAuctionHoldTestBaseModel *holdTestModel = (YXMySendAuctionHoldTestBaseModel *)objcModel;
        
        if (holdTestModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
            [self.tableView.mj_footer addSubview:noMoreDataFooterView];
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            _noMoreDataFooterView = noMoreDataFooterView;
        }else{
            [self.tableView.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
        }
        
    }else if ([self.title isEqualToString:@"正在寄拍"]){
        YXMySendAuctionIngBidBaseModel *ingBidModel = (YXMySendAuctionIngBidBaseModel *)objcModel;
        
        if (ingBidModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            [self.tableView.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
        }else{
            [self.tableView.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
        }
    }else if ([self.title isEqualToString:@"完成寄拍"]){
        YXMySendAuctionEndBidBaseModel *endBidModel = (YXMySendAuctionEndBidBaseModel *)objcModel;
        
        if (endBidModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            [self.tableView.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
        }else{
            [self.tableView.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
        }
    }else if ([self.title isEqualToString:@"我出售的"]){
        YXMySendAuctionHoldTestBaseModel *holdTestModel = (YXMySendAuctionHoldTestBaseModel *)objcModel;
        
        if (holdTestModel.totalRows < kYXMySendAuctionSubTableViewPageSize) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
            [self.tableView.mj_footer addSubview:noMoreDataFooterView];
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            _noMoreDataFooterView = noMoreDataFooterView;
        }else{
            [self.tableView.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
        }
    }
}



#pragma mark - 控制器生命周期

//** 视图加载完毕 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 配置界面 */
    self.tableView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //self.tableView.contentInset = UIEdgeInsetsMake(-10, 0, 20, 0);
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMySendAuctionData)];
    
    //上下拉加载数据
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMySendAuctionData)];
    MJRefreshAutoFooter *autoFooter                                     = (MJRefreshAutoFooter *)self.tableView.mj_footer;
    autoFooter.triggerAutomaticallyRefreshPercent                       = -150;
    
    
    //** 注册 */
    [self.tableView registerNib:[UINib nibWithNibName:@"mySendAuctionHoldTestHeaderView" bundle:nil] forCellReuseIdentifier:kYXMySendAuctionHeaderViewReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"mySendAuctionIngBidCell" bundle:nil] forCellReuseIdentifier:kYXMySendAuctionIngBidCellReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"mySendAuctionEndCell" bundle:nil] forCellReuseIdentifier:kYXMySendAuctionEndBidCellReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXMySendAuctionFixGoodCell class]) bundle:nil] forCellReuseIdentifier:kYXMySendAuctionFixGoodCellReuseIdentifier];
    
    [self loadNewMySendAuctionData];
    
    if ([self.title isEqualToString:@"我的鉴定"]) {
        self.tableView.rowHeight = 150.0f;
    }else if ([self.title isEqualToString:@"正在寄拍"]){
        self.tableView.rowHeight = 112.0f;
    }else if ([self.title isEqualToString:@"完成寄拍"]){
        self.tableView.rowHeight = 112.0f;
    }else if ([self.title isEqualToString:@"我出售的"]){
        self.tableView.rowHeight = 150.0f;
    }
}

//** 视图即将出现 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //** 添加开关，当用户只浏览未操作时，不进行刷新 */
    if (self.userDisspaerCurPage != 0 && self.isRestCurrentPage) {
        [self loadUserDisppaerCurPageData];
    }
}

//** 视图即将离开 */
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


#pragma mark - Table view data source

//** 数据源_返回组 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//** 数据源_返回组对应行 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.title isEqualToString:@"我的鉴定"]) {
        if (self.holdTestArray.count != 0) {
            if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:hiddenTempView:title:)]) {
                [self.delegate mySendAuctionSubTableViewController:self hiddenTempView:YES title:self.title];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:hiddenTempView:title:)]) {
                [self.delegate mySendAuctionSubTableViewController:self hiddenTempView:NO title:self.title];
            }
        }
        return self.holdTestArray.count;
    }else if ([self.title isEqualToString:@"正在寄拍"]){
        
        if (self.isSendingAShotArray.count != 0) {
            if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:hiddenTempView:title:)]) {
                [self.delegate mySendAuctionSubTableViewController:self hiddenTempView:YES title:self.title];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:hiddenTempView:title:)]) {
                [self.delegate mySendAuctionSubTableViewController:self hiddenTempView:NO title:self.title];
            }
        }
        return self.isSendingAShotArray.count;
    }else if ([self.title isEqualToString:@"完成寄拍"]){
        if (self.doneSendAuctionArray.count != 0) {
            if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:hiddenTempView:title:)]) {
                [self.delegate mySendAuctionSubTableViewController:self hiddenTempView:YES title:self.title];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:hiddenTempView:title:)]) {
                [self.delegate mySendAuctionSubTableViewController:self hiddenTempView:NO title:self.title];
            }
        }
        return self.doneSendAuctionArray.count;
        
    }else if ([self.title isEqualToString:@"我出售的"]){
        if (self.holdTestArray.count != 0) {
            if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:hiddenTempView:title:)]) {
                [self.delegate mySendAuctionSubTableViewController:self hiddenTempView:YES title:self.title];
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(mySendAuctionSubTableViewController:hiddenTempView:title:)]) {
                [self.delegate mySendAuctionSubTableViewController:self hiddenTempView:NO title:self.title];
            }
        }
        return self.holdTestArray.count;
    }
    
    return 0;
}

//** 数据源_返回cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.title isEqualToString:@"我的鉴定"]) {
        
        YXMySendAuctionHoldTestHeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:kYXMySendAuctionHeaderViewReuseIdentifier forIndexPath:indexPath];
        headerView.sendAuctionHoldTestModel = self.holdTestArray[indexPath.row];
        headerView.delegate = self;
        return headerView;
    
    }else if ([self.title isEqualToString:@"正在寄拍"]){
        
        YXMySendAuctionIngBidCell *ingBidCell = [tableView dequeueReusableCellWithIdentifier:kYXMySendAuctionIngBidCellReuseIdentifier forIndexPath:indexPath];
        ingBidCell.mySendAuctionIngBidModel = self.isSendingAShotArray[indexPath.row];
        ingBidCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return ingBidCell;
    
    }else if ([self.title isEqualToString:@"完成寄拍"]){
        
        YXMySendAuctionEndBidCell *endBidCell = [tableView dequeueReusableCellWithIdentifier:kYXMySendAuctionEndBidCellReuseIdentifier forIndexPath:indexPath];
        endBidCell.mySendAuctionEndBidModel = self.doneSendAuctionArray[indexPath.row];
        endBidCell.selectionStyle = UITableViewCellSelectionStyleNone;
        endBidCell.delegate = self;
        return endBidCell;
    
    }else if ([self.title isEqualToString:@"我出售的"]) {
        
        YXMySendAuctionFixGoodCell *fixGoodCell = [tableView dequeueReusableCellWithIdentifier:kYXMySendAuctionFixGoodCellReuseIdentifier forIndexPath:indexPath];
        //endBidCell.mySendAuctionEndBidModel = self.doneSendAuctionArray[indexPath.row];
        fixGoodCell.sendAuctionHoldTestModel = self.holdTestArray[indexPath.row];
        fixGoodCell.selectionStyle = UITableViewCellSelectionStyleNone;
        fixGoodCell.delegate = self;
        return fixGoodCell;
        
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXMySendAuctionControllerCellReuseIdentifier forIndexPath:indexPath];
        return cell;
    }
}

//** 代理_返回行高 */
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return 0;
//}

//** 代理_点击 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //** 关闭刷新主界面开关 */
    [self setHomePageAllPageRest:NO];
    
    //** 获取当前页码 */
    self.userDisspaerCurPage = [self.holdTestArray[indexPath.row] currentPage];
    
    //** 关闭刷新开关 */
    self.isRestCurrentPage = NO;
    
    YXHomeAuctionDeatilViewCotroller *deatilViewController = [[YXHomeAuctionDeatilViewCotroller alloc] init];
    
    if ([self.title isEqualToString:@"我的鉴定"]) {
        
        //** 根据状态判断选中的是处于什么状态 3.鉴定失败 2.鉴定成功 */
        YXMySendAuctionHoldTest *holdTestModel = self.holdTestArray[indexPath.row];
        
        //** 通过订单号取出当前订单状态 */
        if ([YXUserDefaults boolForKey:[NSString stringWithFormat:@"%lld", holdTestModel.orderId]]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YXAppraisalReportController" bundle:nil];
            YXAppraisalReportController *appraisalReportController = [sb instantiateInitialViewController];
            appraisalReportController.identifyId = holdTestModel.orderId;
            //appraisalReportController.holdTest = holdTestModel;
            appraisalReportController.delegate = self;
            [self.navigationController pushViewController:appraisalReportController animated:YES];
            return;
        }
        
//        YXSendAuctionInformationController *informationController = [YXSendAuctionInformationController new];
//        informationController.sourceViewController = self;
//        informationController.holdTest = self.holdTestArray[indexPath.row];
//        informationController.commissionRatio = self.commissionRatio;
//        informationController.delegate = self;
//        [self.navigationController pushViewController:informationController animated:YES];
        return;
    }else if ([self.title isEqualToString:@"正在寄拍"]){
        YXMySendAuctionIngBid *ingBid = self.isSendingAShotArray[indexPath.row];
        deatilViewController.prodId = ingBid.prodId;
        deatilViewController.ProBidId = ingBid.bidId;
    }else if ([self.title isEqualToString:@"完成寄拍"]){
        YXMySendAuctionEndBid *endBid = self.doneSendAuctionArray[indexPath.row];
        deatilViewController.prodId = endBid.prodId;
        deatilViewController.ProBidId = endBid.bidId;
    }else if ([self.title isEqualToString:@"我出售的"]){
        YXMySendAuctionHoldTest *holdTestModel = self.holdTestArray[indexPath.row];
        //** 如果流拍，跳转流拍处理界面 */
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YXReConsignmentViewController" bundle:nil];
//        if (holdTestModel.bidStatus == 5) {
//            YXReConsignmentViewController *reConsignmentViewController = [sb instantiateInitialViewController];
//            reConsignmentViewController.identifyId = holdTestModel.orderId;
//            reConsignmentViewController.delegate = self;
//            [self.navigationController pushViewController:reConsignmentViewController animated:YES];
//            return;
//        }
        
        YXOneMouthPriceDeatilViewController *fixDetialViewController = [[YXOneMouthPriceDeatilViewController alloc] init];
        
        fixDetialViewController.prodId = [NSString stringWithFormat:@"%@", holdTestModel.prodId];
        fixDetialViewController.prodBidId = [NSString stringWithFormat:@"%lld", holdTestModel.orderId];
        [self.navigationController pushViewController:fixDetialViewController animated:YES];
        return;
    }
    
    [self.navigationController pushViewController:deatilViewController animated:YES];
}



#pragma mark - ScrollView Delegate




#pragma mark - 懒加载

- (NSMutableArray *)allMySendAuctionDataArray
{
    if (!_allMySendAuctionDataArray) {
        _allMySendAuctionDataArray = [NSMutableArray array];
    }
    return _allMySendAuctionDataArray;
}

- (NSMutableArray *)holdTestArray
{
    if (!_holdTestArray) {
        _holdTestArray = [NSMutableArray array];
    }
    return _holdTestArray;
}

- (NSMutableArray *)isSendingAShotArray
{
    if (!_isSendingAShotArray) {
        _isSendingAShotArray = [NSMutableArray array];
    }
    return _isSendingAShotArray;
}

- (NSMutableArray *)doneSendAuctionArray
{
    if (!_doneSendAuctionArray) {
        _doneSendAuctionArray = [NSMutableArray array];
    }
    return _doneSendAuctionArray;
}

- (CGFloat)headerHeight
{
    if (!_headerHeight) {
        _headerHeight = 147.0f;
    }
    return _headerHeight;
}

@end
