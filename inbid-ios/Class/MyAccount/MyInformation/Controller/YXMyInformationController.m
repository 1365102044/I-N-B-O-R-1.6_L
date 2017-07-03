//
//  YXMyInformationController.m
//  MyAccount
//
//  Created by 郑键 on 16/9/5.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyInformationController.h"
#import "YXMyAccountBaseData.h"
#import "YXMyInformationBaseTableViewController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXMyInformationPwdController.h"
#import "YXMyInformationEmailController.h"
#import "YXMyInformationPhoneNumberController.h"
#import "UIColor+YXColor_Extension.h"
#import <UIImageView+WebCache.h>
#import "JPush.h"
#import "ImagePicker.h"
#import "UIImage+YXExtension.h"
#import "twlt_uuid_util.h"

@interface YXMyInformationController ()<YXMyInformationBaseDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userSexLabel;
@property (weak, nonatomic) IBOutlet UILabel *userBirthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *usreMailLabel;
@property (nonatomic, strong) UIDatePicker *picker;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (nonatomic, strong) UIToolbar *customAccessoryView;
//** 蒙板视图 */
@property (nonatomic, strong) UIView *birthdayBackgroundBlackView;
@property(nonatomic,assign) BOOL  haveIconBool;
/**
 分割线集合
 */
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *marginLineArray;
@end

@implementation YXMyInformationController

#pragma mark - 获取目标控制器

/**
 StoryBoard中跳转获取目标控制器

 @param segue segue 连线
 @param sender sender
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YXMyInformationBaseTableViewController *baseTableViewController = (YXMyInformationBaseTableViewController *)segue.destinationViewController;
    baseTableViewController.delegate = self;
    
    if ([segue.identifier isEqualToString:@"myInformationEmailControllerIdentifier"] && [segue.destinationViewController isKindOfClass:[YXMyInformationEmailController class]]) {
        YXMyInformationEmailController *mailController = (YXMyInformationEmailController *)segue.destinationViewController;
        mailController.TextFiledPlaceholder = @"请输入邮箱地址";
        mailController.emailTextField.text = self.usreMailLabel.text;
    }
}

- (IBAction)birthdayTextFieldBegin:(UITextField *)sender
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.birthdayBackgroundBlackView];
}
- (IBAction)birthdayTextFieldEnd:(UITextField *)sender
{
    [self.birthdayBackgroundBlackView removeFromSuperview];
}


#pragma mark - 点击事件
/**
 修改昵称
 */
-(void)ChangeNickName:(NSNotification*)noti
{
     self.userNameLabel.text = noti.userInfo[@"nickname"];
}


- (IBAction)logOutButtonClick:(UIButton *)sender
{
//    [self showAlert];
}

//** 取消按钮点 */
- (void)cancleButtonItemClick:(UIBarButtonItem *)sender
{
    [self.birthdayTextField resignFirstResponder];
}

//** 确定按钮点击 */
- (void)sureButtonItemClick:(UIBarButtonItem *)sender
{
    //** 取出选中值 */
    NSDate *date = self.picker.date;
    NSDateFormatter *formatt = [[NSDateFormatter alloc]init];
    formatt.dateFormat = @"yyyy-MM-dd";
    __block NSString *dateStr = [formatt stringFromDate:date];

    //上传修改生日
    __weak YXMyInformationController *weakSelf = self;
    [[YXMyAccountNetRequestTool sharedTool] editBirthdayOrSexOrEmailWithBrithday:dateStr sex:nil email:nil nickName:nil success:^(id objc, id respodHeader) {
        
        if ([objc isEqualToString:@"修改成功!"] || (int)respodHeader[@"Status"] == 1) {
            weakSelf.userBirthdayLabel.text = dateStr;
        }
        
    } failure:^(NSError *error) {
        YXLog(@"%@", error);
    }];
    
    [self.birthdayTextField resignFirstResponder];
}


#pragma mark - 赋值

- (void)setAccountBaseDataModel:(YXMyAccountBaseData *)accountBaseDataModel
{
    _accountBaseDataModel = accountBaseDataModel;
    
    [self reloadDataRefreshUI:accountBaseDataModel];
    
}


