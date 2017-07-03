//
//  YXMyAuctionHomeController.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAuctionHomeController.h"
#import "YXMyAuctionSubTableViewController.h"
#import "YXTempView.h"

@interface YXMyAuctionHomeController ()<UIScrollViewDelegate, YXMyAuctionSubTableViewControllerDelegate>

/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;

//** 分类数据数组 */
@property (nonatomic, strong) NSArray *categoryArray;
//** 当前选中标签的索引 */
@property(nonatomic,assign) NSUInteger currentSeleceIndex;

//** 空视图数组 */
@property (nonatomic, strong) NSArray *tempViewArray;
//** 当前页面中的控制器 */
@property (nonatomic, strong) YXMyAuctionSubTableViewController *currentController;

@end

@implementation YXMyAuctionHomeController


#pragma mark - 赋值

//** 切换当前页面 */
- (void)setIndex:(NSInteger)index
{
    _index = index;
    
    //switch (index) {
        //case 2001:
            //[self titleClick:(UIButton *)[self.titlesView viewWithTag:0]];
            //break;
        //case 2002:
            //[self titleClick:(UIButton *)[self.titlesView viewWithTag:1]];
           // break;
        //case 2003:
          //  [self titleClick:(UIButton *)[self.titlesView viewWithTag:2]];
           // break;
            
       //default:
          // break;
   // }
}



#pragma mark - 加载网络数据

- (void)loadNewMySendAuctionData
{
    // 当前的索引
    NSInteger currentIndex = self.contentView.contentOffset.x / self.contentView.width;
    
    YXMyAuctionSubTableViewController *controller = self.childViewControllers[currentIndex];
    controller.loadNewData = YES;
}


#pragma mark - 响应事件


/**
 接收到回调通知
 */
- (void)tempViewEndRefresh
{
    // 当前的索引
    NSInteger currentIndex = self.contentView.contentOffset.x / self.contentView.width;
    YXTempView *tempView = self.tempViewArray[currentIndex];
    [tempView.mj_header endRefreshing];
}

#pragma mark --YXMyAuctionSubTableViewControllerDelegate

- (void)myAuctionSubTableViewController:(YXMyAuctionSubTableViewController *)myAuctionSubTableViewController hiddenTempView:(BOOL)hiddenTempView title:(NSString *)title
{
    if (hiddenTempView) {
        
        if ([title isEqualToString:@"我的关注"]) {
            YXTempView *tempView = self.tempViewArray[0];
            tempView.hidden = YES;
        }else if ([title isEqualToString:@"正在竞拍"]) {
            YXTempView *tempView = self.tempViewArray[1];
            tempView.hidden = YES;
        }else if ([title isEqualToString:@"结束竞拍"]) {
            YXTempView *tempView = self.tempViewArray[2];
            tempView.hidden = YES;
        }
        
    }else{
        
        if ([title isEqualToString:@"我的关注"]) {
            YXTempView *tempView = self.tempViewArray[0];
            tempView.hidden = NO;
        }else if ([title isEqualToString:@"正在竞拍"]) {
            YXTempView *tempView = self.tempViewArray[1];
            tempView.hidden = NO;
        }else if ([title isEqualToString:@"结束竞拍"]) {
            YXTempView *tempView = self.tempViewArray[2];
            tempView.hidden = NO;
        }
    }
}



#pragma mark - 控制器生命周期

- (void)loadView
{
    [super loadView];
    
    // 设置导航栏
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildVces];
    
    // 设置顶部的标签栏
    [self setupTitlesView];
    
    // 底部的scrollView
    [self setupContentView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的关注";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tempViewEndRefresh) name:@"myAuctionEndRefresh" object:nil];
    

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    //** 加载数据 */
    switch (self.index) {
        case 2001:
            [self titleClick:(UIButton *)[self.titlesView viewWithTag:0]];
            break;
        case 2002:
            [self titleClick:(UIButton *)[self.titlesView viewWithTag:1]];
            break;
        case 2003:
            [self titleClick:(UIButton *)[self.titlesView viewWithTag:2]];
            break;
            
        default:
            break;
    }
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        //** 取出控制器加载数据 */
        YXMyAuctionSubTableViewController *controller = (YXMyAuctionSubTableViewController *)self.childViewControllers[i];
        controller.loadNewData = YES;
    }
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tempViewEndRefresh" object:nil];
   
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    for (NSInteger i = 0; i < self.categoryArray.count; i++) {
        YXMyAuctionSubTableViewController *toViewController = [[YXMyAuctionSubTableViewController alloc] init];
        toViewController.title = self.categoryArray[i][@"name"];
        toViewController.delegate = self;
        [self addChildViewController:toViewController];
    }
}

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIScrollView *titlesView = [[UIScrollView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.width = self.view.width;
    titlesView.height = 40;
    titlesView.y = 72;
    titlesView.showsVerticalScrollIndicator = NO;
    titlesView.showsHorizontalScrollIndicator = NO;
    titlesView.layer.cornerRadius = 4;
    titlesView.layer.masksToBounds = YES;
    //[self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor mainThemColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height - 1;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat margin = 12;
    CGFloat width = (self.view.width - ((self.childViewControllers.count + 1) * margin) ) / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * ( width + margin ) + margin;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        //        [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.width;
            self.indicatorView.centerX = button.centerX;
            self.title = button.titleLabel.text;
        }
    }
    
    titlesView.contentSize = CGSizeMake(width * self.categoryArray.count + margin * self.categoryArray.count + 1, 0);
    titlesView.tag = -2;
    [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    self.index = button.tag;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = CGRectMake(0, CGRectGetMaxY(self.titlesView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.titlesView.frame));
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width, 0);
    //contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 * 设置导航栏
 */
