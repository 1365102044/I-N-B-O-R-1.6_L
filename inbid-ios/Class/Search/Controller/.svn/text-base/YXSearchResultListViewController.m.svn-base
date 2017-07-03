//
//  YXSearchResultListViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/9.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchResultListViewController.h"
#import "YXHomePageGoodList.h"
#import "YXGoodCell.h"
#import "YXWaterfallFlowLayout.h"

#import "YXHomeAuctionDeatilViewCotroller.h"

#import "YXSearchListNoDataView.h"

#import "YXNoMoreDataFooterView.h"

#import "YXHomePageMainDataModel.h"
#import "YXTempView.h"


#import "YXSearchResultListTopBarView.h"
#import "YXMyQuerProdBidListCountTime.h"
#import "YXWaterfallFlowLayoutSmall.h"


#import "YXSearchResultNavTextfiledView.h"
#import "YXSearchModle.h"

#import "YXSearchResultShaixuanTableViewCell.h"
#import "YXChangeCellBigAndSmallView.h"

#import "YXOneMouthPriceDeatilViewController.h"

#define kYXSearchPageGoodListCellReuseIdentifier @"kYXHomePageGoodListCellReuseIdentifier"
#define KYXSearchTopBarViewIdentifier @"KYXSearchTopBarViewIdentifier"

NSInteger const kYXHomePageLoadDataPageSizes = 8;



@interface YXSearchResultListViewController ()<YXWaterflowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UICollectionView * collectionView;

@property(nonatomic,strong) NSMutableArray * resultsearchListArr;



@property(nonatomic,assign) NSInteger pullUpCurPage;

//** 分页数据 */
@property (nonatomic, strong) NSMutableArray *pageGoodListArray;
//** 没有更多数据提示 */
@property (nonatomic, strong) YXNoMoreDataFooterView *noMoreDataFooterView;

@property(nonatomic,strong) YXTempView * tempView;

/*
 @brief topbarview
 */
@property(nonatomic,strong) YXSearchResultListTopBarView * topbarView;

/*
 @brief 筛选的tableview
 */
@property(nonatomic,strong) UITableView * shaixuanTableview;
/*
 @brief 背景视图
 */
@property(nonatomic,strong) UIView * bigbackview;


//导航栏的view
@property(strong,nonatomic) YXSearchResultNavTextfiledView  *searchNavTextfiledView;


/*
 @brief 筛选tablveiw的数据源
 */
@property(nonatomic,strong) NSMutableArray * shaixuanDataArr;

//** 倒计时模型数组 */
@property (nonatomic, strong) NSMutableArray *countDownTimeModelArray;
//** 记录当前layout状态 */
@property (nonatomic, assign) BOOL isScale;
/**
 切换layout
 */
@property (nonatomic, assign) BOOL changeLayout;
//** layout */
@property (nonatomic, strong) YXWaterfallFlowLayout *fallFlowLayoutLarge;
@property (nonatomic, strong) YXWaterfallFlowLayoutSmall *fallFlowLayoutSmall;
/**
 倒计时定时器
 */
@property (nonatomic, strong) NSTimer *countDownTimer;

/*
 @brief 筛选的品类数据
 */
@property(nonatomic,strong) NSMutableArray * PinLeiDadaArr;


/*
 @brief 筛选条view上  选择的Tag
 */
@property(nonatomic,assign) NSInteger  shaixuanTag;

@property(nonatomic,strong) YXChangeCellBigAndSmallView * ChangeCellBigAndSmallView;

/*
 @brief 是否显示筛选条
 */
@property(nonatomic,assign) BOOL  isShowShaiXuanTableviewBool;

/*
 @brief 价格排序
 */
//@property(nonatomic,assign) BOOL  pricePaixuBool;
@property(nonatomic,assign) NSInteger  pricePaixu;

@property(nonatomic,assign) BOOL  kaishiTimeBool;
@property(nonatomic,assign) BOOL  jieshuTimeBool;
@property(nonatomic,strong) NSString * shaixuancatID;


@end

@implementation YXSearchResultListViewController



