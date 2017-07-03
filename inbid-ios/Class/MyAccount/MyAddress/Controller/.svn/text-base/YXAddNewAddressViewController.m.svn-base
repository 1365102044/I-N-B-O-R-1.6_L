//
//  YXAddNewAddressViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXAddNewAddressViewController.h"
#import "YXMyAccountNetRequestTool.h"
#import "YXAddNewAddressTableViewController.h"
#import "YXReturnGoodsViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "YXMyAccountGOPaymentConfirmAddressViewController.h"
#import "YXAlearFormMyView.h"
#import "YXOneMouthPriceConfirmOrderViewController.h"
#import "YXMyAddressList.h"
#import "YXMyAddressListController.h"
@interface YXAddNewAddressViewController ()<YXAddNewAddressTableViewControllerDelegate>

//** 完成按钮 */
@property (nonatomic, strong) UIButton *doneButton;
//** 记录当前容器视图内控制器 */
@property (nonatomic, strong) YXAddNewAddressTableViewController *subTableViewController;

/*
 提示框
 */
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

@end

@implementation YXAddNewAddressViewController

#pragma mark - 赋值

- (void)setAddressListModel:(YXMyAddressList *)addressListModel
{
    _addressListModel = addressListModel;
    self.doneButton.tag = 1002;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YXAddNewAddressTableViewController *toTableViewController = segue.destinationViewController;
    toTableViewController.delegate = self;
    
    self.subTableViewController = toTableViewController;
    self.subTableViewController.addressListModel = self.addressListModel;
}

- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
}


#pragma mark --YXAddNewAddressViewControllerDelegate
- (void)addNewAddressViewController:(YXAddNewAddressTableViewController *)addNewAddressViewController withProvince:(NSString *)province withCity:(NSString *)city area:(NSString *)area withPhone:(NSString *)phoneNumber withRecivceName:(NSString *)recuvceName withConsigneeAddressDetail:(NSString *)withConsigneeAddressDetail withIsDefault:(NSInteger)isDefault
{
    __block NSDictionary *dict = @{@"province":province,
                                   @"city":city,
                                   @"phone":phoneNumber,
                                   @"area":area,
                                   @"name":recuvceName,
                                   @"consigneeAddressDetail":withConsigneeAddressDetail};

    [[YXMyAccountNetRequestTool sharedTool] addNewAddressWithReceiveName:recuvceName withPhoneNumber:phoneNumber withProvince:province withCity:city area:area withConsigneeAddressDetail:withConsigneeAddressDetail withIsDefault:isDefault success:^(id objc, id respodHeader) {
        
        if (![objc isEqualToString:@"请输入正确的手机号"]) {
            
            if ([self.sourceController isKindOfClass:[YXOneMouthPriceConfirmOrderViewController class]]) {
                 NSString *addressId = (NSString *)objc;
                
                [YXNotificationTool postNotificationName:@"formecomforOrderVCAddNewaddressNoti" object:nil userInfo:[self tranforDictKey:dict addressid:addressId]];
                [self.navigationController popToViewController:self.navigationController.childViewControllers[self.navigationController.childViewControllers.count-3] animated:YES];

                
                return ;
            }
            
            if ([self.sourceController isKindOfClass:[YXMyAccountGOPaymentConfirmAddressViewController class]]) {
                
                //** 点击完成，刷新当前地址数据后需要做的处理 */
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            if ([self.sourceController isKindOfClass:[YXReturnGoodsViewController class]]) {
                YXReturnGoodsViewController *controller = (YXReturnGoodsViewController *)self.sourceController;
                controller.addNewAddressDict = dict;
                NSString *addressId = (NSString *)objc;
                controller.addressId = addressId.integerValue;
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else{
            //[self showAlert];
            //** 弹出提示框 */
            self.alearMyview.alearstr = @"请输入正确的手机号";
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)addNewAddressViewController:(YXAddNewAddressTableViewController *)addNewAddressViewController withProvince:(NSString *)province withCity:(NSString *)city area:(NSString *)area withPhone:(NSString *)phoneNumber withRecivceName:(NSString *)recuvceName withConsigneeAddressDetail:(NSString *)withConsigneeAddressDetail withIsDefault:(NSInteger)isDefault withAddressId:(NSInteger)addressId
{
    [[YXMyAccountNetRequestTool sharedTool] editAddressWithReceiveName:recuvceName withPhoneNumber:phoneNumber withProvince:province withCity:city area:area withConsigneeAddressDetail:withConsigneeAddressDetail withIsDefault:isDefault withAddressId:addressId success:^(id objc, id respodHeader) {
        
        if ([objc isEqualToString:@"修改成功"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            //[self showFailureAlert];
            self.alearMyview.alearstr = @"修改地址失败";
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(NSMutableDictionary *)tranforDictKey:(NSDictionary *)olddict addressid:(NSString *)addressid{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[@"consigneeName"] =  olddict[@"name"];
    dict[@"consigneeAddressDetail"] = olddict[@"consigneeAddressDetail"];
    dict[@"consigneeProvince"] = olddict[@"province"];
    dict[@"consigneeCity"] = olddict[@"city"];
    dict[@"consigneeMobile"] = [YXStringFilterTool replaceStringWithAsterisk:olddict[@"phone"] startLocation:3 lenght:4];
    dict[@"id"] = addressid;
    dict[@"isDefault"] = @"0";
    return dict;
}

//** 弹出登录或未登录alert */
- (void)showAlert
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"手机号码输入有误" message:@"您的手机号码输入有误" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
    [alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
    [self presentViewController: alert animated:YES completion:nil];
    
}

//** 修改地址失败 */
- (void)showFailureAlert
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"修改地址失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
    [alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
    [self presentViewController: alert animated:YES completion:nil];
    
}


#pragma mark - 响应事件


/**
 返回事件
 
 @param sender 点击按钮
 */
- (void)backButtonClick:(UIButton *)sender
{
    if ([self.sourceController isKindOfClass:[YXReturnGoodsViewController class]] || [self.sourceController isKindOfClass:[YXMyAccountGOPaymentConfirmAddressViewController class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//** 添加新地址或修改地址完成 */
- (void)addNewAddressDoneButtonClick:(UIButton *)sender
{
    self.subTableViewController.clickButton = sender;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.titleText isEqualToString:@"编辑地址"]) {
        self.navigationItem.title = self.titleText;
    }else{
        self.navigationItem.title = @"增加新地址";
    }
    if ([self.sourceController isKindOfClass:[YXReturnGoodsViewController class]] || [self.sourceController isKindOfClass:[YXMyAccountGOPaymentConfirmAddressViewController class]]){
        [self setupNavigationController:self.navigationController];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithWhite:248.0/255.0 alpha:1.0];
    [self.view addSubview:self.doneButton];
    

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.doneButton.frame = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50);
}



/**
 配置navigationController
 
 @param navigationController navigationController
 */
- (void)setupNavigationController:(UINavigationController *)navigationController
{
    //UIButton *leftbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    //[leftbtn sizeToFit];
    //[leftbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    //[leftbtn addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //UIBarButtonItem *leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
    //self.navigationItem.leftBarButtonItem = leftitem;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backButtonClick:) image:@"icon_fanhui" highImage:@"icon_fanhui"];
}

#pragma mark - 懒加载

- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] init];
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _doneButton.tag = 1001;
        [_doneButton setBackgroundColor:[UIColor mainThemColor]];
        [_doneButton addTarget:self action:@selector(addNewAddressDoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
        [self.view addSubview:self.alearMyview];
        _alearMyview.alpha = 0;
    }
    return _alearMyview;
}


@end
