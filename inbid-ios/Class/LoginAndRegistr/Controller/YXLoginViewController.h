//
//  YXLoginViewController.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/31.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 YXQQLogin          QQ登录
 YXWeiChatLogin     微信登录
 */
typedef NS_ENUM(NSUInteger, YXThridLoginType) {
    YXWeiChatLogin = 1,
    YXQQLogin
};

typedef BOOL(^fomeTabbarpushLoginBlock)(NSString *typeStr);

@interface YXLoginViewController : YXMainKeyBoaryViewController
/**
 formeTabarVC，tabbarvc跳转的标示
 FormeOffLineVC , 被挤掉线的过来的标示
 */
@property(nonatomic,strong) NSString * fromeVC;
@property(nonatomic,assign) NSInteger  tabbatlastselectindex;

@property (nonatomic, copy) fomeTabbarpushLoginBlock pushVCBlock;
//从挤掉线过来的
-(void)FormeOffLineViewControllerWith:(NSString *)fromeVC GoodsDict:(NSDictionary *)GoodsDict;
@end