-(YXChangeCellBigAndSmallView*)ChangeCellBigAndSmallView
{
    if (!_ChangeCellBigAndSmallView) {
        _ChangeCellBigAndSmallView = [[YXChangeCellBigAndSmallView alloc]initWithFrame:CGRectMake(0, 113, YXScreenW, 90)];
        _ChangeCellBigAndSmallView.backgroundColor = [UIColor whiteColor];
    }
    return _ChangeCellBigAndSmallView;
}

- (NSMutableArray *)countDownTimeModelArray
{
    if (!_countDownTimeModelArray) {
        _countDownTimeModelArray = [NSMutableArray array];
    }
    return _countDownTimeModelArray;
}
/*
 @brief 筛选的数据
 */
-(NSMutableArray*)shaixuanDataArr
{
    if (!_shaixuanDataArr) {
        _shaixuanDataArr = [NSMutableArray array];
    }
    return _shaixuanDataArr;
}

/*
 @brief  筛选的tablveiw
 */
-(UITableView*)shaixuanTableview
{
    if (!_shaixuanTableview) {
        
        _shaixuanTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, self.topbarView.bottom, YXScreenW, 200)];
        _shaixuanTableview.delegate = self;
        _shaixuanTableview.dataSource = self;
        _shaixuanTableview.rowHeight = 40;
        _shaixuanTableview.tableFooterView = [[UIView alloc]init];
        
    }
    return _shaixuanTableview;
}



-(YXSearchResultListTopBarView*)topbarView
{
    if (!_topbarView) {
        _topbarView = [[YXSearchResultListTopBarView alloc]initWithFrame:CGRectMake(-1, self.searchNavTextfiledView.bottom, YXScreenW+2, 44)];
        _topbarView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        _topbarView.layer.borderWidth = 0.5;
        _topbarView.backgroundColor = [UIColor whiteColor];
    }
    return _topbarView;
}

- (NSMutableArray *)pageGoodListArray
{
    if (!_pageGoodListArray) {
        _pageGoodListArray = [NSMutableArray array];
    }
    return _pageGoodListArray;
}

- (YXTempView *)tempView
{
    if (!_tempView) {
        _tempView = [[YXTempView alloc] initWithFrame:CGRectMake(0, self.topbarView.bottom, YXScreenW, YXScreenH-self.topbarView.bottom)];
        _tempView.logImageNamed = @"iconfont-shangpin";
        _tempView.tipsText =@"暂时没有相关商品";
    }
    return _tempView;
}


-(NSMutableArray*)resultsearchListArr
{
    if (!_resultsearchListArr) {
        _resultsearchListArr = [NSMutableArray array];
    }
    return _resultsearchListArr;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

    self.searchNavTextfiledView.searchTextFiled.text = nil;
    
    [YXUserDefaults removeObjectForKey:@"selectzognhe"];
    [YXUserDefaults removeObjectForKey:@"selectpinlei"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.searchNavTextfiledView.searchTextFiled.text = self.textstr;
}
/*
 @brief 导航栏
 */
-(YXSearchResultNavTextfiledView*)searchNavTextfiledView
{
    if (!_searchNavTextfiledView) {
        _searchNavTextfiledView = [[YXSearchResultNavTextfiledView alloc]initWithFrame:CGRectMake(0, 0, YXScreenW, 59+10)];
    }
    return _searchNavTextfiledView;
}


#pragma mark  ******************* viewdidload**********************
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    
    //** 打开定时器 */
//    [self creatTimer];
    
    
    __weak typeof(self)weakself=self;
    
    
    /*
     @brief 添加导航栏view
     */
    self.searchNavTextfiledView.backblock = ^(){
        
        [weakself.navigationController popToRootViewControllerAnimated:YES];
    };
    
    self.searchNavTextfiledView.clicktextBlock = ^(){
        
        [YXNotificationTool postNotificationName:@"ISFROMESEARCHRESULTVC" object:nil];
        
        [weakself.navigationController popViewControllerAnimated:NO];
        
    };
    
    
    
    [self.view addSubview:self.searchNavTextfiledView];
    self.searchNavTextfiledView.searchTextFiled.text = self.textstr;
    
    YXLog(@"+++++%@+++2+",self.searchNavTextfiledView.searchTextFiled.text);
    
    [self.view addSubview:self.topbarView];
    
    self.topbarView.BarBtnTagBlock = ^(NSInteger tag){
        
        if(tag == 10)
        {
            weakself.bigbackview.alpha = 0;
            [weakself.shaixuanTableview removeFromSuperview];
            return ;
        }
        
        
        
        weakself.bigbackview.alpha = 0.3;
        [weakself.view addSubview:weakself.shaixuanTableview];
        
        [weakself setShaixuanTableviewData:tag];
        
        /*
         @brief 改变tablview的高度
         */
        if (self.shaixuanDataArr.count>=5) {
            weakself.shaixuanTableview.height = 40*5;
        }else{
            weakself.shaixuanTableview.height = 40*self.shaixuanDataArr.count;
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:weakself action:@selector(clickshaixuanbackviewTap)];
        [weakself.bigbackview addGestureRecognizer:tap];
    };
    
    
    
    
    [self requestsearchListData];
    [self requestshaixuanBrandData];
    
    [self addCollectview];
    
    [self setshaixianBackbigView];
    
    
    
    YXLog(@"+++++%@++++",self.searchNavTextfiledView.searchTextFiled.text);
}




