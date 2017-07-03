//
//  YXSendAuctionContentCollectionViewController.m
//  YXSendAuction
//
//  Created by 郑键 on 16/11/11.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXSendAuctionContentCollectionViewController.h"
#import "YXSendAuctionFirstHeaderView.h"
#import "YXSendAuctionSecondOtherHeaderView.h"
#import "YXSendAuctionSecondFooterView.h"
#import "YXSendAuctionSelectedImageCell.h"
#import "YXSendAuctionBranceSelectedTableViewController.h"
#import "YXUploadFile.h"
#import "YXSendAuctionURLMacros.h"
#import "YXSendAuctionProgressModel.h"
#import "YXNavigationController.h"
#import "YXLoginViewController.h"
#import "YXSendAuctionNetworkTool.h"
#import "YXSendAuctionGoodPartsModel.h"
#import "YXSendAuctionGoodPartsCell.h"
#import "UIImage+fixOrientation.h"
#import "YXAlearFormMyView.h"
#import "YXSendAuctionAgreementViewController.h"
#import "YXAlertViewTool.h"
//** 系统库&第三方框架 */
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"

//** 宏定义 */
#define kYXSendAuctionItemWidth (([UIScreen mainScreen].bounds.size.width - 12.5 * 2) / 4)
#define kYXMyLabelItemWidth (([UIScreen mainScreen].bounds.size.width - 7 * 12) / 4)

//** 适配机型 */
#define iPHone6Plus ([UIScreen mainScreen].bounds.size.height == 736) ? YES : NO
#define iPHone6 ([UIScreen mainScreen].bounds.size.height == 667) ? YES : NO
#define iPHone5 ([UIScreen mainScreen].bounds.size.height == 568) ? YES : NO
#define iPHone4oriPHone4s ([UIScreen mainScreen].bounds.size.height == 480) ? YES : NO

@interface YXSendAuctionContentCollectionViewController ()<YXSendAuctionSecondOtherHeaderViewDelegate, TZImagePickerControllerDelegate, YXSendAuctionGoodPartsCellDelegate, YXSendAuctionBranceSelectedTableViewControllerDelegate, YXSendAuctionFirstHeaderViewDelegate, YXSendAuctionSelectedImageCellDelegate, YXSendAuctionSecondFooterViewDelegate>
#pragma mark - 数据源
/**
 配置界面数组
 */
@property (nonatomic, strong) NSArray *setupViewArray;

/**
 选中图片数组
 */
@property (nonatomic, strong) NSMutableArray *selectedPotoArray;

/**
 预览照片数组
 */
@property (nonatomic, strong) NSMutableArray *selectedAssets;

/**
 商品配件数组
 */
@property (nonatomic, strong) NSArray *goodPartsArray;

#pragma mark - 控件

/**
 imagePicker
 */
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

/**
 最大选择相片
 */
@property (nonatomic, assign) NSInteger maxSelectedPhotoCount;

/*
 @brief 自己判读的提示view
 */
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

@end

@implementation YXSendAuctionContentCollectionViewController

//** 重用标志 */
static NSString * const kYXSendAuctionSelectedImageCellReuseIdentifier      = @"kYXSendAuctionSelectedImageCellReuseIdentifier";
static NSString * const kYXSendAuctionFirstHeaderReuseIdentifier            = @"kYXSendAuctionFirstHeaderReuseIdentifier";
static NSString * const kYXSendAuctionSecondOtherHeaderReuseIdentifier      = @"kYXSendAuctionSecondOtherHeaderReuseIdentifier";
static NSString * const kYXSendAuctionSecondFooterReuseIdentifier           = @"kYXSendAuctionSecondFooterReuseIdentifier";
static NSString * const kYXSendAuctionGoodPartsCellReuseIdentifier          = @"kYXSendAuctionGoodPartsCellReuseIdentifier";

