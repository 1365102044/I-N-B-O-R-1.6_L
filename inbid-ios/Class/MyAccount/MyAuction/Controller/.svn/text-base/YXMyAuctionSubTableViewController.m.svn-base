//
//  YXMyAuctionSubTableViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAuctionSubTableViewController.h"
#import "YXMyAuctionBaseCell.h"
#import "YXFollowAuctionCell.h"
#import "YXIsBiddingCell.h"
#import "UIView+YXExtension.h"
#import "YXMyAuctionPostBondsView.h"
#import "YXMyAccountFollowAuction.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXMyAccountFollowAuction.h"
#import "YXMyAccountQueryProdBidList.h"
#import "YXMyAccountQueryProdOverList.h"
#import "YXMyAccountFollowAuctionList.h"
#import "YXEndBiddingCell.h"
#import "YXAuctionBaseModel.h"
#import "YXMyAuctionQueryProdBidModel.h"
#import "YXMyAuctionFollowAuctionModel.h"
#import "YXMyAuctionQueryProdBidModel.h"
#import "YXQueryProdOverModel.h"
#import "YXNoMoreDataFooterView.h"
#import "YXMyQuerProdBidListCountTime.h"
#import "YXHomeAuctionDeatilViewCotroller.h"
#import "YXOneMouthPriceDeatilViewController.h"
#import <Masonry.h>
#import <MJExtension.h>

#pragma mark - 重用标志

static NSString *const kYXMyAuctionFollowAuctionCellReuseIdentifier = @"kYXMyAuctionFollowAuctionCellReuseIdentifier";
static NSString *const kYXMyAuctionIsBiddingCellReuseIdentifer = @"kYXMyAuctionIsBiddingCellReuseIdentifer";
static NSString *const kYXMyAuctionEndBiddingCellReuseIdentifer = @"kYXMyAuctionEndBiddingCellReuseIdentifer";



NSInteger const kYXMyAuctionSubTableViewPageSize = 8;




@interface YXMyAuctionSubTableViewController ()<YXMyAuctionBaseCellDelegate>

//** 全部分页数据 */
@property (nonatomic, strong) NSMutableArray *dataList;
//** 全部数据 */
@property (nonatomic, strong) NSMutableArray *allAuctionDataListArray;
//** 公用重用标志 */
@property (nonatomic, copy) NSString *myAuctionReuseIdentifier;
//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;
//** 上拉记录当前页 */
@property (nonatomic, assign) NSInteger pullUpCurPage;
//** 倒计时定时器 */
@property (nonatomic, strong) NSTimer *countDownTimer;
//** 所有商品结束时间数据 */
@property (nonatomic, strong) NSMutableArray *allGoodEndTimeArray;
/**
 用户离开记录的当前页
 */
@property (nonatomic, assign) NSInteger userDisspaerCurPage;

@end

@implementation YXMyAuctionSubTableViewController


#pragma mark - 赋值

- (void)setIsDisappear:(BOOL)isDisappear
{
    _isDisappear = isDisappear;
    
    //** 不刷新 */
//    if (isDisappear) {
//        if (self.userDisspaerCurPage != 0) {
//            [self loadDataWithUserDisppaerPage];
//        }
//    }else{
//        
//        
////        //** 获取当前页码 */
//        NSIndexPath *currentIndexPath = [self.tableView indexPathsForVisibleRows].lastObject;
//        
//        //** 获取当前页码 */
//        YXLog(@"%zd", [self.dataList[currentIndexPath.row] currentPage]);
//        self.userDisspaerCurPage = [self.dataList[currentIndexPath.row] currentPage];
//    }
}

/**
 给loadNewData赋值
 
 @param loadNewData loadNewData
 */
- (void)setLoadNewData:(BOOL)loadNewData
{
    if (loadNewData) {
        [self loadNewAuctionData];
    }
}


#pragma mark - 点击事件

