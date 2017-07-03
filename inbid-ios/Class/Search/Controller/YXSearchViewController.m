//
//  YXSearchViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSearchViewController.h"
#import "YXSearchCollectionReusableView.h"
#import "YXSearchCollectionViewCell.h"
#import "YXSearchModle.h"
#import "YXSearchBrandsModle.h"
#import "YXSearchBrandsCollectionViewCell.h"
#import "YXSearchResultListViewController.h"

#import "YXHomePageController.h"


#import "YXHomeAuctionDeatilViewCotroller.h"


#define seactionOneIndentfine @"seactionOneIndentfine"
#define seactionTwoIndentfine @"seactionTwoIndentfine"
#define seactionHeaderIndentfine @"seactionHeaderIndentfine"

@interface YXSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

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

@end

@implementation YXSearchViewController

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
//** 取消按钮点击事件 */
- (void)clickBackBtnItem
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = UIColorFromRGB(0xf9f9f9);
    
    self.currenindex = -1;
    
    
    [self addcanclebtn];
    
    [self addBoomview];
    
    [self addcollectview];
    
    [self requestSearchdata];
}

-(void)addcollectview
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    
    layout.headerReferenceSize = CGSizeMake(YXScreenW, 50);
    
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collectview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 65, YXScreenW, YXScreenH-64-50) collectionViewLayout:layout];
    
    //代理设置
    collectview.delegate=self;
    collectview.dataSource = self;
    
    //注册item类型 这里使用系统的类型
    [collectview registerClass:[YXSearchCollectionViewCell class] forCellWithReuseIdentifier:seactionOneIndentfine];
    [collectview registerClass:[YXSearchBrandsCollectionViewCell class] forCellWithReuseIdentifier:seactionTwoIndentfine];
    [collectview registerClass:[YXSearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:seactionHeaderIndentfine];
    
    
    collectview.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:collectview];
    self.collectview = collectview;
    self.collectview.allowsMultipleSelection = YES;
    
}

//这是正确的方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        YXSearchCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:seactionOneIndentfine forIndexPath:indexPath];
        cell.block = ^(BOOL selected){};
        
        cell.modle = self.searchdata[indexPath.row];
        
        return cell;
        
    }else{
        
        YXSearchBrandsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:seactionTwoIndentfine forIndexPath:indexPath];
        
        cell.block = ^(BOOL selected,NSString *ID){};
        
        if (self.currenindex >= 0) {
            cell.brand = self.allSelectedArr[indexPath.row];
            
        }else{
            
            cell.brand = self.searchBrandsdata[indexPath.row];
        }
        
        return cell;
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return self.searchdata.count;
    }
    
    if (self.currenindex >= 0) {
        
        return self.allSelectedArr.count;
    }
    
    return self.searchBrandsdata.count;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
    if (indexPath.section==0) {
        cellHeight = 30;
        
    }else if (indexPath.section==1)
    {
        cellHeight = 60;
    }
    return CGSizeMake((YXScreenW-41)/3, cellHeight);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 15, 10);
}

