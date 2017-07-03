//
//  YXMyPassWordViewController.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/16.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMyPassWordViewController.h"
#import "YXMyAccountThridPartyTableViewCell.h"
#import "YXMyAccountSetPaymengPasswordViewController.h"
#import "YXMyAccountChangePaymentPasswordViewController.h"
#import "YXMyAccountRealNameViewController.h"
#import "YXMyAccoutBindBankCardViewController.h"
#import "YXMyAucctionRealnameAndBindbankCardViewController.h"

@interface YXMyPassWordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview;

@property(nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation YXMyPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    if (self.SourVcEnum == AccountSecurity) {
        self.title = @"账户安全";
        [self.dataArr addObjectsFromArray:@[@"登录密码"]];
        
    }else if(self.SourVcEnum == RealName){
        self.title = @"实名认证";
        [self.dataArr addObjectsFromArray:@[@"实名认证",@"绑定银行卡"]];
    }
    
    [self.view addSubview:self.tableview];
    
    
}




#pragma mark  *** tableview-delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YXMyAccountThridPartyTableViewCell *cell = [[YXMyAccountThridPartyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.namestr = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.SourVcEnum == AccountSecurity) {
        if (indexPath.row == 0) {
//            登录密码
            [self.navigationController pushViewController: [[UIStoryboard storyboardWithName:@"MyInformation" bundle:nil] instantiateViewControllerWithIdentifier:@"loginPwd"] animated:YES];

        }else if (indexPath.row==1){
//            支付密码
            if ([[YXUserDefaults objectForKey:@"isPaymentCode"] integerValue] ==0) {
                
                YXMyAccountSetPaymengPasswordViewController *setpaymentpasswordVC = [[YXMyAccountSetPaymengPasswordViewController alloc]init];
                
                [self.navigationController pushViewController:setpaymentpasswordVC animated:YES];
                
            }else if ([[YXUserDefaults objectForKey:@"isPaymentCode"] integerValue] ==1)
            {
                YXMyAccountChangePaymentPasswordViewController *changepaymentpasswordVC = [[YXMyAccountChangePaymentPasswordViewController alloc]init];
                [self.navigationController pushViewController:changepaymentpasswordVC animated:YES];
            }

        }
        
    }else if (self.SourVcEnum == RealName){
    
        if(indexPath.row ==0){
        //实名认证
            if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"2"]){
                
                YXMyAccountRealNameViewController * realnameVC = [[YXMyAccountRealNameViewController alloc]init];
                realnameVC.realnameStatus = @"REALNAME";
                [self.navigationController pushViewController:realnameVC animated:YES];
                
            }else{
                
                YXMyAccountRealNameViewController * realnameVC = [[YXMyAccountRealNameViewController alloc]init];
                //            realnameVC.realnameStatus = @"NOTREALNAME";
                [self.navigationController pushViewController:realnameVC animated:YES];
            }
            

        }else if (indexPath.row ==1){
        //绑定银行卡
            [self bangdingYinhangka];
        }
    }
}

-(void)bangdingYinhangka
{
    /**
     * 绑定银行卡 0未绑定 1表示绑定
     */
    if([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"cardStatus"]] isEqualToString:@"1"]){
        
        YXMyAccoutBindBankCardViewController * bindbankcardVC = [[YXMyAccoutBindBankCardViewController alloc]init];
        bindbankcardVC.bindbankStatus = @"BINDBANK";
        [self.navigationController pushViewController:bindbankcardVC animated:YES];
        
        
    }else{
        
        /**
         * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
         */
        if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"2"]) {
            
            YXMyAccoutBindBankCardViewController * bindbankcardVC = [[YXMyAccoutBindBankCardViewController alloc]init];
            [self.navigationController pushViewController:bindbankcardVC animated:YES];
            
        }else if([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"0"] || [[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"validateStatus"]] isEqualToString:@"3"]){
            
            YXMyAucctionRealnameAndBindbankCardViewController *allrealnameAndbindbankcardVC = [[YXMyAucctionRealnameAndBindbankCardViewController alloc]init];
            [self.navigationController pushViewController:allrealnameAndbindbankcardVC animated:YES];
        }
    }
}
/**
 懒加载
 */
-(UITableView *)tableview{
    
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 50;
        _tableview.tableFooterView = [[UIView alloc]init];
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

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