//** 接收到cell通知， 添加定时器 */
- (void)creatTimer
{
     [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
}

//** 定时器触发事件， 向cell发送通知, 启动倒计时 */
- (void)timerEvent
{
    for (int i = 0; i < self.allGoodEndTimeArray.count; i++) {
        
        YXMyQuerProdBidListCountTime *model = self.allGoodEndTimeArray[i];
        [model countDown];
    }
    
    //** 通知cell倒计时 */
    [[NSNotificationCenter defaultCenter] postNotificationName:kYXMyAuctionControllerCountDownTimerNotification object:nil userInfo:nil];
}

#pragma mark --YXMyAuctionBaseCellDelegate
//** 点击提交保证金或参与竞拍 */
- (void)myAuctionBaseCell:(YXMyAuctionBaseCell *)myAuctionBaseCell partInAuction:(UIButton *)button withProBidId:(long long)proBidId withProId:(long long)proId 
{
    NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:myAuctionBaseCell];
    self.userDisspaerCurPage = [self.dataList[currentIndexPath.row] currentPage];
    
    YXMyAccountFollowAuctionList *followAuctionList = self.dataList[currentIndexPath.row];
    
    if (followAuctionList.bidType == 1) {
        //** 寄拍 */
        YXHomeAuctionDeatilViewCotroller *deatilViewController = [[YXHomeAuctionDeatilViewCotroller alloc] init];
        deatilViewController.prodId = proId;
        deatilViewController.ProBidId = proBidId;
        [self.navigationController pushViewController:deatilViewController animated:YES];
    }else if (followAuctionList.bidType == 2) {
        //** 一口价 */
        YXOneMouthPriceDeatilViewController *fixDetialViewController = [[YXOneMouthPriceDeatilViewController alloc] init];
        fixDetialViewController.prodId = [NSString stringWithFormat:@"%lld", followAuctionList.prodId];
        fixDetialViewController.prodBidId = [NSString stringWithFormat:@"%lld", followAuctionList.prodBidId];
        [self.navigationController pushViewController:fixDetialViewController animated:YES];
    }

}

#pragma mark --YXMyAuctionPostBondsViewDelegate

#pragma mark - 数据加载

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

