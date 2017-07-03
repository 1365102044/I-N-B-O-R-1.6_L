//
//  YXOrderDetailViewController.m
//  OrderDetail
//
//  Created by 郑键 on 16/12/12.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXOrderDetailViewController.h"
#import "YXOrderDetailStatusHeaderView.h"
#import "YXOrderDetailCell.h"
#import "YXOrderDetaileStepHeaderView.h"
#import "YXOrderDetailBaseDataModel.h"
#import "YXNetworkTool.h"
#import "YXOrederDetailBottomFuncView.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXAlertViewTool.h"
#import "YXLineTransferController.h"
#import "YXChatViewManger.h"
#import "UIBarButtonItem+Extension.h"
#import "YXPaymentSuccessViewController.h"
#import "YXPayMentResultViewController.h"
#import "MYMyOrderLogisticsInformationViewController.h"
#import "YXApplyRefundViewController.h"
#import "YXPayMentHistroyViewController.h"
#import "YXLineTransferController.h"
#import "YXLineInformationCommitSuccessViewController.h"
#import "YXAlearlyCommitApplyViewController.h"
#import "YXIncomeAndExpenseDeatilViewController.h"
#import "YXNewsDingdanNotiListViewController.h"
#import "YXPCUniconPayZabrViewController.h"
#import "YXSearchResultListViewController.h"
@interface YXOrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate, YXOrederDetailBottomFuncViewDelegate>

/**
 订单编号
 */
@property (nonatomic, assign) long long orderId;

/**
 内容视图
 */
@property (nonatomic, strong) UITableView *contentTableView;

/**
 底部功能按钮视图
 */
@property (nonatomic, strong) YXOrederDetailBottomFuncView *bottomFuncView;

/**
 数据模型
 */
@property (nonatomic, strong) YXOrderDetailModel *detailModel;

/**
 基础数据数组
 */
@property (nonatomic, strong) NSArray *baseDataModelArray;

/**
 倒计时定时器
 */
@property (nonatomic, strong) NSTimer *countDownTimer;

/**
 支付方式数组
 */
@property (nonatomic, strong) NSArray *payTypeArray;

/**
 右上角取消订单按钮
 */
@property (nonatomic, strong) UIButton *cancelOrderButton;

/**
 支付界面
 */
@property (nonatomic, weak) YXPaymentHomePageController *paymentHomePageController;

/**
 sourceController
 */
@property (nonatomic, strong) UIViewController *sourceController;

@end

@implementation YXOrderDetailViewController

#pragma mark - Zero.Const

/**
 状态头重用标识
 */
static NSString * const kYXOrderDetailViewControllerStepHeaderViewReuseIdentifier           = @"kYXOrderDetailViewControllerStepHeaderViewReuseIdentifier";

/**
 普通头重用标识
 */
static NSString * const kYXOrderDetailViewControllerStatusHeaderViewReuseIdentifier         = @"kYXOrderDetailViewControllerStatusHeaderViewReuseIdentifier";
/**
 cell重用标志
 */
static NSString * const kYXOrderDetailViewControllerCellReuseIdentifier                     = @"kYXOrderDetailViewControllerCellReuseIdentifier";
/**
 *底部功能栏高度
 */
CGFloat YXOrederDetailBottomFuncViewHeight = 44.f;

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 获取网络数据，转模型

 @param detailModel 网络数据
 */
- (void)setDetailModel:(YXOrderDetailModel *)detailModel
{
    _detailModel = detailModel;
    
    if (self.baseDataModelArray.count == 0
        || !self.baseDataModelArray) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 4; i++) {
            YXOrderDetailBaseDataModel *baseModel               = [YXOrderDetailBaseDataModel new];
            baseModel.dataModel                                 = detailModel;
            baseModel.currentSection                            = i;
            baseModel.status                                    = YXOrderStatusNone;
            baseModel.surplusBidTime                            = CGFLOAT_MIN;
            [tempArray addObject:baseModel];
        }
        self.baseDataModelArray = tempArray.mutableCopy;
    }else{
        [self.baseDataModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YXOrderDetailBaseDataModel *baseModel       = (YXOrderDetailBaseDataModel *)obj;
            baseModel.dataModel                         = detailModel;
            baseModel.status                            = YXOrderStatusNone;
            baseModel.timeListArray                     = nil;
            baseModel.numberForSection                  = 0;
            baseModel.heightForSectionHeader            = 0;
            baseModel.heightForSectionFooter            = 0;
            baseModel.heightForRow                      = nil;
            baseModel.severTime                         = nil;
            baseModel.surplusBidTime                    = CGFLOAT_MIN;
        }];
        self.baseDataModelArray                         = self.baseDataModelArray;
    }
}

