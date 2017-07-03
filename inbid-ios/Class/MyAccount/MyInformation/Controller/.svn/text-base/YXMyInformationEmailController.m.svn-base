//
//  YXMyInformationEmailController.m
//  MyAccount
//
//  Created by 郑键 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyInformationEmailController.h"
#import "YXStringFilterTool.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXAlearFormMyView.h"

@interface YXMyInformationEmailController ()

/*
 @brief 自己判读的提示view
 */
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

@property (weak, nonatomic) IBOutlet UIButton *commitbtn;

@end

@implementation YXMyInformationEmailController

#pragma mark - 点击事件

- (IBAction)doneButtonClick:(UIButton *)sender
{
    if (self.TextFiledPlaceholder) {
        [self ChangeEmail];
        
    }else{
        [self ChangeNickName];
    }
}

/**
 增加，或更改邮箱的方法
 */
-(void)ChangeEmail
{
    if ([YXStringFilterTool filterByMailNumber:self.emailTextField.text]) {
        
        [[YXMyAccountNetRequestTool sharedTool] editBirthdayOrSexOrEmailWithBrithday:nil sex:nil email:self.emailTextField.text nickName:nil success:^(id objc, id respodHeader) {
            
            if ([objc isEqualToString:@"修改成功!"] || (int)respodHeader[@"Status"] == 1) {
                
                [YXUserDefaults setObject:self.emailTextField.text forKey:@"email"];
                if ([self.delegate respondsToSelector:@selector(editBaseInformationWithMyInformationController:withInformation:)]) {
                    [self.delegate editBaseInformationWithMyInformationController:self withInformation:self.emailTextField.text];
                }
            }
            
        } failure:^(NSError *error) {
            YXLog(@"%@", error);
        }];
        
    }else{
        // UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"邮箱错误" message:@"请输入正确的邮箱号" preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
        //[alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
        //[self presentViewController: alert animated:YES completion:nil];
        self.alearMyview.alearstr = @"邮箱输入有误";
    }

}
/**
 修改昵称的方法
 */
-(void)ChangeNickName
{
    if (self.emailTextField.text.length ==0) {
        
        self.alearMyview.alearstr = @"昵称不能为空";
        return;
    }
    
    if ([YXStringFilterTool filterByReginsterNickName:self.emailTextField.text]) {
        
        [[YXMyAccountNetRequestTool sharedTool] editBirthdayOrSexOrEmailWithBrithday:nil sex:nil email:nil nickName:self.emailTextField.text success:^(id objc, id respodHeader) {
            
            if ([objc isEqualToString:@"修改成功!"] || (int)respodHeader[@"Status"] == 1) {
                
                [YXUserDefaults setObject:self.emailTextField.text forKey:@"nickname"];
                
                [YXNotificationTool postNotificationName:@"CHangeNickNAme" object:nil userInfo:@{@"nickname":self.emailTextField.text}];
                    
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                self.alearMyview.alearstr = objc;
            }
        } failure:^(NSError *error) {
            YXLog(@"%@", error);
        }];
    }else{
        self.alearMyview.alearstr = @"用户昵称支持中文、字母、数字、'-''_'的组合，4-10个字符";
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commitbtn.layer.masksToBounds = YES;
    self.commitbtn.layer.cornerRadius = 4;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if(self.TextFiledPlaceholder)
    {
        
        self.emailTextField.placeholder = self.TextFiledPlaceholder;
        //** 判断用户是否设置过邮箱 */
        /**
         * 邮箱账号
         */
        //[YXUserDefaults setObject:objc[@"email"] forKey:@"email"];
        YXLog(@"%@",[YXUserDefaults objectForKey:@"email"]);
        if ([YXUserDefaults objectForKey:@"email"]) {
            self.title = @"编辑邮箱";
        }else{
            self.title = @"新增邮箱";
        }
    }else{
    
        self.emailTextField.placeholder = [YXUserDefaults objectForKey:@"nickname"];
        self.title = @"修改昵称";
    }
}


-(YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
        [self.view addSubview:self.alearMyview];
        _alearMyview.frame = CGRectMake(YXScreenW*0.2, 60 - 15, YXScreenW*0.6, 30);
        _alearMyview.alpha = 0;
    }
    return _alearMyview;
}

@end