//** 加载新数据 */
- (void)loadNewAuctionData
{
    NSInteger curPage = [self.allAuctionDataListArray.firstObject curPage] - 1 == 0 ? 1 : [self.allAuctionDataListArray.firstObject curPage] - 1;
    
    if ([self.title isEqualToString:@"我的关注"]) {
        
        [[YXMyAccountNetRequestTool sharedTool] loadMyQueryMenberCollectionList:curPage withPageSize:kYXMyAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            if (objc) {
                NSArray *dataArray = objc[@"data"];
                self.dataList = [YXMyAccountFollowAuctionList mj_objectArrayWithKeyValuesArray:dataArray];
                
                [self.dataList removeAllObjects];
                [self.allAuctionDataListArray removeAllObjects];
                
                YXMyAuctionFollowAuctionModel *objcModel = [YXMyAuctionFollowAuctionModel mj_objectWithKeyValues:objc];
                [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
                
                [self.dataList addObjectsFromArray: objcModel.dataList];
                [self.allAuctionDataListArray addObject:objcModel];
                
                [self checkTempViewIsHidden:self.dataList];
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                
                //** 通知空视图刷新完毕 */
                [[NSNotificationCenter defaultCenter] postNotificationName:@"myAuctionEndRefresh" object:nil userInfo:nil];
            }
            
        } failure:^(NSError *error) {
            [self checkTempViewIsHidden:self.dataList];
            [self.tableView.mj_header endRefreshing];
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myAuctionEndRefresh" object:nil userInfo:nil];
        }];
        //关注拍品
        self.myAuctionReuseIdentifier = kYXMyAuctionFollowAuctionCellReuseIdentifier;
        
    }else if ([self.title isEqualToString:@"正在竞拍"]){
        
        [[YXMyAccountNetRequestTool sharedTool] loadMyQueryPiddingByMemberId:curPage withPageSize:kYXMyAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            [self.dataList removeAllObjects];
            [self.allGoodEndTimeArray removeAllObjects];
            [self.allAuctionDataListArray removeAllObjects];
            
            YXMyAuctionQueryProdBidModel *objcModel = [YXMyAuctionQueryProdBidModel mj_objectWithKeyValues:objc];

            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.dataList addObjectsFromArray: objcModel.dataList];
            [self.allAuctionDataListArray addObject:objcModel];
            
            [self checkTempViewIsHidden:self.dataList];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myAuctionEndRefresh" object:nil userInfo:nil];
            
//            for (YXMyAccountQueryProdBidList *model in objcModel.dataList) {
//                [self.allGoodEndTimeArray addObject: [YXMyQuerProdBidListCountTime timeModelWithTitle:[NSString stringWithFormat:@"%zd", model.bidId] time:(int)model.surplusBidTime]];
//            }
            
        } failure:^(NSError *error) {
            [self checkTempViewIsHidden:self.dataList];
            [self.tableView.mj_header endRefreshing];
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myAuctionEndRefresh" object:nil userInfo:nil];
        }];
        //正在竞拍
        self.myAuctionReuseIdentifier = kYXMyAuctionIsBiddingCellReuseIdentifer;
        
    }else if ([self.title isEqualToString:@"结束竞拍"]){
        //TUDO：
        [[YXMyAccountNetRequestTool sharedTool] loadMyQueryPidOverByMemberId:curPage withPageSize:kYXMyAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            [self.dataList removeAllObjects];
            [self.allAuctionDataListArray removeAllObjects];
            
            YXQueryProdOverModel *objcModel = [YXQueryProdOverModel mj_objectWithKeyValues:objc];
            
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.dataList addObjectsFromArray: objcModel.dataList];
            [self.allAuctionDataListArray addObject:objcModel];
            
            [self checkTempViewIsHidden:self.dataList];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myAuctionEndRefresh" object:nil userInfo:nil];
            
        } failure:^(NSError *error) {
            [self checkTempViewIsHidden:self.dataList];
            [self.tableView.mj_header endRefreshing];
            //** 通知空视图刷新完毕 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myAuctionEndRefresh" object:nil userInfo:nil];
        }];
        
        self.myAuctionReuseIdentifier = kYXMyAuctionEndBiddingCellReuseIdentifer;
    }
}

//** 加载旧数据 */
- (void)loadMoreAuctionData
{
    [self.tableView.mj_header endRefreshing];
    [self.noMoreDataFooterView removeFromSuperview];
    
    self.pullUpCurPage = [[self.allAuctionDataListArray lastObject] curPage] + 1;
    
    if ([self.title isEqualToString:@"我的关注"]) {
        [[YXMyAccountNetRequestTool sharedTool] loadMyQueryMenberCollectionList:self.pullUpCurPage withPageSize:kYXMyAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            YXMyAuctionFollowAuctionModel *objcModel = [YXMyAuctionFollowAuctionModel mj_objectWithKeyValues:objc];
           
            //判断，当当前页数为最后一页时，关闭刷新
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.dataList addObjectsFromArray:objcModel.dataList];
                [self.allAuctionDataListArray addObject:objcModel];
            }
            self.pullUpCurPage = objcModel.curPage;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        }];
        //关注拍品
        self.myAuctionReuseIdentifier = kYXMyAuctionFollowAuctionCellReuseIdentifier;
        
    }else if ([self.title isEqualToString:@"正在竞拍"]){
        [[YXMyAccountNetRequestTool sharedTool] loadMyQueryPiddingByMemberId:self.pullUpCurPage withPageSize:kYXMyAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            YXMyAuctionQueryProdBidModel *objcModel = [YXMyAuctionQueryProdBidModel mj_objectWithKeyValues:objc];
            
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.dataList addObjectsFromArray:objcModel.dataList];
                [self.allAuctionDataListArray addObject:objcModel];
            }
            
            self.pullUpCurPage = objcModel.curPage;
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            
//            for (YXMyAccountQueryProdBidList *model in objcModel.dataList) {
//                [self.allGoodEndTimeArray addObject: [YXMyQuerProdBidListCountTime timeModelWithTitle:[NSString stringWithFormat:@"%zd", model.bidId] time:(int)model.surplusBidTime]];
//            }
            
        } failure:^(NSError *error) {
            
        }];
        //正在竞拍
        self.myAuctionReuseIdentifier = kYXMyAuctionIsBiddingCellReuseIdentifer;
        
    }else if ([self.title isEqualToString:@"结束竞拍"]){
        //TUDO：
        [[YXMyAccountNetRequestTool sharedTool] loadMyQueryPidOverByMemberId:self.pullUpCurPage withPageSize:kYXMyAuctionSubTableViewPageSize success:^(id objc, id respodHeader) {
            
            YXQueryProdOverModel *objcModel = [YXQueryProdOverModel mj_objectWithKeyValues:objc];
            
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.dataList addObjectsFromArray:objcModel.dataList];
                [self.allAuctionDataListArray addObject:objcModel];
            }
            self.pullUpCurPage = objcModel.curPage;
            [self.tableView reloadData];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
        } failure:^(NSError *error) {
            
        }];
        
        self.myAuctionReuseIdentifier = kYXMyAuctionEndBiddingCellReuseIdentifer;
    }
}

