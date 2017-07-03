//
//  YXHomePageController.m
//  HomePage
//
//  Created by 郑键 on 16/9/20.
//  Copyright © 2016年 郑键. All rights reserved.
//

#import "YXHomePageController.h"
#import "UIView+YXExtension.h"
#import "YXHomePageNetRequestTool.h"
#import "YXHomePageGoodClassification.h"
#import "YXHomePageGoodListCollectionView.h"
#import "YXWaterfallFlowLayout.h"
#import "YXConst.h"
#import "YXHomeAuctionDeatilViewCotroller.h"
#import "YXSearchViewController.h"
#import "YXTempView.h"
#import "YXMyLabelController.h"
#import "YXSearchModle.h"
#import "YXSearchBrandsModle.h"
#import "YXChangeLargeOrSmallView.h"
#import "UIImage+YXExtension.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXHomePageBadRequestView.h"
#import "YXHomePageScreenView.h"
#import "YXHomePageScreenSubTableViewController.h"
#import "YXHomePageScreenViewModel.h"
#import <UIButton+WebCache.h>
#import <MJExtension.h>
#import <Photos/Photos.h>
#import "YXSearchTextFiledViewController.h"
#import "YXCheckUpdateView.h"
#import "YXVersionModle.h"
#import "YXPayZBarViewController.h"
#import "YXLoginStatusTool.h"
#import "YXNavigationController.h"
#import "YXLoginViewController.h"
#import "YXAlertViewTool.h"
#import "JPLoader.h"
#import "YXOneMouthPriceDeatilViewController.h"
#import "YXChatViewManger.h"

/**
 价格按钮状态

 - YXHomePagePriceTypeAscending:  升序
 - YXHomePagePriceTypeDescending: 降序
 - YXHomePagePriceTypeNorml:      未选中
 */
typedef NS_ENUM(NSUInteger, YXHomePagePriceTypeStatus) {
    YXHomePagePriceTypeNorml,
    YXHomePagePriceTypeAscending,
    YXHomePagePriceTypeDescending,
};


#define MYBUNDLE_NAME_2   @"ImageResourceBundle.bundle"
#define MYBUNDLE_PATH_2   [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME_2]
#define MYBUNDLE_2        [NSBundle bundleWithPath: MYBUNDLE_PATH_2]

//**去商店 更新**/
static NSString *Itunes_URL = @"itms-apps://itunes.apple.com/gb/app/yi-dong-cai-bian/id1174267701?mt=8";

//** 综合选择器高度 */
CGFloat kYXHomePageAllSelectedScreenViewHeight                  = 117.0f;
//** 品类选择器高度 */
CGFloat kYXHomePageCategorySelectedScreenViewHeight             = 117.0f;
//** 视图切换选择器高度 */
CGFloat kYXHomePageChangeLayoutViewHeight                       = 90.5f;

@interface YXHomePageController ()<UIScrollViewDelegate, YXHomePageGoodListCollectionViewDelegate, YXChangeLargeOrSmallViewDelegate, YXHomePageBadRequestViewDelegate, YXHomePageScreenViewDelegate, YXHomePageScreenSubTableViewControllerDelegate>


/**
 标签栏底部的红色指示器
 */
@property (nonatomic, weak) UIView *indicatorView;

/**
 当前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedButton;

/**
 顶部的所有标签
 */
@property (nonatomic, weak) UIScrollView *titlesView;

/**
 底部的所有内容
 */
@property (nonatomic, weak) UIScrollView *contentView;

/**
 分类数据数组
 */
@property (nonatomic, strong) NSArray *categoryArray;

/**
 当前选中标签的索引
 */
@property(nonatomic, assign) NSUInteger currentSeleceIndex;

/**
 当前页面中的控制器
 */
@property (nonatomic, strong) YXHomePageGoodListCollectionView *currentGoodListController;

/**
 空视图数组
 */
@property (nonatomic, strong) NSArray *tempViewArray;

/**
 切换大小图控件
 */
@property (nonatomic, strong) UIView *selectLargeOrSmall;

/**
 切换大小视图的控件
 */
@property (nonatomic, strong) YXChangeLargeOrSmallView *changeLargeOrSmallView;

/**
 刷新标志
 */
@property (nonatomic, assign) NSInteger indecatorNumber;

/**
 请求失败视图
 */
@property (nonatomic, strong) YXHomePageBadRequestView *badRequestView;

/**
 条件筛选视图
 */
@property (nonatomic, strong) YXHomePageScreenView *screenView;

/**
 初始化筛选条件按钮数组
 */
@property (nonatomic, strong) NSArray *screenViewInitArray;

/**
 综合分类筛选控件
 */
@property (nonatomic, strong) YXHomePageScreenSubTableViewController *comprehensiveController;

/**
 品类分类筛选控件
 */
@property (nonatomic, strong) YXHomePageScreenSubTableViewController *categoryController;

/**
 条件筛选当前选中button
 */
@property (nonatomic, assign) NSInteger screenViewCurrentButtonTag;

/**
 品类条件筛选器高度
 */
@property (nonatomic, assign) CGFloat categoryTableViewHeight;

///**
// 倒计时定时器
// */
//@property (nonatomic, strong) NSTimer *countDownTimer;

/**
 价格按钮状态
 */
@property (nonatomic, assign) YXHomePagePriceTypeStatus priceTypeStatus;

@property(nonatomic,strong) YXCheckUpdateView * CheckUpdateView;
@property(nonatomic,strong) YXVersionModle * myversionModle;
@property(nonatomic,assign) BOOL  isNeedRemoveNaviTitleView;

@end

@implementation YXHomePageController

#pragma mark -- YXHomePageScreenSubTableViewControllerDelegate

/**
 点击筛选条件

 @param homePageScreenSubTableViewController homePageScreenSubTableViewController
 @param currentType                          currentType
 @param selectedScreenViewModel              selectedScreenViewModel
 */