#pragma mark  ******************* 点击筛选 跳的回调**********************
/*
 @brief 更换筛选的数据源
 */
-(void)setShaixuanTableviewData:(NSInteger )tag
{
    
    if(self.shaixuanTag ==tag)
    {
        
        if (self.isShowShaiXuanTableviewBool) {
            
            if (tag!=2) {
                
                self.isShowShaiXuanTableviewBool = NO;
                
                [self clickshaixuanbackviewTap];
                return;
            }
        }else
        {
            self.isShowShaiXuanTableviewBool = YES;
            
        }
        
    }else
    {
        self.isShowShaiXuanTableviewBool = YES;
        
    }
    
    
    self.shaixuanDataArr = nil;
    
    NSArray *arr;
    if (tag==1) {
        
        arr = @[@"综合排序",@"即将结束",@"即将开始"];
        self.shaixuanDataArr = (NSMutableArray*)arr;
        
        
    }else if (tag==2)
    {
        [self hidenshaixuanview];
        
        if(!self.pricePaixu)
        {
            self.pricePaixu = 2;
        }else{
            self.pricePaixu = self.pricePaixu==1?2:1;
        }
        
        self.jieshuTimeBool = NO;
        self.kaishiTimeBool = NO;
        self.shaixuancatID = nil;
        [YXUserDefaults removeObjectForKey:@"selectpinlei"];
        [YXUserDefaults removeObjectForKey:@"selectzognhe"];
        
        [self requestsearchListData];
        
        
    }else if (tag ==3)
    {
        for (YXSearchModle *model in self.PinLeiDadaArr) {
            
            [self.shaixuanDataArr addObject:model.catName];
        }
        
        
    }else if (tag ==4)
    {
        
        
        __weak typeof(self)weakself =self;
        self.ChangeCellBigAndSmallView.changeBlock =^(NSString *tag){
            
            [weakself changecellview:tag];
            
            
            [UIView animateWithDuration:0.25 animations:^{
                
                [weakself clickshaixuanbackviewTap];
            }];
            
        };
        
        
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.view addSubview:self.ChangeCellBigAndSmallView];
            
        } completion:^(BOOL finished) {
            
            
            
        }];
        
        if ([YXUserDefaults boolForKey:@"isSearchDefaultLayout"]) {
            
            self.ChangeCellBigAndSmallView.smallbtn.selected = YES;
            [self.ChangeCellBigAndSmallView.smallbtn setImage:[UIImage imageNamed:@"ic_homePage_small_sel"] forState:UIControlStateSelected];
            [self.ChangeCellBigAndSmallView.Bigbtn setImage:[UIImage imageNamed:@"ic_homePage_small_no"] forState:UIControlStateSelected];
        }else{
            self.ChangeCellBigAndSmallView.Bigbtn.selected = YES;
            [self.ChangeCellBigAndSmallView.Bigbtn setImage:[UIImage imageNamed:@"ic_homePage_large_sel"] forState:UIControlStateSelected];
            [self.ChangeCellBigAndSmallView.smallbtn setImage:[UIImage imageNamed:@"ic_homePage_large_no"] forState:UIControlStateSelected];
        }
        
        
    }
    
    if (tag != 4) {
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.ChangeCellBigAndSmallView removeFromSuperview];
        }];
    }
    self.shaixuanTag = tag;
    [self.shaixuanTableview reloadData];
    
    [YXNotificationTool postNotificationName:@"changeselectTAG" object:nil];
    
    [YXNotificationTool postNotificationName:@"ClickItemTopviewTag" object:nil userInfo:@{@"selecttag":[NSString stringWithFormat:@"%ld",tag],@"paixu": [NSString stringWithFormat:@"%ld",(long)self.pricePaixu] }];
    
}

