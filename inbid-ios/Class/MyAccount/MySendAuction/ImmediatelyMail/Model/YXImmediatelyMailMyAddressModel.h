//
//  YXImmediatelyMailMyAddressModel.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/29.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXImmediatelyMailMyAddressModel : NSObject

//consigneePhone = "15837688987",
//consigneeName = "呛口小辣椒",
//consigneeAdress = "北京市朝阳区望京东路8号锐创国际中心A座20层"

@property (nonatomic, copy) NSString *customerPhone;
@property (nonatomic, copy) NSString *consigneeAddress;
@property (nonatomic, copy) NSString *consigneeName;
@property (nonatomic, copy) NSString *consigneePhone;
@property (nonatomic, copy) NSString *businessTime;

@end
