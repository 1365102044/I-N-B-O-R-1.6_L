//
//  YXTheAccountAlearlybindingView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 2017/1/17.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXLoginViewController.h"

//typedef void(^clickBackBtn)();
typedef void(^clickkLoginBtn)();

@interface YXTheAccountAlearlybindingView : UIView
/**
 改变对应的状态
 */
-(void)setLoginTypeWith:(YXThridLoginType)type;

//@property(nonatomic,copy) clickBackBtn backBlock;
@property(nonatomic,copy)  clickkLoginBtn loginBlock;

@end