- (void)homePageScreenSubTableViewController:(YXHomePageScreenSubTableViewController *)homePageScreenSubTableViewController
                              andCurrentType:(kYXHomePageScreenSubTableViewType)currentType
                  andSelectedScreenViewModel:(YXHomePageScreenViewModel *)selectedScreenViewModel
{
    [self resetSelected];
    //** 1.将条件告诉当前界面中的子控制器 2.给筛选器赋值，展示选中条件，并切换选中状态 3.收起筛选控件 */
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    YXHomePageGoodListCollectionView *currentController = self.childViewControllers[index];
    currentController.screenModel = selectedScreenViewModel;
    
    if (currentType == kYXHomePageScreenSubTableViewComprehensive) {
        self.screenView.selectedButtonTag = 1;
    }else{
        self.screenView.selectedButtonTag = 3;
    }
    self.screenView.catName = selectedScreenViewModel.catName;
    
    [self checkScreenSubViewStatus];
}

#pragma mark -- YXHomePageGoodListCollectionViewDelegate

- (void)homePageGoodListCheckData:(YXHomePageGoodListCollectionView *)goodListCollectionView
                   hiddenTempView:(BOOL)hiddenTempView
{
    if (hiddenTempView) {
        
        YXTempView *tempView = self.tempViewArray[goodListCollectionView.controllerIndex];
        tempView.hidden = YES;
    }else{
        
        YXTempView *tempView = self.tempViewArray[goodListCollectionView.controllerIndex];
        tempView.hidden = NO;
    }
}

- (void)changeLargeOrSmallView:(YXChangeLargeOrSmallView *)changeLargeOrSmallView
                andClickButton:(UIButton *)btn
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([btn.titleLabel.text isEqualToString:@"大图模式"]) {
        for (YXHomePageGoodListCollectionView *collectionView in self.childViewControllers) {
            collectionView.changeLayout = YES;
            YXHomePageGoodListCollectionView *collectionController = self.childViewControllers[0];
            [collectionController.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
            [defaults setBool:YES forKey:@"isDefaultLayout"];
        }
    }else{
        for (YXHomePageGoodListCollectionView *collectionView in self.childViewControllers) {
            collectionView.changeLayout = NO;
            [defaults setBool:NO forKey:@"isDefaultLayout"];
        }
    }
    
    //** 收起切换大小图控件 */
    [UIView animateWithDuration:0.25 animations:^{
        _changeLargeOrSmallView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame) - kYXHomePageChangeLayoutViewHeight, self.view.width, kYXHomePageChangeLayoutViewHeight);
    }];
    
//    YXHomePageGoodListCollectionView *collectionController = self.childViewControllers[0];
//    [collectionController.collectionView setContentOffset:CGPointMake(0, -108) animated:NO];
}

#pragma mark - 赋值

- (void)setCategoryTableViewHeight:(CGFloat)categoryTableViewHeight
{
    _categoryTableViewHeight = categoryTableViewHeight;
    
    [self.view insertSubview:_categoryController.tableView belowSubview:self.titlesView];
}

- (void)setCategoryArray:(NSArray *)categoryArray
{
    _categoryArray = categoryArray;
    
    // 初始化子控制器
    [self setupChildVces];
    
    // 设置顶部的标签栏
    [self setupTitlesView];
    
    // 配置条件筛选控件
    [self setupScreenView];
    
    // 底部的scrollView
    [self setupContentView];
}


/**
 添加定时器
 */
//- (void)creatTimer
//{
//    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer
//                                 forMode:NSRunLoopCommonModes];
//}

#pragma mark - 响应事件

//** 定时器触发事件， 向cell发送通知, 启动倒计时 */
- (void)timerEvent
{
//    for (int i = 0; i < self.childViewControllers.count; i++) {
//        //** 通知所有控制器倒计时 */
//        YXHomePageGoodListCollectionView *homePageGoodListCollectionView = self.childViewControllers[i];
//        homePageGoodListCollectionView.isCountDown = YES;
//    }
}

- (void)closeChangeView:(UIGestureRecognizer *)tap
{
    //** 覆盖切换大小图控件 */
    if (self.changeLargeOrSmallView.y == CGRectGetMaxY(self.screenView.frame)) {
        [UIView animateWithDuration:0.25 animations:^{
            //self.changeLargeOrSmallView.height = self.view.height;
            _changeLargeOrSmallView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame) - kYXHomePageChangeLayoutViewHeight, self.view.width, kYXHomePageChangeLayoutViewHeight);
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            //self.changeLargeOrSmallView.height = 0;
            _changeLargeOrSmallView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame), self.view.width, kYXHomePageChangeLayoutViewHeight);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)searchButtonClick:(UIButton *)sender
{
    
    YXSearchTextFiledViewController *searchVC = [[YXSearchTextFiledViewController alloc]init];
//    YXSearchViewController *searchController = [[YXSearchViewController alloc] init];
//    searchController.title = @"搜索";
    [self.navigationController pushViewController: searchVC  animated:YES];
}

- (void)addMyLabelButtonClick:(UIButton *)sender
{
    YXMyLabelController *labelController = [[YXMyLabelController alloc] init];
    self.indecatorNumber = 1002;
    [self.navigationController pushViewController:labelController animated:YES];
}

#pragma mark --YXHomePageScreenViewDelegate

/**
 条件筛选器按钮点击事件代理

 @param homePageScreenView homePageScreenView
 @param sender             sender
 */
