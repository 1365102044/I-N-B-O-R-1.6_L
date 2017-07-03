//
//  YXMyLabelController.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/22.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyLabelController.h"
#import "YXSearchCollectionReusableView.h"
#import "YXSearchCollectionViewCell.h"
#import "YXSearchModle.h"
#import "YXSearchBrandsModle.h"
#import "YXSearchBrandsCollectionViewCell.h"
#import "YXSearchResultListViewController.h"
#import "YXHomePageController.h"
#import "YXHomeAuctionDeatilViewCotroller.h"

#import "YXMyLabelFirestSectionReusableView.h"
#import "YXMyLabelSecondSectionReusableView.h"
#import "YXMyLabelThirdSectionReusableView.h"
#import "YXMyLabelCell.h"


//** 重用标志 */
static NSString * const kYXMyLabelControllerFirstSectionReusableViewReId = @"kYXMyLabelControllerFirstSectionReusableViewReId";
static NSString * const kYXMyLabelControllerSecondSectionReusableViewReId = @"kYXMyLabelControllerSecondSectionReusableViewReId";
static NSString * const kYXMyLabelControllerThirdSectionReusableViewReId = @"kYXMyLabelControllerThirdSectionReusableViewReId";
static NSString * const kYXMyLabelControllerCellReusableViewReId = @"kYXMyLabelControllerCellReusableViewReId";

//** item宽 */
#define kYXMyLabelItemWidth (([UIScreen mainScreen].bounds.size.width - 2 * (27 + 15)) / 3 )

@interface YXMyLabelController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSMutableArray * searchdata;

@property(nonatomic,strong) NSMutableArray * searchBrandsdata;


@property(nonatomic,strong) UICollectionView * collectview;


@property(nonatomic,assign) NSInteger  currenBrandsindex;

@property(nonatomic,assign) NSInteger currenindex;


/** 多选数组列表*/
@property(nonatomic,strong) NSMutableArray  * selectItemsIDArr;
/** 多选数组列表－－>下面的所有数据 (section == 0)*/
@property(nonatomic,strong) NSMutableArray *allSelectedArr;
/** 多选数组列表－－>下面的所有数据的ID集合 (section == 1)*/
@property(nonatomic,strong) NSMutableArray *selectedIDs;

/* 选择品类的id数组－－－－－*/
@property(strong,nonatomic) NSMutableArray * selectItemsIDs;

/**
 选中的标签数组
 */
@property (nonatomic, strong) NSMutableArray *selectedLabelArray;

@end

@implementation YXMyLabelController

- (NSMutableArray *)selectedLabelArray
{
    if (!_selectedLabelArray) {
        _selectedLabelArray = [NSMutableArray array];
    }
    return _selectedLabelArray;
}

-(NSMutableArray*)searchdata
{
    if (!_searchdata) {
        _searchdata = [NSMutableArray array];
    }
    return _searchdata;
}
- (NSMutableArray *)selectItemsIDArr{
    
    if (!_selectItemsIDArr) {
        
        _selectItemsIDArr = [NSMutableArray array];
    }
    
    return _selectItemsIDArr;
    
}

- (NSMutableArray *)selectedIDs{
    
    if (!_selectedIDs) {
        
        _selectedIDs = [NSMutableArray array];
    }
    
    return _selectedIDs;
    
}

- (NSMutableArray *)selectItemsIDs{
    
    if (!_selectItemsIDs) {
        
        _selectItemsIDs = [NSMutableArray array];
    }
    
    return _selectItemsIDs;
    
}

/**
 返回按钮点击事件
 */
- (void)clickBackBtnItem
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //** 保存我的标签至本地 */
    [self saveSelectedLabelData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 获取本地数据 */
    [self.selectedLabelArray addObjectsFromArray: [self loadLocalData]];
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    self.currenindex = -1;
    
    //** 配置NavigationBar */
    [self setupNavigationBar];
    
    [self addcollectview];
    
    [self requestSearchdata];
    
    
}

/**
 保存数据到本地
 */