#pragma mark  ******************* 点击大图小图切换的方法**********************
-(void)changecellview:(NSString *)isscacle
{
    if (self.pageGoodListArray.count==0) {
        
        if ([isscacle isEqualToString:@"small"]) {
            [YXUserDefaults setBool:YES forKey:@"isSearchDefaultLayout"];
        }else{
            [YXUserDefaults setBool:NO forKey:@"isSearchDefaultLayout"];
        }
        
        [self kongzhiShaixuanViewISShow];
        
        return;
    }
    
    
    BOOL iscalcle ;
    
    if ([isscacle isEqualToString:@"small"]) {
        iscalcle = YES;
        
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutLarge animated:NO completion:nil];
        
    }else{
        
        iscalcle = NO;
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutSmall animated:NO completion:nil];
        
    }
    
    [YXUserDefaults setBool:iscalcle forKey:@"isSearchDefaultLayout"];
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                            atScrollPosition:UICollectionViewScrollPositionNone
                                    animated:NO];
    [self kongzhiShaixuanViewISShow];
    
    [self.collectionView reloadData];
    
}

#pragma mark  ******************* 控制筛选视图的出现 和 隐藏的方法**********************
-(void)kongzhiShaixuanViewISShow
{
    if (self.isShowShaiXuanTableviewBool) {
        
        self.isShowShaiXuanTableviewBool = NO;
        
        [self clickshaixuanbackviewTap];
        return;
    }else
    {
        self.isShowShaiXuanTableviewBool = YES;
    }
    
}



#pragma mark  ******************* 隐藏 筛选的 view**********************

-(void)hidenshaixuanview
{
    self.bigbackview.alpha = 0;
    [self.shaixuanTableview removeFromSuperview];
}

/*
 @brief 给筛选tableview底部添加蒙板
 */
-(void)setshaixianBackbigView
{
    UIView *bigbackview = [[UIView alloc]initWithFrame:CGRectMake(0, self.topbarView.bottom, YXScreenW, YXScreenH-self.topbarView.bottom)];
    bigbackview.backgroundColor = [UIColor grayColor];
    bigbackview.alpha = 0;
    self.bigbackview = bigbackview;
    [self.view addSubview:bigbackview];
    
}
/*
 @brief 点击蒙版
 */
-(void)clickshaixuanbackviewTap
{
    [YXNotificationTool postNotificationName:@"changeselectTAG" object:nil];
    [self hidenshaixuanview];
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        //        [self.view sendSubviewToBack:self.ChangeCellBigAndSmallView];
        //        self.ChangeCellBigAndSmallView.height = 0;
        
        [self.ChangeCellBigAndSmallView removeFromSuperview];
    } completion:^(BOOL finished) {
        
    }];
    
    
    
    self.isShowShaiXuanTableviewBool = NO;
    
}

