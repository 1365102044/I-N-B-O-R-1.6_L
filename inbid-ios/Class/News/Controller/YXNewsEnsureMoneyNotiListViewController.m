//
//  YXNewsEnsureMoneyNotiListViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNewsEnsureMoneyNotiListViewController.h"

#import "YXNewsEnsuremoneyNotiListTableViewCell.h"
#import "YXNoMoreDataFooterView.h"

#import "YXNewsBaseModle.h"
#import "YXNewsEnsureNotiListModle.h"

#import "YXTempView.h"



#import "YXMySureMoneyNopayMentDeatilViewController.h"  //未付款
#import "YXMySureMoneyThawingDeatilViewController.h" //冻结中
#import "YXRefundMySureMoneyViewController.h"  //已解冻

NSInteger const NEWSENSURENOTIPAGESIZE = 8;


@interface YXNewsEnsureMoneyNotiListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * ensuremoneyNotiListtableview;

@property(nonatomic,strong) NSMutableArray * ensurenotilistDataArr;

//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;

//** 上拉记录当前页 */
@property (nonatomic, assign) NSInteger pullUpCurPage;
//** 全部分页数据 */
@property (nonatomic, strong) NSMutableArray *dataList;

@property(nonatomic,strong) YXTempView * tempView;

@end

@implementation YXNewsEnsureMoneyNotiListViewController
- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
        _tempView.logImageNamed = @"iconfont-dingdan";
        _tempView.tipsText = @"暂时您没有保证金通知信息";
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


-(NSMutableArray*)ensurenotilistDataArr
{
    if (!_ensurenotilistDataArr) {
        _ensurenotilistDataArr = [[NSMutableArray alloc]init];
    }
    return _ensurenotilistDataArr;
}
-(UITableView*)ensuremoneyNotiListtableview
{
    if (!_ensuremoneyNotiListtableview) {
        _ensuremoneyNotiListtableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _ensuremoneyNotiListtableview.delegate = self;
        _ensuremoneyNotiListtableview.dataSource = self;
        _ensuremoneyNotiListtableview.tableFooterView = [[UIView alloc]init];
        _ensuremoneyNotiListtableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 15)];
        headerview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _ensuremoneyNotiListtableview.tableHeaderView = headerview;
        
        _ensuremoneyNotiListtableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ensuremoneyNotiListtableview.rowHeight = 130;
    }
    return _ensuremoneyNotiListtableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"保证金";
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    [self.view addSubview:self.ensuremoneyNotiListtableview];
    
    
    self.ensuremoneyNotiListtableview.tableFooterView = [[UIView alloc]init];
    
    self.ensuremoneyNotiListtableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestensuremoneyNotiListData)];
    // 自动改变透明度
    self.ensuremoneyNotiListtableview.mj_header.automaticallyChangeAlpha = YES;
    self.ensuremoneyNotiListtableview.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreensuremoneyNotiList)];
    MJRefreshAutoFooter *autoFooter                                     = (MJRefreshAutoFooter *)self.ensuremoneyNotiListtableview.mj_footer;
    autoFooter.triggerAutomaticallyRefreshPercent                       = -100;

    
    [self requestensuremoneyNotiListData];
    
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
    //最终完美版本
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXNewsEnsuremoneyNotiListTableViewCell *dingdanlistcell = [YXNewsEnsuremoneyNotiListTableViewCell creatensuremoenyNotilistTableViewCell];
    
    dingdanlistcell.selectionStyle = UITableViewCellSelectionStyleNone;
    dingdanlistcell.ensuremodle = self.dataList[indexPath.section];
    
    return dingdanlistcell;
}
/*
 /**
 * 保证金分笔支付一次
 */
//Integer msgType = 201;

/**
 * 保证金分笔支付完成
 */
//Integer msgType = 202;

/**
 * 保证金全额支付完成
 */
//Integer msgType = 203;

/**
 * 保证金退款提醒
 */
//Integer msgType = 204;

/**
 * 保证金退款成功提醒
 */
//Integer msgType = 205;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXNewsEnsureNotiListModle*modle = self.dataList[indexPath.section];
    
    if (modle.msgType ==201) {
      YXMySureMoneyNopayMentDeatilViewController*  vc = [[YXMySureMoneyNopayMentDeatilViewController alloc]init];
        vc.marginId = [NSString stringWithFormat:@"%lld",modle.marginId];
        [self.navigationController pushViewController:vc animated:YES];

    }else if (modle.msgType==202||modle.msgType==203){
        
       YXMySureMoneyThawingDeatilViewController* vc = [[YXMySureMoneyThawingDeatilViewController alloc]init];
        if (modle.msgType ==203) {
            
            vc.isPartPay = 0;
        }else if (modle.msgType==203)
        {
            vc.isPartPay = 1;
        }
        vc.marginId = [NSString stringWithFormat:@"%lld",modle.marginId];
          [self.navigationController pushViewController:vc animated:YES];
        
    }else if (modle.msgType==204||modle.msgType==205){
       
      YXRefundMySureMoneyViewController*  vc = [[YXRefundMySureMoneyViewController alloc]init];
        vc.marginId = [NSString stringWithFormat:@"%lld",modle.marginId];
      [self.navigationController pushViewController:vc animated:YES];
    }
    

}



