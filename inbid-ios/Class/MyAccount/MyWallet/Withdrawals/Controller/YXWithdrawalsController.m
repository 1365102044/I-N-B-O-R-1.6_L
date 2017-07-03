//
//  YXWithdrawalsController.m
//  Project
//
//  Created by 郑键 on 17/2/16.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXWithdrawalsController.h"
#import "YXWithdrawalsCell.h"
#import "YXWithdrawalsModel.h"
#import "YXInputPaymentPasswordView.h"
#import "YXWalletResultController.h"
#import "YXWithdrawalsDataModel.h"
#import "YXBankCardDetailInformationModel.h"
#import "YXStringFilterTool.h"
#import "YXBankCardInformationController.h"
#import "YXMyWalletRequestTool.h"
#import "YXBankCardDetailInformationModel.h"
#import "YXAlertViewTool.h"
#import "NSDate+YXExtension.h"
#import "YXResetPassWordViewController.h"
#import "YXLoginStatusTool.h"
#import "YXSaveLoginDataTool.h"
#import "YXMyWalletBankCardListViewController.h"

static NSString * const kYXWithdrwalsReusableIdentifyId = @"kYXWithdrwalsReusableIdentifyId";

@interface YXWithdrawalsController () <UITableViewDataSource, UITableViewDelegate, YXWithdrawalsCellDelegate, YXInputPaymentPasswordViewDelegate, YXMyWalletBankCardListViewControllerDelegate>

/**
 contentTableView
 */
@property (nonatomic, strong) UITableView *contentTableView;

/**
 模型数组
 */
@property (nonatomic, strong) NSArray *withdrawalsArray;

/**
 数据数组
 */
@property (nonatomic, strong) YXWithdrawalsDataModel *dataModel;

/**
 刷新数据标识
 */
@property (nonatomic, assign) BOOL refreshData;

/**
 记录输入框cell
 */
@property (nonatomic, weak) YXWithdrawalsCell *amontInputCell;

@end

@implementation YXWithdrawalsController

#pragma mark - First.通知

