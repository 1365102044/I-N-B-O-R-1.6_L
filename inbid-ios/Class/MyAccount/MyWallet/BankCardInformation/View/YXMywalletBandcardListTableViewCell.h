//
//  YXMywalletBandcardListTableViewCell.h
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/22.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXBankCardDetailInformationModel.h"

@interface YXMywalletBandcardListTableViewCell : UITableViewCell
@property(nonatomic,strong) NSString * namestr;
@property(nonatomic,strong) YXBankCardDetailInformationModel * listModle;
@end
