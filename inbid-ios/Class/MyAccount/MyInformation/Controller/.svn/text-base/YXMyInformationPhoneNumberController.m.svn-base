//
//  YXMyInformationPhoneNumberController.m
//  MyAccount
//
//  Created by 郑键 on 16/9/6.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyInformationPhoneNumberController.h"

@interface YXMyInformationPhoneNumberController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@end

@implementation YXMyInformationPhoneNumberController

#pragma mark - 点击事件

- (IBAction)doneButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(editBaseInformationWithMyInformationController:withInformation:)]) {
        [self.delegate editBaseInformationWithMyInformationController:self withInformation:self.phoneNumberTextField.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(editBaseInformationWithMyInformationController:withInformation:)]) {
        [self.delegate editBaseInformationWithMyInformationController:self withInformation:self.phoneNumberTextField.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改手机号码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
