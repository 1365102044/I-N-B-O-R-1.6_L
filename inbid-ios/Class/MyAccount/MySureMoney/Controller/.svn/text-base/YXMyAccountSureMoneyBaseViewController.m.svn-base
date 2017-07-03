//
//  YXMyAccountSureMoneyBaseViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountSureMoneyBaseViewController.h"
#import "YXMyOrderTitleMenuView.h"

#import "YXMySureMoneyNoPaymentViewController.h"

#import "YXMySureMoneyInFreezingViewController.h"
#import "YXMySureMoneyThawingViewController.h"

@interface YXMyAccountSureMoneyBaseViewController ()<UIScrollViewDelegate>

@property(strong,nonatomic) YXMyOrderTitleMenuView * titView;

@property(strong,nonatomic) UIScrollView * scrollView;

@end

@implementation YXMyAccountSureMoneyBaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.tabBarController.tabBar.tag) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"我的保证金";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTitleView];
    [self setupChildVC];
    
    
}

#pragma mark  添加titleview视图
-(void)setupTitleView
{
    NSArray *arr = @[@"未付款",@"已解冻",@"冻结中"];
    YXMyOrderTitleMenuView *tv = [[YXMyOrderTitleMenuView alloc] initWithFrame:CGRectMake(0,64, YXScreenW, 55) titleArr:arr type:@""];
    self.titView = tv;
    tv.titleBlock = ^(NSInteger index){
        self.scrollView.contentOffset = CGPointMake(index * YXScreenW, 0);
    };
    
    [self.view addSubview:tv];
    
}

#pragma mark 添加滚动视图
-(void)setupChildVC
{
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.titView.bottom, YXScreenW, YXScreenH)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.contentSize = CGSizeMake(YXScreenW * 3, 1);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
//    [self.scrollView setContentOffset:CGPointMake(YXScreenW * 2, 0) animated:YES];
    
    
    YXMySureMoneyNoPaymentViewController *oneVC = [[YXMySureMoneyNoPaymentViewController alloc]init];
    [self addChildViewController:oneVC];
    [scrollView addSubview:oneVC.view];
    
    YXMySureMoneyInFreezingViewController *twoVC = [[YXMySureMoneyInFreezingViewController alloc]init];
    twoVC.view.x = YXScreenW;
    [self addChildViewController:twoVC];
    [scrollView addSubview:twoVC.view];
    
    YXMySureMoneyThawingViewController *threeVC = [[YXMySureMoneyThawingViewController alloc]init];
    threeVC.view.x = YXScreenW * 2;
    [self addChildViewController:threeVC];
    [scrollView addSubview:threeVC.view];
    
}

#pragma mark 监听滚动事件
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.titView sliderMoveToOffsetX:scrollView.contentOffset.x];
}

@end
