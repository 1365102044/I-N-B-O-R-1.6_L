//
//  YXImmediatelyMailController.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/27.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXOrderDetailModel;
@class YXImmediatelyMailController;

@protocol YXImmediatelyMailControllerDelegate <NSObject>

/**
 监听用户操作

 @param immediatelyMailController 立即邮寄控制器
 @param isRestPage                开关
 */
- (void)immediatelyMailController:(YXImmediatelyMailController *)immediatelyMailController changeRestPageON:(BOOL)isRestPage;

@end

@interface YXImmediatelyMailController : UIViewController

/**
 数据
 */
@property (nonatomic, strong) YXOrderDetailModel *orderDetailModel;

/**
 代理
 */
@property (nonatomic, weak) id<YXImmediatelyMailControllerDelegate> delegate;

@end
