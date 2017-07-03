//
//  YXSendAuctionURLMacros.h
//  inbid-ios
//
//  Created by 郑键 on 16/10/10.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#ifndef YXSendAuctionURLMacros_h
#define YXSendAuctionURLMacros_h

/**DEBUG模式测试环境 */
//#if                              DEBUG
/** 测试环境 */
//#define kOuternet                            @"http://101.200.162.3:8850"
//** 寄拍上传图片 */
#define SENDAUCTIONUOLOADIMAGE_URL           @"/api/uploadIdeOrderPic"
//** 寄拍生成鉴定订单 */
#define SENDAUCTIONIDENIFYORDER_URL          @"/api/addIdentifyOrder"
//** 寄拍获取商品配件 */
#define SENDAUCTIONGETGOODPARTS_URL          @"/api/identify/prodAcessory"
//** 寄拍获取品牌 */
#define SENDAUCTIONGETGOODBRAND_URL          @"/api/identify/prodBrand"
//** 寄拍点击删除图片 */
#define SENDAUCTIONGETDELIMAGE_URL           @"/api/delPic"

#else

#define YXHomePageBaseURL  @""

#endif

//#endif /* YXSendAuctionURLMacros_h */
