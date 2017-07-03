//
//  YXSearchTextFiledTableViewCell.h
//  inbid-ios
//
//  Created by 刘文强 on 2016/11/14.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickremoveblock)(NSString *textstr);

@interface YXSearchTextFiledTableViewCell : UITableViewCell

+(instancetype)creatsearchtextfiledNotilistTableViewCell;

@property (weak, nonatomic) IBOutlet UILabel *texttitleLable;

@property(nonatomic,copy) clickremoveblock  removebalcok;

@end
