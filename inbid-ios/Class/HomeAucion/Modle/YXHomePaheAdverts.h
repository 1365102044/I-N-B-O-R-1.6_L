//
//  YXHomePaheAdverts.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/1.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHomePaheAdverts : NSObject
/**
 * 广告编号
 */
//private Long id;
@property (nonatomic, assign)NSInteger adID;
/**
 * 广告图片地址
 */
//private String imgUrl;
@property (nonatomic, copy)NSString *imgUrl;
/**
 * 关联编号，type为1时表示商品编号
 */
//private Long refId;
@property (nonatomic, assign)NSInteger refId;
/**
 * 广告类型：1表示商品广告，2表示活动广告
 */
//private Integer type;
@property (nonatomic, assign)NSInteger type;
/**
 * 广告活动外链地址
 */
//private String url;
@property (nonatomic, copy)NSString *url;
@end
