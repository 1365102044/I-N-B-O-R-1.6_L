//
//  YXMyAccountThridPartyTableViewCell.h
//  inbid-ios
//
//  Created by 胤讯测试 on 2017/1/13.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXMyAccountThridPartyTableViewCell : UITableViewCell
/**
 第三方登录
 */
@property(nonatomic,strong) NSDictionary * dataDict;

//账户安全，实名认证
@property(nonatomic,strong) NSString * namestr;

@end
