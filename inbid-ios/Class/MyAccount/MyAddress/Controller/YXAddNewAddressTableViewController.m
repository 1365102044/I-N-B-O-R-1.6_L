//
//  YXAddNewAddressTableViewController.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXAddNewAddressTableViewController.h"
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>
#import "YXPlaceholderTextView.h"
#import "YXStringFilterTool.h"
#import "MOFSPickerManager.h"
#import "YXMyAddressList.h"
#import "YXKeyboardToolbar.h"
#import <ContactsUI/ContactsUI.h>
#import "YXAlearFormMyView.h"
#import "SXAddressBookManager.h"


@interface YXAddNewAddressTableViewController ()<ABPeoplePickerNavigationControllerDelegate, YXKeyboardToolbarDelegate, CNContactPickerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *consigneeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet YXPlaceholderTextView *detailedAddressTextView;

//** 辅助视图 */
@property (nonatomic, strong) YXKeyboardToolbar *customAccessoryView;

/*
 提示框
 */
@property(nonatomic,strong) YXAlearFormMyView * alearMyview;

/**
 是否是默认电话号码
 */
@property (nonatomic, assign) BOOL isDefaultPhoneNumber;

@property(nonatomic,strong)NSArray<SXPersonInfoEntity *>*personEntityArray;

@end

@implementation YXAddNewAddressTableViewController


#pragma mark - 赋值

- (void)setClickButton:(UIButton *)clickButton
{
    _clickButton = clickButton;
    
    if ([self.consigneeTextField.text isEqualToString:@""]
        || [self.consigneeTextField.text length] == 0) {
        //TODO:
        
        //UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"请输入收件人" message:@"收件人不能为空" preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
        //[alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
        //[self presentViewController: alert animated:YES completion:nil];
        //** 提示 */
        self.alearMyview.alearstr = @"收货人不能为空";
        
        return;
    }
    
    if ([self.phoneNumberTextField.text isEqualToString:@""]
        || [self.phoneNumberTextField.text length] == 0) {
        //TODO:
        
        //UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"手机号码输入有误" message:nil preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
        //[alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
        //[self presentViewController: alert animated:YES completion:nil];
        self.alearMyview.alearstr = @"手机号码不能为空";
        
        return;
    }
    
    //** 验证电话号码 */
    if (![YXStringFilterTool filterByPhoneNumber:self.phoneNumberTextField.text] && self.isDefaultPhoneNumber) {
        //[self showAlert];
        self.alearMyview.alearstr = @"手机号码输入有误";
        return;
    }
    
    if ([self.addressLabel.text isEqualToString:@"请选择地区"]) {
        
        //UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"地址不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
        //[alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
        //[self presentViewController: alert animated:YES completion:nil];
        self.alearMyview.alearstr = @"所在地区不能为空";
        
        return;
    }
    
    if ([self.detailedAddressTextView.text isEqualToString:@""] || [self.detailedAddressTextView.text length] == 0) {
        //TODO:
        
       // UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"详细地址不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
        //[alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
        //[self presentViewController: alert animated:YES completion:nil];
        self.alearMyview.alearstr = @"详细地址不能为空";
        
        return;
    }
    
    
    if (clickButton.tag == 1001) {
        //回调
        if ([self.delegate respondsToSelector:@selector(addNewAddressViewController:withProvince:withCity:area:withPhone:withRecivceName:withConsigneeAddressDetail:withIsDefault:)]) {
            
            //--获取省市信息
            NSArray *tempAddressArray = [self.addressLabel.text componentsSeparatedByString: @" "];
            
            [self.delegate addNewAddressViewController:self withProvince:tempAddressArray[0] withCity:tempAddressArray[1] area:tempAddressArray.lastObject withPhone:self.phoneNumberTextField.text withRecivceName:self.consigneeTextField.text withConsigneeAddressDetail:self.detailedAddressTextView.text withIsDefault:0];
        }
    }else if (clickButton.tag == 1002){
        
        if ([self.delegate respondsToSelector:@selector(addNewAddressViewController:withProvince:withCity:area:withPhone:withRecivceName:withConsigneeAddressDetail:withIsDefault:withAddressId:)]) {
            
            //--获取省市信息
            NSArray *tempAddressArray = [self.addressLabel.text componentsSeparatedByString: @" "];
            
            [self.delegate addNewAddressViewController:self withProvince:tempAddressArray[0] withCity:tempAddressArray[1] area:tempAddressArray.lastObject withPhone:self.phoneNumberTextField.text withRecivceName:self.consigneeTextField.text withConsigneeAddressDetail:self.detailedAddressTextView.text withIsDefault:self.addressListModel.isDefault withAddressId:self.addressListModel.addressId];
        }
    }
}

- (void)setAddressListModel:(YXMyAddressList *)addressListModel
{
    _addressListModel = addressListModel;
}



#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 0) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}


#pragma mark - YXKeyboardToolbarDelegate

- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    [self.view endEditing:YES];
}


#pragma mark - 响应事件

- (IBAction)phoneNumberEndEditing:(UITextField *)sender
{
    
}

- (IBAction)phoneNumberStartEditing:(UITextField *)sender
{
    self.isDefaultPhoneNumber = YES;
}

//** 弹出登录或未登录alert */
- (void)showAlert
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"手机号码输入有误" message:@"您的手机号码输入有误" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *actoin){}];
    [alert addAction:defaultAction];                                                                                                                                                             //代码块前的括号是代码块返回的数据类型
    [self presentViewController: alert animated:YES completion:nil];
    
}

