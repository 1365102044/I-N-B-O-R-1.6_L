//
//  YXResetPassWordViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/22.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXResetPassWordViewController.h"
#import "YXMeMainTableCell.h"
#import "YXBankCardInformationController.h"
#import "YXSaveLoginDataTool.h"
static NSString *resetpasswordinfit = @"resetpasswordinfit";
@interface YXResetPassWordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong ,nonatomic) UITableView *tableview;
@property(nonatomic,strong) NSArray* dataArr;
@end

@implementation YXResetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"重置支付密码";
    self.view.backgroundColor = YXBackMainColor;
    
    self.dataArr = @[@"忘记支付密码了，绑定新卡找回",@"忘记支付密码了，绑定已绑卡找回"];
    
    [self.view addSubview:self.tableview];
    
    self.tableview.tableFooterView = [self addfooterView];
    self.tableview.tableHeaderView = [self creatHeaderView];
}
-(UIView *)creatHeaderView{
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 10)];
    headerview.backgroundColor = YXBackMainColor;
    return headerview;
}
-(UIView *)addfooterView
{
    UIView *footerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 100)];
    footerview.backgroundColor = [UIColor clearColor];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, YXScreenW-30, 40)];
    lable.numberOfLines = 2;
    lable.text = @"通过绑定新卡找回密码时，原先已绑定卡将自动解除";
    lable.textColor = UIColorFromRGB(0x999999);
    lable.font = YXSFont(13);
    [footerview addSubview:lable];
    
    return footerview;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resetpasswordinfit];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resetpasswordinfit];
    }
    YXMeMainTableCell*cellview = [[YXMeMainTableCell alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 50)];
    cellview.cellname = self.dataArr[indexPath.row];
    [cell.contentView addSubview:cellview];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    YXBankCardInformationController *addvc = [YXBankCardInformationController bankCardInformationControllerWithType:YXBankCardInformationControllerAddBankCard cardholderName:[[YXSaveLoginDataTool shared] getRealName] cardNumber:nil extend:@2];
    [self.navigationController pushViewController:addvc animated:YES];
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 50;
        _tableview.backgroundColor = YXBackMainColor;
    }
    return _tableview;
}

@end
