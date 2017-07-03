//
//  YXMyInformationBaseTableViewController.h
//  MyAccount
//
//  Created by 郑键 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyInformationBaseTableViewController;

@protocol YXMyInformationBaseDelegate <NSObject>

- (void)editBaseInformationWithMyInformationController:(YXMyInformationBaseTableViewController *)baseController withInformation:(NSString *)information;
- (void)editBaseInformationWithMyInformationController:(YXMyInformationBaseTableViewController *)baseController withOldPwd:(NSString *)oldPwd withNewPwd:(NSString *)newPwd;
- (void)editBaseInformationWithMyInformationController:(YXMyInformationBaseTableViewController *)baseController withInformationNickName:(NSString *)informationNickName;
@end

@interface YXMyInformationBaseTableViewController : UITableViewController

@property (nonatomic, weak)id<YXMyInformationBaseDelegate> delegate;

//** 发送网络请求 */
- (void)sureButtonClick:(UIButton *)sender;

@end