#pragma mark - 控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    [self reloadDataRefreshUI:self.accountBaseDataModel];
    
    //--设置生日弹框
    self.birthdayTextField.inputView = self.picker;
    self.birthdayTextField.inputAccessoryView = self.customAccessoryView;
    self.tableView.bounces = NO;
    

    
    //**配置界面**/
    [self.marginLineArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *lineView = (UIView *)obj;
        lineView.backgroundColor = [UIColor themGrayColor];
    }];
    
    [YXNotificationTool addObserver:self selector:@selector(ChangeNickName:) name:@"CHangeNickNAme" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.birthdayTextField resignFirstResponder];
    
    [YXNetworkHUD dismiss];
    
    
}

//** 根据数据更新UI */
- (void)reloadDataRefreshUI:(YXMyAccountBaseData *)model
{
//    [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:model.head]];
    
    self.userNameLabel.text = model.nickname;
    self.userBirthdayLabel.text = model.birthday;
    self.userPhoneNumberLabel.text = model.phone;
    self.usreMailLabel.text = model.email;
    
    NSArray *arr = [model.head componentsSeparatedByString:@"?"];
    if (arr.count>1) {
        
        self.haveIconBool = YES;
        [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"ic_default"]];
        
   
        
    }else
    {
        if (model.head) {
            self.userIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@", model.head]];
        }else{
            self.userIconImageView.image = [UIImage imageNamed:@"ic_default"];
        }
    
    }
    
    if (model.sex.integerValue == 0 && model.sex) {
        self.userSexLabel.text = @"女";
    }else if (model.sex.integerValue == 1){
        self.userSexLabel.text = @"男";
    }else{
        self.userSexLabel.text = @" ";
    }
}


#pragma mark --YXMyInformationBaseDelegate

- (void)editBaseInformationWithMyInformationController:(YXMyInformationBaseTableViewController *)baseController withInformation:(NSString *)information
{
     if ([baseController isKindOfClass:[YXMyInformationEmailController class]]){
         self.usreMailLabel.text = information;
         [baseController.navigationController popViewControllerAnimated:YES];
    }
}
//- (void)editBaseInformationWithMyInformationController:(YXMyInformationBaseTableViewController *)baseController withInformationNickName:(NSString *)informationNickName
//{
//    if ([baseController isKindOfClass:[YXMyInformationEmailController class]]){
//       
//        [baseController.navigationController popViewControllerAnimated:YES];
//    }
//}

- (void)editBaseInformationWithMyInformationController:(YXMyInformationBaseTableViewController *)baseController withOldPwd:(NSString *)oldPwd withNewPwd:(NSString *)newPwd
{

}

//切换头像
-(void)changeicon
{
    //设置主要参数
    [[ImagePicker sharedManager] dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:2 allowsEditing:YES];
    
    //回调
    [[ImagePicker sharedManager] dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
        
    } pickerImagePic:^(UIImage *pickerImagePic) {
        
        [self updateheaderimage:pickerImagePic];
        /*
         @brief 方便在 客服时候使用，
         */
        NSData *headimagedata = UIImageJPEGRepresentation(pickerImagePic, 0.5);
        [YXUserDefaults setObject:headimagedata forKey:@"headimagedata"];
    
    }];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0&&indexPath.row==0) {
        
        [self changeicon];
    }
    if(indexPath.section==0&&indexPath.row==1)
    {
 
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"MyInformation" bundle:nil] instantiateViewControllerWithIdentifier:@"ChangeEmail"] animated:YES];

    }
    
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *nanAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[YXMyAccountNetRequestTool sharedTool] editBirthdayOrSexOrEmailWithBrithday:nil sex:@"1" email:nil nickName:nil success:^(id objc, id respodHeader) {

                if ([objc isEqualToString:@"修改成功!"] || (int)respodHeader[@"Status"] == 1) {
                    self.userSexLabel.text = @"男";

                    if (!self.haveIconBool) {
                        
                        self.userIconImageView.image = [UIImage imageNamed:@"ic_default"];
                    }
                }
                
            } failure:^(NSError *error) {
                YXLog(@"%@", error);
            }];
        }];
        
        
        UIAlertAction *nvAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[YXMyAccountNetRequestTool sharedTool] editBirthdayOrSexOrEmailWithBrithday:nil sex:@"0" email:nil nickName:nil success:^(id objc, id respodHeader) {
                
                if ([objc isEqualToString:@"修改成功!"] || (int)respodHeader[@"Status"] == 1) {
                    self.userSexLabel.text = @"女";
                       if (!self.haveIconBool) {
                           self.userIconImageView.image = [UIImage imageNamed:@"ic_default"];
                       }
                }
                
            } failure:^(NSError *error) {
                YXLog(@"%@", error);
            }];
        }];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:nanAction];
        [alert addAction:nvAction];//代码块前的括号是代码块返回的数据类型
        [alert addAction:cancleAction];
        [self presentViewController: alert animated:YES completion:nil];
    }
}


