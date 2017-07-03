//
//  YXYXSendAuctionConsignmentPlatformContentController.m
//  inbid-ios
//
//  Created by 郑键 on 16/11/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXYXSendAuctionConsignmentPlatformContentController.h"
#import "YXAppraisaReportIdentifyModel.h"
#import "YXStringFilterTool.h"
#import "YXMyOrderSuccessAlerview.h"

@interface YXYXSendAuctionConsignmentPlatformContentController ()<YXKeyboardToolbarDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

/**
 顶部官方提示label
 */
@property (weak, nonatomic) IBOutlet UILabel *topTIpsLabel;

/**
 底部提示框
 */
@property (weak, nonatomic) IBOutlet UILabel *bottomTipsLabel;

/**
 确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *suerButton;

/**
 辅助视图
 */
@property (nonatomic, strong) YXKeyboardToolbar *customAccessoryView;

/**
 选择寄卖周期textField
 */
@property (weak, nonatomic) IBOutlet UITextField *dayPickerViewTextField;

/**
 日期选择器
 */
@property (nonatomic, strong) UIPickerView *dayPickerView;

/**
 日期选择器数据源
 */
@property (nonatomic, strong) NSArray *dayDataSourceArray;

/**
 弹窗
 */
@property(nonatomic,strong) YXMyOrderSuccessAlerview * RemindGoodsView;

/**
 商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;

/**
 商品编号
 */
@property (weak, nonatomic) IBOutlet UILabel *goodIdentifyId;

/**
 商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *goodName;

@end

@implementation YXYXSendAuctionConsignmentPlatformContentController



#pragma mark - First.通知

#pragma mark - Second.赋值

/**
 商品数据

 @param appraisaReportIdentifyModel appraisaReportIdentifyModel
 */
- (void)setAppraisaReportIdentifyModel:(YXAppraisaReportIdentifyModel *)appraisaReportIdentifyModel
{
    _appraisaReportIdentifyModel = appraisaReportIdentifyModel;
    
    //** 赋值 */
    if (self.type == kYXSendAuctionConsignmentPlatformContentControllerLoadConsignment) {
        self.goodIdentifyId.text = [NSString stringWithFormat:@"鉴 定 编 号：%lld", appraisaReportIdentifyModel.indentifyOrderId];
         [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:appraisaReportIdentifyModel.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    }else{
        self.goodIdentifyId.text = [NSString stringWithFormat:@"商 品 编 号：%lld", appraisaReportIdentifyModel.prodId];
         [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:appraisaReportIdentifyModel.mainImg] placeholderImage:[UIImage imageNamed:@""]];
    }
    self.goodName.text = [NSString stringWithFormat:@"商 品 名 称：%@", appraisaReportIdentifyModel.prodName];
    
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法

#pragma mark <YXKeyboardToolbarDelegate>

/**
 键盘辅助视图
 
 @param keyboardToolbar keyboardToolbar
 @param doneButtonClick doneButtonClick
 */
- (void)keyboardToolbar:(YXKeyboardToolbar *)keyboardToolbar doneButtonClick:(UIBarButtonItem *)doneButtonClick
{
    [self.tableView endEditing:YES];
}

#pragma mark <UIPickerViewDataSource>

/**
 列数

 @param pickerView pickerView

 @return return value
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

/**
 行数

 @param pickerView pickerView
 @param component  component

 @return return 行数
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dayDataSourceArray.count;
}

#pragma mark <UITableViewDelgate>

/**
 行高

 @param tableView tableView
 @param indexPath indexPath

 @return 行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (self.type == kYXSendAuctionConsignmentPlatformContentControllerLoadReConsignment) {
            if (iPHone5) {
                return 53.f;
            }else{
                return 40.f;
            }
        }else if (self.type == kYXSendAuctionConsignmentPlatformContentControllerLoadConsignment) {
            return 53.f;
        }
    }
    if (indexPath.section == 0 && indexPath.row == 1) return 102.f;
    if (indexPath.section == 0 && indexPath.row == 2) return 79.5f;
    if (indexPath.section == 0 && indexPath.row == 3) return 40.f;
    if (indexPath.section == 0 && indexPath.row == 4) return 60.f;
    return 0;
}

#pragma mark <UIPickerViewDelegate>

/**
 标题

 @param pickerView pickerView
 @param row        row
 @param component  component

 @return return 标题
 */
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.dayDataSourceArray objectAtIndex:row];
}