#pragma mark  ******************* 筛选用的tableview  代理方法**********************

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shaixuanDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXSearchResultShaixuanTableViewCell  *cell = [YXSearchResultShaixuanTableViewCell cellWithTableView:tableView indexPath:indexPath];
    
    if (self.shaixuanTag ==1) {
        
        [YXUserDefaults removeObjectForKey:@"selectpinlei"];
        NSString *selsct = [YXUserDefaults objectForKey:@"selectzognhe"];
        if ([self.shaixuanDataArr[indexPath.row] isEqualToString:selsct]) {
            cell.selected = YES;
        }
        cell.textstr = self.shaixuanDataArr[indexPath.row];
        
        
    }else if (self.shaixuanTag ==3)
    {
        NSString *selsct = [YXUserDefaults objectForKey:@"selectpinlei"];
        [YXUserDefaults removeObjectForKey:@"selectzognhe"];
        YXSearchModle *modle = self.PinLeiDadaArr[indexPath.row];
        if ([modle.catName isEqualToString:selsct]) {
            cell.selected = YES;
        }
        cell.modle = self.PinLeiDadaArr[indexPath.row];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.shaixuanTag==1) {
        
        [YXUserDefaults setObject:[self.shaixuanDataArr objectAtIndex:indexPath.row] forKey:@"selectzognhe"];
        if(indexPath.row==0){
            
            self.jieshuTimeBool = NO;
            self.kaishiTimeBool = NO;
            
        }else if (indexPath.row==1) {
            
            self.jieshuTimeBool = YES;
            self.kaishiTimeBool = NO;
            
        }else if (indexPath.row ==2)
        {
            
            self.kaishiTimeBool = YES;
            self.jieshuTimeBool = NO;
        }
        
        self.pricePaixu = 0;
        self.shaixuancatID = nil;
        
        NSArray *arr = @[@"综合",@"结束",@"开始"];
        [YXNotificationTool postNotificationName:@"ChooselItem" object:nil userInfo:@{@"Itemtag":[NSString stringWithFormat:@"%ld",(long)self.shaixuanTag],@"ItemStr":arr[indexPath.row]}];
        
        [YXNotificationTool postNotificationName:@"ClickItemTopviewTag" object:nil userInfo:@{@"selecttag":[NSString stringWithFormat:@"%ld",self.shaixuanTag],@"paixu":@"1"}];
        
    }else if (self.shaixuanTag ==3)
    {
        YXSearchModle *modle = self.PinLeiDadaArr[indexPath.row];
        [YXUserDefaults setObject:modle.catName forKey:@"selectpinlei"];
        
        self.shaixuancatID = [NSString stringWithFormat:@"%lld",modle.catId];
        
        self.kaishiTimeBool = NO;
        self.jieshuTimeBool = NO;
        self.pricePaixu = 0;
        
        [YXNotificationTool postNotificationName:@"ChooselItem" object:nil userInfo:@{@"Itemtag":[NSString stringWithFormat:@"%ld",(long)self.shaixuanTag],@"ItemStr":modle.catName}];
        [YXNotificationTool postNotificationName:@"ClickItemTopviewTag" object:nil userInfo:@{@"selecttag":[NSString stringWithFormat:@"%ld",self.shaixuanTag],@"paixu":@"1"}];
    }
    
    
    
    [self.shaixuanTableview reloadData];
    
    [self hidenshaixuanview];
    
    self.isShowShaiXuanTableviewBool = NO;
    
    [YXNotificationTool postNotificationName:@"changeselectTAG" object:nil];
    
    
    [self requestsearchListData];
    
}



