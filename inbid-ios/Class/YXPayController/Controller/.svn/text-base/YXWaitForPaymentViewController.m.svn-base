//
//  YXWaitForPaymentViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/14.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXWaitForPaymentViewController.h"
#import "YXWaitPaymentTopview.h"



@interface YXWaitForPaymentViewController ()

@property(nonatomic,strong) YXWaitPaymentTopview * topview;


@end

@implementation YXWaitForPaymentViewController
-(YXWaitPaymentTopview*)topview
{
    if (!_topview) {
        _topview = [[YXWaitPaymentTopview alloc]initWithFrame:CGRectMake(0, 0+64, YXScreenW, 80)];
        _topview.backgroundColor = [UIColor whiteColor];
    }
    return _topview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"代付款";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
    
}

-(void)setUI{

    [self.view addSubview:self.topview];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
