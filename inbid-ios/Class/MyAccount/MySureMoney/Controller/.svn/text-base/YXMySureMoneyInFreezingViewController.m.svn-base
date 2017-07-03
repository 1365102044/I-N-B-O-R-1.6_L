//
//  YXMySureMoneyInFreezingViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMySureMoneyInFreezingViewController.h"
#import "YXMySureMoneyThawingTableViewCell.h"

#import "YXMyAccountURLMacros.h"
#import "YXTempView.h"
#import "YXMySureMoneyNopaymentModle.h"
#import "YXHomeAuctionDeatilViewCotroller.h"


#import "YXAuctionBaseModel.h"
#import "YXNoMoreDataFooterView.h"
#import "YXMySureMoneyModle.h"
#import "YXRefundMySureMoneyViewController.h"
#import "YXMySureMoneyThawingDeatilViewController.h"

#define kYXMyAccountMyOrderCellReuseIdentifier  @"kYXMyAccountMyOrderCellReuseIdentifier"

NSInteger const MYSUREMONEYALEARLYJIEDONGPAGESIZE = 8;


@interface YXMySureMoneyInFreezingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableview;


@property(nonatomic,assign) NSInteger  currentpage;
@property(nonatomic,strong) YXTempView * tempView;

@property(nonatomic,strong) NSMutableArray * alearlyjiedongListDataArr;


//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;

//** 上拉记录当前页 */
@property (nonatomic, assign) NSInteger pullUpCurPage;
//** 全部分页数据 */
@property (nonatomic, strong) NSMutableArray *dataList;


@end

@implementation YXMySureMoneyInFreezingViewController

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
        _tempView.tipsText = @"暂时您没有已解冻信息";
    }
    return _tempView;
}
-(NSMutableArray *)alearlyjiedongListDataArr
{
    if (!_alearlyjiedongListDataArr) {
        _alearlyjiedongListDataArr = [NSMutableArray array];
    }
    return _alearlyjiedongListDataArr;
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
    

    
    self.currentpage = 1;
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    self.navigationItem.title = @"已解冻";
    
    [self setTableview];
    
}

