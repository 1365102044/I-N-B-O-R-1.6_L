//
//  YXAddNewAddressViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyAddressList;

@interface YXAddNewAddressViewController : UIViewController

@property (nonatomic, strong) YXMyAddressList *addressListModel;

/**
 来源控制器
 */
@property (nonatomic, strong) UIViewController *sourceController;

/**
 title文字
 */
@property (nonatomic, copy) NSString *titleText;

@end
