//
//  YXImmediatelyMailContentController.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXOrderDetailModel;

@interface YXImmediatelyMailContentController : UITableViewController

//** 数据 */
@property (nonatomic, strong) YXOrderDetailModel *orderDetailModel;
//** 当前选中的邮寄方式 */
@property (nonatomic, strong) UIButton *currentButton;
//** 选择快递 */
@property (weak, nonatomic) IBOutlet UITextField *expressNameTextField;
//** 快递单号 */
@property (weak, nonatomic) IBOutlet UITextField *expressOrderNumberTextField;

/**
 快递编号
 */
@property (nonatomic, assign) NSInteger currentExpressId;
@end