- (void)userEndEditing:(NSNotification *)no
{
    /**
     *  输入事件监听
     */
    YXWithdrawalsModel *amontText           = self.withdrawalsArray[2];
    YXWithdrawalsModel *model               = self.withdrawalsArray[3];
    YXWithdrawalsModel *modelFuncButton     = self.withdrawalsArray[5];
    model.showTotalAmont                    = NO;
    NSString *oldString                     = model.title;
    amontText.showTotalAmont                = NO;
    
    /**
     *  判断输入内容
     */
    NSString *text                          = self.amontInputCell.textField.text;
    if (text.length == 0
        || [text isEqualToString:@""]) {
        model.title = oldString;
        modelFuncButton.funcButtonEnable = NO;
    }else{
        if (text.longLongValue >= self.dataModel.amt_single.longLongValue) {
            model.title = model.userInputText.longLongValue == self.dataModel.amt_single.longLongValue ? @"您提现的金额不足支付手续费":@"超出可提现金额";
        }else{
            model.title = @"提现“连连支付”会扣除1元手续费";
            if (modelFuncButton.dataModel.agreeListBean) {
                modelFuncButton.funcButtonEnable = YES;
            }
        }
    }
    
    NSIndexPath *indexPathRow_3             = [NSIndexPath indexPathForRow:3
                                                                 inSection:0];
    NSIndexPath *indexPathRow_4             = [NSIndexPath indexPathForRow:5
                                                                 inSection:0];
    [self.contentTableView reloadRowsAtIndexPaths:@[indexPathRow_3,
                                                    indexPathRow_4]
                                 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Second.赋值

/**
 获取数据回调

 @param withdrawalsArray withdrawalsArray
 */
- (void)setWithdrawalsArray:(NSArray *)withdrawalsArray
{
    _withdrawalsArray = withdrawalsArray;
    
    [self.withdrawalsArray enumerateObjectsUsingBlock:^(YXWithdrawalsModel *  _Nonnull obj,
                                                        NSUInteger idx,
                                                        BOOL * _Nonnull stop) {
        obj.dataModel = self.dataModel;
    }];
    
    [self.contentTableView reloadData];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark <YXMyWalletBankCardListViewControllerDelegate>

- (void)myWalletBankCardListViewController:(YXMyWalletBankCardListViewController *)myWalletBankCardListViewController
                             bankCardModel:(id)banCardModel
{
    if ([banCardModel isKindOfClass:[YXBankCardDetailInformationModel class]]) {
        
        YXWithdrawalsModel *model           = self.withdrawalsArray[1];
        model.dataModel.agreeListBean       = (YXBankCardDetailInformationModel *)banCardModel;
        model.cellType                      = 1003;
        model.cacheHeightForRow             = ADJUST_PERCENT_FLOAT(70);
        model.title                         = model.dataModel.agreeListBean.bank_name;
        model.detailTitle                   = [NSString stringWithFormat:@"尾号%@%@",
                                                                         model.dataModel.agreeListBean.card_no,
                                               [model.dataModel.agreeListBean.card_type isEqualToString:@"储蓄卡"] ? @"储蓄卡" : @"信用卡"];
        model.titleFontSize                 = 16.f;
        model.detailTitleFontSize           = 13.f;
    }
    
    [self.contentTableView reloadData];
    
}

#pragma mark <YXInputPaymentPasswordViewDelegate>

/**
 输入密码界面，点击按钮回调

 @param inputPaymentPasswordView        inputPaymentPasswordView
 @param button                          button
 */
- (void)inputPaymentPasswordView:(YXInputPaymentPasswordView *)inputPaymentPasswordView
                             pwd:(NSString *)pwd
                     otherButton:(UIButton *)button
{   
    /**
     *  关闭
     */
    if (button.tag == 1001) {
        [inputPaymentPasswordView removeFromSuperview];
    }
    
    /**
     *  忘记密码
     */
    if (button.tag == 1002) {
        YXResetPassWordViewController *forgetPaymentPasswordViewController = [[YXResetPassWordViewController alloc]init];
        [self.navigationController pushViewController:forgetPaymentPasswordViewController
                                             animated:YES];
        
    }
    
    /**
     *  确认发送网络请求
     */
    if (button.tag == 1003) {
        
        /**
         *  获取数据
         */
        YXWithdrawalsModel *model           = self.withdrawalsArray[2];
        
        NSString *no_agree                  = model.dataModel.agreeListBean.no_agree;
        NSString *bank_name                 = model.dataModel.agreeListBean.bank_name;
        NSString *card_no                   = model.dataModel.agreeListBean.card_no;
        
        if (pwd.length == 0
            || [pwd isEqualToString:@""]) {
            
            [self showTipsWithObjc:@{@"errorMsg":@"请输入支付密码"}];
            
            return;
        }
        
        /**
         *  提现
         */
        [[YXMyWalletRequestTool sharedTool] cashoutT1ApplyWithMoneyOrder:model.userInputText
                                                               infoOrder:[NSString stringWithFormat:@"%lld", [NSDate dateGetNowTime]]
                                                                  pwdPay:pwd
                                                                  noAgre:no_agree
                                                             brabankName:bank_name
                                                                  cardNo:card_no
                                                                  success:^(id objc, id respodHeader) {
                                                                      [objc[@"status"] isEqualToString:@"1"] ? [self checkWithdrawalsPaymentPasswordSuccessWithObjc:objc paymentPasswordView: inputPaymentPasswordView] : [self checkWithdrawalsPaymentPasswordFailedWithObjc:objc paymentPasswordView:inputPaymentPasswordView];
                                                                  }
                                                                  failure:^(NSError *error) {
                                                                      YXLog(@"%@", error);
                                                                  }];
    }
}

/**
 验证提现支付密码成功

 @param objc objc
 */
- (void)checkWithdrawalsPaymentPasswordSuccessWithObjc:(id)objc
                                   paymentPasswordView:(YXInputPaymentPasswordView *)inputPaymentPasswordView
{
    [inputPaymentPasswordView removeFromSuperview];
    YXWalletResultController *walletResultController = [YXWalletResultController walletResultControllerWithType:YXWalletResultControllerWithdrawalsResult
                                                                                                         extend:nil];
    [self.navigationController pushViewController:walletResultController animated:YES];
}

/**
 验证提现支付密码失败
 
 @param objc objc
 */
- (void)checkWithdrawalsPaymentPasswordFailedWithObjc:(id)objc
                                  paymentPasswordView:(YXInputPaymentPasswordView *)inputPaymentPasswordView
{
    [inputPaymentPasswordView removeFromSuperview];
    [self showTipsWithObjc:objc];
}

/**
 显示提示
 
 @param objc objc
 */
- (void)showTipsWithObjc:(id)objc
{
    NSString *errorTips;
    @try {
        errorTips = objc[@"errorMsg"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    [YXAlertViewTool showAlertView:self title:@"提示" message:errorTips confrimBlock:^{
        
    }];
}

#pragma mark <YXWithdrawalsCellDelegate>

/**
 cell按钮点击事件

 @param withdrawalsCell         withdrawalsCell
 @param button                  button
 */
- (void)withdrawalsCell:(YXWithdrawalsCell *)withdrawalsCell
            buttonClick:(UIButton *)button
{
    /**
     *  获取数据
     */
    YXWithdrawalsModel *model           = self.withdrawalsArray[2];
    NSString *card_no                   = model.dataModel.agreeListBean.card_no;
    
    /**
     *  输入数据校验
     */
    if (!card_no) {
        [self showTipsWithObjc:@{@"errorMsg":@"请添加或选择一张银行卡"}];
        return;
    }
    
    /**
     *  信用卡过滤
     */
    if ([model.dataModel.agreeListBean.card_type isEqualToString: @"信用卡"]) {
        [self showOtherBankCardList];
        return;
    }
    
    /**
     *  判断金额是否为0
     */
    if ([model.userInputText isEqualToString:@""]
        || model.userInputText.length == 0) {
        [self showTipsWithObjc:@{@"errorMsg":@"请输入提现金额"}];
        return;
    }
    
    /**
     *  判断金额是否大于提现金额
     */
    YXWithdrawalsModel *tipsModel       = self.withdrawalsArray[3];
    if ([tipsModel.title isEqualToString:@"超出可提现金额"]
        || [tipsModel.title isEqualToString:@"您提现的金额不足支付手续费"]) {
        [self showTipsWithObjc:@{@"errorMsg":@"超出可提现金额"}];
        return;
    }
    
    if (button.tag == 1001) {
        YXInputPaymentPasswordView *paymentPasswordView = [YXInputPaymentPasswordView inputPaymentPasswordViewPresentWithExtend:nil];
        paymentPasswordView.delegate = self;
    }
}

/**
 显示其他银行卡提示功能
 */
- (void)showOtherBankCardList
{
    [YXAlertViewTool showAlertView:self title:@"提示" message:@"仅能提现到本人名下储蓄卡" cancelTitle:@"取消" otherTitle:@"添加储蓄卡" cancelBlock:^{
        
    } confrimBlock:^{
        
        /**
         *  跳转银行卡列表界面
         */
        YXMyWalletBankCardListViewController *perfectVC = [[YXMyWalletBankCardListViewController  alloc] init];
        perfectVC.delegate = self;
        perfectVC.PushFormeVCIdentifier = 4;
        self.refreshData = YES;
        [self.navigationController pushViewController:perfectVC animated:YES];
    }];
}

#pragma mark <UITableViewDataSource>

/**
 返回组
 
 
 @param tableView               tableView
 
 @return 组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 返回行
 
 @param tableView               tableView
 @param section                 section
 
 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.withdrawalsArray.count;
}

/**
 自定义cell
 
 @param tableView tableView
 @param indexPath indexPath
 
 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXWithdrawalsCell *cell     = [tableView dequeueReusableCellWithIdentifier:kYXWithdrwalsReusableIdentifyId];
    if (!cell) {
        cell                    = [[YXWithdrawalsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:kYXWithdrwalsReusableIdentifyId];
    }
    if (indexPath.section == 0
        && indexPath.row == 2) {
        self.amontInputCell     = cell;
    }
    
    cell.withdrawalsModel       = self.withdrawalsArray[indexPath.row];
    cell.delegate               = self;
    return cell;
}

/**
 tableViewCell Height

 @param tableView tableView
 @param indexPath indexPath
 @return 行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXWithdrawalsModel *model = self.withdrawalsArray[indexPath.row];
    return model.cacheHeightForRow;
}

/**
 点击事件

 @param tableView tableView
 @param indexPath indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  获取数据，判断当前如何跳转
     */
    YXWithdrawalsModel *model = self.withdrawalsArray[indexPath.row];

    if (indexPath.section == 0
        && indexPath.row == 0) {
        
        /**
         * 跳转银行卡列表
         */
        YXMyWalletBankCardListViewController *perfectVC = [[YXMyWalletBankCardListViewController  alloc] init];
        perfectVC.delegate = self;
        perfectVC.PushFormeVCIdentifier = 4;
        self.refreshData = YES;
        [self.navigationController pushViewController:perfectVC animated:YES];
        
    }
    
    if (indexPath.section == 0
        && indexPath.row == 1) {
        
        /**
         *  银行卡选择，如果有进入选择银行卡界面
         */
        if (model.dataModel.isBindCardFlag) {
            
            /**
             *  跳转银行卡列表
             */
            YXMyWalletBankCardListViewController *perfectVC = [[YXMyWalletBankCardListViewController  alloc] init];
            perfectVC.delegate = self;
            perfectVC.PushFormeVCIdentifier = 4;
            self.refreshData = YES;
            [self.navigationController pushViewController:perfectVC animated:YES];
            
        }else{
            
            /**
             *  未绑定银行卡，进入添加银行卡信息界面
             */
            
            YXBankCardInformationController *bankCardInformationController = [YXBankCardInformationController bankCardInformationControllerWithType:YXBankCardInformationControllerAddBankCard
                                                                                                                                     cardholderName:[[YXSaveLoginDataTool shared] getRealName]
                                                                                                                                         cardNumber:nil
                                                                                                                                             extend:@1];
            bankCardInformationController.title = @"添加银行卡";
            [self.navigationController pushViewController:bankCardInformationController animated:YES];
        }
    }
    
    if (indexPath.section == 0
        && indexPath.row == 3) {
        
        /**
         *  全部提现金额，判断当前是否有可输入金额
         */
        YXWithdrawalsModel *userInputAmontModel = self.withdrawalsArray[indexPath.row - 1];
        YXWithdrawalsModel *tipsModel = self.withdrawalsArray[indexPath.row];
        YXWithdrawalsModel *footerModel = self.withdrawalsArray.lastObject;
        userInputAmontModel.showTotalAmont = YES;
        footerModel.funcButtonEnable = tipsModel.dataModel.amt_single.integerValue <= 0 ? NO : YES;
        tipsModel.title = @"提现“连连支付”会扣除1元手续费";
        [self.contentTableView reloadData];
    }
    
    if (indexPath.section == 0
        && indexPath.row == 4) {
        
        /**
         *  选择到账时间
         */
    }
}

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor       = [UIColor themLightGrayColor];
    self.title                      = @"余额提现";
    [self.view addSubview:self.contentTableView];
    [self registerNotification];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.refreshData) {
        [self loadData];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - Sixth.界面配置

- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userEndEditing:) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - Seventh.懒加载

- (UITableView *)contentTableView
{
    if (!_contentTableView) {
        UITableView *tableViewTemp                      = [[UITableView alloc] initWithFrame:self.view.bounds
                                                                                       style:UITableViewStylePlain];
        tableViewTemp.separatorStyle                    = UITableViewCellSeparatorStyleNone;
        tableViewTemp.delegate                          = self;
        tableViewTemp.dataSource                        = self;
        tableViewTemp.keyboardDismissMode               = YES;
        tableViewTemp.backgroundColor                   = [UIColor themLightGrayColor];
        _contentTableView                               = tableViewTemp;
    }
    return _contentTableView;
}

#pragma mark Eighth.Networking

- (void)loadData
{
    [[YXMyWalletRequestTool sharedTool] queryCashoutApplySuccess:^(id objc, id respodHeader) {
        [objc[@"status"] isEqualToString:@"1"] ? [self loadDataSuccessWithObjc:objc] : [self loadDataFailedWithObjc:objc];
    } failure:^(NSError *error) {
        YXLog(@"%@", error);
    }];
}

/**
 加载数据成功

 @param objc objc
 */
- (void)loadDataSuccessWithObjc:(id)objc
{
    self.dataModel                                          = [YXWithdrawalsDataModel mj_objectWithKeyValues:objc[@"data"]];
    YXBankCardDetailInformationModel *bankCardModel         = self.dataModel.agreeListBean;
    
    /**
     *  判断是否有卡
     */
    if (self.dataModel.isBindCardFlag) {
        NSArray *viewDataModelArray = @[@{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(45),
                                          @"cellType":@1002,
                                          @"title":@"提现至银行卡",
                                          @"detailTitle":@"更改银行卡",
                                          @"titleFontSize":@16,
                                          @"detailTitleFontSize":@13,
                                          @"showTipsColor":@0,
                                          @"funcButtonEnable":@0},
                                        @{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(70),
                                          @"cellType":@1003,
                                          @"title":bankCardModel.bank_name,
                                          @"detailTitle":[NSString stringWithFormat:@"尾号%@%@",
                                                          bankCardModel.card_no,
                                                          [bankCardModel.card_type isEqualToString:@"2"] ? @"储蓄卡" : @"信用卡"],
                                          @"titleFontSize":@16,
                                          @"detailTitleFontSize":@13},
                                        @{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(92),
                                          @"cellType":@1005,
                                          @"title":@"提现金额",
                                          @"detailTitle":@"¥",
                                          @"titleFontSize":@16,
                                          @"detailTitleFontSize":@18.5,
                                          @"showTotalAmont":@0},
                                        @{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(50),
                                          @"cellType":@1002,
                                          @"title":[NSString stringWithFormat:@"¥%@",
                                                    [YXStringFilterTool strmethodComma:
                                                     [self.dataModel.amt_single componentsSeparatedByString:@"."].firstObject]],
                                          @"detailTitle":@"全部提现",
                                          @"titleFontSize":@13,
                                          @"detailTitleFontSize":@13,
                                          @"showTipsColor":@0,
                                          @"funcButtonEnable":@0},
                                        @{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(50),
                                          @"cellType":@1006,
                                          @"title":@"到账时间",
                                          @"detailTitle":@"普通到账",
                                          @"titleFontSize":@16,
                                          @"detailTitleFontSize":@16},
                                        @{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(270),
                                          @"cellType":@1007,
                                          @"title":[NSString stringWithFormat:@"今日剩余额度：¥%@",
                                                    [YXStringFilterTool strmethodComma:self.dataModel.amt_day]],
                                          @"detailTitle":[NSString stringWithFormat:@"今日剩余可提现：%@笔",
                                                          self.dataModel.available_times],
                                          @"titleFontSize":@14,
                                          @"detailTitleFontSize":@14,
                                          @"funcButtonEnable":@0}];
        self.withdrawalsArray       = [YXWithdrawalsModel mj_objectArrayWithKeyValuesArray:viewDataModelArray];
    }else{
        NSArray *viewDataModelArray = @[@{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(45),
                                          @"cellType":@1002,
                                          @"title":@"提现至银行卡",
                                          @"detailTitle":@"更改银行卡",
                                          @"titleFontSize":@16,
                                          @"detailTitleFontSize":@13,
                                          @"showTipsColor":@0,
                                          @"funcButtonEnable":@0},
                                        @{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(70),
                                          @"cellType":@1008,
                                          @"title":@"尚未添加银行卡",
                                          @"detailTitle":@"立即添加一张",
                                          @"titleFontSize":@16,
                                          @"detailTitleFontSize":@16},
                                        @{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(92),
                                          @"cellType":@1005,
                                          @"title":@"提现金额",
                                          @"detailTitle":@"¥",
                                          @"titleFontSize":@16,
                                          @"detailTitleFontSize":@18.5,
                                          @"showTotalAmont":@0},
                                        @{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(50),
                                          @"cellType":@1002,
                                          @"title":[NSString stringWithFormat:@"¥%@",
                                                    [YXStringFilterTool strmethodComma:
                                                     [self.dataModel.amt_single componentsSeparatedByString:@"."].firstObject]],
                                          @"detailTitle":@"全部提现",
                                          @"titleFontSize":@13,
                                          @"detailTitleFontSize":@13,
                                          @"showTipsColor":@0,
                                          @"funcButtonEnable":@0},
                                        @{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(50),
                                          @"cellType":@1006,
                                          @"title":@"到账时间",
                                          @"detailTitle":@"普通到账",
                                          @"titleFontSize":@16,
                                          @"detailTitleFontSize":@16},
                                        @{@"cacheHeightForRow":@ADJUST_PERCENT_FLOAT(270),
                                          @"cellType":@1007,
                                          @"title":[NSString stringWithFormat:@"今日剩余额度：¥%@",
                                                    [YXStringFilterTool strmethodComma:self.dataModel.amt_day]],
                                          @"detailTitle":[NSString stringWithFormat:@"今日剩余可提现：%@笔",
                                                          self.dataModel.available_times],
                                          @"titleFontSize":@14,
                                          @"detailTitleFontSize":@14,
                                          @"funcButtonEnable":@0}];
        self.withdrawalsArray       = [YXWithdrawalsModel mj_objectArrayWithKeyValuesArray:viewDataModelArray];
    }
}

/**
 加载数据失败
 
 @param objc objc
 */
- (void)loadDataFailedWithObjc:(id)objc
{
    if ([objc[@"errorMsg"] isKindOfClass:[NSString class]]) {
        [self showTipsWithObjc:objc];
        return;
    }
    
    NSDictionary *errorMsg;
    NSString *ret_msg;
    @try {
        errorMsg = objc[@"errorMsg"];
        ret_msg = objc[@"ret_msg"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    [YXAlertViewTool showAlertView:self title:@"提示" message:ret_msg confrimBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