//** 界面配置 */
NSInteger maxSelectedPhotoCount                                             = 9;
NSInteger maxColPhotoCount                                                  = 4;
bool isShowCamerButton                                                      = NO;
bool canSelectedVideo                                                       = NO;
bool canSelectedImage                                                       = YES;
bool canPickingOriginaImage                                                 = NO;
bool canSortAscending                                                       = YES;
bool showSheetTakePhotoOrSelectedFromePhotoLabiry                           = YES;
//** 重绘图片的宽度尺寸 */
CGFloat maxImageWidth                                                       = 414.f;

#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 清空数据

 @param clearData clearData
 */
- (void)setClearData:(BOOL)clearData
{
    _clearData = clearData;
    
    //** 清空输入框 */
    self.firstHeaderView.detailTextView.text = @"";
    //** 清空图片 */
    [self.selectedPotoArray removeAllObjects];
    [self.selectedAssets removeAllObjects];
    [self.selectedImageModelArray removeAllObjects];
    //** 清空品牌 */
    self.secondHeaderView.showBranceLabel.text = @"点击选择品牌";
    //** 清空配件 */
    [self.selectedGoodPartArray removeAllObjects];
    for (YXSendAuctionGoodPartsModel *model in self.goodPartsArray) {
        model.isDisable = NO;
    }
    //** 协议选中 */
    self.secondFooterView.isReadAndAgreeButton.selected = YES;
    
    [self.collectionView reloadData];
}

/**
 商品配件

 @param goodPartsArray goodPartsArray
 */
- (void)setGoodPartsArray:(NSArray *)goodPartsArray
{
    _goodPartsArray = goodPartsArray;
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [self.collectionView reloadSections:indexSet];
}

#pragma mark - Third.点击事件

/**
 从数组中删除数据
 */
- (void)delFromeArrayWithIndexPath:(NSIndexPath *)indexPath
{
    //** 清空选中 */
    [self.selectedPotoArray removeObjectAtIndex:indexPath.item];
    //** 清空预览 */
    [self.selectedAssets removeObjectAtIndex:indexPath.item];
    //** 清空上传图片对象 */
    [self.selectedImageModelArray removeObjectAtIndex:indexPath.item];
}

#pragma mark - Fourth.代理方法

#pragma mark <YXSendAuctionSecondFooterViewDelegate>

/**
 查看协议点击事件

 @param sendAuctionSecondFooterView sendAuctionSecondFooterView
 @param sender                      sender
 */