#pragma mark - 懒加载

- (UIDatePicker *)picker
{
    if (!_picker) {
        _picker = [[UIDatePicker alloc]init];
        _picker.datePickerMode =  UIDatePickerModeDate;
        _picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
        _picker.backgroundColor = [UIColor whiteColor];

    }
    return _picker;
}

- (UIToolbar *)customAccessoryView{
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,self.view.bounds.size.width,44}];
        _customAccessoryView.barTintColor = [UIColor colorWithWhite:237.0/255.0 alpha:1.0];
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleButtonItemClick:)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(sureButtonItemClick:)];
        [_customAccessoryView setItems:@[item1,space,finish]];
    }
    return _customAccessoryView;
}

- (UIView *)birthdayBackgroundBlackView
{
    if (!_birthdayBackgroundBlackView) {
        _birthdayBackgroundBlackView = [[UIView alloc] initWithFrame:self.view.bounds];
        _birthdayBackgroundBlackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _birthdayBackgroundBlackView;
}


#pragma mark  ******************* 上传头像的图片**********************

-(void)updateheaderimage:(UIImage *)image
{

    [YXNetworkHUD show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    
    NSString *token = [[YXLoginStatusTool sharedLoginStatus] getTokenId];

    NSString *uuid = twlt_uuid_create();
    
    if (token) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"id"];
    }else{
        [manager.requestSerializer setValue:nil forHTTPHeaderField:@"id"];
    }
    [manager.requestSerializer setValue:uuid forHTTPHeaderField:@"uuid"];
    
    
    NSString *URLSTR = [NSString stringWithFormat:@"%@/api/upLoadHeadPic",kOuternet];
    
    [manager POST:URLSTR parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        //把图片转换为二进制流
        NSData *imageData = UIImagePNGRepresentation(image);
        if (imageData.length/1024/1024>5) {
            imageData = UIImageJPEGRepresentation(image, 0.5);
        }
        //按照表单格式把二进制文件写入formData表单
        [formData appendPartWithFileData:imageData name:@"headPic" fileName:[NSString stringWithFormat:@"%d.png", 1] mimeType:@"image/png"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    }  success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //拿到拍完（或者是选择完）的图片
        self.userIconImageView.image =  [image circleImage];

        YXLog(@"responseObject == %@--++--%@----", [self getResponseObjcWithTask:responseObject],[self getRespodHeaderWithTask:task]);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [YXNetworkHUD dismiss];
        });
        
        if ([[self getRespodHeaderWithTask:task][@"Status"] isEqualToString:@"1"]) {
            if (self.changeImageblock) {
                self.changeImageblock((NSString *)[self getResponseObjcWithTask:responseObject],UIImagePNGRepresentation(image));
            }
            [YXUserDefaults setObject:[self getResponseObjcWithTask:responseObject] forKey:@"head"];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [YXNetworkHUD dismiss];
        
       // YXLog(@"发送失败+++++%@++++%@",error,[self getRespodHeaderWithTask:task]);
        
        [YXAlearMnager ShowAlearViewWith:@"头像更换失败" Type:2];
        
    }];
    
    
    
}
-(id)getResponseObjcWithTask:(id )responseObect{
    id json;
    NSError *error;
    json = [NSJSONSerialization JSONObjectWithData:responseObect options:0 error:&error];
    if (error) {
        json = [[NSString alloc] initWithData:responseObect encoding:NSUTF8StringEncoding];
    }
    return json;
}
//** 获取响应头 */
- (id)getRespodHeaderWithTask:(NSURLSessionTask *)task
{
    NSHTTPURLResponse *respond = (NSHTTPURLResponse *)task.response;
    return respond.allHeaderFields;
}


@end