- (void)setupNav
{
    // 设置背景色
    self.view.backgroundColor = [UIColor colorWithWhite:249.0/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)tagClick
{
    //    XMGRecommendTagsViewController *tags = [[XMGRecommendTagsViewController alloc] init];
    //    [self.navigationController pushViewController:tags animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.categoryArray.count != 0) {
        // 当前的索引
        NSInteger currentIndex = scrollView.contentOffset.x / scrollView.width;
        
        // 取出子控制器
        YXMyAuctionSubTableViewController *vc = self.childViewControllers[currentIndex];
        vc.view.x = scrollView.contentOffset.x;
        vc.view.y = 64; // 设置控制器view的y值为0(默认是20)
        vc.view.height = scrollView.height - 64; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
//        vc.loadNewData = YES;
//        [scrollView addSubview:vc.view];
//        
//        YXTempView *followAuctionTempView = self.tempViewArray[currentIndex];
//        followAuctionTempView.x = vc.view.x;
//        followAuctionTempView.y = vc.view.y;
//        followAuctionTempView.height = vc.view.height;
//        followAuctionTempView.logImageNamed = @"iconfont-dingdan";
//        
//        [scrollView addSubview:followAuctionTempView];
//        
        [scrollView addSubview:vc.view];
        
        self.currentController.isDisappear = NO;
        vc.isDisappear = YES;
        
        YXTempView *followAuctionTempView = self.tempViewArray[currentIndex];
        followAuctionTempView.x = vc.view.x;
        followAuctionTempView.y = vc.view.y;
        followAuctionTempView.height = vc.view.height;
        followAuctionTempView.logImageNamed = @"iconfont-dingdan";
        
        [scrollView addSubview: followAuctionTempView];
        
        self.currentController = vc;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //1.让我们的标签进行颜色值的变化及缩放
    float value = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    if (value<0 || value>(self.categoryArray.count-1)) return;
    
    //1.1 1
    //2.4 2 =0.4
    //1.左边的索引
    int leftIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //2.右边的索引=左边的索引 + 1;
    int rightIndex = leftIndex + 1;
    
    UIButton *leftButton = self.titlesView.subviews[leftIndex];
    UIButton *rightButton = self.titlesView.subviews[rightIndex];
    
    //3.右边的比率
    CGFloat rightScale = value - leftIndex;
    //4.左边的比率
    CGFloat leftScale = 1- rightScale;
    
    if (rightScale > leftScale) {
        // 修改按钮状态
        self.selectedButton.enabled = YES;
        rightButton.enabled = NO;
        self.selectedButton = rightButton;
        self.index = rightButton.tag;
        
        // 动画
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.width = rightButton.width;
            self.indicatorView.centerX = rightButton.centerX;
        }];
    }else{
        // 修改按钮状态
        self.selectedButton.enabled = YES;
        leftButton.enabled = NO;
        self.selectedButton = leftButton;
        self.index = leftButton.tag;
        
        // 动画
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.width = leftButton.width;
            self.indicatorView.centerX = leftButton.centerX;
        }];
    }
}

#pragma mark - 懒加载

- (NSArray *)categoryArray
{
    if (!_categoryArray) {
        //_categoryArray = @[@{@"name":@"我的关注"},
          //                 @{@"name":@"正在竞拍"},
            //               @{@"name":@"结束竞拍"}];
        _categoryArray = @[@{@"name":@"我的关注"}];
    }
    return _categoryArray;
}

- (NSArray *)tempViewArray
{
    if (!_tempViewArray) {
        NSMutableArray *tempArrayM = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            YXTempView *followAuctionTempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
            
            //** 配置空视图下拉加载数据 */
            followAuctionTempView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMySendAuctionData)];
            followAuctionTempView.mj_header.automaticallyChangeAlpha = YES;
            
            [tempArrayM addObject:followAuctionTempView];
        }
        _tempViewArray = tempArrayM.copy;
    }
    return _tempViewArray;
}

@end
