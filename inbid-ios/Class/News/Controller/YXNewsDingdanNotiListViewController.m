//
//  YXNewsDingdanNotiListViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNewsDingdanNotiListViewController.h"
#import "YXNewsDingdanNotiListTableViewCell.h"

#import "YXNewsBaseModle.h"
#import "YXNewsEnsureNotiListModle.h"

#import "YXNoMoreDataFooterView.h"
#import "YXTempView.h"

#import "YXOrderDetailViewController.h"
#import "YXSendAuctionInformationController.h"


NSInteger const NEWSDINGDANNOTIPAGESIZE = 8;

@interface YXNewsDingdanNotiListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * dingdanNotiListtableview;


@property(nonatomic,strong) NSMutableArray * dingdannotilistDataArr;

//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;

//** 上拉记录当前页 */
@property (nonatomic, assign) NSInteger pullUpCurPage;
//** 全部分页数据 */
@property (nonatomic, strong) NSMutableArray *dataList;

@property(nonatomic,strong) YXTempView * tempView;

@end

@implementation YXNewsDingdanNotiListViewController

- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
        _tempView.logImageNamed = @"iconfont-dingdan";
        _tempView.tipsText = @"暂时您没有订单通知信息";
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


-(NSMutableArray*)dingdannotilistDataArr
{
    if (!_dingdannotilistDataArr) {
        _dingdannotilistDataArr = [[NSMutableArray alloc]init];
    }
    return _dingdannotilistDataArr;
}



-(UITableView*)dingdanNotiListtableview
{
    if (!_dingdanNotiListtableview) {
        _dingdanNotiListtableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _dingdanNotiListtableview.delegate = self;
        _dingdanNotiListtableview.dataSource = self;
        _dingdanNotiListtableview.tableFooterView = [[UIView alloc]init];
        _dingdanNotiListtableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 15)];
        headerview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _dingdanNotiListtableview.tableHeaderView = headerview;
        _dingdanNotiListtableview.rowHeight = 150;
        _dingdanNotiListtableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _dingdanNotiListtableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.fromeVC==1) {
        
           self.navigationItem.title = @"我的订单";
    }else if (self.fromeVC==2 )
    {
           self.navigationItem.title = @"鉴定订单";
    }
    
    
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    [self.view addSubview:self.dingdanNotiListtableview];
    
    self.dingdanNotiListtableview.tableFooterView = [[UIView alloc]init];
    
    self.dingdanNotiListtableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestdingdanNotiListData)];
    // 自动改变透明度
    self.dingdanNotiListtableview.mj_header.automaticallyChangeAlpha = YES;
    self.dingdanNotiListtableview.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoredingdanNotiList)];
    MJRefreshAutoFooter *autoFooter                                     = (MJRefreshAutoFooter *)self.dingdanNotiListtableview.mj_footer;
    autoFooter.triggerAutomaticallyRefreshPercent                       = -100;
    
    [self requestdingdanNotiListData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *seactionview = [[UIView alloc]init];
    seactionview.backgroundColor = [UIColor clearColor];
    seactionview.frame = CGRectMake(0, 0, YXScreenW, 20);
    
    YXNewsEnsureNotiListModle*listmodle = self.dataList[section];
    NSDate *timedate = [NSDate dateWithTimeIntervalSince1970:([listmodle.createTime doubleValue] / 1000.0)];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy年MM月dd HH:mm"];
    NSString *time = [formatter stringFromDate:timedate];
    

    UILabel *timelable = [[UILabel alloc]initWithFrame:CGRectMake((YXScreenW-110)/2, 0, 110, 20)];
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
    return 30;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXNewsDingdanNotiListTableViewCell *dingdanlistcell = [YXNewsDingdanNotiListTableViewCell creatdingdanNotilistTableViewCell];
    
     dingdanlistcell.selectionStyle = UITableViewCellSelectionStyleNone;
    dingdanlistcell.dingdanmodle = self.dataList[indexPath.section];
    
    return dingdanlistcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXNewsEnsureNotiListModle *modle = self.dataList[indexPath.section];
    if(self.fromeVC ==1)
    {
        YXOrderDetailViewController *vc = [YXOrderDetailViewController orderDetailViewControllerWithOrderId:[modle.orderId longLongValue] andExtend:self];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.fromeVC ==2)
    {
        /*
         @brief 鉴定详情
         */
        YXSendAuctionInformationController * vc = [[YXSendAuctionInformationController alloc]init];
        vc.orderID = modle.refId;
        vc.sourceViewController = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)requestdingdanNotiListData
{
    NSInteger curPage;
    if (self.dingdannotilistDataArr.count) {
        
        curPage= [self.dingdannotilistDataArr.firstObject curPage] - 1 == 0 ? 1 : [self.dingdannotilistDataArr.firstObject curPage] - 1;
    }else{
        curPage = 1;
    }
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(curPage);
    parm[@"pageSize"] = @(NEWSDINGDANNOTIPAGESIZE);
    NSString *url;
    if (self.fromeVC==1) {
        url= @"/api/message/order";
    }else if (self.fromeVC==2)
    {
        url = @"/api/message/identify";
    }
    [YXRequestTool requestDataWithType:POST url:url params:parm success:^(id objc, id respodHeader) {
        
        YXLog(@"--------%@",objc);
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            NSArray *dataArray = objc[@"data"];
            
            self.dataList = [YXNewsEnsureNotiListModle mj_objectArrayWithKeyValuesArray:dataArray];
            
            [self.dataList removeAllObjects];
            [self.dingdannotilistDataArr removeAllObjects];
            
            YXNewsBaseModle *objcModel = [YXNewsBaseModle mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.dataList addObjectsFromArray: objcModel.dataList];
            [self.dingdannotilistDataArr addObject:objcModel];
            if(!self.dataList.count)
            {
                [self.view addSubview:self.tempView];
                
            }else{
                
                [self.tempView removeFromSuperview];
            }
        }
        [self.dingdanNotiListtableview reloadData];
        [self.dingdanNotiListtableview.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        [self.dingdanNotiListtableview.mj_header endRefreshing];
    }];
    
    
}
/*
 @brief 加载更多
 */
-(void)loadMoredingdanNotiList
{
    
    [self.dingdanNotiListtableview.mj_header endRefreshing];
    [self.noMoreDataFooterView removeFromSuperview];
    
    self.pullUpCurPage = [[self.dingdannotilistDataArr lastObject] curPage] + 1;
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(self.pullUpCurPage);
    parm[@"pageSize"] = @(NEWSDINGDANNOTIPAGESIZE);
    NSString *url;
    if (self.fromeVC==1) {
        url= @"/api/message/order";
    }else if (self.fromeVC==2)
    {
        url = @"/api/message/identify";
    }
    [YXRequestTool requestDataWithType:POST url:url params:parm success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            YXNewsBaseModle *objcModel = [YXNewsBaseModle mj_objectWithKeyValues:objc];
            
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.dataList addObjectsFromArray:objcModel.dataList];
                [self.dingdannotilistDataArr addObject:objcModel];
            }
            self.pullUpCurPage = objcModel.curPage;
        }
        
        [self.dingdanNotiListtableview reloadData];
        
        [self.dingdanNotiListtableview.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.dingdanNotiListtableview.mj_footer endRefreshing];
    }];
}