#pragma mark  ******************* 添加collectview**********************
-(void)addCollectview
{
    YXWaterfallFlowLayout *layout = [[YXWaterfallFlowLayout alloc]init];
    self.fallFlowLayoutLarge = layout;
    layout.delegate = self;
    
    UICollectionView *collectview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.topbarView.bottom, YXScreenW, YXScreenH-self.topbarView.bottom) collectionViewLayout:layout];
    collectview.showsVerticalScrollIndicator = NO;
    collectview.showsHorizontalScrollIndicator = NO;
    
    collectview.delegate = self;
    collectview.dataSource = self;
    self.collectionView = collectview;
    [self.view addSubview:collectview];
    
    UIPinchGestureRecognizer *pincher = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [self.collectionView addGestureRecognizer:pincher];
    
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YXGoodCell class]) bundle:nil] forCellWithReuseIdentifier:kYXSearchPageGoodListCellReuseIdentifier];
    
    
    //    [self.collectionView registerClass:[YXSearchResultListTopBarView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KYXSearchTopBarViewIdentifier];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestsearchListData)];
    // 自动改变透明度
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreGoodSearchList)];
    self.collectionView.mj_footer.automaticallyChangeAlpha              = YES;
    MJRefreshAutoFooter *autoFooter                                     = (MJRefreshAutoFooter *)self.collectionView.mj_footer;
    autoFooter.triggerAutomaticallyRefreshPercent                       = -100;
    
    //--读取本地数据，判断使用哪种buju
    if ([YXUserDefaults boolForKey:@"isSearchDefaultLayout"]) {
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutLarge animated:YES completion:nil];
    }else{
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutSmall animated:YES completion:nil];
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
    if (good.goodNameTextHeight < 27) {
        height += 0;
    }else{
        height += 17;
    }
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

#pragma mark - YXGoodCellDelegate

- (void)goodCell:(YXGoodCell *)goodCell isScalItem:(BOOL)isScallItem
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:goodCell];
    
    __weak typeof(self)weakself = self;
    if (isScallItem) {
        
        self.isScale = YES;
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutSmall animated:NO completion:^(BOOL finished) {
            [weakself.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        }];
        
        [YXUserDefaults setBool:NO forKey:@"isSearchDefaultLayout"];
        
    }else{
        
        self.isScale = NO;
        /*
         @brief 变小的
         */
        [self.collectionView setCollectionViewLayout:self.fallFlowLayoutLarge animated:NO completion:^(BOOL finished) {
            [weakself.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        }];
        [YXUserDefaults setBool:YES forKey:@"isSearchDefaultLayout"];
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
    [YXUserDefaults setBool:changeLayout forKey:@"isSearchDefaultLayout"];
    [self.collectionView reloadData];
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


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.pageGoodListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXGoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kYXSearchPageGoodListCellReuseIdentifier forIndexPath:indexPath];
    
    cell.good = self.pageGoodListArray[indexPath.row];
    cell.timeModel = self.countDownTimeModelArray[indexPath.item];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    YXHomePageGoodList *modle1 = self.pageGoodListArray[indexPath.row];
    //**1 寄拍   2 一口价**/
    if (modle1.bidType==1) {
        
        YXHomeAuctionDeatilViewCotroller *deatilVC = [[YXHomeAuctionDeatilViewCotroller alloc]init];
        
        YXHomePageGoodList *modle = self.pageGoodListArray[indexPath.row];
        deatilVC.prodId = modle.prodId;
        deatilVC.ProBidId = modle.prodBidId;
        [self.navigationController pushViewController:deatilVC animated:YES];
    }else   //if (modle1.bidType ==2)
    {
        YXOneMouthPriceDeatilViewController *deatilVC = [[YXOneMouthPriceDeatilViewController alloc]init];
        
        YXHomePageGoodList *modle = self.pageGoodListArray[indexPath.row];
        deatilVC.prodId = [NSString stringWithFormat:@"%lld",modle.prodId];
        deatilVC.prodBidId = [NSString stringWithFormat:@"%lld",modle.prodBidId];
        [self.navigationController pushViewController:deatilVC animated:YES];
        
        
    }
    
    
}
/*
 @brief 组头的方法
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        // header类型
        
        // 从重用队列里面获取
        YXSearchResultListTopBarView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:KYXSearchTopBarViewIdentifier forIndexPath:indexPath];
        
        return header;
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchNavTextfiledView.searchTextFiled resignFirstResponder];
}


#pragma mark  ******************* 请求 **********************

/*
 @brief 请求筛选品类的数据源
 */
