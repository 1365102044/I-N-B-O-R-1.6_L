//
//  YXApplyRefundHeaderView.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXApplyRefundSultModle.h"
// tag :100 提交数据。200 验证码
typedef void (^clickcommitbtnblock)(NSInteger tag,NSString *smscode);
@interface YXApplyRefundHeaderView : UIView

+(instancetype)loadheaderview;

@property(nonatomic,copy)  clickcommitbtnblock clickBlock;
@property(nonatomic,strong) YXApplyRefundSultModle * RefundModle;

@property (weak, nonatomic) IBOutlet UIButton *SmsBtn;
@property (weak, nonatomic) IBOutlet UITextField *SmsTextfiled;
@end