/**
 基础数据数组

 @param baseDataModelArray baseDataModelArray
 */
- (void)setBaseDataModelArray:(NSArray *)baseDataModelArray
{
    _baseDataModelArray = baseDataModelArray;
    
    __weak YXOrderDetailBaseDataModel *dataBaseModel        = _baseDataModelArray.firstObject;
    self.bottomFuncView.orderDetailBaseDataModel            = dataBaseModel;
    [self changeCancelButtonIsHiddenWithDataBaseModel:dataBaseModel];
    [self.contentTableView reloadData];
    [self checkIsStartTimerWithDataBaseModel:dataBaseModel];
}

/**
 根据条件判断是否开启定时器
 */
- (void)checkIsStartTimerWithDataBaseModel:(YXOrderDetailBaseDataModel *)dataBaseModel
{
    if (dataBaseModel.status == YXOrderStatusPendingPayment
        || dataBaseModel.status == YXOrderStatusPendingPayment_lineTransfer
        || dataBaseModel.status == YXOrderStatusPartPayment
        || dataBaseModel.status == YXOrderStatusPartPayment_notPayBond
        || dataBaseModel.status == YXOrderStatusPartPayment_alreadyPayBond
        || dataBaseModel.status == YXOrderStatusCheckTransferFaild
        || dataBaseModel.status == YXOrderStatusPendingSure) {
        [self creatTimer];
    }
}

/**
 改变取消订单按钮状态

 @param alpha alpha
 */
- (void)changeCancelButtonIsHiddenWithDataBaseModel:(YXOrderDetailBaseDataModel *)orderBaseModel
{
    if (orderBaseModel.status == YXOrderStatusPendingPayment) {
        self.cancelOrderButton.hidden               = NO;
    }else{
        self.cancelOrderButton.hidden               = YES;
    }
}

#pragma mark - Third.点击事件

/**
 返回点击事件

 @param sender 返回按钮
 */
- (void)backButtonClick:(UIBarButtonItem *)sender
{
    //** 支付成功界面进入当前界面 */
    if ([self.sourceController isKindOfClass:[YXPaymentSuccessViewController class]]) {
        /**
         防止从搜索列表过去 付款的，返回问题
         */
        for (UIViewController *Vcs in self.navigationController.viewControllers) {
            if ([Vcs isKindOfClass:[YXSearchResultListViewController class]]) {
                [self.navigationController popToViewController:self.navigationController.viewControllers[3] animated:YES];
                return;
            }
        }
        
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        return;
    }
    
    //** 支付失败结果页进入当前界面 */
    if ([self.sourceController isKindOfClass:[YXPayMentResultViewController class]]) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        return;
    }
    
    //** 上传凭证控制器进入当前界面 */
    if ([self.sourceController isKindOfClass:[YXLineTransferController class]]) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        return;
    }
    
    //** 上传控制器详情进入当前界面 */
    if ([self.sourceController isKindOfClass:[YXLineInformationCommitSuccessViewController class]]) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        return;
    }
    
    //** 退款控制器进入当前界面 */
    if ([self.sourceController isKindOfClass:[YXAlearlyCommitApplyViewController class]]) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        return;
    }
    //** 订单消息列表控制器进入当前界面 */
    if ([self.sourceController isKindOfClass:[YXNewsDingdanNotiListViewController class]]) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        return;
    }
    //** 扫码支付控制器进入当前界面 */
    if ([self.sourceController isKindOfClass:[YXPCUniconPayZabrViewController class]]) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        return;
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 取消订单按钮点击事件

 @param sender 取消订单按钮
 */
