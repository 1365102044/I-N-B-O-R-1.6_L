//
//  YXMeMainTableOrderView.h
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/14.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXMyAccountBaseData.h"

typedef enum : NSUInteger {
    myReleaseSEL = 1,  //我发布的
    mySelloutSEL,       //我卖出的
    myBuySEL,           //我买到的
    myCheckupSEL,        //我鉴定的
    alearlyReturnSEL,     //已退回商品
    MyPlaformReturnSEL,   //平台回收
} OrderViewSelEnum;

typedef void(^clickItemBlock)(NSInteger);
@interface YXMeMainTableOrderView : UIView

@property(nonatomic,copy) clickItemBlock clickItemBlock;

@property(nonatomic,strong) YXMyAccountBaseData * orderViewModle;

@end
