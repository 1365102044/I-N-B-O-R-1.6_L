//
//  YXMyWalletMainViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/20.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyWalletMainViewController.h"
#import "YXMyWalletMainHeaderView.h"
#import "YXMyWalletMainSeationView.h"
#import "YXMyWalletMainTableViewCell.h"
#import "YXWithdrawalsController.h"
#import "YXMyWalletBankCardListViewController.h"
#import "YXMyWalletRequestTool.h"
#import "YXMyWalletAccountInformModle.h"
#import "YXWalletAccountSecurityViewController.h"
#import "YXMyWalletAgreementViewController.h"
#import "YXSaveLoginDataTool.h"
#import "YXPayAndIncomeController.h"
#import "YXAlertViewTool.h"
#import "YXPerfectAccountInformationViewController.h"
#import "YXUploadIDPhotoViewController.h"
@interface YXMyWalletMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * walletTableview;
@property(nonatomic,strong) YXMyWalletMainHeaderView * headerView;
@property(nonatomic,strong) YXMyWalletMainSeationView * seactionHeaderview;

@property(nonatomic,strong) YXMyWalletAccountInformModle * inforDataModle;
/**
 保存naviBar的图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarImage;

/**
 保存naviBar背景图片
 */
@property (nonatomic, strong) UIImage *defaultNaviBarBackgroundImage;
@property(nonatomic,strong) NSArray * celldataArr;

//请求 成功后 才能点击cell
@property(nonatomic,assign) BOOL  isHaveData;
@end

@implementation YXMyWalletMainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.defaultNaviBarImage                            = self.navigationController.navigationBar.shadowImage;
    self.defaultNaviBarBackgroundImage                  = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:self.defaultNaviBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:self.defaultNaviBarImage];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self RequestData];
    self.view.backgroundColor = YXBackMainColor;
    [self.view addSubview:self.walletTableview];
    self.walletTableview.tableHeaderView = self.headerView;
    __weak typeof(self) weakself = self;
    self.headerView.clickDescLableblock =^(NSInteger type){
        if (type ==5||type==1){
            YXPerfectAccountInformationViewController *setRealnameVC = [[YXPerfectAccountInformationViewController alloc]init];
            setRealnameVC.SourceViewController = weakself;
            [weakself.navigationController pushViewController:setRealnameVC animated:YES];
        }
    };
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.celldataArr = @[@"银行卡",@"提现",@"收支明细",@"账号安全"];
 
    self.walletTableview.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(RequestData)];
    
    [self addboomImageview];
}
-(void)RequestData{

    [[YXMyWalletRequestTool sharedTool] RequestMyWalletAccountInformaionSuccess:^(id objc, id respodHeader) {
        YXLog(@"+++++%@===",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            self.isHaveData = YES;
            self.inforDataModle = [YXMyWalletAccountInformModle mj_objectWithKeyValues:objc[@"data"]];
            [[YXSaveLoginDataTool shared] SaveMyDataWithKey:@"realName" Info:self.inforDataModle.name_user];
            self.headerView.dataModel = self.inforDataModle;
            [self.walletTableview reloadData];
        }else{
            [YXAlertViewTool showAlertView:self title:@"错误信息" message:objc[@"errorMsg"] confrimBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        [self.walletTableview.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.walletTableview.mj_header endRefreshing];
        
    }];
}
-(void)addboomImageview{

    UIImageView *boomimage = [[UIImageView alloc]initWithFrame:CGRectMake((YXScreenW-123)/2, YXScreenH-40, 123, 27)];
    boomimage.image = [UIImage imageNamed:@"mywalletboomlogo"];
    [self.view addSubview:boomimage];
    [self.view bringSubviewToFront:boomimage];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0)
    {
        return 80;
    }else{
    
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *str;
    if (indexPath.section == 0) {
        str = @"myseactioncell";
    }else{
        str = [NSString stringWithFormat:@"%ld%ld",indexPath.section,indexPath.row];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if (indexPath.section==0) {
        
        self.seactionHeaderview = [[YXMyWalletMainSeationView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 80)];
        self.seactionHeaderview.dataModel = self.inforDataModle;
        [cell.contentView addSubview:self.seactionHeaderview];
        
    }else {
        
        YXMyWalletMainTableViewCell *cellview = [[YXMyWalletMainTableViewCell alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 50)];
        cellview.titlename = self.celldataArr[indexPath.row];
        [cell.contentView addSubview:cellview];
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.isHaveData) {
        [YXAlearMnager ShowAlearViewWith:@"数据异常" Type:2];
        return;
    }
    if(indexPath.section ==0){
        return;
    }
    
    /**
     *  银行卡
     */
    if (indexPath.section == 1
        && indexPath.row == 0) {
        
        YXMyWalletBankCardListViewController *perfectVC = [[YXMyWalletBankCardListViewController  alloc] init];
        perfectVC.PushFormeVCIdentifier = 1;
        [self.navigationController pushViewController:perfectVC animated:YES];
    }
    
    /**
     *  点击提现
     */
    if (indexPath.section == 1
        && indexPath.row == 1) {
        YXWithdrawalsController *withdrawalsController = [[YXWithdrawalsController alloc] init];
        [self.navigationController pushViewController:withdrawalsController animated:YES];
    }
    
    /**
     *  收支明细
     */
    if (indexPath.section == 1
        && indexPath.row == 2) {
        
        YXPayAndIncomeController *vc = [[YXPayAndIncomeController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    /**
     *  账号安全
     */
    if (indexPath.section == 1
        && indexPath.row == 3) {
        
        YXWalletAccountSecurityViewController *AccountSecurithVC  = [[YXWalletAccountSecurityViewController alloc]init];
        [self.navigationController pushViewController:AccountSecurithVC animated:YES];
    }
}

-(YXMyWalletMainHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[YXMyWalletMainHeaderView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 160)];
    }
    return  _headerView;
}
-(UITableView *)walletTableview{
    if (!_walletTableview) {
        _walletTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _walletTableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _walletTableview.delegate = self;
        _walletTableview.dataSource = self;
    }
    return _walletTableview;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
}
@end