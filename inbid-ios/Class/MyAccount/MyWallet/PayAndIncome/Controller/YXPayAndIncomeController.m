//
//  YXPayAndIncomeController.m
//  inbid-ios
//
//  Created by 郑键 on 17/2/22.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXPayAndIncomeController.h"
#import "ZJCalendarViewController.h"
#import "YXMyWalletRequestTool.h"
#import "YXAlertViewTool.h"
#import "YXWalletPayAndIncomeModel.h"
#import "YXWalletPayAndIncomeDataModel.h"
#import "YXWalletPayAndIncomeCell.h"
#import "YXPayMentHistroyDeatilViewController.h"
#import "YXPayAndIncomeDetailModel.h"

static NSString * const kYXPayAndIncomeCellReusableIdentifyId = @"kYXPayAndIncomeCellReusableIdentifyId";

@interface YXPayAndIncomeController () <UITableViewDataSource, UITableViewDelegate, ZJCalendarViewControllerDelegate, YXWalletPayAndIncomeCellDelegate>

/**
 内容tableView
 */
@property (nonatomic, strong) UITableView *contentTableView;

/**
 no data view
 */
@property (nonatomic, strong) UIView *noDataView;

/**
 dataArray
 */
@property (nonatomic, strong) NSArray *dataArray;

/**
 开始时间
 */
@property (nonatomic, copy) NSString *startTime;

/**
 结束时间
 */
@property (nonatomic, copy) NSString *endTime;

/**
 tempView tipsLabel
 */
@property (nonatomic, strong) UILabel *tempViewTipsLabel;

@end

@implementation YXPayAndIncomeController

#pragma mark - Zero.Const

/**
 *  获取数据页数大小
 */
CGFloat walletPayAndIncomeLoadDataCurrentPageSize = 8;

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 界面赋值

 @param dataArray dataArray
 */
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    /**
     *  判断是否有数据
     */
    YXWalletPayAndIncomeModel *dataModel = self.dataArray.lastObject;
    if (dataModel.totalRows.integerValue == 0) {
        if (!self.startTime
            && !self.endTime) {
            self.contentTableView.hidden = YES;
            self.tempViewTipsLabel.text = @"近30天内无收支记录";
        }else{
            self.contentTableView.hidden = YES;
            self.tempViewTipsLabel.text = @"暂无记录";
        }
    }else{
        self.contentTableView.hidden = NO;
    }
    
    [self.contentTableView reloadData];
}

#pragma mark - Third.点击事件

/**
 上拉
 */
-(void)pullUpRefresh
{
    YXWalletPayAndIncomeModel *lastModel = self.dataArray.lastObject;
    
    /**
     *  判断，当为最后一次请求时
     */
    if (lastModel.curPage.floatValue * walletPayAndIncomeLoadDataCurrentPageSize >= lastModel.totalRows.floatValue) {
        [self.contentTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    [self loadDataWithCurPage:(lastModel.curPage.floatValue + 1.f)
                     pageSize:walletPayAndIncomeLoadDataCurrentPageSize
                  dtStartTime:self.startTime
                    dtEndTime:self.endTime
                   isResetData:NO];
}

/**
 *  下拉
 */
- (void)droupDownRefresh
{
    [self.contentTableView.mj_footer resetNoMoreData];
    [self loadDataWithCurPage:1
                     pageSize:walletPayAndIncomeLoadDataCurrentPageSize
                  dtStartTime:self.startTime
                    dtEndTime:self.endTime
                   isResetData:YES];
}

/**
 按钮点击事件

 @param sender sender
 */
- (void)buttonClick:(UIButton *)sender
{
    ZJCalendarViewController *calendarViewController = [[ZJCalendarViewController alloc] init];
    calendarViewController.delegate = self;
    [self.navigationController pushViewController:calendarViewController animated:YES];
}

/**
 日期选择点击事件

 @param sender sender
 */
- (void)dateSelected:(id)sender
{
    ZJCalendarViewController *calendarViewController = [[ZJCalendarViewController alloc] init];
    calendarViewController.delegate = self;
    [self.navigationController pushViewController:calendarViewController animated:YES];
}

#pragma mark - Fourth.代理方法

#pragma mark <YXWalletPayAndIncomeCellDelegate>

/**
 最后一个cell的点击事件

 @param walletPayAndIncomeCell walletPayAndIncomeCell
 @param sender sender
 */
- (void)walletPayAndIncomeCell:(YXWalletPayAndIncomeCell *)walletPayAndIncomeCell
                   buttonClick:(UIButton *)sender
{
    ZJCalendarViewController *calendarViewController = [[ZJCalendarViewController alloc] init];
    calendarViewController.delegate = self;
    [self.navigationController pushViewController:calendarViewController animated:YES];
}

#pragma mark <ZJCalendarViewControllerDelegate>

/**
 时间选择器选中完毕

 @param calendarViewController  calendarViewController
 @param startTime               startTime
 @param endTime                 endTime
 */
- (void)calendarViewController:(ZJCalendarViewController *)calendarViewController
         userSelectedStartTime:(NSInteger)startTime
           userSelectedEndTime:(NSInteger)endTime
{
    /**
     *  重新发送网络请求，刷新界面
     */
    self.startTime = [self showTimeStringWithTime:startTime];
    self.endTime = [self showTimeStringWithTime:endTime];
    [self droupDownRefresh];
}

/**
 转换时间戳为所需参数格式
 
 @param time time 时间戳
 */
- (NSString *)showTimeStringWithTime:(NSInteger)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]];
}

