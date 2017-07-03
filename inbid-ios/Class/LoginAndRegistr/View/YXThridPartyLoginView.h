//
//  YXThridPartyLoginView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/3.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickQQbtnBlock)();
typedef void(^clickWXbtnBlock)();
typedef void(^clickHelpBlock)();
@interface YXThridPartyLoginView : UIView

@property(nonatomic,copy) clickQQbtnBlock  ClickQQblock;
@property(nonatomic,copy) clickWXbtnBlock  ClickWXblock;
@property(nonatomic,copy) clickHelpBlock  clickHelpblock;

/**
 是否 隐藏图标  isHidden = QQ 隐藏qq ; isHidden = WX 隐藏 wx
 */
@property(nonatomic,strong) NSString * iscanhiddenView;

@end
