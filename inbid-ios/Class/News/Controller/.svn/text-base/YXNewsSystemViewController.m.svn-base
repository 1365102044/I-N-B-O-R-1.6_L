//
//  YXNewsSystemViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNewsSystemViewController.h"
#import "YXAuctionBaseModel.h"
#import "YXNewsEnsureNotiListModle.h"
#import "YXNoMoreDataFooterView.h"
#import "YXTempView.h"
#import "YXNewsBaseModle.h"
#import "YXOrderDetailViewController.h"
#define SYSTEMCELLINDEX @"systemcell"
#import "YXNewsSystemTableViewCell.h"
#import "YXHomeAuctionDeatilViewCotroller.h"

NSInteger const NEWSSYSTEMNOTIPAGESIZE = 8;

@interface YXNewsSystemViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * systemtableview;

@property(nonatomic,strong) NSMutableArray * systemnotilistDataArr;

//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;

//** 上拉记录当前页 */
@property (nonatomic, assign) NSInteger pullUpCurPage;
//** 全部分页数据 */
@property (nonatomic, strong) NSMutableArray *dataList;

@property(nonatomic,strong) YXTempView * tempView;


@end

@implementation YXNewsSystemViewController

- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
        _tempView.logImageNamed = @"iconfont-dingdan";
        _tempView.tipsText = @"暂时您没有系统通知信息";
    }
    return _tempView;
}

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


-(NSMutableArray*)systemnotilistDataArr
{
    if (!_systemnotilistDataArr) {
        _systemnotilistDataArr = [[NSMutableArray alloc]init];
    }
    return _systemnotilistDataArr;
}

-(UITableView*)systemtableview
{
    if (!_systemtableview) {
        _systemtableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _systemtableview.delegate = self;
        _systemtableview.dataSource = self;
        _systemtableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 15)];
        headerview.backgroundColor = UIColorFromRGB(0xf9f9f9);
//        _systemtableview.tableHeaderView = headerview;
        _systemtableview.tableFooterView = [[UIView alloc]init];
        _systemtableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _systemtableview.rowHeight = 75;
    }
    return _systemtableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    self.navigationItem.title = @"系统通知";
    
    [self.view addSubview:self.systemtableview];
    
    self.systemtableview.tableFooterView = [[UIView alloc]init];
    
    self.systemtableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestsystemNotiListData)];
    // 自动改变透明度
    self.systemtableview.mj_header.automaticallyChangeAlpha = YES;
    self.systemtableview.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoresystemmoneyNotiList)];
    MJRefreshAutoFooter *autoFooter                                     = (MJRefreshAutoFooter *)self.systemtableview.mj_footer;
    autoFooter.triggerAutomaticallyRefreshPercent                       = -100;

    [self requestsystemNotiListData];

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *seactionview = [[UIView alloc]init];
//    seactionview.backgroundColor = [UIColor redColor];
    seactionview.frame = CGRectMake(0, 10, YXScreenW, 30);
    
    YXNewsEnsureNotiListModle*listmodle = self.dataList[section];
    NSDate *timedate = [NSDate dateWithTimeIntervalSince1970:([listmodle.createTime doubleValue] / 1000.0)];
    //最终完美版本
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy年MM月dd HH:mm"];
    NSString *time = [formatter stringFromDate:timedate];
    
    
    UILabel *timelable = [[UILabel alloc]initWithFrame:CGRectMake((YXScreenW-110)/2, 15, 110, 20)];
    [seactionview addSubview:timelable];
    timelable.text = time;
    timelable.font = YXRegularfont(10);
    timelable.textColor = [UIColor whiteColor];
    timelable.layer.masksToBounds = YES;
    timelable.layer.cornerRadius  =2;
    timelable.textAlignment = NSTextAlignmentCenter;
    timelable.backgroundColor = UIColorFromRGB(0xb9b9b9);
    return seactionview;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    YXNewsSystemTableViewCell *systemlistcell = [YXNewsSystemTableViewCell creatsystemNotilistTableViewCell];
    
    systemlistcell.selectionStyle = UITableViewCellSelectionStyleNone;
    systemlistcell.modle = self.dataList[indexPath.section];
    
    
    return systemlistcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXNewsEnsureNotiListModle*modle = self.dataList[indexPath.section];
    NSInteger VCType = modle.msgType;
//    /*
//     @brief 系统通知
//     */
//    if (VCType ==401)      //付款通知90847348
//    {
//        YXOrderDetailViewController *orderdeatilVC =[YXOrderDetailViewController orderDetailViewControllerWithOrderId:modle.refId andExtend:nil];
//        [self.navigationController pushViewController:orderdeatilVC animated:YES];
//        
//    }else
    
        if (VCType  == 402)      //关注拍品即将开拍提醒 756751384722546
    {
        YXHomeAuctionDeatilViewCotroller *deatilevc =[[YXHomeAuctionDeatilViewCotroller alloc]init];
        deatilevc.ProBidId = modle.refId;
        [self.navigationController pushViewController:deatilevc animated:YES];
        
    }else if (VCType==403){
    
        //**不需要跳转**/
    }
}


