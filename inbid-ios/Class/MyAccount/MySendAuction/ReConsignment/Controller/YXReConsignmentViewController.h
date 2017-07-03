//
//  YXReConsignmentViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXReConsignmentViewController;

@protocol YXReConsignmentViewControllerDelegate <NSObject>

/**
 监听用户点击

 @param reConsignmentViewController reConsignmentViewController
 @param isRestPage isRestPage
 */
- (void)reConsignmentViewController:(YXReConsignmentViewController *)reConsignmentViewController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXReConsignmentViewController : UIViewController

/**
 一口价id
 */
@property (nonatomic, assign) long long identifyId;

/**
 代理
 */
@property (nonatomic, weak) id<YXReConsignmentViewControllerDelegate> delegate;

@end