- (void)homePageScreenView:(YXHomePageScreenView *)homePageScreenView
            andClickButton:(UIButton *)sender
{
    if (self.screenViewCurrentButtonTag != sender.tag && self.screenViewCurrentButtonTag != 2) [self checkScreenSubViewStatus];
    
    if (sender.tag == 1) {
        if (_comprehensiveController.tableView.y != CGRectGetMaxY(self.screenView.frame)) {
            [UIView animateWithDuration:0.25 animations:^{
                _comprehensiveController.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame), self.view.width, kYXHomePageAllSelectedScreenViewHeight);
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                _comprehensiveController.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame) - kYXHomePageAllSelectedScreenViewHeight, self.view.width, kYXHomePageAllSelectedScreenViewHeight);
            }];
        }
        self.screenViewCurrentButtonTag = sender.tag;
        return;
    }
    
    if (sender.tag == 2) {
        [self resetSelected];
        self.screenViewCurrentButtonTag = sender.tag;
        //** 价格筛选 */
        NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
        YXHomePageGoodListCollectionView *currentController = self.childViewControllers[index];
        if (self.priceTypeStatus == YXHomePagePriceTypeNorml) {
            self.priceTypeStatus = YXHomePagePriceTypeAscending;
            [sender setImage:[UIImage imageNamed:@"ic_homePageScreenViewPriceType_hig_a"] forState:UIControlStateSelected];
            currentController.selectedPriceType = 1;
        }else if (self.priceTypeStatus == YXHomePagePriceTypeAscending){
            self.priceTypeStatus = YXHomePagePriceTypeDescending;
            [sender setImage:[UIImage imageNamed:@"ic_homePageScreenViewPriceType_hig_d"] forState:UIControlStateSelected];
            currentController.selectedPriceType = 2;
        }else if (self.priceTypeStatus == YXHomePagePriceTypeDescending){
            self.priceTypeStatus = YXHomePagePriceTypeAscending;
            [sender setImage:[UIImage imageNamed:@"ic_homePageScreenViewPriceType_hig_a"] forState:UIControlStateSelected];
            currentController.selectedPriceType = 1;
        }
        return;
    }
    
    if (sender.tag == 3) {

        if (_categoryController.tableView.y != CGRectGetMaxY(self.screenView.frame)) {
            [UIView animateWithDuration:0.25 animations:^{
                _categoryController.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame), _categoryController.tableView.width, self.categoryTableViewHeight);
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                _categoryController.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame) - self.categoryTableViewHeight, _categoryController.tableView.width, self.categoryTableViewHeight);
            }];
        }
        self.screenViewCurrentButtonTag = sender.tag;
        return;
    }
    
    if (sender.tag == 4) {
        //** 判断当前是哪种布局 */
        self.changeLargeOrSmallView.currentButton.enabled = YES;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isDefaultLayout"]) {
            self.changeLargeOrSmallView.largeButton.enabled = NO;
            self.changeLargeOrSmallView.currentButton = self.changeLargeOrSmallView.largeButton;
        }else{
            self.changeLargeOrSmallView.smallButton.enabled = NO;
            self.changeLargeOrSmallView.currentButton = self.changeLargeOrSmallView.smallButton;
        }
        
        //** 覆盖切换大小图控件 */
        if (self.changeLargeOrSmallView.y == CGRectGetMaxY(self.screenView.frame)) {
            [UIView animateWithDuration:0.25 animations:^{
                //self.changeLargeOrSmallView.height = self.view.height;
                _changeLargeOrSmallView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame) - kYXHomePageChangeLayoutViewHeight, self.view.width, kYXHomePageChangeLayoutViewHeight);
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                //self.changeLargeOrSmallView.height = 0;
                _changeLargeOrSmallView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame), self.view.width, kYXHomePageChangeLayoutViewHeight);
            }];
        }
        self.screenViewCurrentButtonTag = sender.tag;
        return;
    }
}

/**
 查看条件筛选是否为展开状态
 */
- (void)checkScreenSubViewStatus
{
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    if (self.childViewControllers.count == 0) return;
    YXHomePageGoodListCollectionView *currentController = self.childViewControllers[index];
    if (currentController.screenModel) {
        currentController.screenModel.isSelected = NO;
    }
    
    if (_comprehensiveController.tableView.y == CGRectGetMaxY(self.screenView.frame)) {
        _comprehensiveController.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame) - kYXHomePageAllSelectedScreenViewHeight, self.view.width, kYXHomePageAllSelectedScreenViewHeight);
        return;
    }
    
    if (_categoryController.tableView.y == CGRectGetMaxY(self.screenView.frame)) {
        _categoryController.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame) - self.categoryTableViewHeight, _categoryController.tableView.width, self.categoryTableViewHeight);
        return;
    }
    
    //** 覆盖切换大小图控件 */
    if (self.changeLargeOrSmallView.y == CGRectGetMaxY(self.screenView.frame)) {
        //self.changeLargeOrSmallView.height = self.view.height;
        _changeLargeOrSmallView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame) - kYXHomePageChangeLayoutViewHeight, self.view.width, kYXHomePageChangeLayoutViewHeight);
        return;
    }
}


#pragma mark --YXHomePageGoodListCollectionViewDelegate

- (void)homePageGoodListCheckData:(YXHomePageGoodListCollectionView *)goodListCollectionView checkScreenSubViewStatus:(BOOL)screenSubViewStatus
{
    if (screenSubViewStatus) {
        [self checkScreenSubViewStatus];
    }
}

- (void)homePageGoodListPushDeatilController:(YXHomePageGoodListCollectionView *)goodListCollectionView withProdId:(long long)proId withProBidId:(long long)proBidId
{
    YXHomeAuctionDeatilViewCotroller *deatilViewController = [[YXHomeAuctionDeatilViewCotroller alloc] init];
    
    deatilViewController.prodId = proId;
//    deatilViewController.ProBidId = [NSString stringWithFormat:@"%zd", proBidId];
    deatilViewController.ProBidId =proBidId;
    deatilViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:deatilViewController animated:YES];
    
    deatilViewController.hidesBottomBarWhenPushed = NO;
}

