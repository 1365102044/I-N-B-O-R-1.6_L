//
//  YXHomePageGoodListCollectionView.m
//  YXHomePageController
//
//  Created by 郑键 on 16/9/8.
//  Copyright © 2016年 郑键. All rights reserved.
//

#import "YXHomePageGoodListCollectionView.h"
#import "YXHomePageNetRequestTool.h"
#import "NSDate+YXExtension.h"
#import "YXHomePageGoodList.h"
#import "YXGoodCell.h"
#import "YXHomePageGoodClassification.h"
#import "YXNoMoreDataFooterView.h"
#import "YXHomePageMainDataModel.h"
#import "YXSearchModle.h"
#import "YXSearchBrandsModle.h"
#import "YXMyQuerProdBidListCountTime.h"
#import "YXHomePageScreenViewModel.h"
#import "YXOneMouthPriceDeatilViewController.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>


NSInteger const kYXHomePageLoadDataPageSize = 8;


@interface YXHomePageGoodListCollectionView ()<YXWaterflowLayoutDelegate, YXGoodCellDelegate>

//** 缓存对应Label的数组 */
@property (nonatomic, strong) NSMutableDictionary *catoryGoodListDictM;
//** 总数据数组 */
@property (nonatomic, strong) NSMutableArray *allPageGoodListArray;
//** 分页数据 */
@property (nonatomic, strong) NSMutableArray *pageGoodListArray;
//** 上拉记录当前页 */
@property (nonatomic, assign) NSInteger pullUpCurPage;
//** 用户离开界面时的屏幕内数据页数 */
@property (nonatomic, assign) NSInteger userDisspaerCurPage;
//** 总数据 */
@property (nonatomic, assign) NSInteger totalRows;
//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;
//** layout */
@property (nonatomic, strong) YXWaterfallFlowLayout *fallFlowLayoutLarge;
@property (nonatomic, strong) YXWaterfallFlowLayoutSmall *fallFlowLayoutSmall;
//** 记录当前layout状态 */
@property (nonatomic, assign) BOOL isScale;
//** 首页的列数 */
@property (nonatomic, assign) NSInteger colCount;
////** 倒计时定时器 */
//@property (nonatomic, strong) NSTimer *countDownTimer;
//** 倒计时模型数组 */
@property (nonatomic, strong) NSMutableArray *countDownTimeModelArray;

/**
 综合排序 1升序
 */
@property (nonatomic, assign) NSInteger upDownTime;

/**
 即将结束时间 2降序
 */
@property (nonatomic, assign) NSInteger endTime;

/**
 开拍时间 1升序 2降序
 */
@property (nonatomic, assign) NSInteger startTime;

/**
 最新发布 2降序
 */
@property (nonatomic, assign) NSInteger creatTime;

/**
 价格类型 1升序 2降序
 */
@property (nonatomic, assign) NSInteger priceType;

/**
 分类id
 */
@property (nonatomic, assign) long long categoryId;

/**
 品牌id
 */
@property (nonatomic, assign) long long brandId;

@end



static NSString * const kYXHomePageGoodListCellReuseIdentifier = @"kYXHomePageGoodListCellReuseIdentifier";


@implementation YXHomePageGoodListCollectionView


#pragma mark - 响应事件

- (void)pinchGesture:(UIPinchGestureRecognizer *)pinchGesture
{
    //是否缩放
    BOOL isScale = NO;
    
    if (pinchGesture.scale > 1) {
        isScale = YES;
    }else{
        isScale = NO;
    }
    YXGoodCell *cell;
    if ([self.collectionView visibleCells].count >= 3) {
        cell = [self.collectionView visibleCells][2];
    }else{
        cell = [self.collectionView visibleCells].firstObject;
    }
    
    [self goodCell:cell isScalItem:isScale];
}


#pragma mark - 赋值

/**
 价格筛选条件

 @param selectedPriceType selectedPriceType
 */