- (void)sendAuctionSecondFooterView:(YXSendAuctionSecondFooterView *)sendAuctionSecondFooterView clickButton:(UIButton *)sender
{
    YXSendAuctionAgreementViewController *controller = [[YXSendAuctionAgreementViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark <YXSendAuctionSelectedImageCellDelegate>

/**
 图片上传失败后，点击上传

 @param sendAuctionSelectedImageCell sendAuctionSelectedImageCell
 @param imageModel imageModel
 */
- (void)sendAuctionSelectedImageCell:(YXSendAuctionSelectedImageCell *)sendAuctionSelectedImageCell reUploadImageModel:(YXSendAuctionProgressModel *)imageModel
{
    YXUploadFile *upload = [[YXUploadFile alloc] init];
    [upload uploadImagesWithImagesArray:@[imageModel] andUploadImageUrlString:SENDAUCTIONUOLOADIMAGE_URL];
}

/**
 删除按钮点击事件

 @param sendAuctionSelectedImageCell sendAuctionSelectedImageCell
 @param sender                       sender
 */
- (void)sendAuctionSelectedImageCell:(YXSendAuctionSelectedImageCell *)sendAuctionSelectedImageCell clickButton:(UIButton *)sender
{
    //** 删除模型数组，删除选中数组 */
    [YXNetworkHUD showWithOverlay];
    NSIndexPath *currentIndexPath = [self.collectionView indexPathForCell:sendAuctionSelectedImageCell];
    [[YXSendAuctionNetworkTool sharedTool] deleteImageWithImageUrlString:[self.selectedImageModelArray[currentIndexPath.item] successImageUrlString]success:^(id objc, id respodHeader) {
        [YXNetworkHUD dismiss];
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            [self delFromeArrayWithIndexPath:currentIndexPath];
            
            if (self.selectedPotoArray.count == 8) {
                [self.collectionView reloadData];
                return;
            }
            
            [self.collectionView performBatchUpdates:^{
                [self.collectionView deleteItemsAtIndexPaths:@[currentIndexPath]];
            } completion:^(BOOL finished) {
                [self.collectionView reloadData];
            }];
        }else{
            self.alearMyview.alearstr = @"图片删除失败";
        }
        
        
    } failure:^(NSError *error) {
        [YXNetworkHUD dismiss];
        self.alearMyview.alearstr = @"图片删除失败";
    }];
}

#pragma mark <YXSendAuctionFirstHeaderViewDelegate>

/**
 结束编辑

 @param sendAuctionFirstHeaderView sendAuctionFirstHeaderView
 @param endEditing                 endEditing
 */
- (void)sendAuctionFirstHeaderView:(YXSendAuctionFirstHeaderView *)sendAuctionFirstHeaderView endEditing:(BOOL)endEditing
{
    if (endEditing) {
        [self.collectionView endEditing:endEditing];
    }
}

#pragma mark <YXSendAuctionBranceSelectedTableViewControllerDelegate>

/**
 选中品牌

 @param sendAuctionBranceSelectedTableViewController sendAuctionBranceSelectedTableViewController
 @param selectedBrandText                            selectedBrandText
 */
-(void)sendAuctionBranceSelectedTableViewController:(YXSendAuctionBranceSelectedTableViewController *)sendAuctionBranceSelectedTableViewController andSelectedBrandText:(NSString *)selectedBrandText
{
    _secondHeaderView.showBranceLabel.text = selectedBrandText;
}

#pragma mark <YXSendAuctionGoodPartsCellDelegate>

/**
 多选选中数组

 @param sendAuctionGoodPartsCell sendAuctionGoodPartsCell
 @param model                    model
 */
- (void)sendAuctionGoodPartsCell:(YXSendAuctionGoodPartsCell *)sendAuctionGoodPartsCell andClickButtonModel:(YXSendAuctionGoodPartsModel *)model
{
    @try {
        if (model.isDisable) {
            [self.selectedGoodPartArray addObject:model];
        }else{
            [self.selectedGoodPartArray removeObject:model];
        }
    } @catch (NSException *exception) {
        YXLog(@"%@", exception);
    } @finally {
    }
}

#pragma mark <TZImagePickerControllerDelegate>

/**
 相册选择器选中图片回调

 @param picker                picker
 @param photos                photos
 @param assets                assets
 @param isSelectOriginalPhoto isSelectOriginalPhoto
 */
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    [self.selectedPotoArray addObjectsFromArray:photos];
    [self.selectedAssets addObjectsFromArray:assets];
    NSArray *tempArray = [self photoSetValueForKeyToModel:photos];
    [self.collectionView reloadData];
    
    //** 上传图片 */
    YXUploadFile *upload = [[YXUploadFile alloc] init];
    [upload uploadImagesWithImagesArray:tempArray andUploadImageUrlString:SENDAUCTIONUOLOADIMAGE_URL];
}

/**
 图片转图片模型

 @param photos photo
 */
- (NSArray<YXSendAuctionProgressModel *> *)photoSetValueForKeyToModel:(NSArray *)photos
{
    NSInteger i = 0;
    for (UIImage *image in [self compressImageWithImageArray:photos]) {
        YXSendAuctionProgressModel *model = [[YXSendAuctionProgressModel alloc] init];
        model.compressImage = image;
        model.selectedImage = photos[i];
        model.progress = 0;
        model.successed = YES;
        [self.selectedImageModelArray addObject:model];
        i++;
    }
    
    return self.selectedImageModelArray;
}

/**
 压缩图片

 @param imageArray imageArray 图片数组
 @return return 压缩后图片
 */
- (NSArray<UIImage *> *)compressImageWithImageArray:(NSArray *)imageArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (UIImage *image in imageArray) {
        CGSize imageSize = CGSizeMake(maxImageWidth, image.size.height / image.size.width * maxImageWidth);
        [tempArray addObject: [UIImage OriginImage:image scaleToSize:imageSize]];
    }
    return tempArray.copy;
}

