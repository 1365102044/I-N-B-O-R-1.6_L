//
//  YXSendAuctionInformationImagesCell.m
//  YXSendAuction
//
//  Created by 郑键 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXSendAuctionInformationImagesCell.h"
#import "YXSendAuctionGetIdentifuDetails.h"
#import "YXMySendAuctionSubTableViewController.h"
#import "YXProjectImageConfigManager.h"

@interface YXSendAuctionInformationImagesCell()


@end

@implementation YXSendAuctionInformationImagesCell


- (void)setIdentifuDetailModel:(YXSendAuctionGetIdentifuDetails *)identifuDetailModel
{
    _identifuDetailModel = identifuDetailModel;
    
    if (!identifuDetailModel) {
        return;
    }
    
//    NSMutableArray *tempArray = [NSMutableArray array];
//    for (UIView *view in self.contentView.subviews) {
//        [tempArray addObject:view];
//    }
//    
//    for (UIView *view in tempArray) {
//        if ([view isKindOfClass:[UIImageView class]]) {
//            [view removeFromSuperview];
//        }
//    }
    [self.imageViewsArray removeAllObjects];
    //--初始化
    for (NSInteger i = 0; i < identifuDetailModel.pics.count; i++) {
        
        NSString *imageUrlString = identifuDetailModel.pics[i];
        imageUrlString = [YXProjectImageConfigManager projectImageConfigManagerWithImageUrlString:imageUrlString configType:YXProjectImageConfigMidSS];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"ic_zhanwf"]];
        [self.imageViewsArray addObject:imageView];
        [self.contentView addSubview:imageView];
    }
    
    @try {
        [self layoutImageViewsWithImageViewsArray:self.imageViewsArray];
    } @catch (NSException *exception) {
        YXLog(@"%@", exception);
    } @finally {
        
    }
    
}



- (void)setSourceController:(UIViewController *)sourceController
{
    _sourceController = sourceController;
    
//    if ([self.sourceController isKindOfClass:[YXMySendAuctionSubTableViewController class]]) {
//        return;
//    }
//    
//    //--初始化
//    for (NSInteger i = 0; i < [ZJPhotoManager defaultZJPhotoManager].successSendImageArray.count; i++) {
//        
//        UIImage *image = [ZJPhotoManager defaultZJPhotoManager].successSendImageArray[i];
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.image = image;
//        [self.imageViewsArray addObject:imageView];
//        [self.contentView addSubview:imageView];
//    }
//    
//    [self layoutImageViewsWithImageViewsArray:self.imageViewsArray];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

/**
 九宫格布局imageView

 @param imageViewsArray iamgeViews数组
 */
- (void)layoutImageViewsWithImageViewsArray:(NSArray *)imageViewsArray
{
    NSArray *items = imageViewsArray;
    NSInteger rowCapacity = 3;//每行item容量(个数)
    CGFloat itemSpacing = 8; //item间距
    CGFloat rowSpacing = 8; //行间距
    CGFloat topMargin = 8; //上边距
    CGFloat leftMargin = 8; //左边距
    CGFloat rightMargin = 8; //右边距
    CGFloat bottomMargin = 8; //下边距
    
    
    __block UIView *lastView;
    [items enumerateObjectsUsingBlock:^(UIView   *view, NSUInteger idx, BOOL *  stop) {
        NSInteger rowIndex = idx / rowCapacity; //行index
        NSInteger columnIndex = idx % rowCapacity;//列index
        
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //设置 各个item 大小相等
                make.size.equalTo(lastView);
            }];
        }
        if (columnIndex == 0) {//每行第一列
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //设置左边界
                make.left.offset(leftMargin);
                if (rowIndex == 0) {//第一行 第一个
                    make.width.equalTo(view.mas_height);//长宽相等
                    if (items.count < rowCapacity) {//不满一行时 需要 计算item宽
                        //比如 每行容量是6,则公式为:(superviewWidth/6) - (leftMargin + rightMargin + SumOfItemSpacing)/6
                        make.width.equalTo(view.superview).multipliedBy(1.0/rowCapacity).offset(-(leftMargin + rightMargin + (rowCapacity -1) * itemSpacing)/rowCapacity);
                    }
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {//设置上边界
                        make.top.offset(topMargin);
                    }];
                }else {//其它行 第一个
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        //和上一行的距离
                        make.top.equalTo(lastView.mas_bottom).offset(rowSpacing);
                    }];
                }
            }];
        }else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //设置item水平间距
                make.left.equalTo(lastView.mas_right).offset(itemSpacing);
                //设置item水平对齐
                make.centerY.equalTo(lastView);
                
                //设置右边界距离
                if (columnIndex == rowCapacity - 1 && rowIndex == 0) {//只有第一行最后一个有必要设置与父视图右边的距离，因为结合这条约束和之前的约束可以得出item的宽，前提是必须满一行，不满一行 需要计算item的宽
                    make.right.offset(- rightMargin);
                }
            }];
        }
        
        //最后一个元素底边约束， 用于自动计算行高
        if (idx == items.count - 1) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.contentView).mas_equalTo(bottomMargin);
            }];
        }
        
        lastView = view;
    }];
    
}


#pragma mark - 懒加载

- (NSMutableArray *)imageViewsArray
{
    if (!_imageViewsArray) {
        _imageViewsArray = [NSMutableArray array];
    }
    return _imageViewsArray;
}



@end