/*
 @brief 组头的方法
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        // header类型
        
        // 从重用队列里面获取
        YXSearchCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:seactionHeaderIndentfine forIndexPath:indexPath];
        
        NSString *titlestr;
        if (indexPath.section==0) {
            titlestr = @"商品品类";
        }else{
            titlestr = @"商品品牌";
        }
        
        // 显示数据
        [header.titleBtn setTitle:[NSString stringWithFormat:@"%@",titlestr] forState:UIControlStateNormal];
        return header;
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
    }
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        
        self.allSelectedArr = nil;
        
        self.currenindex = indexPath.row;
        
        YXSearchModle *modle = self.searchdata[indexPath.row];
        
        YXSearchCollectionViewCell *groupCell = (YXSearchCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        groupCell.block = ^(BOOL selected){
            
            
            if (selected == 0) {
                
                [self.selectItemsIDArr removeObject:modle];
                [self.selectItemsIDs removeObject:[NSString stringWithFormat:@"%lld",modle.catId]];
                
                if(self.selectItemsIDArr.count==0)
                {
                    self.currenindex = -1;
                    //一个section刷新
                    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                    [self.collectview reloadSections:indexSet];
                }
                
                NSMutableArray *allSelectedArr = [NSMutableArray array];
                NSMutableArray *idarr = [NSMutableArray array];
                NSMutableArray *allArr =[NSMutableArray array];
                for (YXSearchModle *modle in self.selectItemsIDArr) {
                    
                    for (YXSearchBrandsModle *brand in modle.brands) {
                        
                        if (![idarr containsObject:brand.brandId]) {
                            [idarr addObject:brand.brandId];
                            [allSelectedArr addObject:brand];
                             allArr =  allSelectedArr;
                        }else
                        {
                            //**包含的时候 也要检测一下 数组中已经包含的品牌 是否有相应商品**/
                            //**包含的时候 也要检测一下 数组中已经包含的品牌 是否有相应商品**/
                            if (brand.hasGoods) {
                                
                                for (int i=0; i<allSelectedArr.count; i++) {
                                    
                                    YXSearchBrandsModle *brandmodle = allSelectedArr[i];
                                    
                                    if ([brandmodle.brandId isEqualToString:brand.brandId]) {
                                        [allArr removeObject:brandmodle];
                                        [allArr addObject:brand];
                                    }
                                    
                                }
                            }
                            allSelectedArr = allArr;
                        
                        }
                        
                        
                        if(allSelectedArr.count==0)
                        {
                            self.currenindex = -1;
                            //一个section刷新
                            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                            [self.collectview reloadSections:indexSet];
                        }
                    }
                    if (![self.selectItemsIDs containsObject:[NSString stringWithFormat:@"%lld",modle.catId]]) {
                        
                        [self.selectItemsIDs addObject:[NSString stringWithFormat:@"%lld",modle.catId]];
                    }
                }
                
                /*
                 @brief 排序
                 */
                self.allSelectedArr = [self Arrpaixu:allSelectedArr];
                
                
                //一个section刷新
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                [self.collectview reloadSections:indexSet];
                
            }
        };
        
        if (groupCell.selected) {
            
            [self.selectedIDs removeAllObjects];
            [self.selectItemsIDArr addObject:modle];
            if (![self.selectItemsIDs containsObject:[NSString stringWithFormat:@"%lld",modle.catId]]) {
                
                [self.selectItemsIDs addObject:[NSString stringWithFormat:@"%lld",modle.catId]];
            }
            
        }
        
        NSMutableArray *allSelectedArr = [NSMutableArray array];
        NSMutableArray *idarr = [NSMutableArray array];
        
        NSMutableArray *allArr =[NSMutableArray array];
        
        for (YXSearchModle *modle in self.selectItemsIDArr) {
            
            for (YXSearchBrandsModle *brand in modle.brands) {
                
                
               
                
                if (![idarr containsObject:brand.brandId]) {
                    [idarr addObject:brand.brandId];
                    [allSelectedArr addObject:brand];
                     allArr =  allSelectedArr;
                }else
                {
                   
                    //**包含的时候 也要检测一下 数组中已经包含的品牌 是否有相应商品**/
                    if (brand.hasGoods) {
                        
                            for (int i=0; i<allSelectedArr.count; i++) {
                                
                                YXSearchBrandsModle *brandmodle = allSelectedArr[i];
                                
                                if ([brandmodle.brandId isEqualToString:brand.brandId]) {
                                    [allArr removeObject:brandmodle];
                                    [allArr addObject:brand];
                                }
                                
                            }
                        }
                    
                }
                allSelectedArr = allArr;
                
            }
            if (![self.selectItemsIDs containsObject:[NSString stringWithFormat:@"%lld",modle.catId]]) {
                
                [self.selectItemsIDs addObject:[NSString stringWithFormat:@"%lld",modle.catId]];
            }
        }
        
        self.allSelectedArr = [self Arrpaixu:allSelectedArr];
        
        //一个section刷新
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.collectview reloadSections:indexSet];
        
        
    }else
    {
        if (self.currenindex<0) {
            
            YXSearchBrandsModle *brand = self.searchBrandsdata[indexPath.row];
            NSString *brandId = [NSString stringWithFormat:@"%@",brand.brandId];
            YXSearchBrandsCollectionViewCell *brandCell = (YXSearchBrandsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            brandCell.block = ^(BOOL selected,NSString *ID){
                
                if (selected == 0) {
                    
                    [self.selectedIDs removeObject:ID];
                    
                }
            };
            
            if (brandCell.selected) {
                
                [self.selectedIDs addObject:brandId];
                
            }
            
            
        }else{
            
            
            YXSearchBrandsModle *brand = self.allSelectedArr[indexPath.row];
            
            NSString *brandId = [NSString stringWithFormat:@"%@",brand.brandId];
            
            YXSearchBrandsCollectionViewCell *brandCell = (YXSearchBrandsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            brandCell.block = ^(BOOL selected,NSString *ID){
                
                if (selected == 0) {
                    
                    [self.selectedIDs removeObject:ID];
                    
                }
            };
            
            if (brandCell.selected) {
                
                [self.selectedIDs addObject:brandId];
                
            }
            
        }
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
#pragma mark  ------*************导航栏 底部视图*****************
-(void)addcanclebtn
{
    UIButton *leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(clickBackBtnItem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftitem;
    //    leftbtn.backgroundColor = [UIColor redColor];
    leftbtn.imageEdgeInsets = UIEdgeInsetsMake(0, -39, 0, 0);
    leftbtn.backgroundColor = [UIColor clearColor];
    self.navigationItem.title = @"我的搜索";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
}

//** -------添加底部视图 -----------**/
-(void)addBoomview
{
    UIButton *boomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, YXScreenH-50, YXScreenW, 50)];
    [boomBtn setTitle:@"确认搜索" forState:UIControlStateNormal];
    [boomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    boomBtn.titleLabel.font = YXRegularfont(20);
    [boomBtn addTarget:self action:@selector(SureSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    boomBtn.backgroundColor = [UIColor mainThemColor];
    boomBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:boomBtn];
}


/*
 @brief 确认搜索
 */
-(void)SureSearchBtn
{
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    
    NSString *itmesIDstr = [self.selectItemsIDs componentsJoinedByString:@","] ;
    NSString *brandsIDstr = [self.selectedIDs componentsJoinedByString:@","];
    
    YXLog(@"------品类--%@-----品牌--%@",itmesIDstr,brandsIDstr);
    
    
    YXSearchResultListViewController *resultlist = [[YXSearchResultListViewController alloc]init];
    if (itmesIDstr.length == 0 && brandsIDstr.length == 0) {
        
    }else{
        
        resultlist.itemsStr = itmesIDstr;
        resultlist.brandsStr = brandsIDstr;
    }
    
    
    [self.navigationController pushViewController:resultlist animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark  ------ ************************网络请求*************
-(void)requestSearchdata
{
    
    [YXRequestTool requestDataWithType:POST url:SEARCHGOODSLIST_URL params:nil success:^(id objc, id respodHeader) {
        
//        YXLog(@"-----搜索列表----%@",objc);
        
        NSMutableArray *Allarr = [NSMutableArray array];
        Allarr = [YXSearchModle mj_objectArrayWithKeyValuesArray:objc];
        self.searchdata =  [self Arrpaixu:Allarr];
        
        NSMutableArray *arr = [NSMutableArray array];
        NSMutableArray *Idarr =[NSMutableArray array];
        
        for (YXSearchModle *model in self.searchdata) {
            
            for (YXSearchBrandsModle *obj in model.brands) {
                
                if(![Idarr containsObject:obj.brandId])
                {
                    [Idarr addObject:obj.brandId];
                    [arr addObject:obj];
                }
            }
            
        }
        
        self.searchBrandsdata = [self bransArrpaixu:arr];
        
        [self.collectview reloadData];
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}



@end