- (void)setSelectedPriceType:(NSInteger)selectedPriceType
{
    
    NSInteger temp = 0;
    self.upDownTime = temp;
    self.endTime = temp;
    self.startTime = temp;
    self.creatTime = temp;
    self.priceType = temp;
    self.categoryId = temp;
    
    _selectedPriceType = selectedPriceType;
    
    if (selectedPriceType == 0) {
        return;
    }else if (selectedPriceType == 1) {
        self.priceType = selectedPriceType;
    }else if (selectedPriceType == 2) {
        self.priceType = selectedPriceType;
    }
    
    [self loadUserDisppaerCurPageData];
}

/**
 筛选条件，网络请求

 @param screenModel screenModel
 */
- (void)setScreenModel:(YXHomePageScreenViewModel *)screenModel
{
    _screenModel = screenModel;
    
    //** 清空条件 */
    [self clearScreenViewCondition];
    
    //** 确定条件 */
    if ([screenModel.catName isEqualToString:@"综合排序"]) {
        self.upDownTime = 1;
    }else if([screenModel.catName isEqualToString:@"即将结束"]) {
        self.endTime = 2;
    }else if([screenModel.catName isEqualToString:@"即将开始"]) {
        self.startTime = 1;
    }else{
        self.categoryId = screenModel.catId;
    }
    
    //** 网络请求 */
    [self loadUserDisppaerCurPageData];
}

/**
 清空筛选条件
 */
- (void)clearScreenViewCondition
{
    NSInteger temp = 0;
    self.upDownTime = temp;
    self.endTime = temp;
    self.startTime = temp;
    self.creatTime = temp;
    self.priceType = temp;
    self.categoryId = temp;
    self.selectedPriceType = temp;
}

/**
 是否倒计时setter方法

 @param isCountDown isCountDown
 */
-(void)setIsCountDown:(BOOL)isCountDown
{
//    _isCountDown = isCountDown;
//    if (isCountDown) {
//        //** 刷新当前时间数组，更新倒计时 */
//        for (NSInteger i = 0; i < self.countDownTimeModelArray.count; i++) {
//            YXMyQuerProdBidListCountTime *timeLabel = self.countDownTimeModelArray[i];
//            [timeLabel countDown];
//        }
//        //** 通知cell倒计时 */
//        [[NSNotificationCenter defaultCenter] postNotificationName:kYXMyAuctionControllerCountDownTimerNotification object:nil userInfo:nil];
//    }
}

- (void)setIsDisappear:(BOOL)isDisappear
{
    _isDisappear = isDisappear;
    
    if (isDisappear) {
        if (self.userDisspaerCurPage == 0) {
            self.userDisspaerCurPage = 1;
            return;
        }
        
        [self loadUserDisppaerCurPageData];
    }else{
        //记录离开时的页数
        //YXGoodCell *cell = [self.collectionView visibleCells].firstObject;
//        NSIndexPath *currentIndexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
//        YXHomePageGoodList *goodList = self.pageGoodListArray[currentIndexPath.row];
        
        //** 获取当前页码 */
        self.userDisspaerCurPage = 1;
        [self clearScreenViewCondition];
    }
}

- (void)setChangeLayout:(BOOL)changeLayout
{
    _changeLayout = changeLayout;
    
    if (changeLayout) {
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutSmall animated:NO completion:nil];
    }else{
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutLarge animated:NO completion:nil];
    }
    
    [self.collectionView reloadData];
}


#pragma mark - 请求对应的网络数据