#pragma mark <UIImagePickerDelegate>

/**
 获取相机拍照图片

 @param picker picker
 @param info   info
 */
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [UIView animateWithDuration:0.25 animations:^{
        self.tabBarController.tabBar.y = self.view.height - self.tabBarController.tabBar.height;
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxSelectedPhotoCount delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = canSortAscending;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                YXLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [self.selectedAssets addObject:assetModel.asset];
                        [self.selectedPotoArray addObject:image];
                        NSArray *tempArray = [self photoSetValueForKeyToModel:@[[image fixOrientation]]];
                        [self.collectionView reloadData];
                        
                        //** 上传图片 */
                        YXUploadFile *upload = [[YXUploadFile alloc] init];
                        [upload uploadImagesWithImagesArray:tempArray andUploadImageUrlString:SENDAUCTIONUOLOADIMAGE_URL];
                    }];
                }];
            }
        }];
    }
}

/**
 dismiss

 @param picker picker
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tabBarController.tabBar.y = self.view.height - self.tabBarController.tabBar.height;
        }];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark <UIActionSheetDelegate>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark <YXSendAuctionSecondOtherHeaderViewDelegate>

/**
 品牌选择点击事件

 @param sendAuctionSecondOtherHeaderView sendAuctionSecondOtherHeaderView
 @param showSelectedBranceLabel          showSelectedBranceLabel
 */
- (void)sendAuctionSecondOtherHeaderView:(YXSendAuctionSecondOtherHeaderView *)sendAuctionSecondOtherHeaderView showSelectedBranceLabel:(UILabel *)showSelectedBranceLabel
{
    YXSendAuctionBranceSelectedTableViewController *branceSelectedTableViewController = [[YXSendAuctionBranceSelectedTableViewController alloc] init];
    branceSelectedTableViewController.selectedDelegate = self;
    [self.navigationController pushViewController:branceSelectedTableViewController animated:YES];
}

#pragma mark <UICollectionViewDataSource>

