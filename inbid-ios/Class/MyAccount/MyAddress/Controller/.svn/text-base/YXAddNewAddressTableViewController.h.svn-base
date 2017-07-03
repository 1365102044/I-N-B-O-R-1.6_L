//
//  YXAddNewAddressTableViewController.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXAddNewAddressTableViewController;
@class YXMyAddressList;

@protocol YXAddNewAddressTableViewControllerDelegate <NSObject>

//** 添加新地址 */
- (void)addNewAddressViewController:(YXAddNewAddressTableViewController *)addNewAddressViewController withProvince:(NSString *)province withCity:(NSString *)city area:(NSString *)area withPhone:(NSString *)phoneNumber withRecivceName:(NSString *)recuvceName withConsigneeAddressDetail:(NSString *)withConsigneeAddressDetail withIsDefault:(NSInteger)isDefault;
//** 修改地址 */
- (void)addNewAddressViewController:(YXAddNewAddressTableViewController *)addNewAddressViewController withProvince:(NSString *)province withCity:(NSString *)city area:(NSString *)area withPhone:(NSString *)phoneNumber withRecivceName:(NSString *)recuvceName withConsigneeAddressDetail:(NSString *)withConsigneeAddressDetail withIsDefault:(NSInteger)isDefault withAddressId:(NSInteger)addressId;

@end

@interface YXAddNewAddressTableViewController : UITableViewController

@property (nonatomic, weak)id<YXAddNewAddressTableViewControllerDelegate> delegate;

//** 点击按钮 */
@property (nonatomic, strong) UIButton *clickButton;
@property (nonatomic, strong) YXMyAddressList *addressListModel;

@end
