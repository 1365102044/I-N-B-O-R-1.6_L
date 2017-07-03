//
//  YXMyAddressList.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXMyAddressList : NSObject

/**
 * 编号
 */
//private Integer id;
@property (nonatomic, assign) long long addressId;
/**
 * 会员编号
 */
//private Long memberId;
@property (nonatomic, assign) long long memberId;
/**
 * 收货人姓名
 */
//private String consigneeName;
@property (nonatomic, copy) NSString *consigneeName;
/**
 * 收货人固定电话
 */
//private String consigneeTelephone;
@property (nonatomic, copy) NSString *consigneeTelephone;
/**
 * 收货人手机
 */
//private String consigneeMobile;
@property (nonatomic, copy) NSString *consigneeMobile;
/**
 * 收货人身份证号
 */
//private String consigneeIdcard;
@property (nonatomic, copy) NSString *consigneeIdcard;
/**
 * 收货人省份
 */
//private String consigneeProvince;
@property (nonatomic, copy) NSString *consigneeProvince;
/**
 * 收货人城市
 */
//private String consigneeCity;
@property (nonatomic, copy) NSString *consigneeCity;
/**
 * 收货人详细地址
 */
//private String consigneeAddressDetail;
@property (nonatomic, copy) NSString *consigneeAddressDetail;
/**
 * 是否设置为默认（0否，1是）
 */
//private Integer isDefault;
@property (nonatomic, assign) NSInteger isDefault;
/**
 * 创建时间
 */
//private Date createTime;
@property (nonatomic, assign) NSInteger createTime;
/**
 * 更新时间
 */
//private Date updateTime;
@property (nonatomic, assign) NSInteger updateTime;


@property(nonatomic,assign) BOOL IsHaveData;

@end