/**
 多少组

 @param collectionView collectionView

 @return 组数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.setupViewArray.count;
}

/**
 多少行

 @param collectionView collectionView
 @param section        section

 @return 组对应行数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) return (self.selectedImageModelArray.count == 9 ? self.selectedImageModelArray.count : self.selectedImageModelArray.count + 1);
    if (section == 1) return self.goodPartsArray.count;
    return 0;
}

/**
 自定义cell

 @param collectionView collectionView
 @param indexPath      indexPath

 @return 自定义样式cell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YXSendAuctionSelectedImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kYXSendAuctionSelectedImageCellReuseIdentifier forIndexPath:indexPath];
        //cell.videoImageView.hidden = YES;
        if (indexPath.item == self.selectedImageModelArray.count) {
            cell.imageView.image = [UIImage imageNamed:@"ic_sendAuction_addPhoto"];
            cell.delButton.hidden = YES;
        } else {
            cell.imageView.image = self.selectedPotoArray[indexPath.item];
            cell.asset = _selectedAssets[indexPath.item];
            cell.delButton.hidden = NO;
        }
        
        cell.progressModel = self.selectedImageModelArray[indexPath.item];
        cell.delButton.tag = indexPath.row;
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.section == 1) {
        YXSendAuctionGoodPartsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kYXSendAuctionGoodPartsCellReuseIdentifier forIndexPath:indexPath];
        cell.model = self.goodPartsArray[indexPath.item];
        cell.delegate = self;
        return cell;
    }
    
    NSString *reId = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    
    return cell;
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
            YXSendAuctionFirstHeaderView *firstReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kYXSendAuctionFirstHeaderReuseIdentifier forIndexPath:indexPath];
            firstReusableView.delegate = self;
            _firstHeaderView = firstReusableView;
            return firstReusableView;
        }
        
        if (indexPath.section == 1){
            YXSendAuctionSecondOtherHeaderView *secondOtherHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kYXSendAuctionSecondOtherHeaderReuseIdentifier forIndexPath:indexPath];
            secondOtherHeaderView.delegate = self;
            _secondHeaderView = secondOtherHeaderView;
            return secondOtherHeaderView;
        }
    } else if (kind == UICollectionElementKindSectionFooter) {
        
        if (indexPath.section == 1) {
            YXSendAuctionSecondFooterView *secondFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kYXSendAuctionSecondFooterReuseIdentifier forIndexPath:indexPath];
            _secondFooterView = secondFooterView;
            _secondFooterView.delegate = self;
            return secondFooterView;
        }
    }
    return nil;
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
    if (indexPath.section == 0) return CGSizeMake(kYXSendAuctionItemWidth, kYXSendAuctionItemWidth);
    if (indexPath.section == 1) return CGSizeMake(kYXMyLabelItemWidth, 50 * kYXMyLabelItemWidth / 160);
    return CGSizeMake(50, 33);
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
    if (section == 0) return UIEdgeInsetsMake(5, 12.5, 5, 12.5);
    if (section == 1) return UIEdgeInsetsMake(12, 12, 8, 12);
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/**
 返回最小间距

 @param collectionView       collectionView
 @param collectionViewLayout collectionViewLayout
 @param section              section

 @return return 最小间距
 */
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) return 15;
    return 0;
}

/**
 最小间距

 @param collectionView       collectionView
 @param collectionViewLayout collectionViewLayout
 @param section              section

 @return 最小间距
 */
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) return 15;
    return 0;
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
    if (section == 0) return CGSizeMake(self.view.frame.size.width, 110);
    if (section == 1) return CGSizeMake(self.view.frame.size.width, 88);
    return CGSizeMake(0, 0);
}

/**
 返回组尾高度

 @param collectionView          collectionView
 @param collectionViewLayout    布局
 @param section                 组
 @return                        组尾高度
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 1) return CGSizeMake(self.view.frame.size.width, 44);
    return CGSizeMake(0, 0);
}

#pragma mark <UICollectionViewDelegate>

/**
 点击事件

 @param collectionView collectionView
 @param indexPath      indexPath
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //** 判断登录权限 */
//    if ([[YXUserDefaults objectForKey:@"TokenID"] isKindOfClass:[NSNull class]]
    //        || ![YXUserDefaults objectForKey:@"TokenID"]) {
    if ([[[YXLoginStatusTool sharedLoginStatus] getTokenId] isKindOfClass:[NSNull class]]
        || ![[YXLoginStatusTool sharedLoginStatus] getTokenId]) {
    
        YXLoginViewController *loginVC = [[YXLoginViewController alloc]init];
        YXNavigationController *navi = [[YXNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navi animated:YES completion:nil];
        return;
    }
    [self.collectionView endEditing:YES];
    if (indexPath.section == 0) [self selectedGoodPhotosClick:indexPath];
}

/**
 点击选择照片

 @param indexPath indexPath
 */
