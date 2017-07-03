//
//  YXImmediatelyMailExpressController.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXImmediatelyMailExpressModel;
@class YXImmediatelyMailExpressController;

@protocol YXImmediatelyMailExpressControllerDelegate <NSObject>

/**
 点击快递公司

 @param immediatelyMailExpressController 当前快递公司列表视图
 @param model                            选中的模型
 */
- (void)immediatelyMailExpressController:(YXImmediatelyMailExpressController *)immediatelyMailExpressController andSelectedExpressModel:(YXImmediatelyMailExpressModel *)model;

@end

@interface YXImmediatelyMailExpressController : UITableViewController

/**
 代理
 */
@property (nonatomic, weak) id<YXImmediatelyMailExpressControllerDelegate> delegate;

@end