/**
 检测是否有数据，是否显示无数据界面
 */
- (void)checkTempViewIsHidden:(NSArray *)array
{
    if (array.count != 0) {
        if ([self.delegate respondsToSelector:@selector(myAuctionSubTableViewController:hiddenTempView:title:)]) {
            [self.delegate myAuctionSubTableViewController:self hiddenTempView:YES title:self.title];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(myAuctionSubTableViewController:hiddenTempView:title:)]) {
            [self.delegate myAuctionSubTableViewController:self hiddenTempView:NO title:self.title];
        }
    }
}

/**
 * 时刻监测footer的状态
 */
- (BOOL)checkFooterStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    //当总数等于当前页面
    if (objcModel.totalRows % kYXMyAuctionSubTableViewPageSize == 0 || objcModel.totalRows < kYXMyAuctionSubTableViewPageSize) {
        if (objcModel.totalRows / kYXMyAuctionSubTableViewPageSize == objcModel.curPage || objcModel.totalRows < kYXMyAuctionSubTableViewPageSize) {
            
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
            [self.tableView.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            if (self.pullUpCurPage == objcModel.curPage) {
                
                if ([objcModel isKindOfClass:[YXMyAuctionFollowAuctionModel class]]) {
                    YXMyAuctionFollowAuctionModel *model = (YXMyAuctionFollowAuctionModel *)objcModel;
                    [self.dataList addObjectsFromArray:[model dataList]];
                    [self.allAuctionDataListArray addObject:objcModel];
                }else if ([objcModel isKindOfClass:[YXMyAuctionQueryProdBidModel class]]) {
                    YXMyAuctionQueryProdBidModel *model = (YXMyAuctionQueryProdBidModel *)objcModel;
                    [self.dataList addObjectsFromArray:[model dataList]];
                    [self.allAuctionDataListArray addObject:objcModel];
                }else if ([objcModel isKindOfClass:[YXQueryProdOverModel class]]) {
                    YXQueryProdOverModel *model = (YXQueryProdOverModel *)objcModel;
                    [self.dataList addObjectsFromArray:[model dataList]];
                    [self.allAuctionDataListArray addObject:objcModel];
                }
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
        if ((objcModel.totalRows - objcModel.totalRows % kYXMyAuctionSubTableViewPageSize) / kYXMyAuctionSubTableViewPageSize + 1 == objcModel.curPage) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.tableView.mj_footer.bounds;
            [self.tableView.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            if (self.pullUpCurPage == objcModel.curPage) {
                if ([objcModel isKindOfClass:[YXMyAuctionFollowAuctionModel class]]) {
                    YXMyAuctionFollowAuctionModel *model = (YXMyAuctionFollowAuctionModel *)objcModel;
                    [self.dataList addObjectsFromArray:[model dataList]];
                    [self.allAuctionDataListArray addObject:objcModel];
                }else if ([objcModel isKindOfClass:[YXMyAuctionQueryProdBidModel class]]) {
                    YXMyAuctionQueryProdBidModel *model = (YXMyAuctionQueryProdBidModel *)objcModel;
                    [self.dataList addObjectsFromArray:[model dataList]];
                    [self.allAuctionDataListArray addObject:objcModel];
                }else if ([objcModel isKindOfClass:[YXQueryProdOverModel class]]) {
                    YXQueryProdOverModel *model = (YXQueryProdOverModel *)objcModel;
                    [self.dataList addObjectsFromArray:[model dataList]];
                    [self.allAuctionDataListArray addObject:objcModel];
                }
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
}

//** 下拉检测footerView */
- (void)whenDroupDownCheckFooterViewStateWithObjc:(id)objcModel
{
    
    if ([self.title isEqualToString:@"我的关注"]) {
        YXMyAuctionFollowAuctionModel *model = (YXMyAuctionFollowAuctionModel *)objcModel;
        if (model.totalRows < kYXMyAuctionSubTableViewPageSize) {
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
    }else if ([self.title isEqualToString:@"正在竞拍"]){
        YXMyAuctionQueryProdBidModel *model = (YXMyAuctionQueryProdBidModel *)objcModel;
        if (model.totalRows < kYXMyAuctionSubTableViewPageSize) {
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
    }else if ([self.title isEqualToString:@"结束竞拍"]){
        YXQueryProdOverModel *model = (YXQueryProdOverModel *)objcModel;
        if (model.totalRows < kYXMyAuctionSubTableViewPageSize) {
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

//** 判断当前是否需要隐藏视图 */
- (void)loadView
{
    [super loadView];
}


//** 视图加载完毕 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 114.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXFollowAuctionCell class]) bundle:nil] forCellReuseIdentifier:kYXMyAuctionFollowAuctionCellReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXIsBiddingCell class]) bundle:nil] forCellReuseIdentifier:kYXMyAuctionIsBiddingCellReuseIdentifer];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXEndBiddingCell class]) bundle:nil] forCellReuseIdentifier: kYXMyAuctionEndBiddingCellReuseIdentifer];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewAuctionData)];
    
    //上下拉加载数据
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreAuctionData)];
    MJRefreshAutoFooter *autoFooter                                     = (MJRefreshAutoFooter *)self.tableView.mj_footer;
    autoFooter.triggerAutomaticallyRefreshPercent                       = -100;
    
    [self loadNewAuctionData];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creatTimer) name:kYXMyAuctionCellCountDownTimeToControllerCreatTimerNotification object:nil];
}

//** 视图即将出现 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self cleanTimer];
}

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kYXMyAuctionCellCountDownTimeToControllerCreatTimerNotification object:nil];
}

//** 释放定时器 */
- (void)cleanTimer
{
     [_countDownTimer invalidate];
     _countDownTimer = nil;
}

////** 判断当前状态 */
//- (void)isHaveDataWithDataArray:(NSArray *)dataArray
//{
//    //--刷新数据
//    if (dataArray.count == 0 || !dataArray.count) {
//        self.myFollowAuctionTableView.hidden = YES;
//        self.noAuctionTipLabel.hidden = NO;
//        self.partInAuctionButton.hidden = NO;
//    }else{
//        self.myFollowAuctionTableView.hidden = NO;
//        self.noAuctionTipLabel.hidden = YES;
//        self.partInAuctionButton.hidden = YES;
//    }
//}


#pragma mark - Table view data source

//** 数据源_返回组 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//** 数据源_返回行 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataList.count != 0) {
        if ([self.delegate respondsToSelector:@selector(myAuctionSubTableViewController:hiddenTempView:title:)]) {
            [self.delegate myAuctionSubTableViewController:self hiddenTempView:YES title:self.title];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(myAuctionSubTableViewController:hiddenTempView:title:)]) {
            [self.delegate myAuctionSubTableViewController:self hiddenTempView:NO title:self.title];
        }
    }
    
    return self.dataList.count;
}

