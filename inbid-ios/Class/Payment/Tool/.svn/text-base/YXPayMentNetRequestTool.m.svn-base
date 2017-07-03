//
//  YXPayMentNetRequestTool.m
//  Payment
//
//  Created by 胤讯测试 on 16/12/1.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXPayMentNetRequestTool.h"
#import "YXPaymentURLMacros.h"
#import "YXSendAuctionProgressModel.h"

@implementation YXPayMentNetRequestTool

+(instancetype)sharedTool{
    
    static YXPayMentNetRequestTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YXPayMentNetRequestTool alloc] initWithBaseURL:[NSURL URLWithString:kOuternet]];
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

        tool.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    });
    return tool;
}

/**
 支付界面数据
 
 @param orderId orderId         订单id
 @param type type               需要支付类型
 @param success success         成功
 @param failure failure         失败
 *    * @param id  订单编号
 * @param type 支付事物类型，1=鉴定费，2=拍卖，3保证金，4=一口价
 */
- (void)loadPayMentHomePageDataWithOrderId:(long long)orderId
                            andPaymentType:(NSInteger)type
                                   success:(void (^)(id, id))success
                                   failure:(void (^)(NSError *))failure
{
    NSDictionary *params = @{@"id":[NSString stringWithFormat:@"%lld", orderId],
                             @"type":[NSString stringWithFormat:@"%zd", type]};
    
    [self requestDataWithType:POST url:PAYMENTHOMEPAGE_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 预支付接口
 
 @param orderId orderId                     订单编号
 @param payAmount payAmount                 订单支付金额
 @param paymentType PaymentType             支付类型 2微信app支付，3支付宝app支付，4apple pay，5易支付app支付
 @param transType transType                 支付事务类型 1鉴定订单，2拍卖订单，3保证金，4一口价订单
 @param isPartPay isPartPay                 是否分笔支付 0表示全额，1表示分笔
 @param isDepositPay                        是否定金支付 0表示否，1表示是
 @param success success                     成功
 @param failure failure                     失败
 */
- (void)loadPayMentPrePayDataWithOrderId:(NSString *)orderId
                            andPayAmount:(NSString *)payAmount
                          andPaymentType:(NSInteger)paymentType
                            andTransType:(NSInteger)transType
                            andIsPartPay:(NSInteger)isPartPay
                         andIsDepositPay:(NSInteger)isDepositPay
                                 success:(void (^)(id objc, id respodHeader))success
                                 failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"orderId":orderId,
                             @"payAmount":payAmount,
                             @"paymentType":[NSString stringWithFormat:@"%zd", paymentType],
                             @"transType":[NSString stringWithFormat:@"%zd", transType],
                             @"isPartPay":[NSString stringWithFormat:@"%zd", isPartPay]};
    
//    NSDictionary *params = @{@"orderId":orderId,
//                             @"payAmount":payAmount,
//                             @"paymentType":[NSString stringWithFormat:@"%zd", paymentType],
//                             @"transType":[NSString stringWithFormat:@"%zd", transType],
//                             @"isPartPay":@"1"};
    
    if (isDepositPay) {
        params = [NSMutableDictionary dictionaryWithDictionary:params];
        [params setValue:[NSString stringWithFormat:@"%zd", isDepositPay] forKey:@"isDepositPay"];
    }
    
    [self requestDataWithType:POST url:PAYMENTPREPAY_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 上传图片

 @param urlString       图片上传URL
 @param image           上传的图片
 */
- (void)upLoadImageWithUrlString:(NSString *)urlString
                        andImage:(YXSendAuctionProgressModel *)imageModel
                   andImageNamed:(NSString *)imageNamed
                         success:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure;
{
    imageModel.successed = YES;
    [self POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //把图片转换为二进制流
        NSData *imageData = UIImagePNGRepresentation(imageModel.compressImage);
        //按照表单格式把二进制文件写入formData表单
        [formData appendPartWithFileData:imageData name:imageNamed fileName:[NSString stringWithFormat:@"%d.png", 1] mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //** 进度 */
        CGFloat calculationProgress = (CGFloat)uploadProgress.completedUnitCount / (CGFloat)uploadProgress.totalUnitCount - 0.1;
        imageModel.progress = calculationProgress;
        
    }  success:^(NSURLSessionDataTask *task, id responseObject) {
        id json;
        NSError *error;
        json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        if (error) {
            json = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        }
        success(json, [self getRespodHeaderWithTask:task]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        imageModel.successed = NO;
        failure(error);
    }];
}

//** 获取响应头 */
- (id)getRespodHeaderWithTask:(NSURLSessionTask *)task
{
    NSHTTPURLResponse *respond = (NSHTTPURLResponse *)task.response;
    return respond.allHeaderFields;
}

- (void)loadPayMentZbarPayDataWithOrderId:(NSString *)orderId
                             andorderType:(NSInteger)orderType
                                andUserID:(NSString *)UserID
                              andclientID:(NSString*)clientID
                                   andUrl:(NSString*)Url
                                  success:(void (^)(id objc, id respodHeader))success
                                  failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *params = @{@"orderId":orderId,
                             @"orderType":[NSString stringWithFormat:@"%ld",(long)orderType],
                             @"id":UserID,
                             @"clientId":clientID,
                             };
    [self requestDataWithType:POST url:Url params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 提交生成上传凭证
 
 @param orderId orderId                     订单/保证金编号
 @param prodName prodName                   商品名称
 @param orderPayAmount orderPayAmount       金额
 @param paymentUrl paymentUrl               图片地址
 @param orderType orderType                 支付类型 1.鉴定费 2.拍卖订单 3.保证金 4.一口价订单
 */
- (void)offLineAddPayWithOrderId:(NSString *)orderId
                     andProdName:(NSString *)prodName
               andOrderPayAmount:(NSString *)orderPayAmount
                   andPaymentUrl:(NSString *)paymentUrl
                    andOrderType:(NSInteger)orderType
                         success:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"orderId":orderId,
                             @"prodName":prodName,
                             @"orderPayAmount":orderPayAmount,
                             @"paymentUrl":paymentUrl,
                             @"orderType":[NSString stringWithFormat:@"%zd", orderType]
                             };
    [self requestDataWithType:POST url:LINETRANSFERADDPAY_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 查询线下汇款信息
 
 @param orderId                             订单
 */
- (void)queryPayWithOrderId:(NSString *)orderId
                    success:(void (^)(id objc, id respodHeader))success
                    failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"orderId":orderId};
    [self requestDataWithType:POST url:LINETRANSFERQUERYOFFLINEPAY_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 删除图片
 
 @param imageURLString                      图片urlString
 @param success                             成功
 @param failure                             失败
 */
- (void)delPicWithImageURLString:(NSString *)imageURLString
                         success:(void (^)(id objc, id respodHeader))success
                         failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"filename":imageURLString};
    
    [self requestDataWithType:POST url:LINETRANSFERDELPICTURE_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 微信回到前台回调
 
 @param transactionId                       微信订单号
 @param paymentId                           商户订单号
 @param type                                事务类型
 */
- (void)noticePayWXQueryWithTransactionId:(NSString *)transactionId
                             andpaymentId:(NSString *)paymentId
                                  andType:(NSInteger)type
                                  success:(void (^)(id objc, id respodHeader))success
                                  failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"paymentId":paymentId,
                             @"type":[NSString stringWithFormat:@"%zd", type]};
    
    [self requestDataWithType:POST url:PAYMENTHOMEPAGEWXQUERY_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 支付宝回到前台回调
 
 @param transactionId                       支付宝支付单号
 @param paymentId                           商户支付订单单号
 @param type                                事务类型 1.鉴定订单 2.拍卖订单 3.保证金 4.一口价订单
 */
- (void)noticePayAlipayQueryWithTradeNo:(NSString *)TradeNo
                             outTradeNo:(NSString *)outTradeNo
                                andType:(NSInteger)type
                                success:(void (^)(id objc, id respodHeader))success
                                failure:(void (^)(NSError *error))failure
{
    NSDictionary *params = @{@"outTradeNo":outTradeNo,
                             @"type":[NSString stringWithFormat:@"%zd", type]};
    
    [self requestDataWithType:POST url:PAYMENTHOMEPAGEALIPAYQUERY_URL params:params success:^(id objc, id respodHeader) {
        success(objc, respodHeader);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