- (void)selectedGoodPhotosClick:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.selectedPotoArray.count) {
        //BOOL showSheet = self.showSheetSwitch.isOn;
        BOOL showSheet = showSheetTakePhotoOrSelectedFromePhotoLabiry;
        if (showSheet) {
            
            [YXAlertViewTool showAlertView:self
                                totalTitle:nil
                               titlesArray:@[@"拍照",
                                             @"去相册选择"]
                              messageArray:nil
                              confrimBlock:^(NSString *title) {
                                  if ([title isEqualToString:@"拍照"]) {
                                      [self takePhoto];
                                  } else if ([title isEqualToString:@"去相册选择"]) {
                                      [self pushImagePickerController];
                                  }
                              }];
        } else {
            [self pushImagePickerController];
        }
    } else { // preview photos or video / 预览照片或者视频
        id asset = _selectedAssets[indexPath.row];
        BOOL isVideo = NO;
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = asset;
            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = asset;
            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
#pragma clang diagnostic pop
        }
        if (isVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:self.selectedAssets selectedPhotos:self.selectedPotoArray index:indexPath.item];
            
            imagePickerVc.maxImagesCount = 9;
            imagePickerVc.allowPickingOriginalPhoto = canPickingOriginaImage;
            imagePickerVc.photoSelImageName = @"ic_sendAuction_Sel";
            imagePickerVc.photoNumberIconImageName = @"ic_sendAuction_count";
            imagePickerVc.photoOriginSelImageName = @"ic_sendAuction_photoSel";
            imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
            imagePickerVc.oKButtonTitleColorNormal = [UIColor sendAuctionThemColor];
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
                //** 预览照片，点击完成回调 1.比较回调图片和现有图片 2.删除未选中图片，删除图片模型数组 */
                [self.selectedPotoArray removeObjectsInArray:[self cancelCancelImage:photos andType:1]];
                [self.selectedAssets removeObjectsInArray:[self cancelCancelImage:assets andType:2]];
                
                //** TODO:获取下标，删除图片对象数组 */
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSInteger i = 0; i < photos.count; i++) {
                    YXSendAuctionProgressModel *model = self.selectedImageModelArray[i];
                    if (model.selectedImage == photos[i]) {
                        [tempArray addObject:model];
                    }
                }
                [self.selectedImageModelArray removeObjectsInArray:[self cancelCancelImage:tempArray andType:3]];
                
                [self.collectionView reloadData];
                
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
}

/**
 过滤未选中的图片

 @param imageArray imageArray
 @param type       1.图片 2.预览图片 3.图片模型
 */
- (NSArray *)cancelCancelImage:(NSArray *)imageArray andType:(NSInteger)type
{
    NSPredicate *surplusImaage = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", imageArray];
    if (type == 1) {
        return [self.selectedPotoArray filteredArrayUsingPredicate:surplusImaage];
    }else if (type == 2){
        return [self.selectedAssets filteredArrayUsingPredicate:surplusImaage];
    }else if (type == 3){
        return [self.selectedImageModelArray filteredArrayUsingPredicate:surplusImaage];
    }else{
        return [self.selectedPotoArray filteredArrayUsingPredicate:surplusImaage];
    }
}

/**
 push相册界面
 */
- (void)pushImagePickerController {
    if (self.maxSelectedPhotoCount <= 0) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxSelectedPhotoCount columnNumber:maxColPhotoCount delegate:self pushPhotoPickerVc:YES];
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    //imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    if (self.maxSelectedPhotoCount > 1) {
        // 1.设置目前已经选中的图片数组
        //imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = isShowCamerButton; // 在内部显示拍照按钮
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
//     imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
//     imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
//     imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
//    @property (nonatomic, copy) NSString *takePictureImageName;
//    @property (nonatomic, copy) NSString *photoSelImageName;
//    @property (nonatomic, copy) NSString *photoDefImageName;
//    @property (nonatomic, copy) NSString *photoOriginSelImageName;
//    @property (nonatomic, copy) NSString *photoOriginDefImageName;
//    @property (nonatomic, copy) NSString *photoPreviewOriginDefImageName;
//    @property (nonatomic, copy) NSString *photoNumberIconImageName;
    imagePickerVc.photoSelImageName = @"ic_sendAuction_Sel";
    imagePickerVc.photoNumberIconImageName = @"ic_sendAuction_count";
    imagePickerVc.photoOriginSelImageName = @"ic_sendAuction_photoSel";
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    imagePickerVc.oKButtonTitleColorNormal = [UIColor sendAuctionThemColor];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = canSelectedVideo;
    imagePickerVc.allowPickingImage = canSelectedImage;
    imagePickerVc.allowPickingOriginalPhoto = canPickingOriginaImage;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = canSortAscending;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

