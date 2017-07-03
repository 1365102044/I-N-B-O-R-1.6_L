//
//  YXSendAuctionBranceSelectedTableViewController.m
//  YXSendAuction
//
//  Created by 郑键 on 16/11/14.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXSendAuctionBranceSelectedTableViewController.h"
#import "YXSendAuctionNetworkTool.h"
#import "YXSendAuctionGoodPartsModel.h"
#import "YXNetworkHUD.h"
//** 第三方&系统库 */
#import <ChineseString.h>

@interface YXSendAuctionBranceSelectedTableViewController ()

/**
 分组头数组
 */
@property (nonatomic, strong) NSArray *titleArray;

/**
 品牌数组
 */
@property (nonatomic, strong) NSArray *brandArray;

@end

@implementation YXSendAuctionBranceSelectedTableViewController

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 赋值

 @param brandArray brandArray
 */
- (void)setBrandArray:(NSArray *)brandArray
{
    NSMutableArray *tempArrayM = [NSMutableArray array];
    for (NSInteger i = 0; i < brandArray.count; i++) {
        YXSendAuctionGoodPartsModel *model = brandArray[i];
        [tempArrayM addObject:model.dataValue];
    }
    self.titleArray = [ChineseString IndexArray:tempArrayM];
    _brandArray = [ChineseString LetterSortArray:tempArrayM];
    
    [self.tableView reloadData];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark <UITableViewDataSource>

/**
 返回组

 @param tableView tableView

 @return 组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

/**
 返回行

 @param tableView tableView
 @param section   section

 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.brandArray[section] count];
}

/**
 自定义cell

 @param tableView tableView
 @param indexPath indexPath

 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.brandArray[indexPath.section][indexPath.row];
    return cell;
}

/**
 返回索引内容

 @param tableView tableView

 @return return
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.titleArray;
}

/**
 组头

 @param tableView tableView
 @param section   section

 @return 分类组头
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.titleArray[section];
}

/**
 回调选中的品牌

 @param tableView tableView
 @param indexPath indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.selectedDelegate respondsToSelector:@selector(sendAuctionBranceSelectedTableViewController:andSelectedBrandText:)]) {
        [self.selectedDelegate sendAuctionBranceSelectedTableViewController:self andSelectedBrandText:self.brandArray[indexPath.section][indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self loadGoodBrand];
    //** 设置界面 */
    self.tableView.sectionIndexColor = [UIColor mainThemColor];
    self.navigationItem.title = @"品牌";
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.加载网络数据 

/**
 加载网络数据
 */
- (void)loadGoodBrand
{
    [YXNetworkHUD show];
    [[YXSendAuctionNetworkTool sharedTool] getGoodBranceWithSuccess:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        @try {
          self.brandArray = [YXSendAuctionGoodPartsModel mj_objectArrayWithKeyValuesArray:objc[@"data"]];
        } @catch (NSException *exception) {
            YXLog(@"%@", exception);
        } @finally {
        }
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
    }];
}

#pragma mark - Eighth.懒加载

@end
