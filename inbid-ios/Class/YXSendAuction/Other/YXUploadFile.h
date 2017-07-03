//
//  YXUploadFile.h
//  YXSendAuction
//
//  Created by 郑键 on 16/10/9.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXUploadFile : NSObject

/**
 上传图片（支持批量上传）

 @param images    images（图片数组）
 @param urlString urlString（上传图片地址）
 */
- (void)uploadImagesWithImagesArray:(NSArray *)images andUploadImageUrlString:(NSString *)urlString;

@end
