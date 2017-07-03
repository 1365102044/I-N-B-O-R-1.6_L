//
//  YXMyAccountFollowAuctionList.h
//  MyAccount
//
//  Created by 郑键 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXMyAccountFollowAuctionList : NSObject
/**
 * 关注编号
 */
//private Long id;
@property (nonatomic, assign) long long followId;
/**
 * 拍品编号
 */
//private Long prodBidId;
@property (nonatomic, assign) long long prodBidId;
/**
 * 商品编号
 */
//private Long prodId;
@property (nonatomic, assign) long long prodId;
/**
 * 商品名称
 */
//private String prodName;
@property (nonatomic, copy) NSString *prodName;
/**
 * 商品图片地址
 */
//private String imgUrl;
@property (nonatomic, copy) NSString *imgUrl;
/**
 * 拍卖开始时间
 */
//private Date startTime;
@property (nonatomic, copy) NSString  *startTime;
/**
 * 拍卖结束时间
 */
//private Date endTime;
@property (nonatomic, copy) NSString *endTime;
/**
 * 起拍价格
 */
//private Long startPrice;
@property (nonatomic, assign) NSInteger startPrice;
/**
 * 拍卖状态：1=未开拍，2=拍卖中，3=中拍未支付，4=拍卖完成，5=流拍
 */
//private Integer bidStatus;
@property (nonatomic, assign) NSInteger bidStatus;
/**
 * 关注人数
 */
//private Integer memCount;
@property (nonatomic, assign) NSInteger memCount;

/**
 * 加价按钮显示：0=参与竞拍，大于0=我要加价
 */
//private Integer hasOffered
@property (nonatomic, assign) NSInteger hasOffered;

@property (nonatomic, assign) NSInteger currentPage;
//是否是一口价
//bidType = 1, 1寄拍 2一口价
@property (nonatomic, assign) NSInteger bidType;

/**
 当前价--一口价
 */
@property (nonatomic, assign) long long currentPrice;

@end