- (void)homePageGoodListChangeLayout:(YXHomePageGoodListCollectionView *)goodListCollectionView andIsScale:(BOOL)isScale
{
    for (YXHomePageGoodListCollectionView *collectionView in self.childViewControllers) {
        collectionView.changeLayout = isScale;
    }
}

#pragma mark --YXHomePageBadRequestViewDelegate

/**
 重新发起网络请求

 @param homePageBadRequestView homePageBadRequestView
 */
- (void)homePageBadRequestView:(YXHomePageBadRequestView *)homePageBadRequestView
{
    [self loadData];
    [self ChechVersionNumber];
    [[YXChatViewManger sharedChatviewManger] registerCustomSever];
}


#pragma mark - 控制器生命周期

- (void)loadView
{
    [super loadView];
}

/**
 请求网络数据
 */
- (void)loadData
{
    //** 取消之前的网络请求 */
    [[YXHomePageNetRequestTool sharedTool].operationQueue cancelAllOperations];
    //请求分组数据
    [[YXHomePageNetRequestTool sharedTool] loadHomePageGoodClassificationDataWithParams:nil success:^(id objc, id respodHeader) {
        
        NSMutableArray *tempAttayM = [NSMutableArray array];
        
//        YXHomePageGoodClassification *firstModel = [[YXHomePageGoodClassification alloc] init];
//        firstModel.labelId = HOMEPAGEALLLABEL;
//        firstModel.name = @"全部";
//        firstModel.isSelect = 1;
//        
//        [tempAttayM addObject:firstModel];
        
        [tempAttayM addObjectsFromArray:[YXHomePageGoodClassification mj_objectArrayWithKeyValuesArray:objc]];
        [tempAttayM addObjectsFromArray:[self loadLocalData]];
        
        self.categoryArray = tempAttayM.copy;
        
        //** 收起界面 */
        [UIView animateWithDuration:0.25 animations:^{
            self.badRequestView.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self.badRequestView removeFromSuperview];
            }
        }];
        
        
        
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        
        if (!self.categoryArray) {
            [self.view addSubview:self.badRequestView];
        }
        
        [YXNetworkHUD dismiss];
    }];
}

/**
 获取本地数据
 */
- (NSArray *)loadLocalData
{
    //** 获取本地数据 */
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *myLabelListPath = [paths stringByAppendingString:[NSString stringWithFormat:@"/%@_myLabelList.plist", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:myLabelListPath];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置导航栏
    [self setupNav];
    [self loadData];
    /*
     @brief 是否登录，跳个人中心用
     */
    [self chenckLoginStatus];
    //** 加载客服及地址信息 */
    [self loadMyAddress];
    
    //--获取相机权限和相册权限
    [self ZJhaveAlbumAuthority];
    [self canUserCamear];
    //** 打开定时器 */
    //[self creatTimer];
    
    [self ChechVersionNumber];
 
    [self regisetNoti];
}
- (void)loadMyAddress
{
    [[YXMyAccountNetRequestTool sharedTool] mailNowLoadMyAddressWithSuccess:^(id objc, id respodHeader) {
       
        @try {
            if (objc) {
                //** 数据本地化 */
                [YXUserDefaults setObject:objc[@"customerPhone"]
                                   forKey:@"customerPhone"];
                [YXUserDefaults setObject:objc[@"consigneeAddress"]
                                   forKey:@"consigneeAddress"];
                [YXUserDefaults setObject:objc[@"consigneeName"]
                                   forKey:@"consigneeName"];
                [YXUserDefaults setObject:objc[@"consigneePhone"]
                                   forKey:@"consigneePhone"];
                [YXUserDefaults setObject:objc[@"businessTime"]
                                   forKey:@"businessTime"];
                [YXUserDefaults setObject:objc[@"commissionRatio"]
                                   forKey:@"commissionRatio"];
                [YXUserDefaults setObject:objc[@"qrcodePayUrl"]
                                   forKey:@"qrcodePayUrl"];
            }
            
        } @catch (NSException *exception) {
            YXLog(@"%@", exception);
        } @finally {
            [YXNetworkHUD dismiss];
        }
        [YXNetworkHUD dismiss];
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
    }];
    
}


/**
 *  相册的使用权限
 *
 *  @return 是否
 */
-(BOOL)ZJhaveAlbumAuthority{
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = 100;
        [alertView show];
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == 100) {
        
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.indecatorNumber == 1002) {
        [self resetHomePageController];
        [self loadData];
        self.indecatorNumber = 1001;
    }
    self.tabBarController.tabBar.hidden = NO;
      self.navigationController.navigationBar.hidden = NO;
    [YXUserDefaults setValue:nil forKey:@"selectedIDs"];
    [YXUserDefaults setValue:nil forKey:@"selectItemsIDs"];
    
    
 
}

- (void)viewWillDisappear:(BOOL)animated
{
    [YXNetworkHUD dismiss];
    [self checkScreenSubViewStatus];
}

/**
 释放定时器
 */
- (void)cleanTimer
{
    //[self.countDownTimer invalidate];
   // self.countDownTimer = nil;
}

/**
 重置当前控制器
 */
