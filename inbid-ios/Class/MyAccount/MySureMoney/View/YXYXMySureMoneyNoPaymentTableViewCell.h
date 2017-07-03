//
//  YXYXMySureMoneyNoPaymentTableViewCell.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/26.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXMySureMoneyNopaymentModle.h"


typedef void(^ClickStatusBlock)(NSInteger status,long long cellID,NSInteger marginPrice,NSInteger alearlyprice,NSString* prodName);
@interface YXYXMySureMoneyNoPaymentTableViewCell : UITableViewCell

@property(nonatomic,strong) YXMySureMoneyNopaymentModle * NopayMentModle;

+(instancetype)creatMySureMoneyNoPaymentTableViewCell;

@property(nonatomic,copy) ClickStatusBlock  clickblock;

@end
