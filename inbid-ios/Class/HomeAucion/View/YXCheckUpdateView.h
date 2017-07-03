//
//  YXCheckUpdateView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/3.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXVersionModle.h"
typedef void(^clickUpdateBtn)(NSString *type);

@interface YXCheckUpdateView : UIView



@property(nonatomic,copy) clickUpdateBtn  UpdateBlock;

@property(nonatomic,strong) YXVersionModle * versionModle;
@end