- (void)resetHomePageController
{
    //** 清除子控制器 */
    NSInteger count = self.childViewControllers.count;
    NSMutableArray *tempControllerArray = [NSMutableArray array];
    for (UIViewController *controller in self.childViewControllers) {
        [tempControllerArray addObject:controller];
    }
    
    NSInteger titlesSubViewCount = self.titlesView.subviews.count;
    NSMutableArray *tempTitlesSubViewsArray = [NSMutableArray array];
    for (UIView *view in self.titlesView.subviews) {
        [tempTitlesSubViewsArray addObject:view];
    }
    
    NSInteger subViewsCount = self.view.subviews.count;
    NSMutableArray *tempSubViewsArray = [NSMutableArray array];
    for (UIView *view in self.view.subviews) {
        [tempSubViewsArray addObject:view];
    }
    
    for (NSInteger i = 0; i < count; i++) {
        UIViewController *controller = tempControllerArray[i];
        [controller removeFromParentViewController];
    }
    
    for (NSInteger i = 0; i < titlesSubViewCount; i++) {
        UIView *view = tempTitlesSubViewsArray[i];
        [view removeFromSuperview];
    }
    
    for (NSInteger i = 0; i < subViewsCount; i++) {
        UIView *view = tempSubViewsArray[i];
        [view removeFromSuperview];
    }
    
    //** 清空空视图 */
    self.tempViewArray = nil;
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    if (self.categoryArray.count != 0) {
        for (NSInteger i = 0; i < self.categoryArray.count; i++) {
            
            YXWaterfallFlowLayout *flowLayout = [[YXWaterfallFlowLayout alloc] init];
            YXHomePageGoodListCollectionView *goodListController = [[YXHomePageGoodListCollectionView alloc] initWithCollectionViewLayout:flowLayout];
            
            if ([self.categoryArray[i] isKindOfClass:[YXHomePageGoodClassification class]]) {
                goodListController.title = [self.categoryArray[i] name];
                goodListController.catoryModel = self.categoryArray[i];
            }else if ([self.categoryArray[i] isKindOfClass:[YXSearchModle class]]){
                goodListController.title = [self.categoryArray[i] catName];
                goodListController.model = self.categoryArray[i];
            }else if ([self.categoryArray[i] isKindOfClass:[YXSearchBrandsModle class]]){
                goodListController.title = [self.categoryArray[i] prodBrandName];
                goodListController.model = self.categoryArray[i];
            }
            
            goodListController.controllerIndex = i;
            goodListController.delegate = self;
            [self addChildViewController:goodListController];
        }
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
    titlesView.height = 44;
    titlesView.y = 64;
    titlesView.showsVerticalScrollIndicator = NO;
    titlesView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //** 添加我的标签按钮 */
    UIButton *addMyLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addMyLabelButton setBackgroundImage:[UIImage imageNamed:@"ic_homePage_addMyLabelLight"] forState:UIControlStateNormal];
    addMyLabelButton.width = titlesView.height;
    addMyLabelButton.height = titlesView.height;
    addMyLabelButton.y = titlesView.y;
    addMyLabelButton.x = self.view.width - addMyLabelButton.width;
    [addMyLabelButton addTarget:self action:@selector(addMyLabelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addMyLabelButton];
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    //indicatorView.backgroundColor = [UIColor colorWithRed:159.0/255.0 green:120.0/255.0 blue:65.0/255.0 alpha:1.0];
    indicatorView.backgroundColor = [UIColor mainThemColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat margin = 12;
    CGFloat width = 90;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * ( width + margin ) + margin;
        UIViewController *vc = self.childViewControllers[i];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [button setTitle:vc.title forState:UIControlStateNormal];
        //        [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor mainThemColor] forState:UIControlStateDisabled];
        
        //** 判断当前是哪个模型 */
//        UIColor *imageTintColor = [UIColor colorWithRed:192.0/255.0 green:179.0/255.0 blue:163.0/255.0 alpha:1.0];c
        
        if ([self.categoryArray[i] isKindOfClass:[YXHomePageGoodClassification class]]) {
            YXHomePageGoodClassification *model = self.categoryArray[i];
            UIImage *cachedImage = [UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", model.name]]];
            UIImage *cachedImageHig = [UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_hig", model.name]]];
            if (cachedImage) {
                [button setImage:cachedImage forState:UIControlStateNormal];
                [button setImage:cachedImageHig forState: UIControlStateDisabled];
            }else{
                [button setImage:[UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent: @"默认"]] forState:UIControlStateNormal];
                [button setImage:[UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent: @"默认_hig"]] forState:UIControlStateDisabled];
            }
        }else if ([self.categoryArray[i] isKindOfClass:[YXSearchModle class]]){
            YXSearchModle *model = self.categoryArray[i];
            UIImage *cachedImage = [UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", model.catName]]];
            UIImage *cachedImageHig = [UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_hig", model.catName]]];
            if (cachedImage) {
                [button setImage:cachedImage forState:UIControlStateNormal];
                [button setImage:cachedImageHig forState: UIControlStateDisabled];
            }else{
                [button setImage:[UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent: @"默认"]] forState:UIControlStateNormal];
                [button setImage:[UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent: @"默认_hig"]] forState:UIControlStateDisabled];
            }
        }else if ([self.categoryArray[i] isKindOfClass:[YXSearchBrandsModle class]]){
            YXSearchBrandsModle *model = self.categoryArray[i];
            UIImage *cachedImage = [UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", model.prodBrandName]]];
            UIImage *cachedImageHig = [UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_hig", model.prodBrandName]]];
            if (cachedImage) {
                [button setImage:cachedImage forState:UIControlStateNormal];
                [button setImage:cachedImageHig forState: UIControlStateDisabled];
            }else{
                [button setImage:[UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent: @"默认"]] forState:UIControlStateNormal];
                [button setImage:[UIImage imageWithContentsOfFile:[MYBUNDLE_PATH_2 stringByAppendingPathComponent: @"默认_hig"]] forState:UIControlStateDisabled];
            }
        }
        
        YXLog(@"%@", [MYBUNDLE_PATH_2 stringByAppendingPathComponent: @"默认"]);
       
        button.titleLabel.font = [UIFont systemFontOfSize:14];
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
        }
    }
    
    titlesView.contentSize = CGSizeMake(width * self.categoryArray.count + margin * self.categoryArray.count + 1 + titlesView.height, 0);
    [titlesView addSubview:indicatorView];
}

/**
 配置图片筛选
 */
- (void)setupScreenView
{
    self.screenView.backgroundColor         = [UIColor whiteColor];
    self.screenView.width                   = self.view.width;
    self.screenView.height                  = 39;
    self.screenView.y                       = CGRectGetMaxY(self.titlesView.frame);
    [self.view addSubview:self.screenView];
    [self.view insertSubview:self.changeLargeOrSmallView belowSubview:self.titlesView];
    
    _comprehensiveController = [YXHomePageScreenSubTableViewController initWithDataArray:@[@{@"catName":@"综合排序"},
                                                                                           @{@"catName":@"即将结束"},
                                                                                           @{@"catName":@"即将开始"}]
                                                                                 andType:kYXHomePageScreenSubTableViewComprehensive
                                                                                 andMaxY:CGRectGetMaxY(self.screenView.frame) compliteBlock:nil];
    _comprehensiveController.customDelegate = self;
    
    //** 网络获取分类 */
    [YXHomePageScreenSubTableViewController initWithDataArray:nil
                                                      andType:kYXHomePageScreenSubTableViewCategory
                                                      andMaxY:CGRectGetMaxY(self.screenView.frame) compliteBlock:^(YXHomePageScreenSubTableViewController *controller) {
                                                          _categoryController = controller;
                                                          _categoryController.customDelegate = self;
                                                          self.categoryTableViewHeight = _categoryController.tableView.height;
                                                      }];
    
    [self.view insertSubview:_comprehensiveController.tableView belowSubview:self.titlesView];
}

- (void)titleClick:(UIButton *)button
{   
    [[YXHomePageNetRequestTool sharedTool].operationQueue cancelAllOperations];
    
    // 修改按钮状态
//    self.selectedButton.enabled = YES;
//    button.enabled = NO;
//    self.selectedButton = button;
    if (button.tag == 0) {
        self.selectLargeOrSmall.hidden = NO;
    }else{
        //self.changeLargeOrSmallView.height = 0;
        [UIView animateWithDuration:0.25 animations:^{
            _changeLargeOrSmallView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame), self.view.width, kYXHomePageChangeLayoutViewHeight);
        } completion:^(BOOL finished) {
            if (finished) {
                self.selectLargeOrSmall.hidden = YES;
            }
        }];
    }
    self.contentView.userInteractionEnabled = NO;
    
    if (self.titlesView.contentSize.width >= [UIScreen mainScreen].bounds.size.width) {
        [self scrollTitlesViewWithSelectedButton:button];
    }
    
    // 动画
