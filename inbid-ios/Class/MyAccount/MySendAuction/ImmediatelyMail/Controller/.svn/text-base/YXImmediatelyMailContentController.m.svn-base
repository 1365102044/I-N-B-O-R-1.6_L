//
//  YXImmediatelyMailContentController.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXImmediatelyMailContentController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXImmediatelyMailMyAddressModel.h"
#import "YXKeyboardToolbar.h"
#import "YXImmediatelyMailExpressController.h"
#import "YXImmediatelyMailExpressModel.h"
#import "YXZBarViewController.h"
#import "YXOrderDetailModel.h"

@interface YXImmediatelyMailContentController ()<YXKeyboardToolbarDelegate, UITableViewDataSource, UITableViewDelegate, YXImmediatelyMailExpressControllerDelegate, YXZBarViewControllerDelegate>
//** 收货人姓名 */
@property (weak, nonatomic) IBOutlet UILabel *consigneeNameLabel;
//** 收货人联系电话 */
@property (weak, nonatomic) IBOutlet UILabel *consigneePhoneNumberLabel;
//** 收货地址 */
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;
//** 单侧圆角View */
@property (weak, nonatomic) IBOutlet UIView *bottomView;
//** 快递至胤宝 */
@property (weak, nonatomic) IBOutlet UIButton *sendToInbornButton;
//** 送至收货地点 */
@property (weak, nonatomic) IBOutlet UIButton *sendToReceiptAddressButton;
//** 地址模型 */
@property (nonatomic, strong) YXImmediatelyMailMyAddressModel *myAddressModel;
//** 辅助视图 */
@property (nonatomic, strong) YXKeyboardToolbar *customAccessoryView;

/**
 快递公司列表
 */
@property (weak, nonatomic) IBOutlet UIView *expressContentView;

/**
 快递公司列表控制器
 */
@property (nonatomic, weak) YXImmediatelyMailExpressController *expressController;

/**
 高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *expressContentHeightCons;

/**
 选择送至收货点蒙版视图
 */
@property (weak, nonatomic) IBOutlet UIView *selfSendMaskView;

/**
 选择快递公司按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *chooseExpressButton;

@end

@implementation YXImmediatelyMailContentController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /** 获取来源控制器 */
    _expressController = segue.destinationViewController;
    _expressController.delegate = self;
}

#pragma mark - 代理方法

- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    [self.view endEditing:YES];
}

- (void)zBarViewController:(YXZBarViewController *)zBarViewController andText:(NSString *)text
{
    self.expressOrderNumberTextField.text = text;
}

- (void)immediatelyMailExpressController:(YXImmediatelyMailExpressController *)immediatelyMailExpressController andSelectedExpressModel:(YXImmediatelyMailExpressModel *)model
{
    self.expressContentHeightCons.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
       [self.tableView layoutIfNeeded];
        self.chooseExpressButton.imageView.transform = CGAffineTransformRotate(self.chooseExpressButton.imageView.transform, M_PI);
        self.chooseExpressButton.selected = !self.chooseExpressButton.selected;
    }];
    
    self.expressNameTextField.text = model.expressName;
    self.currentExpressId = model.expressId;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) return 0;
    
    if (indexPath.row != 1) return 143.f;
    
    if (iPHone5) {
        return 350;
    }else{
        return 450;
    }
}
    
#pragma mark - 赋值

- (void)setMyAddressModel:(YXImmediatelyMailMyAddressModel *)myAddressModel
{
    _myAddressModel = myAddressModel;
    
    self.consigneeNameLabel.text = myAddressModel.consigneeName;
    self.consigneePhoneNumberLabel.text = myAddressModel.consigneePhone;
    self.detailAddressLabel.text = myAddressModel.consigneeAddress;
}


#pragma mark - 点击事件

//** 快递方式选择按钮 */
- (IBAction)expressTypeButtonClick:(UIButton *)sender
{
    self.currentButton.enabled = YES;
    sender.enabled = NO;
    
    if ([sender.titleLabel.text isEqualToString:@"快递到胤宝"]) {
        self.selfSendMaskView.hidden = YES;
    }else if ([sender.titleLabel.text isEqualToString:@"送至收货点"]) {
        self.selfSendMaskView.hidden = NO;
        
        //** 判断选择快递公司页面 */
        if (self.chooseExpressButton.selected) {
            [UIView animateWithDuration:0.25 animations:^{
                self.chooseExpressButton.imageView.transform = CGAffineTransformRotate(self.chooseExpressButton.imageView.transform, M_PI);
            }];
            self.expressContentHeightCons.constant = 0;
            self.chooseExpressButton.selected = !self.chooseExpressButton.selected;
        }
    }
    
    self.currentButton = sender;
}

//** 选择快递箭头 */
- (IBAction)chooseExpressButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        self.expressContentHeightCons.constant = 200;
    }else{
        self.expressContentHeightCons.constant = 0;
    }
    
    //** 旋转按钮动画 */
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.tableView layoutIfNeeded];
        sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI);
    }];
}

//** 扫描快递单 */
- (IBAction)scanExpressOrderNumberButtonClick:(UIButton *)sender
{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        YXZBarViewController *scanningQRCodeVC = [[YXZBarViewController alloc] init];
                        scanningQRCodeVC.delegate = self;
                        [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
                        NSLog(@"主线程 - - %@", [NSThread currentThread]);
                    });
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    
                    // 用户第一次同意了访问相机权限
                    YXLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    YXLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            YXZBarViewController *scanningQRCodeVC = [[YXZBarViewController alloc] init];
            scanningQRCodeVC.delegate = self;
            [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            YXLog(@"%@", @"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关");
        } else if (status == AVAuthorizationStatusRestricted) {
            YXLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        YXLog(@"%@", @"未检测到您的摄像头, 请在真机上测试");
    }
}


#pragma mark - 获取网络数据

- (void)loadMyAddress
{
    //** 获取我们的地址 */
    [[YXMyAccountNetRequestTool sharedTool] mailNowLoadMyAddressWithSuccess:^(id objc, id respodHeader) {
        
        self.myAddressModel = [YXImmediatelyMailMyAddressModel mj_objectWithKeyValues:objc];
        
    } failure:^(NSError *error) {
        
    }];
    
}



#pragma mark - 控制器生命周期

//** 视图加载完毕 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"立即邮寄";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //--控件切圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bottomView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bottomView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.bottomView.layer.mask = maskLayer;
    
    self.sendToInbornButton.tag = 0;
    self.sendToReceiptAddressButton.tag = 1;
    [self expressTypeButtonClick:self.sendToInbornButton];
    
    [self loadMyAddress];
    
    //--配置输入框功能条
    [self.expressOrderNumberTextField setKeyboardType:UIKeyboardTypeDefault];
    [self.expressOrderNumberTextField setInputAccessoryView:self.customAccessoryView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//** 弹出登录或未登录alert */
- (void)showAlertWithTitle:(NSString *)title
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
    [self presentViewController: alert animated:YES completion:nil];
    
}

#pragma mark - 懒加载

- (YXKeyboardToolbar *)customAccessoryView
{
    if (!_customAccessoryView) {
        
        _customAccessoryView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YXKeyboardToolbar class]) owner:nil options:nil].firstObject;
        _customAccessoryView.customDelegate = self;
    }
    return _customAccessoryView;
}


@end