#pragma mark <UITableViewDataSource>

/**
 返回组
 
 @param tableView tableView
 
 @return 组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

/**
 返回行
 
 @param tableView tableView
 @param section   section
 
 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YXWalletPayAndIncomeModel *model = self.dataArray[section];
    return model.data.count;
}

/**
 自定义cell
 
 @param tableView tableView
 @param indexPath indexPath
 
 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXWalletPayAndIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXPayAndIncomeCellReusableIdentifyId];
    if (!cell) {
        cell = [[YXWalletPayAndIncomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kYXPayAndIncomeCellReusableIdentifyId];
    }
    
    /**
     *  获取数据
     */
    YXWalletPayAndIncomeModel *model = self.dataArray[indexPath.section];
    cell.dataModel = model.data[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

/**
 点击效果

 @param tableView tableView
 @param indexPath indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  获取数据
     */
    YXWalletPayAndIncomeModel *model = self.dataArray[indexPath.section];
    YXWalletPayAndIncomeDataModel *dataModel = model.data[indexPath.row];
    
    /**
     *  是否是最后一个cell
     */
    if (dataModel.isLastCell) return;
    
    /**
     *  获取详情页数据
     */
    [self loadWalletPayAndIncomeDetailWithModel:dataModel];
}

/**
 加载详情数据

 @param model model
 */
- (void)loadWalletPayAndIncomeDetailWithModel:(YXWalletPayAndIncomeDataModel *)model
{
    NSInteger typeDc = -999;
    
    if ([model.oid_biz isEqualToString:@"107001"]) {
        
        /**
         *  商户付款
         */
        typeDc = 1;
        
    }else if ([model.oid_biz isEqualToString:@"202000"]) {
    
        /**
         *  账号提现
         */
        typeDc = 3;
    }
    
    [[YXMyWalletRequestTool sharedTool] loadOrderDetailWithTypeDc:typeDc
                                                       oidPaybill:model.oid_paybill
                                                          noOrder:nil
                                                          success:^(id objc, id respodHeader) {
                                                              [objc[@"status"] isEqualToString:@"1"] ? [self loadOrderDetailSuccessWithObjc:objc model:model] : [self loadOrderDetailFailedWithObjc:objc];
                                                          }
                                                          failure:^(NSError *error) {
                                                              
                                                          }];
}

/**
 请求详情信息成功

 @param objc objc
 */
- (void)loadOrderDetailSuccessWithObjc:(id)objc
                                 model:(YXWalletPayAndIncomeDataModel *)model
{
    YXPayMentHistroyDeatilViewController *payhistroydeatilVC = [[YXPayMentHistroyDeatilViewController alloc] init];
    YXPayAndIncomeDetailModel *detailModel = [YXPayAndIncomeDetailModel mj_objectWithKeyValues:objc[@"data"]];
    detailModel.oid_biz = model.oid_biz;
    detailModel.dt_billtrans = model.dt_billtrans;
    detailModel.flag_dc = model.flag_dc;
    payhistroydeatilVC.detailModel = detailModel;
    [self.navigationController pushViewController:payhistroydeatilVC animated:YES];
}

