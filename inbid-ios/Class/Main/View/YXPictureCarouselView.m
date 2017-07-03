//
//  YXPictureCarouselController.m
//  图片轮播器 PictureCarousel
//
//  Created by 郑键 on 16/8/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXPictureCarouselView.h"
#import "YXPictureCarouselImageViewCell.h"
#import "YXHomeDeatilImgesModle.h"
//#import "YXHomePageAdverts.h"
#import "YXPageControl.h"
//#import "YXSendAuctionBrowser.h"



static NSString *reID = @"cell";

@interface YXPictureCarouselView ()<UICollectionViewDataSource, UICollectionViewDelegate>

//** 轮播器 */
@property (nonatomic, strong)UICollectionView *pictureCarouselView;
//** pageControl */
@property (nonatomic, strong)YXPageControl *pageControl;
//** 定时器 */
@property (nonatomic, strong)NSTimer *timer;
//** 无数据站位图 **/
@property(nonatomic,strong) UIImageView * placeHolderImageView;

@end

@implementation YXPictureCarouselView



-(void)setDeatilmodle:(YXHomeDeatilModle *)deatilmodle
{
    _deatilmodle = deatilmodle;

    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *arrdesc = [NSMutableArray array];
    for (YXHomeDeatilImgesModle *imagemodle in deatilmodle.prodImgs) {
        [arr addObject:imagemodle.imgUrl];
        if (imagemodle.imgDesc) {
            
            [arrdesc addObject:imagemodle.imgDesc];
        }
    }
    
    _picturesArray = arr;
    _pictureDesc = arrdesc;
    
    [self.pictureCarouselView reloadData];
    if (_picturesArray.count>1) {
        
        self.pageControl.numberOfPages = _picturesArray.count;
    }
}

#pragma mark - 赋值

//** 重写数组setter方法赋值 */
- (void)setPicturesArray:(NSArray *)picturesArray
{
    _picturesArray = picturesArray;
    
    [self.pictureCarouselView reloadData];
    if (picturesArray.count>1) {
        
        self.pageControl.numberOfPages = picturesArray.count;
        //--添加定时器
//        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}


#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        //--配置轮播器界面
        [self setupPictureCarouselUI];
        
    }
    return self;
}

//** 布局子控件 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutPictureCarouselSubViews];
}

#pragma mark - 监听事件

//** 定时器调用更换图片方法 */
- (void)nextpage
{
    if (self.picturesArray.count != 0 && self.picturesArray) {
        
        UICollectionViewCell *item = [[self.pictureCarouselView visibleCells] lastObject];
        
        NSIndexPath *currentIndexPath = [self.pictureCarouselView indexPathForCell:item];
        
        NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:50/2];
        
        [self.pictureCarouselView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        NSInteger nextItem = currentIndexPathReset.item + 1;
        NSInteger nextSection = currentIndexPathReset.section;
        if (nextItem == self.picturesArray.count) {
            nextItem=0;
            nextSection++;
        }
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
        
        [self.pictureCarouselView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}


#pragma mark 定时器

//** 添加定时器定时器 */
-(void) addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kYXHomePagePictureCarouselViewChangePictureTime target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

//** 移除定时器 */
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 设置界面

//** 设置界面 */
- (void)setupPictureCarouselUI
{
    //--添加子控件
    [self addPictureCarouselSubViews];
    //--配置collectionView
    [self setupPictureCarouselCollectionView];
}

//** 配置collection */
- (void)setupPictureCarouselCollectionView
{
    //--配置collectionView
    self.pictureCarouselView.showsHorizontalScrollIndicator = NO;
    self.pictureCarouselView.showsVerticalScrollIndicator = NO;
    self.pictureCarouselView.pagingEnabled = YES;
    self.pictureCarouselView.bounces = NO;
    //--注册cell
    [self.pictureCarouselView registerClass:[YXPictureCarouselImageViewCell class] forCellWithReuseIdentifier:reID];
}

//** 添加子控件 */
- (void)addPictureCarouselSubViews
{
    [self addSubview:self.pictureCarouselView];
    [self addSubview:self.pageControl];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_zhanwf"]];
    imageView.backgroundColor = [UIColor whiteColor];
    _placeHolderImageView = imageView;
    [self addSubview:imageView];
}

//** 布局子控件 */
- (void)layoutPictureCarouselSubViews
{
    [self.pictureCarouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.pictureCarouselView.mas_bottom).mas_offset(kYXHomePagePictureCarouselPageControlCenterY);
        make.right.mas_equalTo(self.pictureCarouselView).mas_offset(kYXHomePagePictureCarouselPageControlRightMargin);
    }];
    
    [self.placeHolderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}



#pragma MARK - UIScrollViewDelegate

//** 监听手指点击 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //--释放定时器
    [self removeTimer];
}

//** 监听手指离开 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //--创建定时器
//    [self addTimer];
}

//** 滚动时调用的方法 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_picturesArray.count == 1) {
        _pictureCarouselView.scrollEnabled = NO;
    }
    
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    NSInteger pageControlCurrentPage = currentPage % self.picturesArray.count;
    self.pageControl.currentPage =pageControlCurrentPage;
}



#pragma mark - UICollectionViewDataSource

//** 数据源_返回组 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 50;
}

//** 数据源_返回组对应行 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.picturesArray.count == 0) {
        self.placeHolderImageView.hidden = NO;
    }else{
        self.placeHolderImageView.hidden = YES;
    }
    
    return self.picturesArray.count;
}

//** 数据源_返回对应Item */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YXPictureCarouselImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reID forIndexPath:indexPath];
    
    id model = self.picturesArray[indexPath.item];
    if (self.pictureDesc.count) {
        
        if (indexPath.row < self.pictureDesc.count) {
            
            id descmodel = self.pictureDesc[indexPath.item];
            cell.imagedesc = descmodel;
        }
        
    }
    cell.imageUrl = model;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSMutableArray *arrayM = [NSMutableArray array];
//    for (NSInteger i = 0; i < self.picturesArray.count; i++) {
//        NSString *imagUrlString = [NSString stringWithFormat:@"%@",[self.picturesArray[i] componentsSeparatedByString:@"?"].firstObject];
//        [arrayM addObject:[MWPhoto photoWithURL:[NSURL URLWithString:imagUrlString]]];
//    }
//    
//    
//    //** 点击切换大图查看，发送通知 */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goodDetailViewControllerPictureCarouselClick" object:nil userInfo:@{@"indexPath":indexPath,
                                                                                                                                     @"imageUrlStringArray":self.picturesArray}];
}

#pragma mark - 懒加载

- (UICollectionView *)pictureCarouselView
{
    if (!_pictureCarouselView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _pictureCarouselView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        
        flowLayout.itemSize = _pictureCarouselView.bounds.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _pictureCarouselView.dataSource = self;
        _pictureCarouselView.delegate = self;
    }
    return _pictureCarouselView;
}

- (YXPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[YXPageControl alloc] init];
    }
    return _pageControl;
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    }
    return _timer;
}


@end
