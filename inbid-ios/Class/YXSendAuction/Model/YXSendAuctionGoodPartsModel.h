//
//  YXSendAuctionGoodPartsModel.h
//  inbid-ios
//
//  Created by 郑键 on 16/11/16.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXSendAuctionGoodPartsModel : NSObject

/**
 * 编号
 */
//private Integer id;
@property (nonatomic, assign) long long partId;
/**
 * 数据类型
 */
//private String dataType;
@property (nonatomic, copy) NSString *dataType;
/**
 * 数据键
 */
//private Integer dataKey;
@property (nonatomic, assign) long long dataKey;
/**
 * 数据值
 */
//private String dataValue;
@property (nonatomic, copy) NSString *dataValue;
/**
 * 描述
 */
//private String description;
@property (nonatomic, copy) NSString *partDescription;
/**
 * 是否禁用：1为是，0为否
 */
//private Integer isDisable;
@property (nonatomic, assign) NSInteger isDisable;
//private Date createTime;

//private Date updateTime;

@end
