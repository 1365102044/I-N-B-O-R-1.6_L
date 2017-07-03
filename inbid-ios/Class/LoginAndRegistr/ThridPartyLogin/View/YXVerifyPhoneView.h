//
//  YXVerifyPhoneView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/3.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXInputPhoneNumberViewController.h"

@interface YXVerifyPhoneView : UIView

-(void)setPhoneTextFiled:(NSString *)phone AccountStatus:(YXBindingPhoneType)TheAccountStatus;

@end
