//
//  YXMyInformationPwdController.m
//  MyAccount
//
//  Created by 郑键 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyInformationPwdController.h"
#import "YXContentTextField.h"
#import "YXStringFilterTool.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXAlearFormMyView.h"


@interface YXMyInformationPwdController ()

@property (weak, nonatomic) IBOutlet YXContentTextField *oldPwdTextField;
@property (weak, nonatomic) IBOutlet YXContentTextField *myNewPwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property(nonatomic,strong) UIButton * oldEyeBtn;
@property (nonatomic, strong) UIButton *myNewEyeBtn;

/*
 @brief 自己判读的提示view
 */
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

@end

@implementation YXMyInformationPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"修改登录密码";
    
    UIButton *oldEyeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,10, 44, 40)];
    [oldEyeBtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
    [oldEyeBtn addTarget:self action:@selector(ClickReginstereyeBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.oldPwdTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    self.oldPwdTextField.rightView = oldEyeBtn;
    self.oldEyeBtn = oldEyeBtn;
    self.oldEyeBtn.tag = 1001;
    
    UIButton *newEyeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,10, 44, 40)];
    [newEyeBtn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
    [newEyeBtn addTarget:self action:@selector(ClickReginstereyeBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.myNewPwdTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    self.myNewPwdTextField.rightView = newEyeBtn;
    self.myNewEyeBtn = newEyeBtn;
    self.myNewEyeBtn.tag = 1002;
    
    self.commitBtn.layer.cornerRadius = 4;
    self.commitBtn.layer.masksToBounds = YES;
    
    self.oldPwdTextField.keyboardType                                 = UIKeyboardTypeASCIICapable;
    self.myNewPwdTextField.keyboardType                               = UIKeyboardTypeASCIICapable;
}


- (IBAction)doneButtonClick:(UIButton *)sender
{
    
    if ([self.oldPwdTextField.text isEqualToString:@""] || self.oldPwdTextField.text.length == 0) {
        //UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请输入登录密码" message:@"登录密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
        //[alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
        //[self presentViewController: alert animated:YES completion:nil];
        self.alearMyview.alearstr = @"登录密码不能为空";
        return;
    }
    
    
    if ([self.myNewPwdTextField.text isEqualToString:@""] || self.myNewPwdTextField.text.length == 0) {
        //UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请输入新密码" message:@"新密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
        //[alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
        //[self presentViewController: alert animated:YES completion:nil];
        self.alearMyview.alearstr = @"新密码不能为空";
        return;
    }
    
    //if ([self.oldPwdTextField.text isEqualToString:@""] || self.myNewPwdTextField.text.length == 0) {
        //UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请输入登录密码" message:@"登录密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
        //[alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
        //[self presentViewController: alert animated:YES completion:nil];
        //return;
    //}
    
    if (![YXStringFilterTool checkResetPwd:self.myNewPwdTextField.text]) {
        
        //UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"新密码输入有误" message:@"请使用字母，数字和符号两种及其以上的组合，8~20位字符" preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
        //[alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
        //[self presentViewController: alert animated:YES completion:nil];
        self.alearMyview.alearstr = @"密码请使用字母，数字和[!#$%^&*]两种及其以上的组合，8～20位字符";
        return;
        
    }
    
    
    [[YXMyAccountNetRequestTool sharedTool] updataPwdWithOldPwd:self.oldPwdTextField.text andNewPwd:self.myNewPwdTextField.text success:^(id objc, id respodHeader) {
        
        if ([objc isEqualToString:@"登录密码有误"] || (int)respodHeader[@"Status"] == 2) {
            //UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"密码输入有误" message:@"旧登录密码输入有误" preferredStyle:UIAlertControllerStyleAlert];
            //UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
            //[alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
            //[self presentViewController: alert animated:YES completion:nil];
            self.alearMyview.alearstr = @"登录密码错误";
        }else if ([objc isEqualToString:@"密码修改成功"] || (int)respodHeader[@"Status"] == 1){
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


//** 密码 密文和明文的切换 */
-(void)ClickReginstereyeBtn:(UIButton*)sender
{
    if (sender.tag == 1001) {
        sender.selected = !sender.selected;
        self.oldPwdTextField.secureTextEntry = !sender.selected;
        if (sender.selected) {
            [sender setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        }else{
            [sender setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        }
        
        NSString *text = self.oldPwdTextField.text;
        self.oldPwdTextField.text = @" ";
        self.oldPwdTextField.text = text;
        if (self.oldPwdTextField.secureTextEntry)
        {
            [self.oldPwdTextField insertText:self.oldPwdTextField.text];
        }
    }else if (sender.tag == 1002){
        sender.selected = !sender.selected;
        self.myNewPwdTextField.secureTextEntry = !sender.selected;
        if (sender.selected) {
            [sender setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        }else{
            [sender setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        }
        
        NSString *text = self.myNewPwdTextField.text;
        self.myNewPwdTextField.text = @" ";
        self.myNewPwdTextField.text = text;
        if (self.myNewPwdTextField.secureTextEntry)
        {
            [self.myNewPwdTextField insertText:self.myNewPwdTextField.text];
        }
    }
}


#pragma mark - 懒加载

-(YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
        [self.view addSubview:self.alearMyview];
        _alearMyview.frame = CGRectMake(YXScreenW*0.2, 60 - 15, YXScreenW*0.6, 30);
        _alearMyview.alpha = 0;
        _alearMyview.time = 10.0f;
    }
    return _alearMyview;
}

@end
