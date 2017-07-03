//
//  YXPayMentHistroyViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPayMentHistroyViewController.h"
#import "YXPayMentHistroyTableViewCell.h"
#import "YXPayMentHistroyDeatilViewController.h"
#import "YXApplyRefundRequestTool.h"
#import "YXPayHistroyModle.h"
#import "YXTempView.h"
@interface YXPayMentHistroyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,strong) YXTempView * tempView;
@property(nonatomic,strong) NSArray * histroyListArr;

@end
static NSString *paymenthistroycellResuseIdentifier = @"paymenthistroycellResuseIdentifier";

@implementation YXPayMentHistroyViewController


#pragma mark  *** 网络请求
-(void)loadpayhistroylistdata
{
    [[YXApplyRefundRequestTool sharedTool] LoadPayHistroyListDataWith:self.orderId Success:^(id objc, id respodHeader) {
        
        if([respodHeader[@"Status"] isEqualToString:@"1"])
        {
            YXLog(@"==========收支记录数据=======%@+++++++",objc);
            
            
            self.histroyListArr  = [YXPayHistroyModle mj_objectArrayWithKeyValuesArray:objc];
            if (self.histroyListArr.count) {
                
                [self.tempView removeFromSuperview];
                
            }else{
                self.tableview.tableHeaderView = self.tempView;
            }
        }else{
            
            self.tableview.tableHeaderView = self.tempView;
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
        
        [self.tableview.mj_header endRefreshing];
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付记录";
    
    [self.view addSubview:self.tableview];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"YXPayMentHistroyTableViewCell" bundle:nil]  forCellReuseIdentifier:paymenthistroycellResuseIdentifier];
    
    self.tableview.tableFooterView = [[UIView alloc]init];
    self.tableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadpayhistroylistdata)];
    
 
    [self loadpayhistroylistdata];
}



#pragma mark  *** tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.histroyListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXPayMentHistroyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:paymenthistroycellResuseIdentifier];
      if (!cell) {
          cell = [[YXPayMentHistroyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:paymenthistroycellResuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.listModle = self.histroyListArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXPayMentHistroyDeatilViewController *payhistroydeatilVC = [[YXPayMentHistroyDeatilViewController alloc]init];
    YXPayHistroyModle *modle = self.histroyListArr[indexPath.row];
    payhistroydeatilVC.DeatilModle = modle;
    [self.navigationController pushViewController:payhistroydeatilVC animated:YES];
}



/**
 懒加载
 */
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor  = UIColorFromRGB(0xf9f9f9);
        _tableview.tableFooterView= [[UIView  alloc]init];
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.rowHeight = 60;
    }
    return  _tableview;
}

- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
        _tempView.logImageNamed = @"iconfont-dingdan";
    }
    return _tempView;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}


@end