//** 下拉刷新 */
- (void)loadNewGoodList
{   
    //** 取消之前的网络请求 */
    [[YXHomePageNetRequestTool sharedTool].operationQueue cancelAllOperations];
    NSInteger curPage = [self.allPageGoodListArray.firstObject curPage] - 1 <= 0 ? 1 : [self.allPageGoodListArray.firstObject curPage] - 1;
    
    if (self.catoryModel) {
        
        [[YXHomePageNetRequestTool sharedTool] loadHomePageGoodListDataWithLabelId:self.catoryModel.labelId
                                                                           curPage:curPage
                                                                          pageSize:kYXHomePageLoadDataPageSize
                                                                        upDownTime:self.upDownTime
                                                                           endTime:self.endTime
                                                                         startTime:self.startTime
                                                                         creatTime:self.creatTime
                                                                         priceType:self.priceType
                                                                        categoryId:self.categoryId
                                                                           brandId:self.brandId
                                                                    isCustomeLabel:NO
                                                                           success:^(id objc, id respodHeader) {
            
            [self.pageGoodListArray removeAllObjects];
            [self.allPageGoodListArray removeAllObjects];
            [self.countDownTimeModelArray removeAllObjects];
            
            YXHomePageMainDataModel *objcModel = [YXHomePageMainDataModel mj_objectWithKeyValues:objc];
            
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
            [self.allPageGoodListArray addObject:objcModel];
            
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self checkTempViewIsHidden];
            
//            for (YXHomePageGoodList *model in objcModel.dataList) {
//                [self.countDownTimeModelArray addObject: [YXMyQuerProdBidListCountTime timeModelWithTitle:[NSString stringWithFormat:@"%zd", model.prodId] time:(long long)model.surplusBidTime]];
//            }
            
        } failure:^(NSError *error) {
            [self checkTempViewIsHidden];
            [self.collectionView.mj_header endRefreshing];
        }];
    }else{
        
        YXSearchBrandsModle *searchModel = (YXSearchBrandsModle *)self.model;
        [[YXHomePageNetRequestTool sharedTool] loadHomePageGoodListDataWithLabelId:0 curPage:curPage pageSize:kYXHomePageLoadDataPageSize upDownTime:self.upDownTime endTime:self.endTime startTime:self.startTime creatTime:self.creatTime priceType:self.priceType categoryId:self.categoryId brandId:searchModel.brandId.longLongValue isCustomeLabel:YES success:^(id objc, id respodHeader) {
            
            [self.pageGoodListArray removeAllObjects];
            [self.allPageGoodListArray removeAllObjects];
            [self.countDownTimeModelArray removeAllObjects];
            
            YXHomePageMainDataModel *objcModel = [YXHomePageMainDataModel mj_objectWithKeyValues:objc];
            
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
            [self.allPageGoodListArray addObject:objcModel];
            
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self checkTempViewIsHidden];
            
//            for (YXHomePageGoodList *model in objcModel.dataList) {
//                [self.countDownTimeModelArray addObject: [YXMyQuerProdBidListCountTime timeModelWithTitle:[NSString stringWithFormat:@"%zd", model.prodId] time:(long long)model.surplusBidTime]];
//            }
            
        } failure:^(NSError *error) {
            
            [self checkTempViewIsHidden];
            [self.collectionView.mj_header endRefreshing];
            
        }];
        
    }
    
    [self.noMoreDataFooterView removeFromSuperview];
//    [self.collectionView.mj_footer resetNoMoreData];
}

