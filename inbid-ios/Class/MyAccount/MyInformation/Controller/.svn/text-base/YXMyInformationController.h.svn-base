//
//  YXMyInformationController.h
//  MyAccount
//
//  Created by 郑键 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyAccountBaseData;

//** 保证在上传的过程中返回到个人中心界面后，在上传成功后头像也能更换 */
typedef void(^changeHeaderImageBlock)(NSString *imageurl,NSData *imagedata);

@interface YXMyInformationController : UITableViewController

@property (nonatomic, strong) YXMyAccountBaseData *accountBaseDataModel;

@property(nonatomic,copy) changeHeaderImageBlock changeImageblock;
@end