/**
 选中回调

 @param pickerView pickerView
 @param row        row
 @param component  component
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    self.showDayPickerLabel.text = self.dayDataSourceArray[row];
}

#pragma mark - Fifth.控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //** 界面样式 */
    [self.suerButton setBackgroundColor: [UIColor mainThemColor]];
    self.automaticallyAdjustsScrollViewInsets       = NO;
    self.tableView.bounces                          = NO;
    self.tableView.backgroundColor                  = [UIColor clearColor];
    
    //** 界面赋值 */
    //** 判断当前是哪种界面 */
    if (self.type == kYXSendAuctionConsignmentPlatformContentControllerLoadReConsignment) {
        self.topTIpsLabel.text              = @"以下商品规定时间内未售出，请重新选择寄卖方式";
    }else if (self.type == kYXSendAuctionConsignmentPlatformContentControllerLoadConsignment) {
     self.topTIpsLabel.text                 = [NSString stringWithFormat:@"经官方鉴定，您的商品符合售卖规定。系统给出的指导价为¥%@",
                                               [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%zd",
                                                                                   self.appraisaReportIdentifyModel.suggestMoney / 100]]];
    }
    
    //** 配置输入框 */
    [self.selaMoneyTextField setInputAccessoryView:self.customAccessoryView];
    [self.dayPickerViewTextField setInputView:self.dayPickerView];
    [self.dayPickerViewTextField setInputAccessoryView:self.customAccessoryView];
    
    //** 佣金比例 */
    self.bottomTipsLabel.text = [NSString stringWithFormat:@"提示：交易成功后，平台会收取成交金额的%@作为佣金其余款项会在5个工作日之内打到您的相应账户。",
                                 [YXLoadZitiData objectZiTiWithforKey:@"commissionRatio"]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.selaMoneyTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.selaMoneyTextField resignFirstResponder];
}

#pragma mark - Sixth.界面配置

#pragma mark - Seventh.懒加载

- (YXKeyboardToolbar *)customAccessoryView
{
    if (!_customAccessoryView) {
        
        _customAccessoryView                = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YXKeyboardToolbar class])
                                                                            owner:nil
                                                                          options:nil].firstObject;
        _customAccessoryView.customDelegate = self;
    }
    return _customAccessoryView;
}

- (UIPickerView *)dayPickerView
{
    if (!_dayPickerView) {
        _dayPickerView                      = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
        _dayPickerView.backgroundColor      = [UIColor whiteColor];
        _dayPickerView.dataSource           = self;
        _dayPickerView.delegate             = self;
    }
    return _dayPickerView;
}

- (NSArray *)dayDataSourceArray
{
    if (!_dayDataSourceArray) {
        _dayDataSourceArray                 = @[@"1天",
                                                @"2天",
                                                @"3天",
                                                @"4天",
                                                @"5天",
                                                @"6天",
                                                @"7天"];
    }
    return _dayDataSourceArray;
}


/**
 弹窗
 
 @param type 弹窗的样式
 */
- (void)showRemindGoodsViewWithType:(NSString *)type
{
    //--弹窗
    [[UIApplication sharedApplication].keyWindow addSubview:self.RemindGoodsView];
    self.RemindGoodsView.Type = type;
    self.RemindGoodsView.frame = [UIApplication sharedApplication].keyWindow.bounds;
    __weak typeof (self) wealself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wealself dimssview];
    });
}


//** 取消弹窗 */
-(void)dimssview
{
    [self.RemindGoodsView removeFromSuperview];
    self.RemindGoodsView = nil;
}


- (YXMyOrderSuccessAlerview *)RemindGoodsView
{
    if(!_RemindGoodsView){
        
        _RemindGoodsView = [[YXMyOrderSuccessAlerview alloc]init];
    }
    return _RemindGoodsView;
}

@end
