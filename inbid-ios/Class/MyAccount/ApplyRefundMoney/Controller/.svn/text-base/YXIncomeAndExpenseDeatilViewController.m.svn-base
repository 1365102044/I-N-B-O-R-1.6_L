
//
//  YXIncomeAndExpenseDeatilViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXIncomeAndExpenseDeatilViewController.h"
#import "YXIncomeAndExpenseDeatilView.h"
#import "YXApplyRefundRequestTool.h"
#import "YXApplyRefundSultModle.h"

@interface YXIncomeAndExpenseDeatilViewController ()
@property(nonatomic,strong) YXIncomeAndExpenseDeatilView * IncomAndExpView;
@property(nonatomic,strong) YXApplyRefundSultModle * refundDeatilModle;

@end

@implementation YXIncomeAndExpenseDeatilViewController


-(void)LoadRefundMondyDeatilData
{
    [[YXApplyRefundRequestTool sharedTool] LoadRefundMoneyDeatilDataWith:self.orderId Success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
//            YXLog(@"====tuikuanixangqign==%@",objc);
            
            self.refundDeatilModle = [YXApplyRefundSultModle mj_objectWithKeyValues:objc];
            self.IncomAndExpView.RefundDeatilModle = self.refundDeatilModle;
            
        }else{
            
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"退款详情";

    self.tableview.tableHeaderView = self.IncomAndExpView;
    [self LoadRefundMondyDeatilData];
    
}



/**
 懒加载
 */
-(YXIncomeAndExpenseDeatilView *)IncomAndExpView
{
    if (!_IncomAndExpView) {
        _IncomAndExpView = [[YXIncomeAndExpenseDeatilView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 445)];
        
    }
    return  _IncomAndExpView;
}

@end
