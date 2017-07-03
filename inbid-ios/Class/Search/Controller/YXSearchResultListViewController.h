//
//  YXSearchResultListViewController.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/9.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^historyBlock)(NSString*str);

@interface YXSearchResultListViewController : UIViewController

@property(nonatomic,strong) NSString * itemsStr;
@property(nonatomic,strong) NSString * brandsStr;



@property(nonatomic,assign) NSInteger pageSize;


/*
 @brief 上个界面的输入的内容
 */
@property(nonatomic,strong) NSString * textstr;

/**
 是否倒计时
 */
@property (nonatomic, assign) BOOL isCountDown;


@property(nonatomic,copy) historyBlock  historystrBlock;

@end
