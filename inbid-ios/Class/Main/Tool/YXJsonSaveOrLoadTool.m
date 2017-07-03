//
//  YXJsonSaveOrLoadTool.m
//  inbid-ios
//
//  Created by 胤讯测试 on 2017/2/9.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXJsonSaveOrLoadTool.h"

@implementation YXJsonSaveOrLoadTool
+(instancetype)shareTool{
    static dispatch_once_t onceToken;
    static YXJsonSaveOrLoadTool *instance;
    dispatch_once(&onceToken, ^{
        
        instance = [[YXJsonSaveOrLoadTool alloc]init];
    });
    return instance;
}

//** 保存 */
-(void)SaveJsonWith:(id)dict UrlType:(NSString *)urlType{

    if (dict == nil || dict == [NSNull null]) {
        return;
    }
    if (urlType.length==0) {
        urlType = @"test";
    }
    NSString * path = [self pathForDataFile:urlType];
    YXLog(@"---savepath---%@",path);
    [dict writeToFile:path atomically:YES];
    
}
//** 加载 */
-(NSMutableDictionary*)loadJsonFormFile:(NSString *)urlType
{
    NSString  * path = [self pathForDataFile:urlType];
    NSMutableDictionary * rootObject = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    if (rootObject == nil ) {
        rootObject = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return rootObject;
}

-(NSString *)pathForDataFile:(NSString *)urltype {
    
    NSArray* documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = nil;

    if (documentDir) {
        path = [documentDir objectAtIndex:0];
    }
    return [NSString stringWithFormat:@"%@/%@.%@", path,urltype,@"json"];
}




@end