-(void)requestshaixuanBrandData
{
    
    [YXRequestTool requestDataWithType:POST url:@"/api/firstCategoryList" params:nil success:^(id objc, id respodHeader) {
//                YXLog(@"++++++搜索结果中 的+品类+++%@+",objc);
//        NSMutableArray *arr =  [NSMutableArray arrayWithArray:@[
//                                                                @{@"catName":@"包袋1",@"catId":@"35"},
//                                                                @{@"catName":@"腕表恩",@"catId":@"36"},
//                                                                @{@"catName":@"珠宝箱子",@"catId":@"55"},
//                                                                @{@"catName":@"珠宝箱子",@"catId":@"55"},
//                                                                @{@"catName":@"珠宝箱子",@"catId":@"55"},
//                                                                @{@"catName":@"珠宝箱子",@"catId":@"55"}]];
        
        self.PinLeiDadaArr = [YXSearchModle mj_objectArrayWithKeyValuesArray:objc];
        
    } failure:^(NSError *error) {
        
        
    } ];
    
}





/*
 * @param catList 分类参数，多个用逗号分隔
 * @param brandList 品牌参数，多个用逗号分隔
 * @param timestamp 时间戳
 * @param pageSize  页面大小
 * @param type 请求类型，1表示下拉请求，2表示上拉请
 */
/*
 * @param searchString 搜索关键词
 * @param orderByPrice 价格排序（默认正序），传递1为逆序  后改为 1 ， 2
 * @param label 推荐标签
 * @param orderByStartTime 开始时间排序（默认正序），传递1为逆序
 * @param orderByEndTime 结束时间排序（默认正序），传递1为逆序
 * @param catId 分类id
 * @param curPage 当前页
 * @param pageSize 页面大小
 * @param response 响应对象
 */

-(void)requestsearchListData
{
    
    NSInteger curPage = [self.resultsearchListArr.firstObject curPage] - 1 == 0 ? 1 : [self.resultsearchListArr.firstObject curPage] - 1;
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    
    if (self.pricePaixu) {
        
        parm[@"orderByPrice"] = @(self.pricePaixu);
        
    }else if (self.kaishiTimeBool)
    {
        parm[@"orderByStartTime"] = @"1";
        
    }else if (self.jieshuTimeBool)
    {
        parm[@"orderByEndTime"] = @"1";
        
    }else if (self.shaixuancatID)
    {
        parm[@"catId"] = self.shaixuancatID;
    }
    
    parm[@"searchString"] = self.searchNavTextfiledView.searchTextFiled.text;
    parm[@"pageSize"] = @(kYXHomePageLoadDataPageSizes);
    parm[@"curPage"] = @(curPage);
    
//    YXLog(@"+++$$$$$$$$++++搜索结果列表+请求的参数+++%@++++++++",parm);
    [YXNetworkHUD show];
    [YXRequestTool requestDataWithType:POST url:SEARCHGOODSRESULTLIST_URL params:parm success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        
//        YXLog(@"+++++++搜索结果列表++++%@++++++++",objc);
        
        [self.pageGoodListArray removeAllObjects];
        [self.resultsearchListArr removeAllObjects];
        [self.countDownTimeModelArray removeAllObjects];
        [self.tempView removeFromSuperview];
        
        YXHomePageMainDataModel *objcModel = [YXHomePageMainDataModel mj_objectWithKeyValues:objc];
        [self whenDroupDownCheckFooterViewStateWithObjc:objcModel];
        
        [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
        [self.resultsearchListArr addObject:objcModel];
        
        
        if (!self.pageGoodListArray.count) {
            [self.view addSubview:self.tempView];
            
        }

        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        
        for (YXHomePageGoodList *model in objcModel.dataList) {
            [self.countDownTimeModelArray addObject: [YXMyQuerProdBidListCountTime timeModelWithTitle:[NSString stringWithFormat:@"%zd", model.prodId] time:(long long)model.surplusBidTime]];
        }
        
        
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        [self.collectionView.mj_header endRefreshing];
    }];
    
    [self.noMoreDataFooterView removeFromSuperview];
    
}


/*
 @brief  上拉请求 [self.resultsearchListArr lastObject]
 */
