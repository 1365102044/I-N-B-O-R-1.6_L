//
//  YXMyAccountRealNameViewController.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyAccountRealNameViewController;

@protocol YXMyAccountRealNameViewControllerDelegate <NSObject>

/**
 *  实名认证成功后的回调
 *
 *  @param myAccountRealNameViewController         myAccountRealNameViewController
 *  @param exten                                   扩展参数（传入nil）
 */
- (void)myAccountRealNameViewController:(YXMyAccountRealNameViewController *)myAccountRealNameViewController extend:(id)exten;

@end

@interface YXMyAccountRealNameViewController : YXMainKeyBoaryViewController

@property(nonatomic,strong) NSString * realnameStatus;

/**
 *  代理
 */
@property (nonatomic, weak) id<YXMyAccountRealNameViewControllerDelegate> delegate;

@end
