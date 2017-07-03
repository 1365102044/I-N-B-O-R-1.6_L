//
//  YXHomePageBadRequestView.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/7.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXHomePageBadRequestView;

@protocol YXHomePageBadRequestViewDelegate <NSObject>

/**
 重新加载网络请求

 @param homePageBadRequestView homePageBadRequestView
 */
- (void)homePageBadRequestView:(YXHomePageBadRequestView *)homePageBadRequestView;

@end

@interface YXHomePageBadRequestView : UIView

/**
 代理
 */
@property (nonatomic, weak) id<YXHomePageBadRequestViewDelegate> delegate;

@end
