//
//  YXPaymentURLMacros.h
//  Payment
//
//  Created by 郑键 on 16/11/29.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#ifndef YXPaymentURLMacros_h
#define YXPaymentURLMacros_h

//** 网络请求URL */

//**支付界面的接口**/
#define PAYMENTHOMEPAGE_URL                 @"/api/pay/info"
#define PAYMENTPREPAY_URL                   @"/api/pay/pre"
//** 线下汇款--图片上传接口 */
#define LINETRANSFERUPLOADIMAGE_URL         @"/api/upLoadOfflinePayPic"
//** 线下汇款--提交生成转账记录 */
#define LINETRANSFERADDPAY_URL              @"/api/offline/addPay"
//** 线下汇款--查询转账记录信息 */
#define LINETRANSFERQUERYOFFLINEPAY_URL     @"/api/offline/queryPay"
//** 线下汇款--删除图片 */
#define LINETRANSFERDELPICTURE_URL          @"/api/delPic"
//** 支付方式--微信回到前台回调 */
#define PAYMENTHOMEPAGEWXQUERY_URL          @"/notice/pay/wxQuery"
//** 支付方式--支付宝回到前台回调 */
#define PAYMENTHOMEPAGEALIPAYQUERY_URL      @"/notice/pay/alipayQuery"

#endif /* YXPaymentURLMacros_h */
