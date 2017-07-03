//
//  YXPickUpPersonListViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPickUpPersonListViewController.h"
#import "YXMyAccountURLMacros.h"
#import "YXPickuppersonListTableViewCell.h"
#import "YXAuctionBaseModel.h"
#import "YXNoMoreDataFooterView.h"
#import "YXTempView.h"
#import "YXPiceuppersonbasemodle.h"
#import "YXPickuppersonListAddNewsViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "YXOneMouthPriceConfirmOrderViewController.h"
NSInteger const PAGESIZE = 8;


@interface YXPickUpPersonListViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) UITableView * listtableview;

@property(nonatomic,strong) NSMutableArray * PickupInformData;

//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;

//** 上拉记录当前页 */
@property (nonatomic, assign) NSInteger pullUpCurPage;
@property(nonatomic,assign) NSInteger  currentpage;
@property(nonatomic,strong) YXTempView * tempView;
@property(nonatomic,strong) NSMutableArray * dataList;

@property(nonatomic,strong) UIButton * addbtn;


@property(nonatomic,strong) YXKeyboardToolbar * customAccessoryView;
@property(nonatomic,strong) YXMyOrderSuccessAlerview*RemindGoodsView;

@end

@implementation YXPickUpPersonListViewController
#pragma mark - 懒加载

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (NSMutableArray *)PickupInformData
{
    if (!_PickupInformData) {
        _PickupInformData = [NSMutableArray array];
    }
    return _PickupInformData;
}

-(UITableView*)listtableview
{
    if (!_listtableview) {
        _listtableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, YXScreenW, YXScreenH-70-50)];
        _listtableview.delegate = self;
        _listtableview.dataSource = self;
        _listtableview.rowHeight = 130;
        _listtableview.tableFooterView = [[UIView alloc]init];
        _listtableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
    }
    return     _listtableview;
}

- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
        _tempView.logImageNamed = @"iconfont-dingdan";
        _tempView.tipsText = @"暂时没有信息";
    }
    return _tempView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.listtableview];
    
    [self requestPickUppersonListdata];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.title = @"提货人信息";
    
    self.view.backgroundColor  = UIColorFromRGB(0xf9f9f9);

    self.listtableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestPickUppersonListdata)];
    
    //上下拉加载数据
    // 自动改变透明度
    self.listtableview.mj_header.automaticallyChangeAlpha = YES;
    self.listtableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMorerequestPickUppersonListdata)];
    
    [self addboomBtnview];
    
    [YXNotificationTool addObserver:self selector:@selector(formeAddNewPickInformationBack:) name:@"formeAddNewPickInformationBack" object:nil];
    
    UIBarButtonItem *leftBarButtonItem          = [UIBarButtonItem itemWithTarget:self
                                                                           action:@selector(pickbackButtonClick:)
                                                                            image:@"icon_fanhui"
                                                                        highImage:@"icon_fanhui"];
    self.navigationItem.leftBarButtonItem       = leftBarButtonItem;
}
/**
 确认订单的时候，新增的完成后，直接返回，
 */
