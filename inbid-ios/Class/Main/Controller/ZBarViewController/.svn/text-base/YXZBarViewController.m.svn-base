//
//  YXZBarViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXZBarViewController.h"
#import "ZJScanningController.h"

@interface YXZBarViewController ()


@end


@implementation YXZBarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark <AVCaptureMetadataOutputObjectsDelegate>

/**
 扫描结果代理
 
 @param captureOutput               captureOutput
 @param metadataObjects             metadataObjects
 @param connection                  connection
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    [super captureOutput:captureOutput
didOutputMetadataObjects:metadataObjects
          fromConnection:connection];
    
    /**
     *  设置界面显示扫描结果
     */
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSLog(@"metadataObjects = %@", metadataObjects);
        
        if ([obj.stringValue hasPrefix:@"http"]) {
            
            [self restartSession];
            
        } else {
            
            /**
             *  扫描结果为条形码
             */
            if ([self.delegate respondsToSelector:@selector(zBarViewController:andText:)]) {
                [self.delegate zBarViewController:self andText:obj.stringValue];
            }
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

//-( void )readerView:( ZBarReaderView *)readerView didReadSymbols:( ZBarSymbolSet *)symbols fromImage:( UIImage *)image
//{
//    
//    const zbar_symbol_t *symbol = zbar_symbol_set_first_symbol (symbols. zbarSymbolSet );
//    
//    NSString *symbolStr = [ NSString stringWithUTF8String : zbar_symbol_get_data (symbol)];
//    
//    
//    //判断是否包含 头'http:'
//    
//    NSString *regex = @"http+:[^\\s]*" ;
//    
//    NSPredicate *predicate = [ NSPredicate predicateWithFormat : @"SELF MATCHES %@" ,regex];
//   
////    UIAlertView *alertView=[[ UIAlertView alloc ] initWithTitle : @"" message :symbolStr delegate : nil cancelButtonTitle : @"取消" otherButtonTitles : nil ];
////    
////    [alertView show ];
//    if ([self.delegate respondsToSelector:@selector(zBarViewController:andText:)]) {
//        [self.delegate zBarViewController:self andText:symbolStr];
//    }
//    
//    //判断是否包含 头'ssid:'
//    
//    NSString *ssid = @"ssid+:[^\\s]*" ;;
//    
//    NSPredicate *ssidPre = [ NSPredicate predicateWithFormat : @"SELF MATCHES %@" ,ssid];
//    
//    
//    if ([predicate evaluateWithObject :symbolStr]) {
//        
//        
//    }
//    
//    else if ([ssidPre evaluateWithObject :symbolStr]){
//        
//        NSArray *arr = [symbolStr componentsSeparatedByString : @";" ];
//        NSArray * arrInfoHead = [[arr objectAtIndex : 0 ] componentsSeparatedByString : @":" ];
//        NSArray * arrInfoFoot = [[arr objectAtIndex : 1 ] componentsSeparatedByString : @":" ];
//        symbolStr = [ NSString stringWithFormat : @"ssid: %@ \n password:%@" ,
//                     [arrInfoHead objectAtIndex : 1 ],[arrInfoFoot objectAtIndex : 1 ]];
//        UIPasteboard *pasteboard=[ UIPasteboard generalPasteboard ];
//        //然后，可以使用如下代码来把一个字符串放置到剪贴板上：
//        pasteboard. string = [arrInfoFoot objectAtIndex : 1 ];
//        
//    }
//}

@end