//** 数据源_返回cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXMyAuctionBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:self.myAuctionReuseIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.model = self.dataList[indexPath.row];
    
    if ([cell isKindOfClass:[YXIsBiddingCell class]]) {
        YXIsBiddingCell *countDownTimeCell = (YXIsBiddingCell *)cell;
        countDownTimeCell.timeModel = self.allGoodEndTimeArray[indexPath.row];
        return countDownTimeCell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataList[indexPath.row];
    YXHomeAuctionDeatilViewCotroller *deatilViewController = [[YXHomeAuctionDeatilViewCotroller alloc] init];
    
    //** 记录当前页 */
    self.userDisspaerCurPage = [self.dataList[indexPath.row] currentPage];
    
    if ([self.title isEqualToString:@"我的关注"]) {
        
        YXMyAccountFollowAuctionList *followAuctionList = self.dataList[indexPath.row];
        if (followAuctionList.bidType == 1) {
            //** 寄拍 */
            YXHomeAuctionDeatilViewCotroller *deatilViewController = [[YXHomeAuctionDeatilViewCotroller alloc] init];
            deatilViewController.prodId = followAuctionList.prodId;
            deatilViewController.ProBidId = followAuctionList.prodBidId;
            [self.navigationController pushViewController:deatilViewController animated:YES];
            
        }else if (followAuctionList.bidType == 2) {
            //** 一口价 */
            YXOneMouthPriceDeatilViewController *fixDetialViewController = [[YXOneMouthPriceDeatilViewController alloc] init];
            fixDetialViewController.prodId = [NSString stringWithFormat:@"%lld", followAuctionList.prodId];
            fixDetialViewController.prodBidId = [NSString stringWithFormat:@"%lld", followAuctionList.prodBidId];
            [self.navigationController pushViewController:fixDetialViewController animated:YES];
        }
        return;
    }else if ([self.title isEqualToString:@"正在竞拍"]) {
        YXMyAccountQueryProdBidList *list = (YXMyAccountQueryProdBidList *)model;
        deatilViewController.prodId = list.prodId;
        deatilViewController.ProBidId =  list.bidId;
    }else if ([self.title isEqualToString:@"结束竞拍"]) {
        
        YXMyAccountQueryProdOverList *list = (YXMyAccountQueryProdOverList *)model;
        deatilViewController.prodId = list.prodId;
        deatilViewController.ProBidId =  list.bidId;
    }
    
    //    deatilViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:deatilViewController animated:YES];
    //    deatilViewController.hidesBottomBarWhenPushed = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.title isEqualToString:@"我的关注"]) {
        return 114.0f;
    }else if ([self.title isEqualToString:@"正在竞拍"]) {
        return 124.0f;
    }else if ([self.title isEqualToString:@"结束竞拍"]) {
        return 114.0f;
    }else{
        return 0;
    }
}

#pragma mark - ScrollView Delegate


#pragma mark - 懒加载

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (NSMutableArray *)allAuctionDataListArray
{
    if (!_allAuctionDataListArray) {
        _allAuctionDataListArray = [NSMutableArray array];
    }
    return _allAuctionDataListArray;
}

- (NSTimer *)countDownTimer
{
    if (!_countDownTimer) {
        _countDownTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    }
    return _countDownTimer;
}

- (NSMutableArray *)allGoodEndTimeArray
{
    if (!_allGoodEndTimeArray) {
        _allGoodEndTimeArray = [NSMutableArray array];
    }
    return _allGoodEndTimeArray;
}


@end