-(void)formeAddNewPickInformationBack:(NSNotification *)noti{
    
    YXPickUpPersonListModle *model = [YXPickUpPersonListModle mj_objectWithKeyValues:noti.userInfo];
    model.IsHaveData = YES;
    if(self.onemouchpricemodleblock)
    {
        self.onemouchpricemodleblock(model);
    }
}
-(void)addboomBtnview
{
    UIButton *addbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, YXScreenH-50, YXScreenW, 50)];
    [addbtn setTitle:@"添加新提货人" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addbtn.titleLabel.font = YXSFont(14);
    addbtn.backgroundColor = [UIColor mainThemColor];
    [addbtn addTarget:self action:@selector(clickaddbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addbtn];
    self.addbtn = addbtn;
}
-(void)clickaddbtn
{
    YXPickuppersonListAddNewsViewController *addinformation = [[YXPickuppersonListAddNewsViewController alloc]init];
    addinformation.texttitle = @"新增提货人信息";
    addinformation.sourceController = self.sourceController;
    [self.navigationController pushViewController:addinformation animated:YES];
}

/**
 返回方法拦截
 */
-(void)pickbackButtonClick:(UIButton *)sender{
    if ([self.sourceController isKindOfClass:[YXOneMouthPriceConfirmOrderViewController class]]) {
        YXPickUpPersonListModle *model = [[YXPickUpPersonListModle alloc]init];
        if (self.dataList.count==0) {
            model.IsHaveData = NO;
        }else{
            model = self.dataList[0];
            model.IsHaveData = YES;
        }
        
        if(self.onemouchpricemodleblock)
        {
            self.onemouchpricemodleblock(model);
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXPickuppersonListTableViewCell *cell = [YXPickuppersonListTableViewCell creatMySureMoneyNoPaymentTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)weakself = self;
    cell.bianjiblock =^(YXPickUpPersonListModle * modle){
    
        [weakself BianjiPickuppersoninformation:modle];
    };
    
    cell.removeblock =^(NSString *cellid){

        [weakself showalearview:cellid];
    };
    
    cell.morenblock =^(NSString *cellid){
    
        [weakself shezhiMorenpickuppersoninformation:cellid];
    };
    
    cell.modle = self.dataList[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (![self.sourceController isKindOfClass:[YXOneMouthPriceConfirmOrderViewController class]]) {
    
        return;
    }
    
    YXPickUpPersonListModle *model = self.dataList[indexPath.row];
    model.IsHaveData = YES;
    if(self.onemouchpricemodleblock)
    {
        self.onemouchpricemodleblock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void)showalearview:(NSString *)cellid
{
    
    //创建AlertController对象 preferredStyle可以设置是AlertView样式或者ActionSheet样式
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"确定删除提货人信息?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //创建取消按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"确定删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self removepickuppersoninformation:cellid];
        
    }];
    //添加按钮
    [alertC addAction:action1];
    [alertC addAction:action3];
    //显示
    [self presentViewController:alertC animated:YES completion:nil];
    
}


#pragma mark  ******************* cell上的操作**********************
//**移除**/
-(void)removepickuppersoninformation:(NSString *)cellid
{


    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = cellid;
    [YXRequestTool requestDataWithType:POST url:REMOVEPICKUPPERSONINFORMATION_URL params:param success:^(id objc, id respodHeader) {
    
        [self requestPickUppersonListdata];
        
    } failure:^(NSError *error) {
        
    }];
    
}



//**编辑**/
-(void)BianjiPickuppersoninformation:(YXPickUpPersonListModle *)modle
{

    YXPickuppersonListAddNewsViewController *addinformation = [[YXPickuppersonListAddNewsViewController alloc]init];
    addinformation.modle = modle;
    addinformation.texttitle = @"编辑提货人信息";
    [self.navigationController pushViewController:addinformation animated:YES];

}

//**默认**/
-(void)shezhiMorenpickuppersoninformation:(NSString *)cellid
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = cellid;
    [YXRequestTool requestDataWithType:POST url:SHEZHIMORENINFORMATION_URL params:param success:^(id objc, id respodHeader) {
        
        [self requestPickUppersonListdata];
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark  ******************* 网络请求**********************
-(void)requestPickUppersonListdata
{

    NSInteger curPage;
    if (self.PickupInformData.count) {
        
        curPage= [self.PickupInformData.firstObject curPage] - 1 == 0 ? 1 : [self.PickupInformData.firstObject curPage] - 1;
    }else{
        curPage = 1;
    }
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(curPage);
    parm[@"pageSize"] = @(PAGESIZE);
    
    [YXNetworkHUD show];
    [YXRequestTool requestDataWithType:POST url:REQUESTPICKUPPERSONLIST_URL params:parm success:^(id objc, id respodHeader) {
        
        [YXNetworkHUD dismiss];
        
        YXLog(@"---tihuorenxinxi---%@----",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
      
            self.PickupInformData = [YXPickUpPersonListModle mj_objectArrayWithKeyValuesArray:objc[@"data"]];
        
            [self.dataList removeAllObjects];
            [self.PickupInformData removeAllObjects];
            
            YXPiceuppersonbasemodle *objcModel = [YXPiceuppersonbasemodle mj_objectWithKeyValues:objc];
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.dataList addObjectsFromArray: objcModel.dataList];
            [self.PickupInformData addObject:objcModel];
            
            if(!self.dataList.count)
            {
                [self.view addSubview:self.tempView];
                [self.view bringSubviewToFront:self.addbtn];
                
            }else{
                
                [self.tempView removeFromSuperview];
            }
            [self.listtableview reloadData];
            [self.listtableview.mj_header endRefreshing];

            
        }
        
        
    } failure:^(NSError *error) {
        
        [self.listtableview.mj_header endRefreshing];
        [YXNetworkHUD dismiss];
        
    }];
}

-(void)loadMorerequestPickUppersonListdata
{
    [self.listtableview.mj_header endRefreshing];
    [self.noMoreDataFooterView removeFromSuperview];
    
    self.pullUpCurPage = [[self.PickupInformData lastObject] curPage] + 1;
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"curPage"] = @(self.pullUpCurPage);
    parm[@"pageSize"] = @(PAGESIZE);
    [YXNetworkHUD show];
    [YXRequestTool requestDataWithType:POST url:REQUESTPICKUPPERSONLIST_URL params:parm success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        YXPiceuppersonbasemodle *objcModel = [YXPiceuppersonbasemodle mj_objectWithKeyValues:objc];
        
        if (![self checkFooterStateWithObjc:objcModel]) {
            [self.dataList addObjectsFromArray:objcModel.dataList];
            [self.PickupInformData addObject:objcModel];
        }
        self.pullUpCurPage = objcModel.curPage;
        [self.listtableview reloadData];
        
        [self.listtableview.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.listtableview.mj_footer endRefreshing];
        [YXNetworkHUD dismiss];
    }];
}



/**
 * 时刻监测footer的状态
 */
- (BOOL)checkFooterStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    NSInteger PAGESIZES = PAGESIZE;
    //当总数等于当前页面
    if (objcModel.totalRows % PAGESIZES == 0 || objcModel.totalRows < PAGESIZES) {
        if (objcModel.totalRows / PAGESIZES == objcModel.curPage || objcModel.totalRows < PAGESIZES) {
            
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.listtableview.mj_footer.bounds;
            [self.listtableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            
            if (self.pullUpCurPage == objcModel.curPage) {
                YXPiceuppersonbasemodle *model = (YXPiceuppersonbasemodle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.PickupInformData addObject:objcModel];
            }
            [self.listtableview.mj_footer endRefreshing];
            return YES;
        }else{
            [self.listtableview.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }else{
        if ((objcModel.totalRows - objcModel.totalRows % PAGESIZES) / PAGESIZES + 1 == objcModel.curPage) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.listtableview.mj_footer.bounds;
            [self.listtableview.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
            
            if (self.pullUpCurPage == objcModel.curPage) {
                
                YXPiceuppersonbasemodle *model = (YXPiceuppersonbasemodle *)objcModel;
                [self.dataList addObjectsFromArray:[model dataList]];
                [self.PickupInformData addObject:objcModel];
            }
            [self.listtableview.mj_footer endRefreshing];
            return YES;
        }else{
            [self.listtableview.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }
}

//** 下拉检测footerView */
- (void)whenDroupDownCheckFooterViewStateWithObjc:(YXAuctionBaseModel *)objcModel
{
    
    if (objcModel.totalRows < PAGESIZE ) {
        YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
        noMoreDataFooterView.frame = self.listtableview.mj_footer.bounds;
        [self.listtableview.mj_footer addSubview:noMoreDataFooterView];
        noMoreDataFooterView.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
        _noMoreDataFooterView = noMoreDataFooterView;
    }else{
        [self.listtableview.mj_footer endRefreshing];
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


#pragma mark  ******************* 提示卡框**********************
-(YXMyOrderSuccessAlerview*)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}
/*
 @brief 结果提示框
 */
-(void)arlearviewOneprice:(NSString*)type
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
    self.RemindGoodsView.longinVCStr = type;
    self.RemindGoodsView.frame = self.view.bounds;
    __weak typeof (self) wealself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wealself dimssview];
    });
    
}
/*
 @brief 消失的时候 移除所有的弹出视图
 */
-(void)dimssview
{
    [self.RemindGoodsView removeFromSuperview];
    self.RemindGoodsView = nil;
}

-(void)dealloc{
    
    [YXNotificationTool removeObserver:self name:@"formeAddNewPickInformationBack" object:nil];
}

@end