//** 上拉 */
- (void)loadMoreGoodList
{
    //** 取消之前的网络请求 */
    [[YXHomePageNetRequestTool sharedTool].operationQueue cancelAllOperations];
    // 结束下拉
    [self.collectionView.mj_header endRefreshing];

    
    if (self.catoryModel) {
        
        [self.noMoreDataFooterView removeFromSuperview];
        self.pullUpCurPage = [[self.allPageGoodListArray lastObject] curPage] + 1;
        
        [[YXHomePageNetRequestTool sharedTool] loadHomePageGoodListDataWithLabelId:self.catoryModel.labelId curPage:self.pullUpCurPage pageSize:kYXHomePageLoadDataPageSize upDownTime:self.upDownTime endTime:self.endTime startTime:self.startTime creatTime:self.creatTime priceType:self.priceType categoryId:self.categoryId brandId:self.brandId isCustomeLabel:NO success:^(id objc, id respodHeader) {
            
            YXHomePageMainDataModel *objcModel = [YXHomePageMainDataModel mj_objectWithKeyValues:objc];
            
            //判断，当当前页数为最后一页时，关闭刷新
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
                [self.allPageGoodListArray addObject:objcModel];
            }
            self.pullUpCurPage = objcModel.curPage;
            
            [self.collectionView reloadData];
            [self checkTempViewIsHidden];
            
//            for (YXHomePageGoodList *model in objcModel.dataList) {
//                [self.countDownTimeModelArray addObject: [YXMyQuerProdBidListCountTime timeModelWithTitle:[NSString stringWithFormat:@"%zd", model.prodId] time:(long long)model.surplusBidTime]];
//            }
            
        } failure:^(NSError *error) {
            
            [self checkTempViewIsHidden];
            [self.collectionView.mj_footer endRefreshing];
        }];
        
    }else{
        
        [self.noMoreDataFooterView removeFromSuperview];
        self.pullUpCurPage = [[self.allPageGoodListArray lastObject] curPage] + 1;
        
        YXSearchBrandsModle *searchModel = (YXSearchBrandsModle *)self.model;
        [[YXHomePageNetRequestTool sharedTool] loadHomePageGoodListDataWithLabelId:self.catoryModel.labelId curPage:self.pullUpCurPage pageSize:kYXHomePageLoadDataPageSize upDownTime:self.upDownTime endTime:self.endTime startTime:self.startTime creatTime:self.creatTime priceType:self.priceType categoryId:self.categoryId brandId:searchModel.brandId.longLongValue isCustomeLabel:YES success:^(id objc, id respodHeader) {
            
            if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
                
                YXHomePageMainDataModel *objcModel = [YXHomePageMainDataModel mj_objectWithKeyValues:objc];
                
                //判断，当当前页数为最后一页时，关闭刷新
                if (![self checkFooterStateWithObjc:objcModel]) {
                    [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
                    [self.allPageGoodListArray addObject:objcModel];
                }
                self.pullUpCurPage = objcModel.curPage;
                
//                for (YXHomePageGoodList *model in objcModel.dataList) {
//                    [self.countDownTimeModelArray addObject: [YXMyQuerProdBidListCountTime timeModelWithTitle:[NSString stringWithFormat:@"%zd", model.prodId] time:(long long)model.surplusBidTime]];
//                }
            }
            [self.collectionView reloadData];
            [self checkTempViewIsHidden];
            
        } failure:^(NSError *error) {
            
            [self checkTempViewIsHidden];
            [self.collectionView.mj_footer endRefreshing];
        }];
    }
}


/**
 * 时刻监测footer的状态
 */
