//
//  YXHomePageScreenSubTableViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomePageScreenSubTableViewController.h"
#import "YXHomePageScreenViewModel.h"
#import "YXHomePageNetRequestTool.h"
#import "YXHomePageScreenViewCell.h"

@interface YXHomePageScreenSubTableViewController ()

/**
 综合筛选条件数据源
 */
@property (nonatomic, strong) NSArray *dataArray;

/**
 品类筛选条件数据源
 */
@property (nonatomic, strong) NSArray *categoryArray;

/**
 当前种类
 */
@property (nonatomic, assign) kYXHomePageScreenSubTableViewType currentType;

/**
 当前选中模型
 */
@property (nonatomic, strong) YXHomePageScreenViewModel *currentModel;

@end

@implementation YXHomePageScreenSubTableViewController

//** 重用标志 */
static NSString * const kYXHomePageScreenViewCellReuseIdentifier = @"kYXHomePageScreenViewCellReuseIdentifier";

#pragma mark - Zero.Const

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 清空筛选条件

 @param isRestSelected 是否清空筛选条件
 */
- (void)setIsRestSelected:(BOOL)isRestSelected
{
    _isRestSelected = isRestSelected;
    
    if (isRestSelected) {
        
        if (_currentType == kYXHomePageScreenSubTableViewComprehensive) {
            
            [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YXHomePageScreenViewModel *model = (YXHomePageScreenViewModel *)obj;
                if (model.isSelected) {
                    *stop = YES;
                    if (*stop) {
                        model.isSelected = NO;
                    }
                }
            }];
        }else{
            
            [self.categoryArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YXHomePageScreenViewModel *model = (YXHomePageScreenViewModel *)obj;
                if (model.isSelected) {
                    *stop = YES;
                    if (*stop) {
                        model.isSelected = NO;
                    }
                }
            }];
        }
        
        [self.tableView reloadData];
    }
}

/**
 品类数据

 @param categoryArray categoryArray
 */
- (void)setCategoryArray:(NSArray *)categoryArray
{
    _categoryArray = categoryArray;
    [self.tableView reloadData];
}

/**
 综合数据

 @param dataArray dataArray
 */
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
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
    return 1;
}

/**
 返回行
 
 @param tableView tableView
 @param section   section
 
 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentType == kYXHomePageScreenSubTableViewComprehensive) return self.dataArray.count;
    if (_currentType == kYXHomePageScreenSubTableViewCategory) return self.categoryArray.count;
    return 0;
}

/**
 自定义cell
 
 @param tableView tableView
 @param indexPath indexPath
 
 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXHomePageScreenViewModel *model;
    if (_currentType == kYXHomePageScreenSubTableViewComprehensive) {
        model = self.dataArray[indexPath.row];
    }else{
        model = self.categoryArray[indexPath.row];
    }
    YXHomePageScreenViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYXHomePageScreenViewCellReuseIdentifier forIndexPath:indexPath];
    
    cell.model = model;
    return cell;
}

#pragma mark <UITableViewDelegate>

/**
 点击代理

 @param tableView tableView
 @param indexPath indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentType == kYXHomePageScreenSubTableViewComprehensive) {
        [self didSelectedScreenViewWithModel:self.dataArray[indexPath.row]];
        return;
    }
    
    if (_currentType == kYXHomePageScreenSubTableViewCategory) {
        [self didSelectedScreenViewWithModel:self.categoryArray[indexPath.row]];
        return;
    }
}

/**
 点击的模型

 @param model model
 */
- (void)didSelectedScreenViewWithModel:(YXHomePageScreenViewModel *)model
{
    if (model.isSelected) return;
    self.currentModel.isSelected = NO;
    //** 1.将选中条件展示在筛选控件上 2.收起筛选条件控件 3.网络请求刷新界面数据 4.清空前一个筛选条件*/
    if ([self.customDelegate respondsToSelector:@selector(homePageScreenSubTableViewController:andCurrentType:andSelectedScreenViewModel:)]) {
        [self.customDelegate homePageScreenSubTableViewController:self andCurrentType:_currentType andSelectedScreenViewModel:model];
    }
    
    model.isSelected = YES;
    self.currentModel = model;
    [self.tableView reloadData];
}

#pragma mark - Fifth.控制器生命周期

////** 综合选择器高度 */
//CGFloat kYXHomePageAllSelectedScreenViewHeight = 117.0f;
////** 品类选择器高度 */
//CGFloat kYXHomePageCategorySelectedScreenViewHeight = 117.0f;
////** 视图切换选择器高度 */
//CGFloat kYXHomePageChangeLayoutViewHeight = 90.5f;

/**
 初始化

 @param dataArray dataArray

 @return return 实例
 */
+ (instancetype)initWithDataArray:(NSArray *)dataArray andType:(kYXHomePageScreenSubTableViewType)type
                          andMaxY:(CGFloat)maxY
                    compliteBlock:(void (^)(YXHomePageScreenSubTableViewController *))compliteBlock
{
    __block YXHomePageScreenSubTableViewController *subTableViewController  = [self new];
    subTableViewController.tableView.frame                                  = CGRectMake(0,
                                                                                         maxY - 39.f,
                                                                                         [UIScreen mainScreen].bounds.size.width,
                                                                                         39.f);
    subTableViewController.tableView.backgroundColor                        = [UIColor colorWithWhite:1.0 alpha:0];
    subTableViewController.currentType                                      = type;
    if (type == kYXHomePageScreenSubTableViewComprehensive) {
        subTableViewController.dataArray                                    = [YXHomePageScreenViewModel mj_objectArrayWithKeyValuesArray:dataArray];
        subTableViewController.tableView.frame                              = CGRectMake(0,
                                                                                         maxY - 117.0f,
                                                                                         [UIScreen mainScreen].bounds.size.width,
                                                                                         117.0f);
    }else{
        [[YXHomePageNetRequestTool sharedTool] loadHomePageFirstCategoryListWithSuccess:^(id objc, id respodHeader) {
            subTableViewController.categoryArray = [YXHomePageScreenViewModel mj_objectArrayWithKeyValuesArray:objc];
            subTableViewController.tableView.frame = CGRectMake(0, maxY - subTableViewController.categoryArray.count * 39, [UIScreen mainScreen].bounds.size.width, subTableViewController.categoryArray.count * 39);
            compliteBlock(subTableViewController);
        } failure:^(NSError *error) {
            
        }];
    }
    return subTableViewController;
}

/**
 视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 注册 */
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXHomePageScreenViewCell class]) bundle:nil] forCellReuseIdentifier:kYXHomePageScreenViewCellReuseIdentifier];
    //** 界面样式 */
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 39;
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载


@end
