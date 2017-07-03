//
//  YXMyAccountDeatilViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/20.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccountDeatilViewController.h"
#import "YXMyAccountAboutUSViewController.h"
#import "NSString+File.h"
#import "YXMyAccountNetRequestTool.h"
#import "JPush.h"
#import "YXMyAccountFeedbookViewController.h"
#import "YXSaveLoginDataTool.h"

@interface YXMyAccountDeatilViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clearimage;
@property (weak, nonatomic) IBOutlet UILabel *CacheLable;
@property (weak, nonatomic) IBOutlet UILabel *NumberLable;

//**退出登录**/
@property (weak, nonatomic) IBOutlet UIButton *TuiChuLoginBtn;

@property (weak, nonatomic) IBOutlet UIView *feedbookview;

@property (weak, nonatomic) IBOutlet UIView *boomviewline;

@property(nonatomic,assign) double  cacheNumber;

@end

@implementation YXMyAccountDeatilViewController
- (IBAction)clickbigview1:(id)sender {
    
    YXMyAccountAboutUSViewController*aboutusVC = [[YXMyAccountAboutUSViewController alloc]init];
    [self.navigationController pushViewController:aboutusVC animated:YES];
    
}

- (IBAction)clickbigview2:(id)sender {

    
    
    if ([self.NumberLable.text isEqualToString:@"(0.00M)"]) {
        return;
    }
    
    //提示
    [SVProgressHUD showWithStatus:@"正在清除缓存"];
    
    //清理
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imageCachesPath = [cachesPath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    NSString *NetImageCachesPath = [cachesPath stringByAppendingPathComponent:@"com.bjInborn/fsCachedData"];
    
    NSFileManager *mgr = [[NSFileManager alloc] init];
    [mgr removeItemAtPath:imageCachesPath error:nil];
    [mgr removeItemAtPath:NetImageCachesPath error:nil];
    


    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1/(self.cacheNumber*10) target:self selector:@selector(UpdateTime:) userInfo:nil repeats:YES];
    [timer fire];


}
-(void)UpdateTime:(NSTimer*)timer
{
    
    if (self.cacheNumber <= 0.10) {
        self.cacheNumber = 0.00;
        self.CacheLable.text = @"(0.00M)";

        [timer invalidate];
        //隐藏
        [SVProgressHUD dismiss];
        return;
    }
    self.cacheNumber = self.cacheNumber - 0.1;
    self.CacheLable.text = [NSString stringWithFormat:@"(%.2fM)",self.cacheNumber];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearimage.hidden = YES;
    self.title = @"设置";
    
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imageCachesPath = [cachesPath stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    NSString *NetImageCachesPath = [cachesPath stringByAppendingPathComponent:@"com.inbid-ios.www.cn/fsCachedData"];
    long long fileSize = [imageCachesPath fileSize];
    long long NetFileSize = [NetImageCachesPath fileSize];//fsCachedData
    self.CacheLable.text = [NSString stringWithFormat:@"(%.2fM)",(fileSize + NetFileSize) / (1000.0 * 1000.0) ];
    self.cacheNumber = (fileSize + NetFileSize) / (1000.0 * 1000.0);
    
    self.TuiChuLoginBtn.layer.cornerRadius = 3;
    self.TuiChuLoginBtn.layer.masksToBounds = YES;
    
    
    if ([[YXLoginStatusTool sharedLoginStatus] getTokenId]) {
        self.TuiChuLoginBtn.hidden = NO;
        
    }else
    {
        self.TuiChuLoginBtn.hidden = YES;
        self.feedbookview.hidden = YES;
        self.boomviewline.hidden = YES;
    }
    
    
    
    
}

/*
 @brief 意见反馈
 */
- (IBAction)clickfeedbookview:(id)sender {
    
    YXMyAccountFeedbookViewController *feedbookVC = [[YXMyAccountFeedbookViewController alloc]init];
    [self.navigationController pushViewController:feedbookVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ClickTuichuLoginBtn:(id)sender {
    
    [self showAlert];
    
}
//** 弹出登录或未登录alert */
- (void)showAlert
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"退出登录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){
    }];
    UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *actoin){
        [[YXMyAccountNetRequestTool sharedTool] logOutWithSuccess:^(id objc, id respodHeader) {
            
            if ([objc isEqualToString:@"退出成功"]) {
                [self setuserinfromationISnil];
            }
            
            /*
             @brief 在tabbar上进入个人中心的时候 登录判断用的标示
             */
            [YXUserDefaults setObject:@"3" forKey:@"FromeMianLoginSatus"];
            self.tabBarController.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSError *error) {
            
        }];
        
    }];
    [alert addAction:defaultAction];
    [alert addAction:sureAction];//代码块前的括号是代码块返回的数据类型
    [self presentViewController: alert animated:YES completion:nil];
    
}
/*
 @brief 退出登录的时候 清空保存的数据
 */
-(void)setuserinfromationISnil
{
    [[YXSaveLoginDataTool shared] loginOutClearUserData];
}

@end