- (BOOL)checkFooterStateWithObjc:(YXHomePageMainDataModel *)objcModel
{
    //当总数等于当前页面
    if (objcModel.totalRows % kYXHomePageLoadDataPageSize == 0 || objcModel.totalRows < kYXHomePageLoadDataPageSize) {
        if (objcModel.totalRows / kYXHomePageLoadDataPageSize == objcModel.curPage || objcModel.totalRows < kYXHomePageLoadDataPageSize) {
            
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.collectionView.mj_footer.bounds;
            [self.collectionView.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;

            if (self.pullUpCurPage == objcModel.curPage) {
                [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
                [self.allPageGoodListArray addObject:objcModel];
            }
            
//            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            [self.collectionView.mj_footer endRefreshing];
            return YES;
        }else{
            [self.collectionView.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }else{
        if ((objcModel.totalRows - objcModel.totalRows % kYXHomePageLoadDataPageSize) / kYXHomePageLoadDataPageSize + 1 == objcModel.curPage) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.collectionView.mj_footer.bounds;
            [self.collectionView.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            
            if (self.pullUpCurPage == objcModel.curPage) {
                [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
                [self.allPageGoodListArray addObject:objcModel];
            }
            
//            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            [self.collectionView.mj_footer endRefreshing];
            return YES;
        }else{
            [self.collectionView.mj_footer endRefreshing];
            [self.noMoreDataFooterView removeFromSuperview];
            self.noMoreDataFooterView = nil;
            return NO;
        }
    }
}

//** 下拉检测footerView */
- (void)whenDroupDownCheckFooterViewStateWithObjc:(YXHomePageMainDataModel *)objcModel
{
    if (objcModel.totalRows < kYXHomePageLoadDataPageSize) {
        YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
        noMoreDataFooterView.frame = self.collectionView.mj_footer.bounds;
        [self.collectionView.mj_footer addSubview:noMoreDataFooterView];
        _noMoreDataFooterView = noMoreDataFooterView;
    }else{
        [self.collectionView.mj_footer endRefreshing];
        [self.noMoreDataFooterView removeFromSuperview];
        self.noMoreDataFooterView = nil;
    }
}


#pragma mark - YXGoodCellDelegate

- (void)goodCell:(YXGoodCell *)goodCell isScalItem:(BOOL)isScallItem
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:goodCell];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (isScallItem) {
        self.isScale = YES;
        __weak UICollectionViewController *weakSelf = self;
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutSmall animated:NO completion:^(BOOL finished) {
            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        }];
        
        [defaults setBool:isScallItem forKey:@"isDefaultLayout"];
        
    }else{
        self.isScale = NO;
        __weak UICollectionViewController *weakSelf = self;
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutLarge animated:NO completion:^(BOOL finished) {
            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        }];
        [defaults setBool:isScallItem forKey:@"isDefaultLayout"];
    }
    
    if ([self.delegate respondsToSelector:@selector(homePageGoodListChangeLayout:andIsScale:)]) {
        [self.delegate homePageGoodListChangeLayout:self andIsScale:isScallItem];
    }
}


#pragma mark - YXWaterflowLayoutDelegate

- (CGFloat)waterflowLayout:(YXWaterfallFlowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    YXHomePageGoodList *good = self.pageGoodListArray[indexPath.row];
    
    if (good.imageWidth == 0 || good.imageHeight == 0) {
        return itemWidth * 1;
    }
    CGFloat height = 90;
    if (good.goodNameTextHeight < 34) {
        height += 0;
    }else{
        height += 17;
    }
//    YXLog(@"%@-%f-%f", good.prodName,  good.goodNameTextHeight, height);
    return (itemWidth * good.imageHeight / good.imageWidth  + height);
}


- (CGFloat)columnMarginInWaterflowLayout:(YXWaterfallFlowLayout *)waterflowLayout{
    return 15;
}

- (CGFloat)rowMarginInWaterflowLayout:(YXWaterfallFlowLayout *)waterflowLayout{
    return 15;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(YXWaterfallFlowLayout *)waterflowLayout{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}


#pragma mark - 初始化

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self == [super initWithCollectionViewLayout:layout]) {
        YXWaterfallFlowLayout *flowLayout = (YXWaterfallFlowLayout *)layout;
        self.fallFlowLayoutLarge = flowLayout;
        flowLayout.delegate = self;
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    UIPinchGestureRecognizer *pincher = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [self.collectionView addGestureRecognizer:pincher];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YXGoodCell class]) bundle:nil] forCellWithReuseIdentifier:kYXHomePageGoodListCellReuseIdentifier];
    
    [self setupRefresh];
    
    //--读取本地数据，判断使用哪种buju
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isDefaultLayout"]) {
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutSmall animated:YES completion:nil];
    }else{
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutLarge animated:YES completion:nil];
    }
    
    [self regisetNoti];
}

- (void)setupRefresh
{
    self.collectionView.mj_header                                       = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewGoodList)];
    // 自动改变透明度
    self.collectionView.mj_header.automaticallyChangeAlpha              = YES;
    
    [self loadNewGoodList];
    self.collectionView.mj_footer                                       = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreGoodList)];
    self.collectionView.mj_footer.automaticallyChangeAlpha              = YES;
    MJRefreshAutoFooter *autoFooter                                     = (MJRefreshAutoFooter *)self.collectionView.mj_footer;
    autoFooter.triggerAutomaticallyRefreshPercent                       = -100;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.collectionView.contentInset = UIEdgeInsetsMake(99, 0, 108, 0);
    //self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

