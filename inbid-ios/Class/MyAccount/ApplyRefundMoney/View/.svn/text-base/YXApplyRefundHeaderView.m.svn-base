//
//  YXApplyRefundHeaderView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXApplyRefundHeaderView.h"
#import "UILabel+Extension.h"
#import "UILabel+YBAttributeTextTapAction.h"

@interface YXApplyRefundHeaderView ()<UITextFieldDelegate,YXKeyboardToolbarDelegate>
@property (weak, nonatomic) IBOutlet UIView *topviewbigView;
@property (weak, nonatomic) IBOutlet UILabel *canrefundTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *CanrefundContentLable;
@property (weak, nonatomic) IBOutlet UILabel *shouxuTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *shouxuContentLable;
@property (weak, nonatomic) IBOutlet UILabel *shituiMoneyLable;
@property (weak, nonatomic) IBOutlet UILabel *shituiMoneyContentLable;
@property (weak, nonatomic) IBOutlet UIView *seactionView;
@property (weak, nonatomic) IBOutlet UIButton *CommitBtn;
@property (weak, nonatomic) IBOutlet UILabel *boomDescLable;
//** 辅助视图 */
@property (nonatomic, strong) YXKeyboardToolbar *customAccessoryView;
@end

@implementation YXApplyRefundHeaderView

/**
 赋值
 */
-(void)setRefundModle:(YXApplyRefundSultModle *)RefundModle
{
    _RefundModle = RefundModle;
    self.CanrefundContentLable.text = [YXStringFilterTool formFenTransformaYuanWith:RefundModle.orderPayAmt];
    CGFloat radio = [RefundModle.refundRadio floatValue]*1000;
    self.shouxuTitleLable.text = [NSString stringWithFormat:@"—需扣手续费(%.0f‰)",radio];
    self.shouxuContentLable.text =  [YXStringFilterTool formFenTransformaYuanWith:RefundModle.refundFee];
    self.shituiMoneyContentLable.text = [YXStringFilterTool formFenTransformaYuanWith:RefundModle.refundAmt];
    
    
    NSString * kefuphone = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    NSString *descStr = [NSString stringWithFormat:@"1.为了保证您的资金，物品安全，请进行安全验证。\n2.如需帮助，可联系客服%@。",kefuphone];
    NSMutableAttributedString *atter = [[NSMutableAttributedString alloc]initWithString:descStr];
    [atter addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x419bef) range:NSMakeRange(descStr.length-kefuphone.length-1, kefuphone.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    [atter addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,  atter.length)];
    self.boomDescLable.attributedText = atter;
}

+(instancetype)loadheaderview
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YXApplyRefundHeaderView" owner:nil options:nil] lastObject];
}

- (IBAction)ClickCommitBtn:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(100,self.SmsTextfiled.text);
    }
}
- (IBAction)ClickSmsBtn:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(200,nil);
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.CommitBtn.layer.cornerRadius = 4;
    self.CommitBtn.layer.masksToBounds = YES;
    
    self.topviewbigView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.topviewbigView.layer.borderWidth = 1;
    
    self.seactionView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.seactionView.layer.borderWidth = 1;
    
    self.SmsTextfiled.delegate = self;
    
    NSString * kefuphone = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    [self.boomDescLable yb_addAttributeTapActionWithStrings:@[kefuphone] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        
        [YXStringFilterTool YXCallPhoneWith:self];
    }];
    
    [self.SmsTextfiled setInputAccessoryView:self.customAccessoryView];
    
    [YXNotificationTool addObserver:self selector:@selector(textViewEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
}
/**
 *  当 text field 文本内容改变时 会调用此方法
 *
 *  @param notification
 */
-(void)textViewEditChanged:(NSNotification *)notification{
    
    // 拿到文本改变的 text field
    UITextField *textField = (UITextField *)notification.object;
    
    if (textField== self.SmsTextfiled) {
        
        [[[YXStringFilterTool alloc]init] limitTextFiledEditChange:textField LimitNumber:6];
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
#pragma mark - 代理方法

- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    [self.SmsTextfiled endEditing:YES];
}
@end