//    [UIView animateWithDuration:0.25 animations:^{
//        self.indicatorView.width = button.width;
//        self.indicatorView.centerX = button.centerX;
//    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

//** 滚动titleView */
- (void)scrollTitlesViewWithSelectedButton:(UIButton *)sender
{
    self.currentSeleceIndex = self.contentView.contentOffset.x / self.contentView.bounds.size.width;
    
    //2.计算channelScrollView应该滚动的偏移量
    CGFloat needScrollOffsetX = sender.center.x - self.titlesView.bounds.size.width * 0.5;
    
    if (needScrollOffsetX < 0) {
        needScrollOffsetX = 0;
    }
    
    CGFloat maxScrollOffsetX = self.titlesView.contentSize.width - self.titlesView.bounds.size.width ;
    
    if (needScrollOffsetX > maxScrollOffsetX) {
        needScrollOffsetX = maxScrollOffsetX;
    }
    
    [self.titlesView setContentOffset:CGPointMake(needScrollOffsetX, 0) animated:YES];
}

/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
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
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setImage:[UIImage imageNamed:@"tab_soushuo"] forState:UIControlStateNormal];
    [rightButton sizeToFit];
    [rightButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    rightButton.backgroundColor = [UIColor clearColor];
    
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setImage:[UIImage imageNamed:@"ic_homeSanLogin"] forState:UIControlStateNormal];
    [leftButton sizeToFit];
    [leftButton addTarget:self action:@selector(ScanlLoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    leftButton.backgroundColor = [UIColor clearColor];
    
    
    
    UIImageView *logImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    logImageView.tag = 1001;
    self.navigationItem.titleView = logImageView;
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
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        
        // 取出子控制器
        YXHomePageGoodListCollectionView *vc = self.childViewControllers[index];
        vc.view.x = scrollView.contentOffset.x;
        //vc.view.y = self.titlesView.y + self.titlesView.height; // 设置控制器view的y值为0(默认是20)
        vc.view.y = CGRectGetMaxY(self.screenView.frame);
        vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
        vc.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 244, 0);
        [scrollView addSubview:vc.view];
        
        self.currentGoodListController.isDisappear = NO;
        vc.isDisappear = YES;
        
        YXTempView *followAuctionTempView = self.tempViewArray[index];
        followAuctionTempView.x = vc.view.x;
        followAuctionTempView.y = 9;
        followAuctionTempView.height = vc.view.height;
        followAuctionTempView.logImageNamed = @"iconfont-dingdan";
        
        [scrollView addSubview: followAuctionTempView];
        
        //加载数据
        self.currentGoodListController = vc;
        
        //** 恢复用户交互 */
        self.contentView.userInteractionEnabled = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
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
        
        if (self.titlesView.contentSize.width >= [UIScreen mainScreen].bounds.size.width) {
            [self scrollTitlesViewWithSelectedButton:rightButton];
        }
        
        if (rightButton.tag == 0) {
            self.selectLargeOrSmall.hidden = NO;
        }else{
            self.selectLargeOrSmall.hidden = YES;
            _changeLargeOrSmallView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame), self.view.width, kYXHomePageChangeLayoutViewHeight);
        }
        
        // 动画
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.width = rightButton.width;
            self.indicatorView.centerX = rightButton.centerX;
        }];
        
        //** 重置筛选条件内容 */
        [self resetSelected];
    }else{
        // 修改按钮状态
        self.selectedButton.enabled = YES;
        leftButton.enabled = NO;
        self.selectedButton = leftButton;
        
        if (self.titlesView.contentSize.width >= [UIScreen mainScreen].bounds.size.width) {
            [self scrollTitlesViewWithSelectedButton:leftButton];
        }
        
        if (leftButton.tag == 0) {
            self.selectLargeOrSmall.hidden = NO;
        }else{
            self.selectLargeOrSmall.hidden = YES;
            //self.changeLargeOrSmallView.height = 0;
            _changeLargeOrSmallView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame), self.view.width, kYXHomePageChangeLayoutViewHeight);
        }
        
        // 动画
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.width = leftButton.width;
            self.indicatorView.centerX = leftButton.centerX;
        }];
        
        //** 重置筛选条件内容 */
        [self resetSelected];
    }
    
    //** 清空筛选条件按钮选中状态 */
    self.screenView.isClearAllSelectedButton = YES;
    [self checkScreenSubViewStatus];
}

