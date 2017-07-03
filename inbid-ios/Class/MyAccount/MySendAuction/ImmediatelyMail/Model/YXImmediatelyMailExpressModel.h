//
//  YXImmediatelyMailExpressModel.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXImmediatelyMailExpressModel : NSObject

//id = 1,
//expressName = "顺丰快递",
@property (nonatomic, assign) NSInteger expressId;
@property (nonatomic, copy) NSString *expressName;

@end