-(void)loadMoreGoodSearchList
{
    
    // 结束下拉
    [self.collectionView.mj_header endRefreshing];
    [self.noMoreDataFooterView removeFromSuperview];
    
    self.pullUpCurPage = [[self.resultsearchListArr lastObject] curPage] + 1;
    
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    
    
    parm[@"pageSize"] = @(kYXHomePageLoadDataPageSizes);
    parm[@"curPage"] = @(self.pullUpCurPage);
    parm[@"searchString"] = self.searchNavTextfiledView.searchTextFiled.text;
    if (self.pricePaixu) {
        
        parm[@"orderByPrice"] = @(self.pricePaixu);
        
    }else if (self.kaishiTimeBool)
    {
        parm[@"orderByStartTime"] = @"1";
        
    }else if (self.jieshuTimeBool)
    {
        parm[@"orderByEndTime"] = @"1";
        
    }else if (self.shaixuancatID)
    {
        parm[@"catId"] = self.shaixuancatID;
        
    }
    
    
    
    [YXRequestTool requestDataWithType:POST url:SEARCHGOODSRESULTLIST_URL params:parm success:^(id objc, id respodHeader) {
        
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            YXHomePageMainDataModel *objcModel = [YXHomePageMainDataModel mj_objectWithKeyValues:objc];
            
            //判断，当当前页数为最后一页时，关闭刷新
            if (![self checkFooterStateWithObjc:objcModel]) {
                [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
                [self.resultsearchListArr addObject:objcModel];
            }
            
            self.pullUpCurPage = objcModel.curPage;
            
            for (YXHomePageGoodList *model in objcModel.dataList) {
                [self.countDownTimeModelArray addObject: [YXMyQuerProdBidListCountTime timeModelWithTitle:[NSString stringWithFormat:@"%zd", model.prodId] time:(long long)model.surplusBidTime]];
            }
        }
        
        
        
        [self.collectionView reloadData];
        
        [self.collectionView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}


/**
 * 时刻监测footer的状态
 */
-(BOOL)checkFooterStateWithObjc:(YXHomePageMainDataModel *)objcModel
{
    //当总数等于当前页面
    if (objcModel.totalRows % kYXHomePageLoadDataPageSizes == 0 || objcModel.totalRows < kYXHomePageLoadDataPageSizes) {
        if (objcModel.totalRows / kYXHomePageLoadDataPageSizes == objcModel.curPage || objcModel.totalRows < kYXHomePageLoadDataPageSizes) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.collectionView.mj_footer.bounds;
            
            [self.collectionView.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            
            if (self.pullUpCurPage == objcModel.curPage) {
                [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
                [self.resultsearchListArr addObject:objcModel];
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
        if ((objcModel.totalRows - objcModel.totalRows % kYXHomePageLoadDataPageSizes) / kYXHomePageLoadDataPageSizes + 1 == objcModel.curPage) {
            YXNoMoreDataFooterView *noMoreDataFooterView = [[YXNoMoreDataFooterView alloc] init];
            
            noMoreDataFooterView.frame = self.collectionView.mj_footer.bounds;
            [self.collectionView.mj_footer addSubview:noMoreDataFooterView];
            _noMoreDataFooterView = noMoreDataFooterView;
            
            if (self.pullUpCurPage == objcModel.curPage) {
                [self.pageGoodListArray addObjectsFromArray:objcModel.dataList];
                [self.resultsearchListArr addObject:objcModel];
            }
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
    if (objcModel.totalRows < kYXHomePageLoadDataPageSizes) {
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //按照作者最后的意思还要加上下面这一段
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
}



#pragma mark  ******************* 倒计时的**********************
///**
// 是否倒计时setter方法
// 
// @param isCountDown isCountDown
// */
//-(void)setIsCountDown:(BOOL)isCountDown
//{
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
//}
//
////** 定时器触发事件， 向cell发送通知, 启动倒计时 */
//- (void)timerEvent
//{
//    
//    [self setIsCountDown:YES];
//    
//}
//- (NSTimer *)countDownTimer
//{
//    if (!_countDownTimer) {
//        _countDownTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
//    }
//    return _countDownTimer;
//}
///**
// 添加定时器
// */
//- (void)creatTimer
//{
//    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
//}
@end

