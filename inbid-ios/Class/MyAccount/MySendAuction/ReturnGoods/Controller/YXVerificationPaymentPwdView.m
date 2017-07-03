//
//  YXVerificationPaymentPwdController.m
//  inbid-ios
//
//  Created by 郑键 on 16/10/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXVerificationPaymentPwdView.h"
#import "YXKeyboardToolbar.h"

@interface YXVerificationPaymentPwdView ()<YXKeyboardToolbarDelegate,UITextFieldDelegate>

/**
 取消按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

/**
 帮助按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *helpButton;

/**
 支付密码
 */
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

/**
 忘记支付密码
 */
@property (weak, nonatomic) IBOutlet UIButton *resetPaymentPwd;

/**
 底部上虚线视图
 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

/**
 辅助视图
 */
@property (nonatomic, strong) YXKeyboardToolbar *customAccessoryView;

/**
 左侧约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewLeftCons;

/**
 右侧约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewRightCons;


/*
 @brief 图片验证码
 */

@property (weak, nonatomic) IBOutlet UIView *ImageCodeBigBackView;

@property (weak, nonatomic) IBOutlet UIImageView *ImageCodeimage;

@property (weak, nonatomic) IBOutlet UIButton *ChangeImageCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *ImageCodeTextfield;

@property (weak, nonatomic) IBOutlet UIView *bigbackview;


@property(nonatomic,strong) UILabel * alearview;

@end

@implementation YXVerificationPaymentPwdView

/**
 键盘辅助视图代理

 @param keyboardToolbar toolbar
 @param doneButtonClick 完成按钮
 */
- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    [self endEditing:YES];
}

#pragma mark - 点击事件

/*
 @brief 切换 图片验证码
 */
- (IBAction)ClickChangeImagecodeBtn:(id)sender {
    

    if (self.Changeimagecodeblock) {
        self.Changeimagecodeblock();
    }
    
}

-(void)setImagecode:(UIImage *)imagecode
{
//    self.imagecode = imagecode;
    self.ImageCodeTextfield.text = nil;
    self.ImageCodeimage.image = imagecode;
    
}

-(void)setImagecodeshowStatus:(BOOL)imagecodeshowStatus
{
//    _imagecodeshowStatus = imagecodeshowStatus;
    self.ImageCodeBigBackView.hidden = imagecodeshowStatus;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _ImageCodeTextfield) {
        
        NSString *shurutimagecode =[textField.text stringByReplacingCharactersInRange:range withString:string];
        if (shurutimagecode.length>4) {
            
            [_ImageCodeTextfield resignFirstResponder];
        }
        
        if (self.textblock) {
            self.textblock(shurutimagecode);
        }
    }
  
    
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (YXScreenW<=320) {
        
        self.bigbackview.y = self.bigbackview.y-30;
    }else if (YXScreenW>=375)
    {
        self.bigbackview.y = self.bigbackview.y-20;
    }
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (YXScreenW<=320) {
        
        self.bigbackview.y = self.bigbackview.y+30;
    }else if (YXScreenW>=375)
    {
        self.bigbackview.y = self.bigbackview.y+20;
    }
    
}

/**
 确认按钮点击事件

 @param sender 点击的按钮
 */
- (IBAction)suerButtonClick:(UIButton *)sender
{
    if (self.pwdTextField.text.length==0) {
        
        [self.bigbackview addSubview: self.alearview];
        self.alearview.text = @"密码不能为空";
        [self.alearview bringSubviewToFront:self.bigbackview];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.alearview removeFromSuperview];
            self.alearview =nil;
        });
        
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(verificationPaymentPwdView:andClickButton:andTextFieldText:)]) {
        [self.delegate verificationPaymentPwdView:self andClickButton:sender andTextFieldText:self.pwdTextField.text];
    }
}

/**
 忘记支付密码点击事件

 @param sender 点击的按钮
 */
