//
//  YXMyAddressCell.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyAddressCell;
@class YXMyAddressList;


@protocol YXMyAddressCellDelegate <NSObject>

//** 点击设置默认按钮 */
- (void)myAddressCell:(YXMyAddressCell *)myAddressCell withCurrentButton:(UIButton *)currentButton withDefaultAddressId:(NSInteger)defaultAddressId;
//** 点击删除按钮 */
- (void)myAddressCell:(YXMyAddressCell *)myAddressCell withDeleteAddressId:(NSInteger)addressId;
//** 点击编辑按钮 */
- (void)myAddressCell:(YXMyAddressCell *)myAddressCell withEditAddressModel:(YXMyAddressList *)addressListModel;

@end


@interface YXMyAddressCell : UITableViewCell

//** 模型数据 */
@property (nonatomic, strong) YXMyAddressList *addressListModel;

@property (nonatomic, weak)id<YXMyAddressCellDelegate> delegate;

@end
