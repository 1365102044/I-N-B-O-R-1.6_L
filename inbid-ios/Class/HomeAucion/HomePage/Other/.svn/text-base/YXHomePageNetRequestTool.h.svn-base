//
//  YXHomePageNetRequestTool.h
//  inbid-ios
//
//  Created by 郑键 on 16/9/2.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXNetworkTool.h"

@interface YXHomePageNetRequestTool : YXNetworkTool

//** 加载广告数据 */
- (void)loadHomePageAdPictureDataWithParams:(NSDictionary *)params success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

//** 加载首页商品分类按钮数据 */
- (void)loadHomePageGoodClassificationDataWithParams:(NSDictionary *)params success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

////** 加载商品列表数据 */
//- (void)loadHomePageGoodListDataWithLabelId:(NSInteger)labelId timestamp:(NSString *)timestamp type:(NSInteger)type success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;
//
////** 加载首页全部列表 */
//- (void)loadHomePageGoodListFirstTimeWithTimestamp:(NSString *)timestamp type:(NSInteger)type success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

////** 根据分页加载首页商品列表数据 */
//- (void)loadHomePageGoodListDataWithLabelId:(long long)labelId curPage:(NSInteger)curPage pageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 首页根据条件筛选加载首页数据

 @param labelId         标签编号
 @param curPage         当前页
 @param pageSize        页面大小
 @param upDownTime      综合排序 1升序
 @param endTime         即将结束 2降序
 @param startTime       开拍时间 1升序 2降序
 @param creatTime       最新发布 2降序
 @param priceType       价格类型 1升序 2降序
 @param categoryId      分类ID
 @param brandId         品牌ID
 @param isCustomeLabel  是否是自定义标签
 */
- (void)loadHomePageGoodListDataWithLabelId:(long long)labelId
                                    curPage:(NSInteger)curPage
                                   pageSize:(NSInteger)pageSize
                                 upDownTime:(NSInteger)upDownTime
                                    endTime:(NSInteger)endTime
                                  startTime:(NSInteger)startTime
                                  creatTime:(NSInteger)creatTime
                                  priceType:(NSInteger)priceType
                                 categoryId:(long long)categoryId
                                    brandId:(long long)brandId
                             isCustomeLabel:(BOOL)isCustomeLabel
                                    success:(void (^)(id objc, id respodHeader))success
                                    failure:(void (^)(NSError *error))failure;

/**
 查询首页自定义标签品牌分类

 @param success success
 @param failure failure
 */
- (void)loadHomePageQueryLabelBrandsWithSuccess:(void (^)(id objc, id respodHeader))success
                                        failure:(void (^)(NSError *error))failure;

//** 根据分页加载全部首页列表 */
- (void)loadHomePageGoodListFirstTimeWithCurPage:(NSInteger)curPage
                                    withPageSize:(NSInteger)pageSize
                                         success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 首页品类筛选条件

 @param success success
 @param failure failure
 */
- (void)loadHomePageFirstCategoryListWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure;

/**
 版本 检查
 * @param appType 系统类型:1=ios,2=Android
 * @param appVersion 用户当前app系统版本号
 
 message  1:不需要更新  2:需要更新
 appVersion 系统最新版本号
 UpdateDesc 更新内容
 forceUpdate 是否强制更新:1=否,2=是
 */
-(void)RequestCheckVersionNumberWithCurrenAppVersion:(NSString *)appVersion
                                             success:(void (^)(id objc, id respodHeader))success
                                             failure:(void (^)(NSError *error))failure;


/**
 首页的扫码登录
 不要参数
 */
-(void)RequestScanCodeLoginWith:(NSString *)url
                        success:(void (^)(id objc, id respodHeader))success
                        failure:(void (^)(NSError *error))failure;
@end