- (void)saveSelectedLabelData
{
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *myLabelListPath = [paths stringByAppendingString:[NSString stringWithFormat:@"/%@_myLabelList.plist", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
    [NSKeyedArchiver archiveRootObject:self.selectedLabelArray toFile:myLabelListPath];
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

/**
 添加collectionView
 */
-(void)addcollectview
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.headerReferenceSize = CGSizeMake(YXScreenW, 50);
    layout.minimumLineSpacing = 15.f;
    layout.minimumInteritemSpacing = 27.f;
    
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collectview = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    //代理设置
    collectview.delegate=self;
    collectview.dataSource = self;
    
    //** 注册 */
    [collectview registerNib:[UINib nibWithNibName:NSStringFromClass([YXMyLabelCell class]) bundle:nil] forCellWithReuseIdentifier:kYXMyLabelControllerCellReusableViewReId];
    [collectview registerNib:[UINib nibWithNibName:NSStringFromClass([YXMyLabelFirestSectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kYXMyLabelControllerFirstSectionReusableViewReId];
    [collectview registerNib:[UINib nibWithNibName:NSStringFromClass([YXMyLabelSecondSectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kYXMyLabelControllerSecondSectionReusableViewReId];
    [collectview registerNib:[UINib nibWithNibName:NSStringFromClass([YXMyLabelThirdSectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kYXMyLabelControllerThirdSectionReusableViewReId];
    
    
    collectview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectview];
    self.collectview = collectview;
    self.collectview.allowsMultipleSelection = NO;
    //此处给其增加长按手势，用此手势触发cell移动效果
    if (!SYSTEM_VERSION_LESS_THAN(@"9.0")) {
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        [collectview addGestureRecognizer:longGesture];
    }
}


/**
 返回cell样式

 @param collectionView collectionView
 @param indexPath      下标

 @return 返回cell
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YXMyLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kYXMyLabelControllerCellReusableViewReId forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if ([self.selectedLabelArray[indexPath.item] isKindOfClass:[YXSearchModle class]]) {
            cell.searchModel = self.selectedLabelArray[indexPath.item];
        }else{
            cell.searchBrandModel = self.selectedLabelArray[indexPath.item];
        }
    }else if (indexPath.section == 1) {
        //cell.searchModel = self.searchdata[indexPath.item];
        cell.searchBrandModel = self.searchBrandsdata[indexPath.item];
    }
    
    return cell;
}


/**
 返回多少组

 @param collectionView collectionView

 @return 返回组数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

/**
 返回组对应行

 @param collectionView collectionView
 @param section        组

 @return 返回对应行
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.selectedLabelArray.count;
    }else if (section == 1) {
        //return self.searchdata.count;
        return self.searchBrandsdata.count;
    }
    return 0;
}


/**
 设置collectionView的ItemSize

 @param collectionView       collectionView
 @param collectionViewLayout 布局
 @param indexPath            下标

 @return 返回itemSize大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kYXMyLabelItemWidth, 33);
}


/**
 设置collectionView的组间距

 @param collectionView       collectionView
 @param collectionViewLayout 布局
 @param section              组

 @return 返回间距
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 15, 15);
}


/**
 设置组头组尾的方法

 @param collectionView collectionView
 @param kind           组头组尾
 @param indexPath      下标

 @return 返回组头或组尾
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 0) {
            YXMyLabelFirestSectionReusableView *firstReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kYXMyLabelControllerFirstSectionReusableViewReId forIndexPath:indexPath];
            return firstReusableView;
        }else if (indexPath.section == 1){
            YXMyLabelSecondSectionReusableView *secondReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kYXMyLabelControllerSecondSectionReusableViewReId forIndexPath:indexPath];
            return secondReusableView;
        }
//        else if (indexPath.section == 2){
//            YXMyLabelThirdSectionReusableView *thirdReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kYXMyLabelControllerThirdSectionReusableViewReId forIndexPath:indexPath];
//            return thirdReusableView;
//        }
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
    }
    return nil;
}

/**
 返回组头高度

 @param collectionView       collectionView
 @param collectionViewLayout 布局
 @param section              组

 @return 组头高度
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(self.view.width, 58);
    }else if (section == 1) {
        return CGSizeMake(self.view.width, 110);
    }
//    else if (section == 2) {
//        return CGSizeMake(self.view.width, 38);
//    }
    return CGSizeMake(0, 0);
}

/**
 选中的代理方法

 @param collectionView collectionView
 @param indexPath      下标
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //** 移除数据 */
        if ([self.selectedLabelArray[indexPath.item] isKindOfClass:[YXSearchModle class]]) {
            YXSearchModle *searchModel = self.selectedLabelArray[indexPath.item];
            searchModel.isSelected = NO;
            [self.searchdata addObject:searchModel];
        }else{
            YXSearchBrandsModle *searchBrandsModel = self.selectedLabelArray[indexPath.item];
            searchBrandsModel.isSelected = NO;
            [self.searchBrandsdata addObject:searchBrandsModel];
        }
        [self.selectedLabelArray removeObjectAtIndex:indexPath.item];
        [collectionView reloadData];
        return;
    }
    
//    if (indexPath.section == 1) {
//        //** 向第一组添加数据 */
//        YXSearchModle *searchModel = self.searchdata[indexPath.item];
//        searchModel.isSelected = YES;
//        [self.selectedLabelArray addObject:searchModel];
//        [self.searchdata removeObjectAtIndex:indexPath.item];
//        //** 刷新当前数据 */
//        [collectionView reloadData];
//        return;
//    }
    
    if (indexPath.section == 1) {
        YXSearchBrandsModle *searchBransModel = self.searchBrandsdata[indexPath.item];
        searchBransModel.isSelected = YES;
        //** 向第一组添加数据 */
        [self.selectedLabelArray addObject:searchBransModel];
        [self.searchBrandsdata removeObjectAtIndex:indexPath.item];
        //** 刷新数据 */
        [collectionView reloadData];
        return;
    }
}

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectview indexPathForItemAtPoint:[longGesture locationInView:self.collectview]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectview beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.collectview updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectview]];
            break;
        case UIGestureRecognizerStateEnded:
            
            //移动结束后关闭cell移动
            [self.collectview endInteractiveMovement];
            break;
        default:
            [self.collectview cancelInteractiveMovement];
            break;
    }
}

/**
 是否可以移动

 @param collectionView collectionView
 @param indexPath      下标

 @return 是否
 */
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return YES;
    }else{
        return NO;
    }
}

/**
 移动完成回调

 @param collectionView       collectionView
 @param sourceIndexPath      初始下标
 @param destinationIndexPath 结束时下标
 */
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    
    @try {
        if (destinationIndexPath.section != 0) {
            [self.collectview reloadData];
            return;
        }
        id objc = [self.selectedLabelArray objectAtIndex:sourceIndexPath.item];
        [self.selectedLabelArray removeObject:objc];
        [self.selectedLabelArray insertObject:objc atIndex:destinationIndexPath.item];
    } @catch (NSException *exception) {
        YXLog(@"%@", exception);
    } @finally {
        
    }
}

/*
 @brief 商品品类的数组排序
 */
-(NSMutableArray*)Arrpaixu:(NSMutableArray*)arr
{
    
    NSMutableArray *Allarr = [NSMutableArray array];
    NSMutableArray *hasgoodsarr = [NSMutableArray array];
    NSMutableArray *nohasgoodsarr =[NSMutableArray array];
    for (YXSearchModle *modle in arr) {
        if (modle.hasGoods==1) {
            [hasgoodsarr addObject:modle];
        }else{
            [nohasgoodsarr addObject:modle];
        }
    }
    for (YXSearchModle*modle in hasgoodsarr) {
        [Allarr addObject:modle];
    }
    for (YXSearchModle *modle in nohasgoodsarr) {
        [Allarr addObject:modle];
    }
    return Allarr;
}
/*
 @brief 商品品牌的数组排序
 */
-(NSMutableArray*)bransArrpaixu:(NSMutableArray*)arr
{
    
    NSMutableArray *Allarr = [NSMutableArray array];
    NSMutableArray *hasgoodsarr = [NSMutableArray array];
    NSMutableArray *nohasgoodsarr =[NSMutableArray array];
    for (YXSearchBrandsModle *modle in arr) {
        if (modle.hasGoods==1) {
            [hasgoodsarr addObject:modle];
        }else{
            [nohasgoodsarr addObject:modle];
        }
    }
    for (YXSearchBrandsModle*modle in hasgoodsarr) {
        [Allarr addObject:modle];
    }
    for (YXSearchBrandsModle *modle in nohasgoodsarr) {
        [Allarr addObject:modle];
    }
    return Allarr;
}

/**
 配置navigationBar
 */
-(void)setupNavigationBar
{
    UIButton *leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(clickBackBtnItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftitem;
    //    leftbtn.backgroundColor = [UIColor redColor];
    leftbtn.imageEdgeInsets = UIEdgeInsetsMake(0, -39, 0, 0);
    leftbtn.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    //** 设置标题 */
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"我的标签";
    titleLabel.font = [UIFont systemFontOfSize:17];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark  ------ ************************网络请求*************
-(void)requestSearchdata
{
    [YXNetworkHUD show];
    [[YXHomePageNetRequestTool sharedTool] loadHomePageQueryLabelBrandsWithSuccess:^(id objc, id respodHeader) {
    
        [YXNetworkHUD dismiss];
        NSArray *tempBrandArray = [YXSearchBrandsModle mj_objectArrayWithKeyValuesArray:objc];
        self.searchBrandsdata = [self removeRepeatFromeLocalAndNetDataWithDataArray:tempBrandArray];
        [self.collectview reloadData];
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
    }];
}

/**
 标签去重

 @param dataArray 传入的数组

 @return 与本地数据不重合的数据
 */
- (NSMutableArray *)removeRepeatFromeLocalAndNetDataWithDataArray:(NSArray *)dataArray
{
    //** 品牌 */
    NSMutableArray *searchBrandsTempArray = [NSMutableArray array];
    //** 品类 */
    NSMutableArray *searchTempArray = [NSMutableArray array];
    
    for (id model in [self loadLocalData]) {
        if ([model isKindOfClass:[YXSearchModle class]]) {
            [searchTempArray addObject:model];
        }else{
            [searchBrandsTempArray addObject:model];
        }
    }
    
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:dataArray];
    if ([dataArray.firstObject isKindOfClass:[YXSearchModle class]]) {
        //** 便利本地数据的品类数组 */
        for (YXSearchModle *model in searchTempArray) {
            //** 便利传进来的数组，如果相同不添加 */
            for (YXSearchModle *searchModel in dataArray) {
                if (model.catId == searchModel.catId) {
                    [resultArray removeObject:searchModel];
                    break;
                }
            }
        }
    }else{
        //** 便利本地数据的品类数组 */
        for (YXSearchBrandsModle *model in searchBrandsTempArray) {
            //** 便利传进来的数组，如果相同不添加 */
            for (YXSearchBrandsModle *searchModel in dataArray) {
                if (model.brandId == searchModel.brandId) {
                    [resultArray removeObject:searchModel];
                    break;
                }
            }
        }
    }
    
    return resultArray;
}


@end
