//
//  YXImmediatelyMailExpressController.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXImmediatelyMailExpressController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXImmediatelyMailExpressModel.h"

@interface YXImmediatelyMailExpressController ()

/**
 快递公司列表
 */
@property (nonatomic, strong) NSArray *expressListArray;

@end

@implementation YXImmediatelyMailExpressController

- (void)setExpressListArray:(NSArray *)expressListArray
{
    _expressListArray = expressListArray;
    
    [self.tableView reloadData];
}

#pragma mark - 控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadNetData];
}

#pragma mark - 网络请求

- (void)loadNetData
{
    //** 获取快递公司 */
    [[YXMyAccountNetRequestTool sharedTool] getExpressListSuccess:^(id objc, id respodHeader) {
        
        self.expressListArray = [YXImmediatelyMailExpressModel mj_objectArrayWithKeyValuesArray:objc];
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.expressListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"express" forIndexPath:indexPath];
    
    UILabel *label = [cell viewWithTag:1001];
    label.text = [self.expressListArray[indexPath.row] expressName];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(immediatelyMailExpressController: andSelectedExpressModel:)]) {
        [self.delegate immediatelyMailExpressController:self andSelectedExpressModel:self.expressListArray[indexPath.row]];
    }
}

@end
