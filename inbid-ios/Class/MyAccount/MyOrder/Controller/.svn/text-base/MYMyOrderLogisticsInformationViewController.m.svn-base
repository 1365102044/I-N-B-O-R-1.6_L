//
//  MYMyOrderLogisticsInformationViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "MYMyOrderLogisticsInformationViewController.h"
#import "YXMyOrderLogiticsInformationHeaderview.h"

#import "MYMyOrderLogiticsInformationTableViewCell.h"
#import "YXMyAccountURLMacros.h"
#import "YXMyOrderLoginticsInformationListModle.h"
#import "YXTempView.h"

@interface MYMyOrderLogisticsInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableview;

@property(nonatomic,strong) YXMyOrderLogiticsInformationHeaderview * headerview;



@property(nonatomic,strong) NSMutableDictionary  * HeaderviewDataDict;

@property(nonatomic,strong) NSMutableArray * routListDataArr;

@property(nonatomic,strong) YXTempView * tempView;


@property(nonatomic,strong) YXMyOrderLoginticsInformationListModle * topviewDataArrModle;

@end

@implementation MYMyOrderLogisticsInformationViewController
/*
 @brief 空白页
 */
- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
        _tempView.logImageNamed = @"ic_wuliu";
        _tempView.tipsText =@"暂时没有物流信息";
    }
    return _tempView;
}


-(NSMutableDictionary *)HeaderviewDataDict
{
    if (!_HeaderviewDataDict) {
        _HeaderviewDataDict = [NSMutableDictionary dictionary];
    }
    return _HeaderviewDataDict;
}
-(NSMutableArray *)routListDataArr
{
    if (!_routListDataArr) {
        _routListDataArr = [NSMutableArray array];
        
    }
    return _routListDataArr;
}


-(YXMyOrderLogiticsInformationHeaderview*)headerview
{
    if (!_headerview) {
        _headerview = [[YXMyOrderLogiticsInformationHeaderview alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 74)];
    }
    return _headerview;
}

-(UITableView*)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableview.delegate =self;
        _tableview.dataSource = self;
        _tableview.backgroundColor =  YXBackMainColor;
        _tableview.showsVerticalScrollIndicator = NO;
    }
   return  _tableview;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"物流信息";
    self.view.backgroundColor = YXBackMainColor;
    [self.view addSubview:self.tableview];
    [self requestLoginsticsInformationList];
    
    self.tableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestLoginsticsInformationList)];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.routListDataArr.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MYMyOrderLogiticsInformationTableViewCell *cell = [MYMyOrderLogiticsInformationTableViewCell cellWithTableView:tableView indexPath:indexPath dataCount:self.routListDataArr.count];
    if (indexPath.row!=0) {
        
        cell.listmodle = self.routListDataArr[indexPath.row-1];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 40;
    }
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *seacview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 10)];
    seacview.backgroundColor = UIColorFromRGB(0xf9f9f9);
    return seacview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
/*
 @brief 请求物流接口
 */
-(void)requestLoginsticsInformationList
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    parm[@"id"] = self.cellid;
//    parm[@"id"] = @"790351585059591";
    [YXRequestTool requestDataWithType:POST url:MYORDERLOGINTICSINFORMATIONLIST params:parm success:^(id objc, id respodHeader) {
        YXLog(@"---物流详情---%@----",objc);
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
        self.routListDataArr =  [YXMyOrderLoginticsInformationListModle mj_objectArrayWithKeyValuesArray:objc[@"routeList"]];
        
            self.topviewDataArrModle = [YXMyOrderLoginticsInformationListModle mj_objectWithKeyValues:objc[@"data"]];
            self.headerview.topviewDataArrModle = self.topviewDataArrModle;
        
            if (!self.routListDataArr.count) {
                self.tableview.tableHeaderView = self.tempView;
            }else{
                self.tableview.tableHeaderView = self.headerview;
            }
        [self.tableview reloadData];
        }
    } failure:^(NSError *error) {
    }];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) {
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {        [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {        [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        //按照作者最后的意思还要加上下面这一段
        if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
            [cell setPreservesSuperviewLayoutMargins:NO];
        }

    }else
    {
        cell.separatorInset = UIEdgeInsetsMake(100000, 45, 0,0);
        
      }
}
@end
/*
 
 "consigneeName": "收货人",
 "consigneeMobile": "收货人手机号",
 "consigneeTelephone": "收货人电话",
 "id": 订单号,
 "deliveryMerchant": "承运公司",
 "deliveryTime": 快递发货时间,
 "consigneeProvince": "省",
 "consigneeCity": "市",
 "consigneeAddressDetail": "地址详细",
 "deliveryMemo": "快递备注",
 "memberId": 会员号id,
 "deliveryNum": "快递号",
 "deliveryStatus": 快递状态
 */