/**
 清空筛选条件
 */
- (void)resetSelected
{
    /**
     综合分类筛选控件
     */
    self.comprehensiveController.isRestSelected = YES;
    
    /**
     品类分类筛选控件
     */
    self.categoryController.isRestSelected = YES;
    
    /**
     筛选控件重置
     */
    self.screenView.isRestCurrentSelected = YES;
}

- (void)chenckLoginStatus
{
    //NSString *usetToken = [YXUserDefaults objectForKey:@"TokenID"];
    NSString *usetToken = [[YXLoginStatusTool sharedLoginStatus] getTokenId];
    if (usetToken) {
        [YXRequestTool requestDataWithType:POST url:@"/api/personal" params:nil success:^(id objc, id respodHeader) {
            
            [YXUserDefaults setObject:[NSString stringWithFormat:@"%@",respodHeader[@"Status"]] forKey:@"FromeMianLoginSatus"];
            
        } failure:^(NSError *error) {
            [YXNetworkHUD dismiss];
        }];
        
    }

}

#pragma mark - 懒加载

- (NSArray *)tempViewArray
{
    if (!_tempViewArray) {
        NSMutableArray *tempArrayM = [NSMutableArray array];
        for (NSInteger i = 0; i < self.categoryArray.count; i++) {
            YXTempView *followAuctionTempView = [[YXTempView alloc] initWithFrame:self.view.bounds];
            followAuctionTempView.hidden = YES;
            [tempArrayM addObject:followAuctionTempView];
        }
        _tempViewArray = tempArrayM.copy;
    }
    return _tempViewArray;
}

- (YXChangeLargeOrSmallView *)changeLargeOrSmallView
{
    if (!_changeLargeOrSmallView) {
        _changeLargeOrSmallView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YXChangeLargeOrSmallView class]) owner:nil options:nil].lastObject;
        _changeLargeOrSmallView.delegate = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeChangeView:)];
        [_changeLargeOrSmallView addGestureRecognizer:tap];
        //** 添加切换大小视图控件 */
        _changeLargeOrSmallView.frame = CGRectMake(0, CGRectGetMaxY(self.screenView.frame) - kYXHomePageChangeLayoutViewHeight, self.view.width, kYXHomePageChangeLayoutViewHeight);
    }
    return _changeLargeOrSmallView;
}

- (YXHomePageBadRequestView *)badRequestView
{
    if (!_badRequestView) {
        _badRequestView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YXHomePageBadRequestView class]) owner:nil options:nil].lastObject;
        _badRequestView.frame = self.view.bounds;
        _badRequestView.delegate = self;
    }
    return _badRequestView;
}

- (YXHomePageScreenView *)screenView
{
    if (!_screenView) {
        _screenView = [YXHomePageScreenView initWithViewsDataArray:self.screenViewInitArray];
        _screenView.delegate = self;
    }
    return _screenView;
}

- (NSArray *)screenViewInitArray
{
    if (!_screenViewInitArray) {
        _screenViewInitArray = @[@{@"title":@"综合",
                                   @"imageNamed":@""},
                                 @{@"title":@"价格",
                                   @"imageNamed":@""},
                                 @{@"title":@"品类",
                                   @"imageNamed":@""},
                                 @{@"title":@"图片模式",
                                   @"imageNamed":@""},];
    }
    return _screenViewInitArray;
}

//- (NSTimer *)countDownTimer
//{
//    if (!_countDownTimer) {
//        _countDownTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
//    }
//    return _countDownTimer;
//}

#pragma mark  *** 版本更新 ***

-(void)ClickCheckViewBtnWithType:(NSString *)type
{
    if([type isEqualToString:@"Later"]){
    
        [self.CheckUpdateView removeFromSuperview];
        self.CheckUpdateView = nil;
    }else if ([type isEqualToString:@"Now"]){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Itunes_URL] options:@{} completionHandler:nil];
    }
    
}

-(void)ChechVersionNumber
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    [[YXHomePageNetRequestTool sharedTool] RequestCheckVersionNumberWithCurrenAppVersion:app_Version success:^(id objc, id respodHeader) {
        
        YXLog(@"+++++++++++update++%@",objc);
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            self.myversionModle = [YXVersionModle mj_objectWithKeyValues:objc];
            self.myversionModle.CurrenVersion = app_Version;
            
            [self loadJSPatchFile:self.myversionModle];
            
            if (self.myversionModle.isUpdate ==2) {
               
                [[UIApplication sharedApplication].keyWindow addSubview:self.CheckUpdateView];
                
                self.CheckUpdateView.versionModle = self.myversionModle;
                __weak typeof(self)weakself = self;
                self.CheckUpdateView.UpdateBlock = ^(NSString *type){
                    [weakself ClickCheckViewBtnWithType:type];
                };
            }
        }
    } failure:^(NSError *error) {
    }];
}