- (void)cancelOrderButtonClick:(UIButton *)sender
{
    [YXAlertViewTool showAlertView:self
                        totalTitle:nil
                       titlesArray:@[@"我不想要了",
                                     @"支付遇到问题，无法支付",
                                     @"其他原因"]
                      messageArray:nil
                      confrimBlock:^(NSString *title) {
        [[YXMyAccountNetRequestTool sharedTool] cancelOrderWithOrderId:self.detailModel.orderId.longLongValue
                                                             andReason:title
                                                               success:^(id objc, id respodHeader) {
                                                                   [self loadData];
        } failure:^(NSError *error) {
            YXLog(@"%@", error);
        }];
    }];
}

/**
 下拉加载数据
 */
- (void)loadNewData
{
    [self loadData];
}

/**
 定时器触发事件， 向cell发送通知, 启动倒计时
 */
- (void)timerEvent
{
    //** 当刷新界面时，避免由于数组指针指向引起的对象释放，导致的坏内存访问 */
    
    YXOrderDetailBaseDataModel *orderDetailBaseDataModel = self.baseDataModelArray[0];
    [orderDetailBaseDataModel countDown];
    if ([orderDetailBaseDataModel.countDownString isEqualToString:@"倒计时已结束"]) {
        [self cleanTimer];
        [self loadData];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:YXOrderDetailCellCountDownNotification object:nil userInfo:nil];
}

#pragma mark - Fourth.代理方法

#pragma mark <YXOrederDetailBottomFuncViewDelegate>

/**
 底部功能按钮点击事件

 @param orederDetailBottomFuncView      orederDetailBottomFuncView
 @param sender                          按钮
 */
- (void)orederDetailBottomFuncView:(YXOrederDetailBottomFuncView *)orederDetailBottomFuncView
                    andClickButton:(UIButton *)sender
{
    
    if ([sender.titleLabel.text isEqualToString:@"联系客服"]) {
        [[YXChatViewManger sharedChatviewManger] LoadChatView];
        [[YXChatViewManger sharedChatviewManger] presentMQChatViewControllerInViewController:self];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"去支付"]) {
        [self.navigationController pushViewController:self.paymentHomePageController animated:YES];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"上传凭证"]
        || [sender.titleLabel.text isEqualToString:@"编辑凭证"]) {
        //** 跳转相应的控制器 */
        YXLineTransferController *lineTransferController        = [[YXLineTransferController alloc] init];
        lineTransferController.orderId                          = self.detailModel.orderId.longLongValue;
        [self.navigationController pushViewController:lineTransferController animated:YES];
        
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"其他方式支付"]) {
        [self otherPaymentTypeSelectedWithTitleArray:self.payTypeArray
                                    isPushController:YES];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"提醒发货"]) {
        [YXAlertViewTool showAlertView:self title:@"提醒发货" message:@"提醒成功" confrimBlock:^{
            
        }];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"继续支付"]) {
        [self continuePay];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"查看物流"]) {
        MYMyOrderLogisticsInformationViewController *informationController  = [MYMyOrderLogisticsInformationViewController new];
        informationController.cellid                                        = [NSString stringWithFormat:@"%lld",
                                                                               self.detailModel.orderId.longLongValue];
        [self.navigationController pushViewController:informationController animated:YES];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"评价"]) {
        //** 暂无功能 */
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"申请退款"]) {
        YXApplyRefundViewController *refundPwdController = [YXApplyRefundViewController new];
        refundPwdController.orderId = [NSString stringWithFormat:@"%lld", self.orderId];
        [self.navigationController pushViewController:refundPwdController animated:YES];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"确认收货"]) {
        [[YXMyAccountNetRequestTool sharedTool] makeSureConsigneeWithOrder:self.detailModel.orderId.longLongValue
                                                                   success:^(id objc, id respodHeader) {
                                                                       if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                           [self loadData];
                                                                       }
        } failure:^(NSError *error) {
            YXLog(@"%@", error);
        }];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"查看退款"]) {
        YXIncomeAndExpenseDeatilViewController *incomeAndExpenseDeatilViewController = [YXIncomeAndExpenseDeatilViewController new];
        incomeAndExpenseDeatilViewController.orderId = [NSString stringWithFormat:@"%lld", self.detailModel.orderId.longLongValue];
        [self.navigationController pushViewController:incomeAndExpenseDeatilViewController animated:YES];
        return;
    }
}

