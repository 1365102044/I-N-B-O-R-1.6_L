//
//  YXHomePageScreenSubTableViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXHomePageScreenSubTableViewController;
@class YXHomePageScreenViewModel;

typedef NS_ENUM(NSUInteger, kYXHomePageScreenSubTableViewType) {
    kYXHomePageScreenSubTableViewCategory,
    kYXHomePageScreenSubTableViewComprehensive,
};

@protocol YXHomePageScreenSubTableViewControllerDelegate <NSObject>

/**
 点击筛选条件

 @param homePageScreenSubTableViewController homePageScreenSubTableViewController
 @param currentType                          currentType （必传，当前的筛选种类）
 @param selectedScreenViewModel              selectedScreenViewModel（必传，点击的条件模型）
 */
- (void)homePageScreenSubTableViewController:(YXHomePageScreenSubTableViewController *)homePageScreenSubTableViewController
                              andCurrentType:(kYXHomePageScreenSubTableViewType)currentType andSelectedScreenViewModel:(YXHomePageScreenViewModel *)selectedScreenViewModel;

@end

@interface YXHomePageScreenSubTableViewController : UITableViewController

/**
 代理
 */
@property (nonatomic, weak) id<YXHomePageScreenSubTableViewControllerDelegate> customDelegate;

/**
 清空筛选条件
 */
@property (nonatomic, assign) BOOL isRestSelected;

/**
 初始化
 
 @param dataArray dataArray
 
 @return return 实例
 */
+ (instancetype)initWithDataArray:(NSArray *)dataArray andType:(kYXHomePageScreenSubTableViewType)type
                          andMaxY:(CGFloat)maxY
                    compliteBlock:(void(^)(YXHomePageScreenSubTableViewController *controller))compliteBlock;


@end
