//
//  YXScanCodePCLoginResultViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 2017/1/19.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXScanCodePCLoginResultViewController.h"

@interface YXScanCodePCLoginResultViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation YXScanCodePCLoginResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.loginBtn.layer.cornerRadius = 4;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.borderColor = [UIColor mainThemColor].CGColor;
    self.loginBtn.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ClickLogin:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.clickBlock) {
        self.clickBlock(@"login");
    }
}
- (IBAction)ClickCancleLogin:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.clickBlock) {
        self.clickBlock(@"cancle");
    }
}
- (IBAction)ClickCloseBtn:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    if (self.clickBlock) {
        self.clickBlock(@"cancle");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
