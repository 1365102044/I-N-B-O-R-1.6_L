//
//  YXMyAddressListController.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXMyAddressList;

typedef void(^ADDaddressblock)();

//**一口价的确认订单界面过来的选择收货地址**/
typedef void(^chooseaddressBlock)(YXMyAddressList *modle);

@interface YXMyAddressListController : UIViewController


@property(nonatomic,copy) ADDaddressblock  addressblock;

@property(nonatomic,assign) NSInteger  formetype;

@property (nonatomic, strong) UIViewController *sourceController;

@property(nonatomic,copy) chooseaddressBlock    modleblock;

@end