/**
 继续支付的定金支付和分笔支付
 */
- (void)continuePay
{
    if (self.detailModel.orderPayType == 2) {
        [YXAlertViewTool showAlertView:self
                            totalTitle:nil
                           titlesArray:@[@"全额支付",
                                         @"分笔支付"]
                          messageArray:nil
                          confrimBlock:^(NSString *title) {
                              if ([title isEqualToString:@"全额支付"]) {
                                  self.detailModel.isPartPay = 0;
                                  [self.navigationController pushViewController:self.paymentHomePageController animated:YES];
                              }
                              
                              if ([title isEqualToString:@"分笔支付"]) {
                                  self.detailModel.isPartPay = 1;
                                  [self.navigationController pushViewController:self.paymentHomePageController animated:YES];
                              }
                          }];
    }
    
    if (self.detailModel.orderPayType == 3) {
        [self.navigationController pushViewController:self.paymentHomePageController animated:YES];
    }
}

#pragma mark <UITableViewDataSource>

/**
 返回组
 
 @param tableView               tableView
 
 @return 组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.baseDataModelArray.count;
}

/**
 返回行
 
 @param tableView               tableView
 @param section                 section
 
 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.baseDataModelArray[section] numberForSection];
}

/**
 自定义cell
 
 @param tableView               tableView
 @param indexPath               indexPath
 
 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXOrderDetailViewControllerCellReuseIdentifier];
    if (!cell) {
        cell = [[YXOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kYXOrderDetailViewControllerCellReuseIdentifier];
    }
    
    YXOrderDetailBaseDataModel *dataBaseModel           = self.baseDataModelArray[indexPath.section];
    YXOrderDetailCellStyle currentStyle                 = YXOrderDetailCellNone;
    
    if (indexPath.section == 0
        && indexPath.row == 0) {
        currentStyle = YXOrderDetailCellStatus;
    }
    
    if (indexPath.section == 0
        && indexPath.row == 1) {
        if (dataBaseModel.dataModel.deliveryType == 0) {
            currentStyle = YXOrderDetailCellMail;
        }
        
        if (dataBaseModel.dataModel.deliveryType == 1) {
            currentStyle = YXOrderDetailCellMailPickUp;
        }
    }
    
    if (indexPath.section == 0
        && indexPath.row == 2) {
        currentStyle = YXOrderDetailCellLogistics;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        currentStyle = YXOrderDetailCellDetail;
    }
    
    if (indexPath.section == 2) currentStyle = YXOrderDetailCellPaymentStyle;
    
    if (indexPath.section == 3) currentStyle = YXOrderDetailTimeDetail;
    
    dataBaseModel.currentRow                = indexPath.row;
    cell.orderDetailBaseDataModel           = dataBaseModel;
    cell.style                              = currentStyle;
    return cell;
}

/**
 返回组头

 @param tableView               tableView
 @param section                 section
 @return                        组头
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //** 根据状态判断是否显示当前状态栏 */
    if (section == 0) {
        YXOrderDetaileStepHeaderView *stepHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYXOrderDetailViewControllerStepHeaderViewReuseIdentifier];
        if (!stepHeaderView) {
            stepHeaderView = [[YXOrderDetaileStepHeaderView alloc] initWithReuseIdentifier:kYXOrderDetailViewControllerStepHeaderViewReuseIdentifier];
        }
        stepHeaderView.orderDetailBaseDataModel = self.baseDataModelArray[section];
        return stepHeaderView;
    }
    
    //** 判断，当前为哪种头 */
    YXOrderDetailHeaderViewStyle currentStyle       = YXOrderDetailHeaderViewNone;
    if (section == 1) currentStyle                  = YXOrderDetailHeaderViewDetail;
    if (section == 3) currentStyle                  = YXOrderDetailHeaderViewOrderId;
    
    YXOrderDetailStatusHeaderView *detailStatusHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYXOrderDetailViewControllerStatusHeaderViewReuseIdentifier];
    if (!detailStatusHeaderView) {
        detailStatusHeaderView                      = [[YXOrderDetailStatusHeaderView alloc] initWithReuseIdentifier:kYXOrderDetailViewControllerStatusHeaderViewReuseIdentifier];
    }
    detailStatusHeaderView.style                    = currentStyle;
    detailStatusHeaderView.orderDetailBaseModel     = self.baseDataModelArray[section];
    return detailStatusHeaderView;
    
}