-(void)requestsystemNotiListData
{
    NSInteger curPage;
    if (self.systemnotilistDataArr.count) {
        
        curPage= [self.systemnotilistDataArr.firstObject curPage] - 1 == 0 ? 1 : [self.systemnotilistDataArr.firstObject curPage] - 1;
    }else{
        curPage = 1;
    }
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(curPage);
    parm[@"pageSize"] = @(NEWSSYSTEMNOTIPAGESIZE);
    
    [YXRequestTool requestDataWithType:POST url:@"/api/message/system" params:parm success:^(id objc, id respodHeader) {
        
        YXLog(@"--------%@",objc);
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            NSArray *dataArray = objc[@"data"];
            
            self.dataList = [YXNewsEnsureNotiListModle mj_objectArrayWithKeyValuesArray:dataArray];
            
            [self.dataList removeAllObjects];
            [self.systemnotilistDataArr removeAllObjects];
            
            YXNewsBaseModle *objcModel = [YXNewsBaseModle mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.dataList addObjectsFromArray: objcModel.dataList];
            [self.systemnotilistDataArr addObject:objcModel];
            if(!self.dataList.count)
            {
                [self.view addSubview:self.tempView];
                
            }else{
                
                [self.tempView removeFromSuperview];
            }
        }
        [self.systemtableview reloadData];
        [self.systemtableview.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        [self.systemtableview.mj_header endRefreshing];
    }];
    
    
}
/*
 @brief 加载更多
 */
-(void)loadMoresystemmoneyNotiList
{
    
    [self.systemtableview.mj_header endRefreshing];
    [self.noMoreDataFooterView removeFromSuperview];
    
    self.pullUpCurPage = [[self.systemnotilistDataArr lastObject] curPage] + 1;
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(self.pullUpCurPage);
    parm[@"pageSize"] = @(NEWSSYSTEMNOTIPAGESIZE);
    
    [YXRequestTool requestDataWithType:POST url:@"/api/message/system" params:parm success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            YXNewsBaseModle *objcModel = [YXNewsBaseModle mj_objectWithKeyValues:objc];
            
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.dataList addObjectsFromArray:objcModel.dataList];
                [self.systemnotilistDataArr addObject:objcModel];
            }
            self.pullUpCurPage = objcModel.curPage;
        }
        
        [self.systemtableview reloadData];
        
        [self.systemtableview.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.systemtableview.mj_footer endRefreshing];
    }];
}

/**
 * 时刻监测footer的状态
 */
- (BOOL)checkFooterStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    //当总数等于当前页面
    if (objcModel.totalRows % NEWSSYSTEMNOTIPAGESIZE == 0 || objcModel.totalRows < NEWSSYSTEMNOTIPAGESIZE) {
        if (objcModel.totalRows / NEWSSYSTEMNOTIPAGESIZE == objcModel.curPage || objcModel.totalRows < NEWSSYSTEMNOTIPAGESIZE) {
            
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.systemtableview.mj_footer.bounds;
            [self.systemtableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            
            if (self.pullUpCurPage == objcModel.curPage) {
                YXNewsBaseModle *model = (YXNewsBaseModle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.systemnotilistDataArr addObject:objcModel];
            }
            [self.systemtableview.mj_footer endRefreshing];
            return YES;
        }else{
            [self.systemtableview.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }else{
        if ((objcModel.totalRows - objcModel.totalRows % NEWSSYSTEMNOTIPAGESIZE) / NEWSSYSTEMNOTIPAGESIZE + 1 == objcModel.curPage) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.systemtableview.mj_footer.bounds;
            [self.systemtableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            if (self.pullUpCurPage == objcModel.curPage) {
                
                YXNewsBaseModle *model = (YXNewsBaseModle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.systemnotilistDataArr addObject:objcModel];
            }
            [self.systemtableview.mj_footer endRefreshing];
            return YES;
        }else{
            [self.systemtableview.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }
}

//** 下拉检测footerView */
- (void)whenDroupDownCheckFooterViewStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    
    if (objcModel.totalRows < NEWSSYSTEMNOTIPAGESIZE) {
        YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
        noMoreDataFooterView.frame = self.systemtableview.mj_footer.bounds;
        [self.systemtableview.mj_footer addSubview:noMoreDataFooterView];
        noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
        _noMoreDataFooterView = noMoreDataFooterView;
    }else{
        [self.systemtableview.mj_footer endRefreshing];
        [self.noMoreDataFooterView removeFromSuperview];
        self.noMoreDataFooterView = nil;
    }
}
@end
