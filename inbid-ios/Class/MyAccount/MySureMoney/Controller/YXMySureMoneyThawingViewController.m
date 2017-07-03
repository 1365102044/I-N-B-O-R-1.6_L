//
//  YXMySureMoneyThawingViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySureMoneyThawingViewController.h"
#import "YXMySureMoneyThawingTableViewCell.h"

#import "YXMyAccountURLMacros.h"
#import "YXTempView.h"
#import "YXMySureMoneyNopaymentModle.h"

#import "YXAuctionBaseModel.h"
#import "YXNoMoreDataFooterView.h"
#import "YXMySureMoneyModle.h"
#import "YXMySureMoneyThawingDeatilViewController.h"

NSInteger const MYSUREMONEYDONGJIEZHONGPAGESIZE = 8;

#define kYXMyAccountMysuremoneythawingCellReuseIdentifier  @"kYXMyAccountMysuremoneythawingCellReuseIdentifier"

@interface YXMySureMoneyThawingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableview;

@property(nonatomic,assign) NSInteger  currentpage;

@property(nonatomic,strong) NSMutableArray * dongjiezhongListDataArr;

@property(nonatomic,strong) YXTempView * tempView;

//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;

//** 上拉记录当前页 */
@property (nonatomic, assign) NSInteger pullUpCurPage;
//** 全部分页数据 */
@property (nonatomic, strong) NSMutableArray *dataList;


@end

@implementation YXMySureMoneyThawingViewController

#pragma mark - 懒加载

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
        _tempView.logImageNamed = @"iconfont-dingdan";
        _tempView.tipsText = @"暂时您没有冻结中信息";
    }
    return _tempView;
}
-(NSMutableArray *)dongjiezhongListDataArr
{
    if (!_dongjiezhongListDataArr) {
        _dongjiezhongListDataArr = [NSMutableArray array];
    }
    return _dongjiezhongListDataArr;
}
-(UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _tableview.delegate = self;
        _tableview.dataSource  =self;
        _tableview.rowHeight = 110;
        _tableview.tableFooterView = [[UIView alloc]init];
    }
    
    return  _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    self.navigationItem.title = @"冻结中";
    
    [self setTableview];
    
    [self requestMydongjiezhongListdata];
    
}

-(void)setTableview
{
    [self.view addSubview:self.tableview];
    self.tableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMydongjiezhongListdata)];
    
    // 自动改变透明度
    self.tableview.mj_header.automaticallyChangeAlpha = YES;
    self.tableview.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoremydongjiezhongdataList)];
    
    [self requestMydongjiezhongListdata];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    YXMySureMoneyThawingTableViewCell *cell = [YXMySureMoneyThawingTableViewCell creatMySureMoneyThawingTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.FromVCtype = self.navigationItem.title;
    cell.modle = self.dataList[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YXMySureMoneyNopaymentModle *modle =self.dataList[indexPath.row];
    
    YXMySureMoneyThawingDeatilViewController*refundsuremoney = [[YXMySureMoneyThawingDeatilViewController alloc]init];
    refundsuremoney.marginId = [NSString stringWithFormat:@"%lld",modle.NopaymentId];
    refundsuremoney.isPartPay = modle.isPartPay;
    [self.navigationController pushViewController:refundsuremoney animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  ******************* 网络请求**********************

-(void)requestMydongjiezhongListdata
{
    NSInteger curPage;
    if (self.dongjiezhongListDataArr.count) {
        
        curPage= [self.dongjiezhongListDataArr.firstObject curPage] - 1 == 0 ? 1 : [self.dongjiezhongListDataArr.firstObject curPage] - 1;
    }else{
        curPage = 1;
    }
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(curPage);
    parm[@"pageSize"] = @(MYSUREMONEYDONGJIEZHONGPAGESIZE);
    
    [YXRequestTool requestDataWithType:POST url:MYSUREMONEYDONGJIEZHONG_URL params:parm success:^(id objc, id respodHeader) {
    
        
            
            NSArray *dataArray = objc[@"data"];
            self.dataList = [YXMySureMoneyNopaymentModle mj_objectArrayWithKeyValuesArray:dataArray];
            
            [self.dataList removeAllObjects];
            [self.dongjiezhongListDataArr removeAllObjects];
            
            YXMySureMoneyModle *objcModel = [YXMySureMoneyModle mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.dataList addObjectsFromArray: objcModel.dataList];
            [self.dongjiezhongListDataArr addObject:objcModel];
        
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
-(void)loadMoremydongjiezhongdataList
{
    
    [self.tableview.mj_header endRefreshing];
    [self.noMoreDataFooterView removeFromSuperview];
    
    self.pullUpCurPage = [[self.dongjiezhongListDataArr lastObject] curPage] + 1;
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(self.pullUpCurPage);
    parm[@"pageSize"] = @(MYSUREMONEYDONGJIEZHONGPAGESIZE);
    
    [YXRequestTool requestDataWithType:POST url:MYSUREMONEYDONGJIEZHONG_URL params:parm success:^(id objc, id respodHeader) {
        
        YXMySureMoneyModle *objcModel = [YXMySureMoneyModle mj_objectWithKeyValues:objc];
        
        if (![self checkFooterStateWithObjc:objcModel]) {
            [self.dataList addObjectsFromArray:objcModel.dataList];
            [self.dongjiezhongListDataArr addObject:objcModel];
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
    if (objcModel.totalRows % MYSUREMONEYDONGJIEZHONGPAGESIZE == 0 || objcModel.totalRows < MYSUREMONEYDONGJIEZHONGPAGESIZE) {
        if (objcModel.totalRows / MYSUREMONEYDONGJIEZHONGPAGESIZE == objcModel.curPage || objcModel.totalRows < MYSUREMONEYDONGJIEZHONGPAGESIZE) {
            
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.tableview.mj_footer.bounds;
            [self.tableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            
            if (self.pullUpCurPage == objcModel.curPage) {
                YXMySureMoneyModle *model = (YXMySureMoneyModle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.dongjiezhongListDataArr addObject:objcModel];
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
        if ((objcModel.totalRows - objcModel.totalRows % MYSUREMONEYDONGJIEZHONGPAGESIZE) / MYSUREMONEYDONGJIEZHONGPAGESIZE + 1 == objcModel.curPage) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.tableview.mj_footer.bounds;
            [self.tableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            if (self.pullUpCurPage == objcModel.curPage) {
                
                YXMySureMoneyModle *model = (YXMySureMoneyModle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.dongjiezhongListDataArr addObject:objcModel];
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
    
    if (objcModel.totalRows < MYSUREMONEYDONGJIEZHONGPAGESIZE) {
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