//** 根据用户离开前的页数获取数据 */
- (void)loadUserDisppaerCurPageData
{
    
    [YXNetworkHUD show];
    
    if (self.catoryModel) {
        
        [[YXHomePageNetRequestTool sharedTool] loadHomePageGoodListDataWithLabelId:self.catoryModel.labelId curPage:self.userDisspaerCurPage pageSize:kYXHomePageLoadDataPageSize upDownTime:self.upDownTime endTime:self.endTime startTime:self.startTime creatTime:self.creatTime priceType:self.priceType categoryId:self.categoryId brandId:self.brandId isCustomeLabel:NO success:^(id objc, id respodHeader) {
            
            [self.pageGoodListArray removeAllObjects];
            [self.allPageGoodListArray removeAllObjects];
            [self.countDownTimeModelArray removeAllObjects];
            
            YXHomePageMainDataModel *objcModel = [YXHomePageMainDataModel mj_objectWithKeyValues:objc];
            
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
            [self.allPageGoodListArray addObject:objcModel];
            
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            
            [self checkTempViewIsHidden];
            [self collectionViewScrollToTopWithData:self.pageGoodListArray];
            
//            for (YXHomePageGoodList *model in objcModel.dataList) {
//                [self.countDownTimeModelArray addObject: [YXMyQuerProdBidListCountTime timeModelWithTitle:[NSString stringWithFormat:@"%zd", model.prodId] time:(long long)model.surplusBidTime]];
//            }
            
        } failure:^(NSError *error) {
            
            [self checkTempViewIsHidden];
            [self.collectionView.mj_header endRefreshing];
            
        }];
        
    }else{
        
        YXSearchBrandsModle *searchModel = (YXSearchBrandsModle *)self.model;
        [[YXHomePageNetRequestTool sharedTool] loadHomePageGoodListDataWithLabelId:0 curPage:self.userDisspaerCurPage pageSize:kYXHomePageLoadDataPageSize upDownTime:self.upDownTime endTime:self.endTime startTime:self.startTime creatTime:self.creatTime priceType:self.priceType categoryId:self.categoryId brandId:searchModel.brandId.longLongValue isCustomeLabel:YES success:^(id objc, id respodHeader) {
            
            [self.pageGoodListArray removeAllObjects];
            [self.allPageGoodListArray removeAllObjects];
            [self.countDownTimeModelArray removeAllObjects];
            
            YXHomePageMainDataModel *objcModel = [YXHomePageMainDataModel mj_objectWithKeyValues:objc];
            
            [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
            
            [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
            [self.allPageGoodListArray addObject:objcModel];
            
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self checkTempViewIsHidden];
            [self collectionViewScrollToTopWithData:self.pageGoodListArray];
            
//            for (YXHomePageGoodList *model in objcModel.dataList) {
//                [self.countDownTimeModelArray addObject: [YXMyQuerProdBidListCountTime timeModelWithTitle:[NSString stringWithFormat:@"%zd", model.prodId] time:(long long)model.surplusBidTime]];
//            }
            
        } failure:^(NSError *error) {
            
            [self checkTempViewIsHidden];
            [self.collectionView.mj_header endRefreshing];
            
        }];
    }
    
    [self.noMoreDataFooterView removeFromSuperview];
//    [self.collectionView.mj_footer resetNoMoreData];
}

/**
 滚动视图
 
 @param data 数据数组
 */
- (void)collectionViewScrollToTopWithData:(NSArray *)data
{
//    if (data && data.count != 0) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
//    }
}

/**
 检测是否有数据，是否显示无数据界面
 */
- (void)checkTempViewIsHidden
{
    if (self.pageGoodListArray.count != 0) {
        if ([self.delegate respondsToSelector:@selector(homePageGoodListCheckData:hiddenTempView:)]) {
            [self.delegate homePageGoodListCheckData:self hiddenTempView:YES];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(homePageGoodListCheckData:hiddenTempView:)]) {
            [self.delegate homePageGoodListCheckData:self hiddenTempView:NO];
        }
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.pageGoodListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXGoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kYXHomePageGoodListCellReuseIdentifier forIndexPath:indexPath];

    cell.good = self.pageGoodListArray[indexPath.item];
    cell.timeModel = self.countDownTimeModelArray[indexPath.item];
    cell.delegate = self;
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YXHomePageGoodList *good = self.pageGoodListArray[indexPath.item];
    //** 判断如果是一口价，进入一口价详情 */
    if (good.bidType == 2) {
        YXOneMouthPriceDeatilViewController *fixDetialViewController = [[YXOneMouthPriceDeatilViewController alloc] init];
        fixDetialViewController.prodId = [NSString stringWithFormat:@"%lld", good.prodId];
        fixDetialViewController.prodBidId = [NSString stringWithFormat:@"%lld", good.prodBidId];
        [self.navigationController pushViewController:fixDetialViewController animated:YES];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(homePageGoodListPushDeatilController:withProdId:withProBidId:)]) {
        [self.delegate homePageGoodListPushDeatilController:self withProdId:good.prodId withProBidId: good.prodBidId];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.catoryModel.currentContentOffsetY = scrollView.contentOffset.y;
    
    //** 监听首页条件筛选控件状态 */
    if ([self.delegate respondsToSelector:@selector(homePageGoodListCheckData:checkScreenSubViewStatus:)]) {
        [self.delegate homePageGoodListCheckData:self checkScreenSubViewStatus:YES];
    }
}