- (IBAction)getAddressBookButtonClick:(UIButton *)sender
{
    //CNContactPickerViewController * con = [[CNContactPickerViewController alloc]init];
    //con.delegate = self;
    //[self presentViewController:con animated:YES completion:nil];
    [[SXAddressBookManager manager]presentPageOnTarget:self chooseAction:^(SXPersonInfoEntity *person) {
        
        @try {
            NSString *tempPhoneNumber;
            
            if ([person.phoneNumber containsString:@"-"]) {
                tempPhoneNumber = [person.phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
            }else{
                tempPhoneNumber = person.phoneNumber;
            }
            self.phoneNumberTextField.text = tempPhoneNumber;
        } @catch (NSException *exception) {
            YXLog(@"%@", exception);
        } @finally {
            
        }
    }];
}

- (void)checkStatus1
{
    SXAddressBookAuthStatus status = [[SXAddressBookManager manager] getAuthStatus];
    if (status == kSXAddressBookAuthStatusNotDetermined) {
        
        [[SXAddressBookManager manager]askUserWithSuccess:^{
            self.personEntityArray = [[SXAddressBookManager manager]getPersonInfoArray];
        } failure:^{
            YXLog(@"失败");
        }];
        
    }else if (status == kSXAddressBookAuthStatusAuthorized){
        
        self.personEntityArray = [[SXAddressBookManager manager]getPersonInfoArray];
        
    }else{
        YXLog(@"没有权限");
    }
}

#pragma mark --ABPeoplePickerNavigationControllerDelegate

/**
 获取联系人电话号码

 @param picker          通讯录
 @param contactProperty 内容
 */
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
    //** 点击的是电话号码的时候，获取内容 */
    if ([contactProperty.key isEqualToString:@"phoneNumbers"]) {
        CNPhoneNumber *phonenumber=contactProperty.value;//将value转为cnphonenumber类型
        self.phoneNumberTextField.text = phonenumber.stringValue;
    }
}



#pragma mark - 控制器生命周期

//** 视图加载完毕 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:248.0/255.0 alpha:1.0];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.detailedAddressTextView.placeholder = @"请填写详细地址";
    self.detailedAddressTextView.placeholderColor = [UIColor colorWithWhite:170.0/255.0 alpha:1.0];
    self.detailedAddressTextView.scrollEnabled = NO;
    
    
    if (self.addressListModel) {
        self.consigneeTextField.text = self.addressListModel.consigneeName;
        self.phoneNumberTextField.text = self.addressListModel.consigneeMobile;
        self.addressLabel.text = [NSString stringWithFormat:@"%@ %@", self.addressListModel.consigneeProvince, self.addressListModel.consigneeCity];
        self.detailedAddressTextView.text = self.addressListModel.consigneeAddressDetail;
    }
    
    //** 配置辅助视图 */
    [self.consigneeTextField setKeyboardType:UIKeyboardTypeDefault];
    [self.consigneeTextField setInputAccessoryView:self.customAccessoryView];
    
    [self.phoneNumberTextField setInputAccessoryView:self.customAccessoryView];
    
    [self.detailedAddressTextView setKeyboardType:UIKeyboardTypeDefault];
    [self.detailedAddressTextView setInputAccessoryView:self.customAccessoryView];
    
    [self checkStatus1];
    
    [YXNotificationTool addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
     [YXNotificationTool addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];

}

//** 子控件布局完毕 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
}

//** 视图即将离开 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 3) {
        
        [self.tableView endEditing:YES];
        
        [[MOFSPickerManager shareManger] showMOFSAddressPickerWithTitle:nil cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString *address, NSString *zipcode) {
            self.addressLabel.text = address;
        } cancelBlock:^{
            
        }];
    }
}
/**
 *  当 text field 文本内容改变时 会调用此方法
 *
 *  @param notification
 */
-(void)textFiledEditChanged:(NSNotification *)notification{
    
    // 拿到文本改变的 text field
    UITextField *textField = (UITextField *)notification.object;

    if (textField.tag == 10) {
        
        [[[YXStringFilterTool alloc]init] limitTextFiledEditChange:textField LimitNumber:10];
    }
    if (textField.tag == 11) {
        [[[YXStringFilterTool alloc]init] limitTextFiledEditChange:textField LimitNumber:11];
    }
   
}
/**
 *  当 text field 文本内容改变时 会调用此方法
 *
 *  @param notification
 */
-(void)textViewEditChanged:(NSNotification *)notification{
    
    // 拿到文本改变的 text field
    UITextView *textField = (UITextView *)notification.object;
    
    // 需要限制的长度
    NSUInteger maxLength = 0;
    if(textField.tag == 12)
    {
        maxLength = 70;
    }
    if (maxLength == 0) return;
    
    // text field 的内容
    NSString *contentText = textField.text;
    // 获取高亮内容的范围
    UITextRange *selectedRange = [textField markedTextRange];
    // 这行代码 可以认为是 获取高亮内容的长度
    NSInteger markedTextLength = [textField offsetFromPosition:selectedRange.start toPosition:selectedRange.end];
    // 没有高亮内容时,对已输入的文字进行操作
    if (markedTextLength == 0) {
        // 如果 text field 的内容长度大于我们限制的内容长度
        if (contentText.length > maxLength) {
            // 截取从前面开始maxLength长度的字符串
            //            textField.text = [contentText substringToIndex:maxLength];
            // 此方法用于在字符串的一个range范围内，返回此range范围内完整的字符串的range
            NSRange rangeRange = [contentText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
            textField.text = [contentText substringWithRange:rangeRange];
        }
    }
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

- (YXAlearFormMyView*)alearMyview
{
    if (!_alearMyview) {
        
        _alearMyview = [[YXAlearFormMyView alloc]init];
        [self.view addSubview:self.alearMyview];
        _alearMyview.alpha = 0;
    }
    return _alearMyview;
}
-(void)dealloc
{
    [YXNotificationTool removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [YXNotificationTool removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}
@end