/**
 读取JSPatch补丁文件

 @param versionModel versionModel
 */
- (void)loadJSPatchFile:(YXVersionModle *)versionModel
{
    /**
     *  服务器返回补丁版本为0时，当前应用版本下无补丁
     */
    if (![versionModel.patchVersion isEqualToString:@"0"]) {
        
        /**
         *  与本地保存补丁版本作比较
         */
        if (![versionModel.currentPatchVersion isEqualToString:versionModel.patchVersion]) {
            
            [JPLoader updateToVersion:[[versionModel.patchVersion componentsSeparatedByString:@"."].lastObject integerValue] callback:^(NSError *error) {
                if (!error) {
                    
                    /**
                     *  清除旧补丁文件
                     */
                    [self removeOldJSPatchFile];
                    
                    /**
                     *  截取本地补丁文件的版本号，保存
                     */
                    [YXUserDefaults setObject:versionModel.patchVersion forKey:@"currentPatchVersion"];
                    YXLog(@"%zd", [JPLoader run]);
                }else{
                    YXLog(@"%@", error);
                }
            }];
            
        }else{
            
            /**
             *  加载本地补丁
             */
            if ([JPLoader run]) return;
            [JPLoader updateToVersion:[[versionModel.patchVersion componentsSeparatedByString:@"."].lastObject integerValue] callback:^(NSError *error) {
                if (!error) {
                    
                    /**
                     *  清除旧补丁文件
                     */
                    [self removeOldJSPatchFile];
                    
                    /**
                     *  截取本地补丁文件的版本号，保存
                     */
                    [YXUserDefaults setObject:versionModel.patchVersion forKey:@"currentPatchVersion"];
                    YXLog(@"%zd", [JPLoader run]);
                }else{
                    YXLog(@"%@", error);
                }
            }];
        }
    }
}

/**
 *  清空前面版本的补丁文件
 */
- (void)removeOldJSPatchFile
{
    NSString *scriptDirectory = [self fetchScriptDirectory];
    NSString *scriptPath = [scriptDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"JSPatch_v%@.js", [YXUserDefaults objectForKey:@"currentPatchVersion"]]];
    
    NSFileManager *mgr = [[NSFileManager alloc] init];
    [mgr removeItemAtPath:scriptPath error:nil];
}

/**
 获取补丁路径

 @return 返回补丁路径
 */
- (NSString *)fetchScriptDirectory
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *scriptDirectory = [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"JSPatch/%@/", appVersion]];
    return scriptDirectory;
}


/**
 版本更新view
 */
-(YXCheckUpdateView *)CheckUpdateView
{
    if(!_CheckUpdateView){
        _CheckUpdateView = [[YXCheckUpdateView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, YXScreenH)];
    }
    return _CheckUpdateView;

}

#pragma mark  *** 扫码登录 ***
/**
 扫码登录
 */
-(void)ScanlLoginButtonClick:(UIButton *)sender{
    
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        YXPayZBarViewController *scanloginvc = [[YXPayZBarViewController alloc]init];
                        scanloginvc.vctitle = @"扫一扫";
                        
                        scanloginvc.formePCPayurlBlock = ^(NSString *url){
                            
                            [self requestPCLoginWith:url];
                            
                        };
                        
                        [self.navigationController pushViewController:scanloginvc animated:YES];
                        YXLog(@"主线程 - - %@", [NSThread currentThread]);
                    });
                    YXLog(@"当前线程 - - %@", [NSThread currentThread]);
                    
                    // 用户第一次同意了访问相机权限
                    YXLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    YXLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            
            YXPayZBarViewController *scanloginvc = [[YXPayZBarViewController alloc]init];
            scanloginvc.vctitle = @"扫一扫";
            
            scanloginvc.formePCPayurlBlock = ^(NSString *url){
                
                [self requestPCLoginWith:url];
                
            };
            
            [self.navigationController pushViewController:scanloginvc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            YXLog(@"%@", @"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关");
        } else if (status == AVAuthorizationStatusRestricted) {
            YXLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        YXLog(@"%@", @"未检测到您的摄像头, 请在真机上测试");
    }
    
}


-(void)requestPCLoginWith:(NSString *)url{
    
    [[YXHomePageNetRequestTool sharedTool] RequestScanCodeLoginWith:url success:^(id objc, id respodHeader) {
        
//        YXLog(@"=sancode====%@==",objc);
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            if ([(NSString *)objc isEqualToString:@"登录成功"]) {
                
                //** 登录成功 */
//                [YXAlearMnager ShowAlearViewWith:objc Type:1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }else{
            
            [YXAlearMnager ShowAlearViewWith:objc Type:2];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
/**
 商品购买的时候被挤掉，重新登录后，跳到商品页面
 */
-(void)regisetNoti{
    [YXNotificationTool addObserver:self selector:@selector(FormeloginVcPushGoodsDeatilVcWhenOutOfAccount:) name:@"FormeloginVcPushGoodsDeatilVcWhenOutOfAccount" object:nil];
}
-(void)FormeloginVcPushGoodsDeatilVcWhenOutOfAccount:(NSNotification *)noti{
//    self.isNeedRemoveNaviTitleView = YES;
    
    @try {
        if (noti.userInfo ==nil) {
            return;
        }
        NSString *prodId = noti.userInfo[@"prodId"];
        NSString *prodBidId = noti.userInfo[@"prodBidId"];
        YXOneMouthPriceDeatilViewController *fixDetialViewController = [[YXOneMouthPriceDeatilViewController alloc] init];
        fixDetialViewController.prodId = prodId;
        fixDetialViewController.prodBidId = prodBidId;
        [self.navigationController pushViewController:fixDetialViewController animated:NO];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}
@end