-(void)requestensuremoneyNotiListData
{
    NSInteger curPage;
    if (self.ensurenotilistDataArr.count) {
        
        curPage= [self.ensurenotilistDataArr.firstObject curPage] - 1 == 0 ? 1 : [self.ensurenotilistDataArr.firstObject curPage] - 1;
    }else{
        curPage = 1;
    }
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(curPage);
    parm[@"pageSize"] = @(NEWSENSURENOTIPAGESIZE);
    
    [YXRequestTool requestDataWithType:POST url:@"/api/message/margin" params:parm success:^(id objc, id respodHeader) {
        
        YXLog(@"--------%@",objc);
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            NSArray *dataArray = objc[@"data"];
            
            self.dataList = [YXNewsEnsureNotiListModle mj_objectArrayWithKeyValuesArray:dataArray];
            
            [self.dataList removeAllObjects];
            [self.ensurenotilistDataArr removeAllObjects];
            
            YXNewsBaseModle *objcModel = [YXNewsBaseModle mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.dataList addObjectsFromArray: objcModel.dataList];
            [self.ensurenotilistDataArr addObject:objcModel];
            if(!self.dataList.count)
            {
                [self.view addSubview:self.tempView];
                
            }else{
                
                [self.tempView removeFromSuperview];
            }
        }
        [self.ensuremoneyNotiListtableview reloadData];
        [self.ensuremoneyNotiListtableview.mj_header endRefreshing];
        
        
    } failure:^(NSError *error) {
        [self.ensuremoneyNotiListtableview.mj_header endRefreshing];
    }];
    
    
}
/*
 @brief 加载更多
 */
-(void)loadMoreensuremoneyNotiList
{
    
    [self.ensuremoneyNotiListtableview.mj_header endRefreshing];
    [self.noMoreDataFooterView removeFromSuperview];
    
    self.pullUpCurPage = [[self.ensurenotilistDataArr lastObject] curPage] + 1;
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(self.pullUpCurPage);
    parm[@"pageSize"] = @(NEWSENSURENOTIPAGESIZE);
    
    [YXRequestTool requestDataWithType:POST url:@"/api/message/margin" params:parm success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            YXNewsBaseModle *objcModel = [YXNewsBaseModle mj_objectWithKeyValues:objc];
            
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.dataList addObjectsFromArray:objcModel.dataList];
                [self.ensurenotilistDataArr addObject:objcModel];
            }
            self.pullUpCurPage = objcModel.curPage;
        }
        
        [self.ensuremoneyNotiListtableview reloadData];
        
        [self.ensuremoneyNotiListtableview.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.ensuremoneyNotiListtableview.mj_footer endRefreshing];
    }];
}

/**
 * 时刻监测footer的状态
 */
- (BOOL)checkFooterStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    //当总数等于当前页面
    if (objcModel.totalRows % NEWSENSURENOTIPAGESIZE == 0 || objcModel.totalRows < NEWSENSURENOTIPAGESIZE) {
        if (objcModel.totalRows / NEWSENSURENOTIPAGESIZE == objcModel.curPage || objcModel.totalRows < NEWSENSURENOTIPAGESIZE) {
            
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.ensuremoneyNotiListtableview.mj_footer.bounds;
            [self.ensuremoneyNotiListtableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            
            if (self.pullUpCurPage == objcModel.curPage) {
                YXNewsBaseModle *model = (YXNewsBaseModle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.ensurenotilistDataArr addObject:objcModel];
            }
            [self.ensuremoneyNotiListtableview.mj_footer endRefreshing];
            return YES;
        }else{
            [self.ensuremoneyNotiListtableview.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }else{
        if ((objcModel.totalRows - objcModel.totalRows % NEWSENSURENOTIPAGESIZE) / NEWSENSURENOTIPAGESIZE + 1 == objcModel.curPage) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.ensuremoneyNotiListtableview.mj_footer.bounds;
            [self.ensuremoneyNotiListtableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            if (self.pullUpCurPage == objcModel.curPage) {
                
                YXNewsBaseModle *model = (YXNewsBaseModle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.ensurenotilistDataArr addObject:objcModel];
            }
            [self.ensuremoneyNotiListtableview.mj_footer endRefreshing];
            return YES;
        }else{
            [self.ensuremoneyNotiListtableview.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }
}

//** 下拉检测footerView */
- (void)whenDroupDownCheckFooterViewStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    
    if (objcModel.totalRows < NEWSENSURENOTIPAGESIZE) {
        YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
        noMoreDataFooterView.frame = self.ensuremoneyNotiListtableview.mj_footer.bounds;
        [self.ensuremoneyNotiListtableview.mj_footer addSubview:noMoreDataFooterView];
        noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
        _noMoreDataFooterView = noMoreDataFooterView;
    }else{
        [self.ensuremoneyNotiListtableview.mj_footer endRefreshing];
        [self.noMoreDataFooterView removeFromSuperview];
        self.noMoreDataFooterView = nil;
    }
}


@end