/**
 行高

 @param tableView           tableView
 @param indexPath           indexPath
 @return                    行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXOrderDetailBaseDataModel *baseDataModel   = self.baseDataModelArray[indexPath.section];
    NSNumber *height                            = baseDataModel.heightForRow[indexPath.row];
    return height.floatValue;
}

/**
 组头高度

 @param tableView           tableView
 @param section             section
 @return                    高度0.1为最小
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.baseDataModelArray[section] heightForSectionHeader];
}

/**
 组尾高度

 @param tableView           tableView
 @param section             section
 @return                    高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [self.baseDataModelArray[section] heightForSectionFooter];
}

/**
 点击选中cell

 @param tableView           tableView
 @param indexPath           indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak YXOrderDetailBaseDataModel *baseDataModel = self.baseDataModelArray.firstObject;
    //** 付款方式 */
    if (indexPath.section == 2 && indexPath.row == 0) {
        //** 判断是否有过支付行为 */
        if (baseDataModel.status != YXOrderStatusPendingPayment ) return;
        
        [self otherPaymentTypeSelectedWithTitleArray:self.payTypeArray
                                    isPushController:NO];
    }
    
    //** 跳转查看明细 */
    if (indexPath.section == 2
        && indexPath.row == 1) {
        YXPayMentHistroyViewController *paymentHistoryController = [YXPayMentHistroyViewController new];
        paymentHistoryController.orderId = [NSString stringWithFormat:@"%lld", self.orderId];
        [self.navigationController pushViewController:paymentHistoryController animated:YES];
    }
}

/**
 其他支付方式选择

 @param titlesArray         标题数组
 @param isPushController    是否push控制器
 */
- (void)otherPaymentTypeSelectedWithTitleArray:(NSArray<NSString *> *)titlesArray
                              isPushController:(BOOL)isPushController
{
    [YXAlertViewTool showAlertView:self
                        totalTitle:nil
                       titlesArray:titlesArray
                      messageArray:nil
                      confrimBlock:^(NSString *title) {
                          //** 请求网络，通知服务器，支付方式改变 */
                          [[YXMyAccountNetRequestTool sharedTool] changePaytypeWithOrderId:self.detailModel.orderId.longLongValue
                                                                              orderPayType:[self checkOrderPayTypeWithTitle:title]
                                                                                   success:^(id objc, id respodHeader) {
                                                                                       if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                                                                                           [self pushFuncControllerWithIsPushController:isPushController title:title];
                                                                                       }else{
                                                                                           
                                                                                       }
                                                                                   } failure:^(NSError *error) {
                                                                                       YXLog(@"%@", error);
                                                                                   }];
                          
                      }];
}

/**
 跳转支付控制器

 @param isPushController 是否跳转
 */
- (void)pushFuncControllerWithIsPushController:(BOOL)isPushController
                                         title:(NSString *)title
{
    self.detailModel.orderPayType                                   = [self checkOrderPayTypeWithTitle:title];
    if (isPushController) {
        if ([self checkOrderPayTypeWithTitle:title] == 4) {
            //** 跳转相应的控制器 */
            YXLineTransferController *lineTransferController        = [[YXLineTransferController alloc] init];
            lineTransferController.orderId                          = self.detailModel.orderId.longLongValue;
            [self.navigationController pushViewController:lineTransferController animated:YES];
        }else{
            [self.navigationController pushViewController:self.paymentHomePageController animated:YES];
        }
    }else{
        [self loadData];
    }
}

