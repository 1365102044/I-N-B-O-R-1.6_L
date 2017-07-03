//
//  YXHomePageNetRequestTool.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/2.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomePageNetRequestTool.h"
#import "YXHomePageURLMacros.h"


@implementation YXHomePageNetRequestTool

+(instancetype)sharedTool{
    
    static YXHomePageNetRequestTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YXHomePageNetRequestTool alloc] initWithBaseURL:[NSURL URLWithString:kOuternet]];
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        //        tool.requestSerializer = [AFJSONRequestSerializer serializer];
        tool.responseSerializer = [AFHTTPResponseSerializer serializer];

//        tool.securityPolicy.allowInvalidCertificates = YES;
//        tool.securityPolicy.validatesDomainName = NO;
        
        //** 解决http请求重定向 */
//        [tool setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSURLResponse * _Nonnull response, NSURLRequest * _Nonnull request) {
//            return nil;
//        }];
        
    });
    return tool;
}

//** 加载首页广告数据 */
- (void)loadHomePageAdPictureDataWithParams:(NSDictionary *)params success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [self requestDataWithType:POST url:HOMEPAGEADPICTURE_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 加载首页商品分类按钮数据 */
- (void)loadHomePageGoodClassificationDataWithParams:(NSDictionary *)params success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [self requestDataWithType:POST url:HOMEPAGECLASSIFICATION_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

////** 加载首页商品列表数据 */
//- (void)loadHomePageGoodListDataWithLabelId:(NSInteger)labelId timestamp:(NSString *)timestamp type:(NSInteger)type success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
//{
//    NSDictionary *params = @{@"labelId": [NSString stringWithFormat:@"%zd", labelId],
//                             @"timestamp":timestamp,
//                             @"pageSize":@"10",
//                             @"type":[NSString stringWithFormat:@"%zd", type]};
//    
//    [self requestDataWithType:POST url: HOMEPAHEGOODLIST_URL params:params success:^(id objc, id respodHeader) {
//        success(objc, respodHeader);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}

////** 加载首页全部列表 */
//- (void)loadHomePageGoodListFirstTimeWithTimestamp:(NSString *)timestamp type:(NSInteger)type success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
//{
//    NSDictionary *params = @{@"timestamp":timestamp,
//                             @"pageSize":@"12",
//                             @"type":[NSString stringWithFormat:@"%zd", type]};
//    
//    [self requestDataWithType:POST url: HOMEPAGEGOODLISTFIRSTTIME_URL params:params success:^(id objc, id respodHeader) {
//        success(objc, respodHeader);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}

////** 根据分页加载首页商品列表数据 */
//- (void)loadHomePageGoodListDataWithLabelId:(long long)labelId curPage:(NSInteger)curPage pageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
//{
//    NSDictionary *params = @{@"labelId": [NSString stringWithFormat:@"%lld", labelId],
//                             @"curPage": [NSString stringWithFormat:@"%zd", curPage],
//                             @"pageSize": [NSString stringWithFormat:@"%zd", pageSize]};
//    
//    [self requestDataWithType:POST url:HOMEPAHEGOODLIST_URL params:params success:^(id objc, id respodHeader) {
//        success(objc, respodHeader);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}

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
                                    failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%zd", curPage] forKey:@"curPage"];
    [params setValue:[NSString stringWithFormat:@"%zd", pageSize] forKey:@"pageSize"];
    
    NSString *urlString;
    if (!isCustomeLabel) {
        [params setValue:[NSString stringWithFormat:@"%lld", labelId] forKey:@"labelId"];
        urlString = HOMEPAHEGOODLIST_URL;
    }else{
        [params setValue:[NSString stringWithFormat:@"%lld", brandId] forKey:@"brandId"];
        urlString = HOMEPAHEGOODLIST_URL;
    }
    
    if (upDownTime) {
        [params setValue:[NSString stringWithFormat:@"%zd", upDownTime] forKey:@"upDownTime"];
    }else if (endTime) {
        [params setValue:[NSString stringWithFormat:@"%zd", endTime] forKey:@"endTime"];
    }else if (startTime) {
        [params setValue:[NSString stringWithFormat:@"%zd", startTime] forKey:@"startTime"];
    }else if (creatTime) {
        [params setValue:[NSString stringWithFormat:@"%zd", creatTime] forKey:@"createTime"];
    }else if (priceType) {
        [params setValue:[NSString stringWithFormat:@"%zd", priceType] forKey:@"priceType"];
    }else if (categoryId) {
        [params setValue:[NSString stringWithFormat:@"%lld", categoryId] forKey:@"categoryId"];
    }
    
    [self requestDataWithType:POST url:urlString params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 查询首页自定义标签品牌分类
 
 @param success success
 @param failure failure
 */
- (void)loadHomePageQueryLabelBrandsWithSuccess:(void (^)(id objc, id respodHeader))success
                                        failure:(void (^)(NSError *error))failure
{
    [self requestDataWithType:POST url:HOMEPAGEQUERYLABELBRANDS_URL params:nil success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//** 根据分页加载全部首页列表 */
- (void)loadHomePageGoodListFirstTimeWithCurPage:(NSInteger)curPage withPageSize:(NSInteger)pageSize success:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"curPage": [NSString stringWithFormat:@"%zd", curPage],
                             @"pageSize": [NSString stringWithFormat:@"%zd", pageSize]};
    
    [self requestDataWithType:POST url:HOMEPAGEGOODLISTFIRSTTIME_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 首页品类筛选条件
 
 @param success success
 @param failure failure
 */
- (void)loadHomePageFirstCategoryListWithSuccess:(void (^)(id objc, id respodHeader))success failure:(void (^)(NSError *error))failure
{
    [self requestDataWithType:POST url:HOMEPAGEFIRSTCATEGORYLIST_URL params:@{} success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



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
                                    failure:(void (^)(NSError *error))failure{
    
    NSDictionary *params = @{@"appType": @"1",
                             @"appVersion": appVersion};
    
    [self requestDataWithType:POST url:CHECKAPPVERSION_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

/**
 首页的扫码登录
 不要参数
 */
-(void)RequestScanCodeLoginWith:(NSString *)url
                        success:(void (^)(id objc, id respodHeader))success
                        failure:(void (^)(NSError *error))failure{

    [self requestDataWithType:POST url:url params:nil success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];

}
@end
