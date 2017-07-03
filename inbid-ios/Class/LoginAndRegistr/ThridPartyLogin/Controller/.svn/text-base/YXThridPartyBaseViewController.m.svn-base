//
//  YXThridPartyBaseViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/3.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXThridPartyBaseViewController.h"

@interface YXThridPartyBaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YXThridPartyBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
   return cell;
}


#pragma mark  *** 懒加载
-(UITableView *)MyTableView
{
    if (!_MyTableView) {
        _MyTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _MyTableView.delegate = self;
        _MyTableView.dataSource = self;
        _MyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _MyTableView.backgroundColor = UIColorFromRGB(0xf9f9f9);
        
    }
    return _MyTableView;
}

@end