/**
 转换支付方式为状态码 0.传入错误的title

 @param title title
 */
- (NSInteger)checkOrderPayTypeWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"全额支付"]) return 1;
    if ([title isEqualToString:@"定金支付"]) return 2;
    if ([title isEqualToString:@"分笔支付"]) return 3;
    if ([title isEqualToString:@"转账汇款"]) {
        return 4;
    }else{
        return 0;
    }
}

#pragma mark - Fifth.控制器生命周期

/**
 获取订单详情控制器实例
 
 @param orderId orderId                 订单编号
 @param extend extend                   扩展参数（暂时可传空）
 @return return value                   订单详情控制器实例
 */
+ (instancetype)orderDetailViewControllerWithOrderId:(long long)orderId
                                           andExtend:(id)extend
{
    YXOrderDetailViewController *orderDetailViewController      = [self new];
    orderDetailViewController.orderId                           = orderId;
    if (!extend) return orderDetailViewController;
    if ([extend isKindOfClass:[UIViewController class]]) orderDetailViewController.sourceController = (UIViewController *)extend;
    return orderDetailViewController;
}

/**
 视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCustomUI];
    [self registerSubViews];
}

/**
 视图即将出现

 @param animated 动画
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    self.tabBarController.tabBar.hidden = YES;
}

/**
 视图即将离开

 @param animated animated
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self cleanTimer];
    [[YXMyAccountNetRequestTool sharedTool].operationQueue cancelAllOperations];
}

/**
 视图即将离开

 @param animated 动画
 */
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Sixth.界面配置

/**
 注册子控件
 */
- (void)registerSubViews
{
    [self.contentTableView registerClass:[YXOrderDetailStatusHeaderView class] forHeaderFooterViewReuseIdentifier:kYXOrderDetailViewControllerStatusHeaderViewReuseIdentifier];
}

/**
 配置自定义界面
 */
- (void)setupCustomUI
{
    self.view.backgroundColor                   = [UIColor whiteColor];
    self.title                                  = @"订单详情";
    self.tabBarController.tabBar.hidden         = YES;
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.bottomFuncView];
    
    UIBarButtonItem *cancelButtonBarItem        = [[UIBarButtonItem alloc] initWithCustomView:self.cancelOrderButton];
    self.navigationItem.rightBarButtonItem      = cancelButtonBarItem;
    
    UIBarButtonItem *leftBarButtonItem          = [UIBarButtonItem itemWithTarget:self
                                                                           action:@selector(backButtonClick:)
                                                                            image:@"icon_fanhui"
                                                                        highImage:@"icon_fanhui"];
    self.navigationItem.leftBarButtonItem       = leftBarButtonItem;
}

/**
 添加定时器
 */
- (void)creatTimer
{
    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
}

/**
 释放定时器
 */
- (void)cleanTimer
{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}

#pragma mark - Seventh.懒加载

- (YXPaymentHomePageController *)paymentHomePageController
{
    if (!_paymentHomePageController) {
        __weak YXOrderDetailBaseDataModel *baseDataModel        = self.baseDataModelArray.firstObject;
        YXPaymentHomePageController *paymentHomePageController  = [YXPaymentHomePageController
                                                                   loadPaymentControllerWithProdId:self.detailModel.orderId.longLongValue
                                                                   andType:baseDataModel.type];
        [self addChildViewController:paymentHomePageController];
        _paymentHomePageController                              = paymentHomePageController;
    }
    return _paymentHomePageController;
}