/**
 请求详情信息失败
 
 @param objc objc
 */
- (void)loadOrderDetailFailedWithObjc:(id)objc
{
    [self showTipsWithObjc:objc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCustomUI];
    [self setupNavigationBar];
    [self droupDownRefresh];
}

#pragma mark - Sixth.界面配置

- (void)setupCustomUI
{
    self.view.backgroundColor                   = [UIColor whiteColor];
    self.title                                  = @"收支明细";
    self.automaticallyAdjustsScrollViewInsets   = NO;
    [self.view addSubview:self.noDataView];
    [self.view addSubview:self.contentTableView];
}

- (void)setupNavigationBar
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"查询"
            forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(dateSelected:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor mainThemColor]
                 forState:UIControlStateNormal];
    [button sizeToFit];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

#pragma mark - Seventh.懒加载

- (UIView *)noDataView
{
    if (!_noDataView) {
        
        _noDataView                         = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                                       64,
                                                                                       self.view.width,
                                                                                       self.view.height - 64)];
        
        UIImageView *logoImageView          = [[UIImageView alloc] init];
        logoImageView.image                 = [UIImage imageNamed:@"iconfont-dingdan"];
        
        UILabel *tipsLabel                  = [[UILabel alloc] init];
        tipsLabel.font                      = REGULAR_FONT(16.f);
        tipsLabel.textColor                 = [UIColor walletTextColor];
        tipsLabel.textAlignment             = NSTextAlignmentCenter;
        _tempViewTipsLabel                  = tipsLabel;
        
        UIButton *button                    = [[UIButton alloc] init];
        [button setTitle:@"查看其它时间段记录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor systemButtonTextColor]
                     forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(buttonClick:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [_noDataView addSubview:logoImageView];
        [_noDataView addSubview:tipsLabel];
        [_noDataView addSubview:button];
        
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_noDataView);
            make.top.mas_equalTo(_noDataView).mas_offset(ADJUST_PERCENT_FLOAT(112));
            make.width.height.mas_equalTo(ADJUST_PERCENT_FLOAT(55));
        }];
        
        [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_noDataView).mas_offset(ADJUST_PERCENT_FLOAT(15));
            make.right.mas_equalTo(_noDataView).mas_offset(ADJUST_PERCENT_FLOAT(-15));
            make.top.mas_equalTo(logoImageView.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(46.5));
            
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(tipsLabel.mas_bottom).mas_offset(ADJUST_PERCENT_FLOAT(46.5));
            make.height.mas_equalTo(ADJUST_PERCENT_FLOAT(35.f));
            make.centerX.mas_equalTo(_noDataView);
            
        }];
    }
    return _noDataView;
}

- (UITableView *)contentTableView
{
    if (!_contentTableView) {
        UITableView *tableViewTemp                      = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                                                        64,
                                                                                                        self.view.width,
                                                                                                        self.view.height - 64)
                                                                                       style:UITableViewStyleGrouped];
        tableViewTemp.separatorStyle                    = UITableViewCellSeparatorStyleNone;
        tableViewTemp.delegate                          = self;
        tableViewTemp.dataSource                        = self;
        tableViewTemp.keyboardDismissMode               = YES;
        tableViewTemp.backgroundColor                   = [UIColor themLightGrayColor];
        tableViewTemp.rowHeight                         = ADJUST_PERCENT_FLOAT(50);
        tableViewTemp.sectionHeaderHeight               = 0.1;
        tableViewTemp.sectionFooterHeight               = 0.1;
        tableViewTemp.keyboardDismissMode               = UIScrollViewKeyboardDismissModeOnDrag;
        tableViewTemp.mj_header                         = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(droupDownRefresh)];
        tableViewTemp.mj_footer                         = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpRefresh)];
        _contentTableView                               = tableViewTemp;
    }
    return _contentTableView;
}

#pragma mark - Eight.LoadData

/**
 加载网络数据

 @param curPage                 当前页
 @param pageSize                页面大小
 @param dtStartTime             开始时间
 @param dtEndTime               结束时间
 @param isRestData              是否重置数据
 */
