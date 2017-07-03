//
//  YXAlertViewTool.m
//  Payment
//
//  Created by 胤讯测试 on 16/11/30.
//  Copyright © 2016年 胤宝. All rights reserved.
//

#import "YXAlertViewTool.h"
#define IAIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface YXAlertViewTool ()

@property(copy,nonatomic)void (^cancelClicked)();

@property(copy,nonatomic)void (^confirmClicked)();

@end

@implementation YXAlertViewTool

+ (void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelButtonTitle otherTitle:(NSString *)otherButtonTitle cancelBlock:(void (^)())cancle confrimBlock:(void (^)())confirm{
    
    if (IAIOS8) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        alertController.view.tintColor = [UIColor mainThemColor];
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            cancle();
            
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            confirm();
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        
        UIAlertView *TitleAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle,nil];
        [TitleAlert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
        if (self.cancelClicked) {
            self.cancelClicked();
        }
    }
    else{
        if (self.confirmClicked) {
            self.confirmClicked();
        }
        
    }
}

/**
 只有一个确定按钮
 */
+(void)showAlertView:(UIViewController *)viewController title:(NSString*)title message:(NSString *)message confrimBlock:(void(^)())comfirm;
{
    if (IAIOS8) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        alertController.view.tintColor = [UIColor mainThemColor];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            comfirm();
        }];
        
        // Add the actions.
        [alertController addAction:otherAction];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        
        UIAlertView *TitleAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"" otherButtonTitles:@"确定",nil];
        
        [TitleAlert show];
    }

}

/**
 alertView底部弹窗
 
 @param viewController      viewController
 @param titlesArray         标题数组
 @param messageArray        信息数组
 @param comfirm             回调
 */
+ (void)showAlertView:(UIViewController *)viewController
           totalTitle:(NSString *)totalTitle
          titlesArray:(NSArray<NSString *> *)titlesArray
         messageArray:(NSArray<NSString *> *)messageArray
         confrimBlock:(void (^)(NSString *))comfirm
{
    if (IAIOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:totalTitle message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        alertController.view.tintColor = [UIColor mainThemColor];
        for (NSString *title in titlesArray) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:title
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *action) {
                                                                    comfirm(title);
                
            }];
            [alertController addAction:otherAction];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {}];
        [alertController addAction:cancelAction];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        
//        UIAlertView *TitleAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"" otherButtonTitles:@"确定",nil];
//        
//        [TitleAlert show];
    }
}
@end