- (UIButton *)cancelOrderButton
{
    if (!_cancelOrderButton) {
        _cancelOrderButton                      = [[UIButton alloc] init];
        _cancelOrderButton.titleLabel.font      = YXRegularfont(15.f);
        _cancelOrderButton.hidden               = YES;
        [_cancelOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelOrderButton sizeToFit];
        [_cancelOrderButton setTitleColor:[UIColor mainThemColor] forState:UIControlStateNormal];
        [_cancelOrderButton addTarget:self
                               action:@selector(cancelOrderButtonClick:)
                     forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelOrderButton;
}

- (NSArray *)payTypeArray
{
    /**
     订单付款方式 1全额支付，2定金支付，3分笔支付，4转账汇款，5订金+刷卡
     */
    //@property (nonatomic, assign) NSInteger orderPayType;
    
    //** 不允许分笔 */
    if (self.detailModel.isAllowDepositPay == 0) {
        
        if (self.detailModel.orderPayType == 1) {
            _payTypeArray                           = @[@"分笔支付"];
        }
        
        if (self.detailModel.orderPayType == 3) {
            _payTypeArray                           = @[@"全额支付"];
        }
        
        if (self.detailModel.orderPayType == 4) {
            _payTypeArray                           = @[@"全额支付",
                                                        @"分笔支付"];
        }
        
    }else{
        if (self.detailModel.orderPayType == 1) {
            _payTypeArray                           = @[@"定金支付",
                                                        @"分笔支付",];
        }
        
        if (self.detailModel.orderPayType == 2) {
            _payTypeArray                           = @[@"全额支付",
                                                        @"分笔支付"];
        }
        
        if (self.detailModel.orderPayType == 3) {
            _payTypeArray                           = @[@"全额支付",
                                                        @"定金支付"];
        }
        
        if (self.detailModel.orderPayType == 4) {
            _payTypeArray                           = @[@"全额支付",
                                                        @"定金支付",
                                                        @"分笔支付"];
        }
    }
    return _payTypeArray;
}

/**
 倒计时定时器

 @return 定时器
 */
- (NSTimer *)countDownTimer
{
    if (!_countDownTimer) {
        _countDownTimer = [NSTimer timerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(timerEvent)
                                                userInfo:nil
                                                 repeats:YES];
    }
    return _countDownTimer;
}

- (UITableView *)contentTableView
{
    if (!_contentTableView) {
        _contentTableView                       = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _contentTableView.separatorStyle        = UITableViewCellSeparatorStyleNone;
        _contentTableView.contentInset          = UIEdgeInsetsMake(0, 0, 44, 0);
        _contentTableView.backgroundColor       = [UIColor themLightGrayColor];
        _contentTableView.mj_header             = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                       refreshingAction:@selector(loadNewData)];
        _contentTableView.delegate              = self;
        _contentTableView.dataSource            = self;
    }
    return _contentTableView;
}

- (YXOrederDetailBottomFuncView *)bottomFuncView
{
    if (!_bottomFuncView) {
        _bottomFuncView                         = [[YXOrederDetailBottomFuncView alloc] initWithFrame:CGRectMake(0,
                                                                                                                 self.view.bounds.size.height - YXOrederDetailBottomFuncViewHeight,
                                                                                                                 self.view.bounds.size.width,
                                                                                                                 YXOrederDetailBottomFuncViewHeight)];
        _bottomFuncView.delegate                = self;
    }
    return _bottomFuncView;
}

#pragma mark - Eighth.加载网络数据

- (void)loadData
{
    //** =========================================================================================== */
    //** =====================================测试本地JSON数据代码===================================== */
    //** =========================================================================================== */
    
//    NSData *data = [NSData dataWithContentsOfFile:@"/Users/zhengjian/Desktop/Contents.json"];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//    self.detailModel = [YXOrderDetailModel mj_objectWithKeyValues:dict];

    //** =========================================================================================== */
    //** ===========================================网络请求========================================== */
    //** =========================================================================================== */
    [self cleanTimer];
    [[YXMyAccountNetRequestTool sharedTool] loadOrderDetailWithOrderId:self.orderId success:^(id objc, id respodHeader) {
        self.detailModel = [YXOrderDetailModel mj_objectWithKeyValues:objc];
        [self.contentTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        YXLog(@"%@", error);
        [self.contentTableView.mj_header endRefreshing];
    }];
}

@end
