//
//  YXBiddingRuleViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXBiddingRuleViewController.h"

@interface YXBiddingRuleViewController ()

@end

@implementation YXBiddingRuleViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"竞拍规则";
    
    
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
