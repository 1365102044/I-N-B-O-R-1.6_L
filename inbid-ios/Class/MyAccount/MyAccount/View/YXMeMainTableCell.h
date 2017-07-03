//
//  YXMeMainTableCell.h
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/14.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXMyAccountBaseData.h"

@interface YXMeMainTableCell : UIView
@property(nonatomic,strong) NSString * cellname;
//@property(nonatomic,copy) NSIndexPath*  indexPath;
/**
 基本信息
 */
//@property (nonatomic, strong) YXMyAccountBaseData *baseDataModel;

-(void)SetBaseMyAccountInforModle:(YXMyAccountBaseData *)Model indexPath:(NSIndexPath *)indexPath titleArr:(NSArray *)titleArr;

@end