- (void)loadDataWithCurPage:(NSInteger)curPage
                   pageSize:(NSInteger)pageSize
                dtStartTime:(NSString *)dtStartTime
                  dtEndTime:(NSString *)dtEndTime
                 isResetData:(BOOL)isResetData
{
    [[YXMyWalletRequestTool sharedTool] loadWalletExpenseListWithCurPage:curPage pageSize:pageSize dtStartTime:dtStartTime dtEndTime:dtEndTime success:^(id objc, id respodHeader) {
        
        /**
         *  判断成功失败
         */
        [respodHeader[@"status"] isEqualToString:@"1"] ? [self loadDataSuccessWithObjc:objc isResetData:isResetData] : [self loadDataFailedWithObjc:objc isResetData:isResetData];
        
    } failure:^(NSError *error) {
        
        /**
         *  判断，是否展示无数据界面
         */
        [self endRefresh];
        YXLog(@"%@", error);
    }];
}

/**
 结束刷新
 */
- (void)endRefresh
{
    [self.contentTableView.mj_header endRefreshing];
    [self.contentTableView.mj_footer endRefreshing];
}

/**
 加载数据成功

 @param objc
 */
- (void)loadDataSuccessWithObjc:(id)objc
                    isResetData:(BOOL)isResetData
{
    /**
     *  判断是上拉还是下拉
     */
    isResetData ? [self handleDroupDownRefreshWith:objc] : [self handlePullUpRefreshWithObjc:objc];
}

/**
 上拉数据处理
 */
- (void)handlePullUpRefreshWithObjc:(id)objc
{
    [self.contentTableView.mj_footer endRefreshing];
    NSMutableArray *tempArrayM              = [NSMutableArray arrayWithArray:self.dataArray];
    YXWalletPayAndIncomeModel *model        = [YXWalletPayAndIncomeModel mj_objectWithKeyValues:objc];
    [tempArrayM addObject:model];
    
    /**
     *  判断当前为时间内最后一页数据时，创建一个点击的cell拼接在数据最后，刷新界面
     */
    if (walletPayAndIncomeLoadDataCurrentPageSize * model.curPage.floatValue >= model.totalRows.floatValue) {
        
        NSMutableArray *tempDataArray = [NSMutableArray arrayWithArray:model.data];
        YXWalletPayAndIncomeDataModel *dataModel = [[YXWalletPayAndIncomeDataModel alloc] init];
        dataModel.lastCell                    = YES;
        [tempDataArray addObject:dataModel];
        model.data = tempDataArray.copy;
        
    }
    
    self.dataArray                          = tempArrayM.copy;
}

/**
 下拉数据处理
 */
- (void)handleDroupDownRefreshWith:(id)objc
{
    [self.contentTableView.mj_header endRefreshing];
    NSMutableArray *tempArrayM              = [NSMutableArray array];
    YXWalletPayAndIncomeModel *model        = [YXWalletPayAndIncomeModel mj_objectWithKeyValues:objc];
    [tempArrayM addObject:model];
    
    /**
     *  判断当前为时间内最后一页数据时，创建一个点击的cell拼接在数据最后，刷新界面
     */
    if (walletPayAndIncomeLoadDataCurrentPageSize * model.curPage.floatValue >= model.totalRows.floatValue) {
        
        NSMutableArray *tempDataArray = [NSMutableArray arrayWithArray:model.data];
        YXWalletPayAndIncomeDataModel *dataModel = [[YXWalletPayAndIncomeDataModel alloc] init];
        dataModel.lastCell                    = YES;
        [tempDataArray addObject:dataModel];
        model.data = tempDataArray.copy;
        
    }
    
    self.dataArray                          = tempArrayM.copy;
}

/**
 加载数据失败

 @param objc objc
 */
- (void)loadDataFailedWithObjc:(id)objc
                   isResetData:(BOOL)isResetData
{
    [self showTipsWithObjc:objc];
}

/**
 显示提示
 
 @param objc objc
 */
- (void)showTipsWithObjc:(id)objc
{
    if ([objc[@"errorMsg"] isKindOfClass:[NSString class]]) {
        NSString *errorTips;
        @try {
            errorTips = objc[@"errorMsg"];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        [YXAlertViewTool showAlertView:self title:@"提示" message:errorTips confrimBlock:^{
            
        }];
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
        
    }];
}

@end
