//
//  YXPickuppersonListTableViewCell.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/11/21.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPickUpPersonListModle.h"

//**点击默认**/
typedef void(^clickmorenblock)(NSString *cellid);

typedef void(^clickbianjiblock)(YXPickUpPersonListModle *modle);

typedef void(^clickremoveblock)(NSString *cellid);

@interface YXPickuppersonListTableViewCell : UITableViewCell

+(instancetype)creatMySureMoneyNoPaymentTableViewCell;

@property(nonatomic,strong) YXPickUpPersonListModle * modle;


@property(nonatomic,copy) clickremoveblock  removeblock;

@property(nonatomic,copy) clickmorenblock  morenblock;

@property(nonatomic,copy) clickbianjiblock  bianjiblock;

@end
