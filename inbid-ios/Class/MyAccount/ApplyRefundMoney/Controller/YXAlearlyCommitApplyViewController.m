//
//  YXAlearlyCommitApplyViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXAlearlyCommitApplyViewController.h"
#import "YXAlearlyCommitApplyView.h"
#import "UIBarButtonItem+Extension.h"
#import "YXOrderDetailViewController.h"
@interface YXAlearlyCommitApplyViewController ()

@property(nonatomic,strong) YXAlearlyCommitApplyView * alearlyCommitApplyView;

@end

@implementation YXAlearlyCommitApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请已提交";
    
    self.tableview.tableHeaderView = self.alearlyCommitApplyView;
    self.alearlyCommitApplyView.refundModle = self.refundModle;
    
    UIBarButtonItem *LeftItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickLeftItem) image:@"矩形-15-拷贝" highImage:@"矩形-15-拷贝"];
    self.navigationItem.leftBarButtonItem = LeftItem;
}

-(void)clickLeftItem
{
    
  YXOrderDetailViewController *orderdeatil =   [YXOrderDetailViewController orderDetailViewControllerWithOrderId:[self.refundModle.orderId longLongValue] andExtend:self];
    [self.navigationController pushViewController:orderdeatil animated:YES];
    
}


/**
 懒加载
 */
-(YXAlearlyCommitApplyView *)alearlyCommitApplyView
{
    if (!_alearlyCommitApplyView) {
          _alearlyCommitApplyView =   [[YXAlearlyCommitApplyView alloc]initWithFrame:self.view.bounds];
        
    }
    return  _alearlyCommitApplyView;
}

@end