/**
 照相
 */
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        [UIView animateWithDuration:0.25 animations:^{
            self.tabBarController.tabBar.y = self.view.height;
        }];
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            YXLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

#pragma mark - Fifth.控制器生命周期

/**
 视图加载完毕
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerViews];
    [self registerNotification];
    [self loadGoodPartsData];
    
    //** 界面样式 */
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

/**
 布局完毕
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

/**
 销毁
 */
- (void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"uploadImageProgressNotification" object:nil];
}

#pragma mark - Sixth.界面配置

/**
 Register
 */
- (void)registerViews
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YXSendAuctionGoodPartsCell class])
                                                    bundle:nil] forCellWithReuseIdentifier:kYXSendAuctionGoodPartsCellReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YXSendAuctionSelectedImageCell class])
                                                    bundle:nil] forCellWithReuseIdentifier:kYXSendAuctionSelectedImageCellReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YXSendAuctionFirstHeaderView class])
                                                    bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kYXSendAuctionFirstHeaderReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YXSendAuctionSecondOtherHeaderView class])
                                                    bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kYXSendAuctionSecondOtherHeaderReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YXSendAuctionSecondFooterView class])
                                                    bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kYXSendAuctionSecondFooterReuseIdentifier];
}

/**
 注册通知
 */
- (void)registerNotification
{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showProgress:) name:@"uploadImageProgressNotification" object:nil];
}

#pragma mark - Seventh.加载网络数据

/**
 加载商品配件
 */
- (void)loadGoodPartsData
{
    [[YXSendAuctionNetworkTool sharedTool] getGoodPartsWithSuccess:^(id objc, id respodHeader) {
        @try {
            self.goodPartsArray = [YXSendAuctionGoodPartsModel mj_objectArrayWithKeyValuesArray:objc[@"data"]];
        } @catch (NSException *exception) {
            YXLog(@"%@", exception);
        } @finally {
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Eighth.懒加载

- (NSArray *)setupViewArray
{
    if (!_setupViewArray) {
        _setupViewArray = @[@{@"headerView":@"detaileHeaderView",
                              @"footerView":@"none"},
                            @{@"headerView":@"selectedBranceHeaderView",
                              @"footerView":@"checkAgreementView"}];
    }
    return _setupViewArray;
}

- (NSMutableArray *)selectedPotoArray
{
    if (!_selectedPotoArray) {
        _selectedPotoArray = [NSMutableArray array];
    }
    return _selectedPotoArray;
}

- (NSMutableArray *)selectedAssets
{
    if (!_selectedAssets) {
        _selectedAssets = [NSMutableArray array];
    }
    return _selectedAssets;
}

- (NSMutableArray *)selectedImageModelArray
{
    if (!_selectedImageModelArray) {
        _selectedImageModelArray = [NSMutableArray array];
    }
    return _selectedImageModelArray;
}

- (NSMutableArray *)selectedGoodPartArray
{
    if (!_selectedGoodPartArray) {
        _selectedGoodPartArray = [NSMutableArray array];
    }
    return _selectedGoodPartArray;
}

- (NSInteger)maxSelectedPhotoCount
{
    return (9 - self.selectedPotoArray.count);
}

- (YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        _alearMyview = [[YXAlearFormMyView alloc]init];
        [self.collectionView addSubview:self.alearMyview];
        _alearMyview.alpha = 0;
    }
    return _alearMyview;
}

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

@end
