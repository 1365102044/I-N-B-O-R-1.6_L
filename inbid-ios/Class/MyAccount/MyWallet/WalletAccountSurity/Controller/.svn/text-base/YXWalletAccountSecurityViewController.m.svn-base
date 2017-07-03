//
//  YXWalletAccountSecurityViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/21.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXWalletAccountSecurityViewController.h"
#import "YXMeMainTableCell.h"
#import "YXMyWalletPassWordViewController.h"
@interface YXWalletAccountSecurityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview;
@end

@implementation YXWalletAccountSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户安全";
    
    self.view.backgroundColor = YXBackMainColor;
    
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = [self creatHeaderView];
}
-(UIView *)creatHeaderView{
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 10)];
    headerview.backgroundColor = YXBackMainColor;
    return headerview;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    YXMyWalletPassWordViewController *passwordvc = [[YXMyWalletPassWordViewController alloc]init];
    passwordvc.CurrenPassWordType = ModifyPayPasswordType;
    [self.navigationController pushViewController:passwordvc animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    YXMeMainTableCell *cellview = [[YXMeMainTableCell alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 50)];
    cellview.cellname = @"修改支付密码";
    [cell.contentView addSubview:cellview];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 50;
        _tableview.backgroundColor = YXBackMainColor;
    }
    return _tableview;
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