-(void)setTableview
{
    [self.view addSubview:self.tableview];
    self.tableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestMYalerlyjiedongListdata)];
    // 自动改变透明度
    self.tableview.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableview.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMYalerlyjiedongdataList)];
    
    [self requestMYalerlyjiedongListdata];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXMySureMoneyThawingTableViewCell *cell = [YXMySureMoneyThawingTableViewCell creatMySureMoneyThawingTableViewCell];
    cell.pushBlock=^(NSInteger proBidId,NSInteger proId){
        
        [self requestDeatilCheckIFxiajia:proBidId proId:proId];
        
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.FromVCtype = self.navigationItem.title;
    cell.modle = self.dataList[indexPath.row];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YXMySureMoneyNopaymentModle *modle =self.dataList[indexPath.row];
    if(modle.marginStatus == 6 || modle.marginStatus ==5)
    {
        YXMySureMoneyThawingDeatilViewController *vc =[[YXMySureMoneyThawingDeatilViewController alloc]init];
        vc.marginStatus = modle.marginStatus;
        vc.marginId = [NSString stringWithFormat:@"%lld",modle.NopaymentId];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        YXRefundMySureMoneyViewController*refundsuremoney = [[YXRefundMySureMoneyViewController alloc]init];
        refundsuremoney.marginId = [NSString stringWithFormat:@"%lld",modle.NopaymentId];
        [self.navigationController pushViewController:refundsuremoney animated:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  ******************* 网络请求**********************

-(void)requestMYalerlyjiedongListdata
{
    NSInteger curPage;
    if (self.alearlyjiedongListDataArr.count) {
        
        curPage= [self.alearlyjiedongListDataArr.firstObject curPage] - 1 == 0 ? 1 : [self.alearlyjiedongListDataArr.firstObject curPage] - 1;
    }else{
        curPage = 1;
    }
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(curPage);
    parm[@"pageSize"] = @(MYSUREMONEYALEARLYJIEDONGPAGESIZE);
    
    [YXRequestTool requestDataWithType:POST url:MYSUREMONEYALEARLYJIEDONG_URL params:parm success:^(id objc, id respodHeader) {
        
            NSArray *dataArray = objc[@"data"];
            self.dataList = [YXMySureMoneyNopaymentModle mj_objectArrayWithKeyValuesArray:dataArray];
            
            [self.dataList removeAllObjects];
            [self.alearlyjiedongListDataArr removeAllObjects];
            
            YXMySureMoneyModle *objcModel = [YXMySureMoneyModle mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.dataList addObjectsFromArray: objcModel.dataList];
            [self.alearlyjiedongListDataArr addObject:objcModel];
        
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
-(void)loadMoreMYalerlyjiedongdataList
{
    
    [self.tableview.mj_header endRefreshing];
    [self.noMoreDataFooterView removeFromSuperview];
    
    self.pullUpCurPage = [[self.alearlyjiedongListDataArr lastObject] curPage] + 1;
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(self.pullUpCurPage);
    parm[@"pageSize"] = @(MYSUREMONEYALEARLYJIEDONGPAGESIZE);
    
    [YXRequestTool requestDataWithType:POST url:MYSUREMONEYALEARLYJIEDONG_URL params:parm success:^(id objc, id respodHeader) {
        
        YXMySureMoneyModle *objcModel = [YXMySureMoneyModle mj_objectWithKeyValues:objc];
        
        if (![self checkFooterStateWithObjc:objcModel]) {
            [self.dataList addObjectsFromArray:objcModel.dataList];
            [self.alearlyjiedongListDataArr addObject:objcModel];
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
    if (objcModel.totalRows % MYSUREMONEYALEARLYJIEDONGPAGESIZE == 0 || objcModel.totalRows < MYSUREMONEYALEARLYJIEDONGPAGESIZE) {
        if (objcModel.totalRows / MYSUREMONEYALEARLYJIEDONGPAGESIZE == objcModel.curPage || objcModel.totalRows < MYSUREMONEYALEARLYJIEDONGPAGESIZE) {
            
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.tableview.mj_footer.bounds;
            [self.tableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            
            if (self.pullUpCurPage == objcModel.curPage) {
                YXMySureMoneyModle *model = (YXMySureMoneyModle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.alearlyjiedongListDataArr addObject:objcModel];
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
        if ((objcModel.totalRows - objcModel.totalRows % MYSUREMONEYALEARLYJIEDONGPAGESIZE) / MYSUREMONEYALEARLYJIEDONGPAGESIZE + 1 == objcModel.curPage) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.tableview.mj_footer.bounds;
            [self.tableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            if (self.pullUpCurPage == objcModel.curPage) {
                
                YXMySureMoneyModle *model = (YXMySureMoneyModle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.alearlyjiedongListDataArr addObject:objcModel];
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
    
    if (objcModel.totalRows < MYSUREMONEYALEARLYJIEDONGPAGESIZE) {
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


-(void)requestDeatilCheckIFxiajia:(long long  )proBidId proId:(long long)proId
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"prodBidId"] = @(proBidId);
    para[@"prodId"] = @(proId);
    [YXRequestTool requestDataWithType:POST url:@"/api/prodView" params:para success:^(id objc, id respodHeader) {

        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            long endTime =  [objc[@"endTime"] doubleValue];
            long nowtime = [[YXStringFilterTool getTimeNow] doubleValue];
            
            if (endTime > nowtime) {
                
                YXHomeAuctionDeatilViewCotroller *deatilevc = [[YXHomeAuctionDeatilViewCotroller alloc]init];
    
                deatilevc.prodId = proId;
                deatilevc.ProBidId = proBidId;
                [self.navigationController pushViewController:deatilevc animated:YES];
            }else{
                
                
            }
        }
        
        
    } failure:^(NSError *error) {


    }];

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
