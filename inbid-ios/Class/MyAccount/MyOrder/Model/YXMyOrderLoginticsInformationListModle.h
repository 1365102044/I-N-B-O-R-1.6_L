//
//  YXMyOrderLoginticsInformationListModle.h
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXMyOrderLoginticsInformationListModle : NSObject

@property(nonatomic,copy) NSString * address;

@property(nonatomic,copy) NSString * time;

@property(nonatomic,copy) NSString * remark;


/*
 @brief headerview data
 */

@property(nonatomic,strong) NSString * prodName;

@property(nonatomic,strong) NSString * deliveryStatus;

/*
 @brief 承运公司
 */
@property(nonatomic,strong) NSString * deliveryMerchant;

/*
 @brief 快递单号
 */
@property(nonatomic,strong) NSString * deliveryNum;

/*
 @brief 收货人
 */
@property(nonatomic,strong) NSString * consigneeName;
/*
 @brief 电话
 */
@property(nonatomic,strong) NSString * consigneeMobile;


@property(nonatomic,strong) NSString * consigneeAddressDetail;

@property(nonatomic,strong) NSString * consigneeProvince;

@property(nonatomic,strong) NSString * consigneeCity;


@end
