//
//  YXHomePageGoodList.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/1.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXHomePageGoodList : NSObject

/**
 * 商品编号
 */
//private Long prodId;
@property (nonatomic, assign) long long prodId;

//** 拍卖编号 -- 沟通后加 */
@property (nonatomic, assign) long long prodBidId;

/**
 * 商品名称
 */
//private String prodName;
@property (nonatomic, copy)NSString *prodName;

/**
 * 商品品牌名称
 */
//private String prodBrandName;
@property (nonatomic, copy)NSString *prodBrandName;

/**
 * 商品状态,1:待上架,2:上架,3:下架;4:中拍未支付；5:卖出
 */
//private Integer prodStatus;
@property (nonatomic, assign)NSInteger prodStatus;

/**
 * 拍卖状态:1=未开拍，2=拍卖中，3=中拍未支付，4=拍卖完成，5=流拍
 */
//private Integer bidStatus;
@property (nonatomic, assign)NSInteger bidStatus;

/**
 * 商品图片
 */
//private String imgUrl;
@property (nonatomic, copy)NSString *imgUrl;

/**
 * 当前价
 */
//private Long currentPrice;
@property (nonatomic, assign)long long currentPrice;

/**
 * 起拍价
 */
//private Long startPrice;
@property (nonatomic, assign)long startPrice;

/**
 * 拍卖开始时间
 */
//private Date startTime;
@property (nonatomic, copy)NSString *startTime;
/**
 * 拍卖结束时间
 */
//private Date endTime;
@property (nonatomic, copy)NSString *endTime;

//** 创建时间戳 */
@property (nonatomic, assign)NSInteger createTime;

//** 缓存图片宽 */
@property (nonatomic, assign)CGFloat imageHeight;

//** 缓存图片高 */
@property (nonatomic, assign)CGFloat imageWidth;
/**
 * 用户昵称
 */
//private String nickname;
@property (nonatomic, copy) NSString *nickname;

/**
 * 用户头像
 */
//private String head;
@property (nonatomic, copy) NSString *head;

/**
 当前页
 */
@property (nonatomic, assign) NSInteger currentPage;

//** 剩余拍卖时间 */
@property (nonatomic, assign) NSTimeInterval surplusBidTime;
//是否自营 1自营 0个人
//isSelf = 0,
@property (nonatomic, assign) NSInteger isSelf;
//是否是一口价
//bidType = 1, 1寄拍 2一口价
@property (nonatomic, assign) NSInteger bidType;

/**
 占位图片
 */
@property (nonatomic, strong) UIImage *placeHolderImage;

/**
 文字高度
 */
@property (nonatomic, assign) CGFloat goodNameTextHeight;

@end
