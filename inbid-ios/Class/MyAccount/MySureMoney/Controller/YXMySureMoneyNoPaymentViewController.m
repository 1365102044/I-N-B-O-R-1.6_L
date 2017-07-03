//
//  YXMySureMoneyNoPaymentViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySureMoneyNoPaymentViewController.h"
#import "YXYXMySureMoneyNoPaymentTableViewCell.h"
#import "YXMyAccountURLMacros.h"
#import "YXMySureMoneyNopaymentModle.h"
#import "YXTempView.h"
#import "YXAuctionBaseModel.h"
#import "YXNoMoreDataFooterView.h"
#import "YXMySureMoneyModle.h"
#import "YXMySureMoneyNopayMentDeatilViewController.h"
#import "YXPaymentHomePageController.h"
//#import "YXInbornTickByTickPayView.h"
#import "YXPaymentHomepageViewDataModel.h"
#import "YXWebPagePayViewController.h"
NSInteger const MYSUREMONEYPAGESIZE = 8;

@interface YXMySureMoneyNoPaymentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,assign) NSInteger  currentpage;

@property(nonatomic,strong) NSMutableArray * NoPaymentListDataArr;


@property(nonatomic,strong) YXTempView * tempView;

//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;

//** 上拉记录当前页 */
@property (nonatomic, assign) NSInteger pullUpCurPage;
//** 全部分页数据 */
@property (nonatomic, strong) NSMutableArray *dataList;

/*
 @brief requestDataModle
 */
@property(nonatomic,strong) YXPaymentHomepageViewDataModel * RequestDataModle;

@end



@implementation YXMySureMoneyNoPaymentViewController
- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
        _tempView.logImageNamed = @"iconfont-dingdan";
        _tempView.tipsText = @"暂时您没有未付款信息";
        
    }
    return _tempView;
}
-(NSMutableArray *)NoPaymentListDataArr
{
    if (!_NoPaymentListDataArr) {
        _NoPaymentListDataArr = [NSMutableArray array];
    }
    return _NoPaymentListDataArr;
}
-(UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _tableview.delegate = self;
        _tableview.dataSource  =self;
        _tableview.rowHeight = 125;
        _tableview.tableFooterView = [[UIView alloc]init];
    }
    
    return  _tableview;
}




-(void)viewWillAppear:(BOOL)animated
{
    [super  viewWillAppear:animated];
    self.currentpage = 1;
    [self.view addSubview:self.tableview];

    [self requestMynopaymentListdata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    self.navigationItem.title = @"未付款";
    
    
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMynopaymentListdata)];
    
    //上下拉加载数据
    // 自动改变透明度
    self.tableview.mj_header.automaticallyChangeAlpha = YES;
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMynopaymentList)];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXYXMySureMoneyNoPaymentTableViewCell *cell = [YXYXMySureMoneyNoPaymentTableViewCell creatMySureMoneyNoPaymentTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.NopayMentModle = self.dataList[indexPath.row];
    __weak typeof(self)weakslef = self;
    cell.clickblock = ^(NSInteger status,long long cellid ,NSInteger marginPrice,NSInteger alearlyprice,NSString *prodName){
        if (status == 1) {
            /*
             @brief 2 未支付过  1 支付过
             */
            
            [weakslef GoToPayVc:cellid payType:2 name:prodName marginprice:marginPrice alearlyprice:alearlyprice];
        }else if (status ==2)
        {
            
            [weakslef GoToPayVc:cellid payType:1 name:prodName marginprice:marginPrice alearlyprice:alearlyprice];
        }
    };
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YXMySureMoneyNopaymentModle *modle =self.dataList[indexPath.row];
    
    YXMySureMoneyNopayMentDeatilViewController*refundsuremoney = [[YXMySureMoneyNopayMentDeatilViewController alloc]init];
    refundsuremoney.marginId = [NSString stringWithFormat:@"%lld",(long long)modle.NopaymentId];
    [self.navigationController pushViewController:refundsuremoney animated:YES];
    
}

-(void)GoToPayVc:(long long )cellId payType:(NSInteger)type name:(NSString *)proname marginprice:(NSInteger)marginPrice alearlyprice:(NSInteger)alearlyprice
{

//    1 支付过  2 未支付过
    if (type==1) {

         [self PushScanVC:cellId];
        
    }else if (type== 2)
    {
        YXPaymentHomePageController *paymentController = [YXPaymentHomePageController loadPaymentControllerWithProdId:cellId andType:YXPaymentHomePageControllerBond];
        [self.navigationController pushViewController:paymentController animated:YES];
    }
    
}

#pragma mark  ******************* 网络请求**********************
/**
 继续支付 跳转扫码支付
 */