#pragma mark - 懒加载

- (NSMutableArray *)allPageGoodListArray
{
    if (!_allPageGoodListArray) {
        _allPageGoodListArray = [NSMutableArray array];
    }
    return _allPageGoodListArray;
}

- (NSMutableArray *)pageGoodListArray
{
    if (!_pageGoodListArray) {
        _pageGoodListArray = [NSMutableArray array];
    }
    return _pageGoodListArray;
}

- (YXWaterfallFlowLayoutSmall *)fallFlowLayoutSmall
{
    if (!_fallFlowLayoutSmall) {
        //--初始化动画layout
        self.fallFlowLayoutSmall = [[YXWaterfallFlowLayoutSmall alloc] init];
        self.fallFlowLayoutSmall.delegate = self;

    }
    return _fallFlowLayoutSmall;
}

- (NSMutableArray *)countDownTimeModelArray
{
    if (!_countDownTimeModelArray) {
        _countDownTimeModelArray = [NSMutableArray array];
    }
    return _countDownTimeModelArray;
}

/**
 商品购买的时候被挤掉，重新登录后，跳到商品页面
 */
-(void)regisetNoti{
    [YXNotificationTool addObserver:self selector:@selector(FormeloginVcPushGoodsDeatilVcWhenOutOfAccount:) name:@"FormeloginVcPushGoodsDeatilVcWhenOutOfAccount" object:nil];
}
-(void)FormeloginVcPushGoodsDeatilVcWhenOutOfAccount:(NSNotification *)noti{
//    
//    @try {
//        if (noti.userInfo ==nil) {
//            return;
//        }
//        NSString *prodId = noti.userInfo[@"prodId"];
//        NSString *prodBidId = noti.userInfo[@"prodBidId"];
//        YXOneMouthPriceDeatilViewController *fixDetialViewController = [[YXOneMouthPriceDeatilViewController alloc] init];
//        fixDetialViewController.prodId = prodId;
//        fixDetialViewController.prodBidId = prodBidId;
//        [self.navigationController pushViewController:fixDetialViewController animated:NO];
//        
//    } @catch (NSException *exception) {
//        
//    } @finally {
//        
//    }
    
}
@end