/**
 * 时刻监测footer的状态
 */
- (BOOL)checkFooterStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    //当总数等于当前页面
    if (objcModel.totalRows % NEWSDINGDANNOTIPAGESIZE == 0 || objcModel.totalRows < NEWSDINGDANNOTIPAGESIZE) {
        if (objcModel.totalRows / NEWSDINGDANNOTIPAGESIZE == objcModel.curPage || objcModel.totalRows < NEWSDINGDANNOTIPAGESIZE) {
            
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.dingdanNotiListtableview.mj_footer.bounds;
            [self.dingdanNotiListtableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            
            if (self.pullUpCurPage == objcModel.curPage) {
                YXNewsBaseModle *model = (YXNewsBaseModle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.dingdannotilistDataArr addObject:objcModel];
            }
            [self.dingdanNotiListtableview.mj_footer endRefreshing];
            return YES;
        }else{
            [self.dingdanNotiListtableview.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }else{
        if ((objcModel.totalRows - objcModel.totalRows % NEWSDINGDANNOTIPAGESIZE) / NEWSDINGDANNOTIPAGESIZE + 1 == objcModel.curPage) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.dingdanNotiListtableview.mj_footer.bounds;
            [self.dingdanNotiListtableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            if (self.pullUpCurPage == objcModel.curPage) {
                
                YXNewsBaseModle *model = (YXNewsBaseModle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.dingdannotilistDataArr addObject:objcModel];
            }
            [self.dingdanNotiListtableview.mj_footer endRefreshing];
            return YES;
        }else{
            [self.dingdanNotiListtableview.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }
}

//** 下拉检测footerView */
- (void)whenDroupDownCheckFooterViewStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    
    if (objcModel.totalRows < NEWSDINGDANNOTIPAGESIZE) {
        YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
        noMoreDataFooterView.frame = self.dingdanNotiListtableview.mj_footer.bounds;
        [self.dingdanNotiListtableview.mj_footer addSubview:noMoreDataFooterView];
        noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
        _noMoreDataFooterView = noMoreDataFooterView;
    }else{
        [self.dingdanNotiListtableview.mj_footer endRefreshing];
        [self.noMoreDataFooterView removeFromSuperview];
        self.noMoreDataFooterView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