-(void)PushScanVC:(long long )cellID
{

    [[YXPayMentNetRequestTool sharedTool] loadPayMentHomePageDataWithOrderId:cellID andPaymentType:3 success:^(id objc, id respodHeader) {
        YXLog(@"---zhifus----%@",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.RequestDataModle = [YXPaymentHomepageViewDataModel mj_objectWithKeyValues:objc];
            self.RequestDataModle.transType = 3;
            //** 跳转相应的控制器 */
            YXWebPagePayViewController *controller = [[YXWebPagePayViewController alloc]init];
            controller.dataModel = self.RequestDataModle;
            [self.navigationController pushViewController:controller animated:YES];
            
        }
    } failure:^(NSError *error) {
        YXLog(@"---error--%@",error);
    }];
}
-(void)requestMynopaymentListdata
{
    NSInteger curPage;
    if (self.NoPaymentListDataArr.count) {
        
        curPage= [self.NoPaymentListDataArr.firstObject curPage] - 1 == 0 ? 1 : [self.NoPaymentListDataArr.firstObject curPage] - 1;
    }else{
        curPage = 1;
    }
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(curPage);
    parm[@"pageSize"] = @(MYSUREMONEYPAGESIZE);
    
    [YXRequestTool requestDataWithType:POST url:MYSUREMONEYNOPAYMENT_URL params:parm success:^(id objc, id respodHeader) {
        
        YXLog(@"%@",objc);
        
            NSArray *dataArray = objc[@"data"];
            self.dataList = [YXMySureMoneyNopaymentModle mj_objectArrayWithKeyValuesArray:dataArray];
            
            [self.dataList removeAllObjects];
            [self.NoPaymentListDataArr removeAllObjects];
            
            YXMySureMoneyModle *objcModel = [YXMySureMoneyModle mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.dataList addObjectsFromArray: objcModel.dataList];
            [self.NoPaymentListDataArr addObject:objcModel];
            
        if(!self.dataList.count)
        {
            [self.view addSubview:self.tempView];
            
        }else{
            
            [self.tempView removeFromSuperview];
        }
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
        

    } failure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];
    
    
}
/*
 @brief 加载更多
 */
-(void)loadMoreMynopaymentList
{
    
    [self.tableview.mj_header endRefreshing];
    [self.noMoreDataFooterView removeFromSuperview];
    
    self.pullUpCurPage = [[self.NoPaymentListDataArr lastObject] curPage] + 1;
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(self.pullUpCurPage);
    parm[@"pageSize"] = @(MYSUREMONEYPAGESIZE);
    
    [YXRequestTool requestDataWithType:POST url:MYSUREMONEYNOPAYMENT_URL params:parm success:^(id objc, id respodHeader) {
        
        YXMySureMoneyModle *objcModel = [YXMySureMoneyModle mj_objectWithKeyValues:objc];
        
        if (![self checkFooterStateWithObjc:objcModel]) {
            [self.dataList addObjectsFromArray:objcModel.dataList];
            [self.NoPaymentListDataArr addObject:objcModel];
        }
        self.pullUpCurPage = objcModel.curPage;
        [self.tableview reloadData];
        
        [self.tableview.mj_footer endRefreshing];
    } failure:^(NSError *error) {
       [self.tableview.mj_footer endRefreshing]; 
    }];
}

/**
 * 时刻监测footer的状态
 */
- (BOOL)checkFooterStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    //当总数等于当前页面
    if (objcModel.totalRows % MYSUREMONEYPAGESIZE == 0 || objcModel.totalRows < MYSUREMONEYPAGESIZE) {
        if (objcModel.totalRows / MYSUREMONEYPAGESIZE == objcModel.curPage || objcModel.totalRows < MYSUREMONEYPAGESIZE) {
            
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.tableview.mj_footer.bounds;
            [self.tableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            

              if (self.pullUpCurPage == objcModel.curPage) {
                  YXMySureMoneyModle *model = (YXMySureMoneyModle *)objcModel;
                  [self.dataList addObjectsFromArray:[model dataList]];
                  [self.NoPaymentListDataArr addObject:objcModel];
              }
            [self.tableview.mj_footer endRefreshing];
            return YES;
        }else{
            [self.tableview.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }else{
        if ((objcModel.totalRows - objcModel.totalRows % MYSUREMONEYPAGESIZE) / MYSUREMONEYPAGESIZE + 1 == objcModel.curPage) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.tableview.mj_footer.bounds;
            [self.tableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            if (self.pullUpCurPage == objcModel.curPage) {
                
                    YXMySureMoneyModle *model = (YXMySureMoneyModle *)objcModel;
                    [self.dataList addObjectsFromArray:[model dataList]];
                    [self.NoPaymentListDataArr addObject:objcModel];
            }
            [self.tableview.mj_footer endRefreshing];
            return YES;
        }else{
            [self.tableview.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }
}

//** 下拉检测footerView */
- (void)whenDroupDownCheckFooterViewStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    
    if (objcModel.totalRows < MYSUREMONEYPAGESIZE) {
        YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
        noMoreDataFooterView.frame = self.tableview.mj_footer.bounds;
        [self.tableview.mj_footer addSubview:noMoreDataFooterView];
        noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
        _noMoreDataFooterView = noMoreDataFooterView;
    }else{
        [self.tableview.mj_footer endRefreshing];
        [self.noMoreDataFooterView removeFromSuperview];
        self.noMoreDataFooterView = nil;
    }
}


#pragma mark - 懒加载

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //按照作者最后的意思还要加上下面这一段
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
        
    }
}

@end