- (IBAction)resetPaymentPwdButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(verificationPaymentPwdView:andClickButton:andTextFieldText:)]) {
        [self.delegate verificationPaymentPwdView:self andClickButton:sender andTextFieldText:self.pwdTextField.text];
    }
}

/**
 取消按钮点击事件

 @param sender 点击的按钮
 */
- (IBAction)cancelButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(verificationPaymentPwdView:andClickButton:andTextFieldText:)]) {
        [self.delegate verificationPaymentPwdView:self andClickButton:sender andTextFieldText:self.pwdTextField.text];
    }
}

/**
 帮助按钮点击事件

 @param sender 点击的按钮
 */
- (IBAction)helpButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(verificationPaymentPwdView:andClickButton:andTextFieldText:)]) {
        [self.delegate verificationPaymentPwdView:self andClickButton:sender andTextFieldText:self.pwdTextField.text];
    }
}

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"YXVerificationPaymentPwdView" owner:nil options:nil].lastObject;
        
        //** 初始化界面 */
        self.pwdTextField.inputAccessoryView = self.customAccessoryView;
        self.pwdTextField.keyboardType = UIKeyboardTypeDefault;
        
        self.ImageCodeBigBackView.layer.masksToBounds = YES;
        self.ImageCodeBigBackView.layer.cornerRadius = 6;
        self.ImageCodeBigBackView.layer.borderColor = [UIColor mainThemColor].CGColor;
        self.ImageCodeBigBackView.layer.borderWidth = 1;
        
        self.ImageCodeBigBackView.hidden = YES;
        self.ImageCodeTextfield.delegate = self;
        self.pwdTextField.delegate = self;
        
        
        //** 画边框 */
        [self.pwdTextField.layer setBorderWidth:1.0];
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGColorRef color = [UIColor mainThemColor].CGColor;
        [self.pwdTextField.layer setBorderColor:color];
        
        //** 画虚线 */
        CAShapeLayer *border = [CAShapeLayer layer];
        border.strokeColor = [UIColor colorWithWhite:179.0/255.0 alpha:1.0].CGColor;
        border.fillColor = nil;
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(0, 0)];
        [bezierPath addLineToPoint:CGPointMake(self.bottomView.width, 0)];
        bezierPath.lineWidth = 1;
        border.path = bezierPath.CGPath;
        border.frame = self.bottomView.bounds;
        border.lineWidth = 1.f;
        border.lineCap = @"square";
        border.lineDashPattern = @[@4, @2];
        [self.bottomView.layer addSublayer:border];
        
        //** 屏幕适配 */
        if (iPHone6Plus) {
            self.contentViewLeftCons.constant = 56.5;
            self.contentViewRightCons.constant = 56.5;
        }else{
            self.contentViewLeftCons.constant = 37;
            self.contentViewRightCons.constant = 37;
        }
        
        [self.ImageCodeTextfield setInputAccessoryView:self.customAccessoryView];
        [self.pwdTextField setInputAccessoryView:self.customAccessoryView];
        
    }
    return self;
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


-(UILabel*)alearview
{
    if (!_alearview) {
        
        _alearview = [[UILabel alloc]initWithFrame:CGRectMake(20, 150, self.bigbackview.width-40, 30)];
        _alearview.backgroundColor = [UIColor blackColor];
        _alearview.alpha = 0.8;
        _alearview.textColor = [UIColor whiteColor];
        _alearview.font = YXRegularfont(12);
        _alearview.layer.cornerRadius = 3;
        _alearview .layer.masksToBounds = YES;
        _alearview.textAlignment = NSTextAlignmentCenter;
        
    }
    return _alearview;
    
}

-(void)setErrorstr:(NSString *)errorstr
{

    [self.bigbackview addSubview: self.alearview];
    self.alearview.text = errorstr;
    [self.alearview bringSubviewToFront:self.bigbackview];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.alearview removeFromSuperview];
        self.alearview =nil;
    });

}
@end
