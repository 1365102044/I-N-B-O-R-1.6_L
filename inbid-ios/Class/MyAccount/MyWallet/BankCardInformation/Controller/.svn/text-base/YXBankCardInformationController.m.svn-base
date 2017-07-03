//
//  YXBankCardInformationController.m
//  Project
//
//  Created by 郑键 on 17/2/20.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "YXBankCardInformationController.h"
#import "YXBankCardInformationModel.h"
#import "YXBankCardInformationSubModel.h"
#import "YXBankCardInformationCell.h"
#import "YXSendMessageCell.h"
#import "YXBankCardInformationTitleHeader.h"
#import "YXBankCardInformationBottomFuncFooter.h"
#import "YXMyWalletAgreementViewController.h"
#import "YXMyWalletRequestTool.h"
#import "YXAlertViewTool.h"
#import "YXBankCardInformationController.h"
#import "MTDatePickerView.h"
#import "NSDate+YXExtension.h"

static NSString * const kYXBankCardInformationCellReusableIdentifyId = @"kYXBankCardInformationCellReusableIdentifyId";
static NSString * const kYXBankCardInformationSendMessageCellReusableIdentifyId = @"kYXBankCardInformationSendMessageCellReusableIdentifyId";
static NSString * const kYXBankCardInformationTitleHeaderReusableIdentifyId = @"kYXBankCardInformationTitleHeaderReusableIdentifyId";
static NSString * const kYXBankCardInformationBottomFuncFooterReusableIdentifyId = @"kYXBankCardInformationBottomFuncFooterReusableIdentifyId";

@interface YXBankCardInformationController () <UITableViewDataSource, UITableViewDelegate, YXBankCardInformationBottomFuncFooterDelegate, YXSendMessageCellDelegate>

/**
 控制器类型
 */
@property (nonatomic, assign) YXBankCardInformationControllerType type;

/**
 contentTableView
 */
@property (nonatomic, strong) UITableView *contentTableView;

/**
 cardholderName
 */
@property (nonatomic, copy) NSString *cardholderName;

/**
 cardNumber
 */
@property (nonatomic, copy) NSString *cardNumber;

/**
 数据模型
 */
@property (nonatomic, strong) NSArray *dataArray;

/**
 token
 */
@property (nonatomic, copy) NSString *token;

/**
 跳转控制器标志
 */
@property (nonatomic, assign) NSInteger popControllerIdentifier;

/**
 定时器
 */
@property (nonatomic, strong) NSTimer *countDownTimer;

/**
 短信验证码倒计时
 */
@property (nonatomic, assign) NSInteger time;

/**
 当前选中的有效期
 */
@property (nonatomic, copy) NSString *currentDateStr;

/**
 获取短信验证码标志
 */
@property (nonatomic, assign) BOOL loadMessageCode;

@end

@implementation YXBankCardInformationController

#pragma mark - First.通知

#pragma mark - Second.赋值

#pragma mark - Third.点击事件

/**
 定时器事件
 */
- (void)timerEventCountDown
{
    /**
     *  将模型内倒计时时间-1
     */
    YXBankCardInformationModel *model = self.dataArray.lastObject;
    YXBankCardInformationSubModel *messageModel = model.contentData.firstObject;
    [messageModel countDown];
    
    /**
     *  通知cell更新界面
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"walletBankMessageCountDown" object:nil userInfo:@{}];
    
    /**
     *  如果结束，释放定时器
     */
    if (messageModel.time <= 0) {
        [self stopTimer];
        self.loadMessageCode = NO;
        messageModel.time = CGFLOAT_MAX;
    }
}

#pragma mark - Fourth.代理方法

#pragma mark <YXSendMessageCellDelegate>

/**
 短信验证码，获取短信验证码点击事件

 @param sendMessageCell     sendMessageCell
 @param button              button
 */
- (void)sendMessageCell:(YXSendMessageCell *)sendMessageCell buttonClick:(UIButton *)button
{
    self.popControllerIdentifier == 2 ? [self loadForgetPaymentPasswordMessageCode] : [self loadBindBankCardMessageCode];
}

/**
 获取重置密码短信验证码
 */
- (void)loadForgetPaymentPasswordMessageCode
{
    if (self.loadMessageCode) return;
    
    /**
     *  请求参数配置
     */
    NSInteger payType = self.type == YXBankCardInformationControllerDebitCardInformation ? 2 : 3;
    
    /**
     *  获取数据
     */
    YXBankCardInformationModel *model                   = self.dataArray.firstObject;
    YXBankCardInformationModel *messageModel            = self.dataArray[1];
    YXBankCardInformationSubModel *bindMobSubModel      = messageModel.contentData[0];
    YXBankCardInformationSubModel *validateSubModel;
    YXBankCardInformationSubModel *cvv2SubModel;
    if (self.type == YXBankCardInformationControllerCreditCardInformation) {
        validateSubModel    = messageModel.contentData[1];
        cvv2SubModel        = messageModel.contentData[2];
        
        if ([validateSubModel.userInputText isEqualToString:@"请选择有效期"]
            || validateSubModel.userInputText.length == 0) {
            
            [self showTipsWithObjc:@{@"errorMsg":@"有效期不能为空"}];
            
            return;
        }
        
        if ([cvv2SubModel.userInputText isEqualToString:@""]
            || cvv2SubModel.userInputText.length == 0) {
            
            [self showTipsWithObjc:@{@"errorMsg":@"cvv2不能为空"}];
            
            return;
        }
    }
    
    /**
     *  验证输入数据是否正确。
     */
    if ([bindMobSubModel.userInputText isEqualToString:@""]
        || bindMobSubModel.userInputText.length == 0) {
        
        [self showTipsWithObjc:@{@"errorMsg":@"手机号不能为空"}];
        
        return;
    }
    
    self.loadMessageCode = YES;
    
    /**
     *  获取短信验证码，并倒计时
     */
    
    [[YXMyWalletRequestTool sharedTool] addBankCardGetMessageWithPayType:payType cardNo:self.cardNumber bindMob:bindMobSubModel.userInputText validate:self.currentDateStr cvv2:cvv2SubModel.userInputText type:@"password" success:^(id objc, id respodHeader) {
        [objc[@"status"] isEqualToString:@"1"] ? [self addBankCardGetMessageSuccessWithObjc:objc] : [self addBankCardGetMessageFailedWithObjc:objc];
    } failure:^(NSError *error) {
        YXLog(@"%@", error);
    }];
}

/**
 获取绑定银行卡短信验证码
 */
- (void)loadBindBankCardMessageCode
{
    if (self.loadMessageCode) return;
    
    /**
     *  请求参数配置
     */
    NSInteger payType = self.type == YXBankCardInformationControllerDebitCardInformation ? 2 : 3;
    
    /**
     *  获取数据
     */
    YXBankCardInformationModel *model                   = self.dataArray.firstObject;
    YXBankCardInformationModel *messageModel            = self.dataArray[1];
    YXBankCardInformationSubModel *bindMobSubModel      = messageModel.contentData[0];
    YXBankCardInformationSubModel *validateSubModel;
    YXBankCardInformationSubModel *cvv2SubModel;
    if (self.type == YXBankCardInformationControllerCreditCardInformation) {
        validateSubModel    = messageModel.contentData[1];
        cvv2SubModel        = messageModel.contentData[2];
        
        if ([validateSubModel.placeHolder isEqualToString:@"请选择有效期"]
            || validateSubModel.placeHolder.length == 0) {
            
            [self showTipsWithObjc:@{@"errorMsg":@"有效期不能为空"}];
            
            return;
        }
        
        if ([cvv2SubModel.userInputText isEqualToString:@""]
            || cvv2SubModel.userInputText.length == 0) {
            
            [self showTipsWithObjc:@{@"errorMsg":@"cvv2不能为空"}];
            
            return;
        }
    }
    
    /**
     *  验证输入数据是否正确。
     */
    if ([bindMobSubModel.userInputText isEqualToString:@""]
        || bindMobSubModel.userInputText.length == 0) {
        
        [self showTipsWithObjc:@{@"errorMsg":@"手机号不能为空"}];
        
        return;
    }
    
    self.loadMessageCode = YES;
    
    /**
     *  获取短信验证码，并倒计时
     */
    [[YXMyWalletRequestTool sharedTool] addBankCardGetMessageWithPayType:payType
                                                                  cardNo:self.cardNumber
                                                                 bindMob:bindMobSubModel.userInputText
                                                                validate:self.currentDateStr
                                                                    cvv2:cvv2SubModel.userInputText
                                                                    type:@"brank"
                                                                 success:^(id objc, id respodHeader) {
                                                                     [objc[@"status"] isEqualToString:@"1"] ? [self addBankCardGetMessageSuccessWithObjc:objc] : [self addBankCardGetMessageFailedWithObjc:objc];
                                                                 }
                                                                 failure:^(NSError *error) {
                                                                     YXLog(@"%@", error);
                                                                 }];

}

/**
 短信验证码倒计时
 */
- (void)messageCodeCountDown
{
    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer
                                 forMode:NSRunLoopCommonModes];
}

/**
 停止定时器
 */
- (void)stopTimer
{
    [self.countDownTimer invalidate];
     self.countDownTimer = nil;
}

/**
 添加银行卡获取短信验证码，成功

 @param objc objc
 */
- (void)addBankCardGetMessageSuccessWithObjc:(id)objc
{
    /**
     *  按钮进入倒计时状态，禁止点击
     */
    [self messageCodeCountDown];
    
    /**
     *  保存token
     */
    @try {
        NSDictionary *objcDic       = objc[@"data"];
        self.token                  = objcDic[@"token"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 添加银行卡获取短信验证码，失败

 @param objc objc
 */
- (void)addBankCardGetMessageFailedWithObjc:(id)objc
{
    self.loadMessageCode = NO;
    [self showTipsWithObjc:objc];
}

#pragma mark <YXBankCardInformationBottomFuncFooterDelegate>

/**
 footer按键点击代理事件

 @param bankCardInformationBottomFuncFooter bankCardInformationBottomFuncFooter «
 @param sender 点击的按钮
 */
- (void)bankCardInformationBottomFuncFooter:(YXBankCardInformationBottomFuncFooter *)bankCardInformationBottomFuncFooter
                                buttonClick:(UIButton *)sender
{
    /**
     *  获取数据
     */
    YXBankCardInformationModel *model                               = self.dataArray.firstObject;
    YXBankCardInformationSubModel *subModel                         = model.contentData[1];
    
    /**
     *  服务协议跳转
     */
    if (sender.tag == 1001) {
        YXMyWalletAgreementViewController *agreementViewController  =[[YXMyWalletAgreementViewController alloc] init];
        agreementViewController.isHiddenBoobView                    = YES;
        [self.navigationController pushViewController:agreementViewController
                                             animated:YES];
    }
    
    /**
     *  切换是否同意支付协议（默认同意）
     */
    if (sender.tag == 1002) {
        
    }
    
    /**
     *  下一步
     */
    if (sender.tag == 1003) {
        
        if (self.type == YXBankCardInformationControllerAddBankCard) {
            
            /**
             *  验证银行卡合法性
             */
            
            if ([subModel.userInputText isEqualToString:@""]
                || subModel.userInputText.length == 0) {
                
                [self showTipsWithObjc:@{@"errorMsg":@"银行卡号不能为空"}];
                
                return;
            }
            
            /**
             *  判断银行卡性质，根据不同的银行卡，跳转不同的界面
             *  暂时由于不支持信用卡，暂时使用储蓄卡
             */
            [[YXMyWalletRequestTool sharedTool] checkBankCardTypeWithCardNo:subModel.userInputText success:^(id objc, id respodHeader) {
                
                [objc[@"status"] isEqualToString:@"1"] ? [self checkBankCardTypeWithObjc:objc] : [self showTipsWithObjc:objc];
                
            } failure:^(NSError *error) {
                YXLog(@"%@", error);
            }];
        }
        
        if (self.type == YXBankCardInformationControllerDebitCardInformation
            || self.type == YXBankCardInformationControllerCreditCardInformation) {
            
            /**
             *  验证是否输入验证码
             */
            YXBankCardInformationModel *model                               = self.dataArray.lastObject;
            YXBankCardInformationSubModel *subModel                         = model.contentData.firstObject;
            if ([subModel.userInputText isEqualToString:@""]
                || subModel.userInputText.length == 0) {
                
                [self showTipsWithObjc:@{@"errorMsg":@"请进行短信验证"}];
                
                return;
            }
            
            /**
             *  验证是否同意协议
             */
            if (!model.isAgreeFooterArgeement) {
                
                [self showTipsWithObjc:@{@"errorMsg":@"请仔细阅读并同意协议"}];
                
                return;
            }
            
            /**
             *  根据popIdentifer判断，跳转的界面
             */
            self.popControllerIdentifier == 2 ? [self pushToForgetPaymentPasswordViewController] : [self popToSourceViewController];
        }
    }
}

/**
 跳转到来源的控制器
 */
- (void)popToSourceViewController
{
    
    /**
     *  获取数据
     */
    YXBankCardInformationModel *model = self.dataArray.lastObject;
    YXBankCardInformationSubModel *subModel = model.contentData.firstObject;
    
    /**
     *  校验验证码
     */
    [[YXMyWalletRequestTool sharedTool] addBankCardCheckMessageWithToken:self.token verifyCode:subModel.userInputText type:@"brank" success:^(id objc, id respodHeader) {
        
        [objc[@"status"] isEqualToString:@"1"] ? [self verificationMessageCodeSuccessWithObjc:objc] : [self verificationMessageCodeFailedWithObjc:objc];
        
    } failure:^(NSError *error) {
        YXLog(@"%@", error);
    }];
    
}

/**
 跳转到重置支付密码页面
 */
- (void)pushToForgetPaymentPasswordViewController
{
    /**
     *  获取数据
     */
    YXBankCardInformationModel *model = self.dataArray.lastObject;
    YXBankCardInformationSubModel *subModel = model.contentData.firstObject;
    
    /**
     *  校验验证码
     */
    [[YXMyWalletRequestTool sharedTool] addBankCardCheckMessageWithToken:self.token verifyCode:subModel.userInputText type:@"password" success:^(id objc, id respodHeader) {
        
        [objc[@"status"] isEqualToString:@"1"] ? [self verificationMessageCodeSuccessWithObjc:objc] : [self verificationMessageCodeFailedWithObjc:objc];
        
    } failure:^(NSError *error) {
        YXLog(@"%@", error);
    }];
}

/**
 验证短信验证码成功

 @param objc objc
 */
- (void)verificationMessageCodeSuccessWithObjc:(id)objc
{
    
    /**
     *  判断来源，如果为重置密码过来，则跳转结果页
     *  如果为添加银行卡则pop即可
     */
    if (self.popControllerIdentifier == 1) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:YES];
    }
    
    if (self.popControllerIdentifier == 2) {
        
        YXMyWalletPassWordViewController *passwordvc = [[YXMyWalletPassWordViewController alloc]init];
        passwordvc.CurrenPassWordType = SetPayPasswordType;
        passwordvc.token = objc[@"data"][@"token"];
        [self.navigationController pushViewController:passwordvc animated:YES];
    }

}

/**
 验证短信验证码失败

 @param objc objc
 */
- (void)verificationMessageCodeFailedWithObjc:(id)objc
{
    [self showTipsWithObjc:objc];
}

/**
 检查卡类型

 @param objc objc
 */
- (void)checkBankCardTypeWithObjc:(id)objc
{
    NSDictionary *dataDic                                       = objc[@"data"];
    
    YXBankCardInformationControllerType type                    = YXBankCardInformationControllerNone;
    
    /**
     *  储蓄卡
     */
    if ([dataDic[@"card_type"] isEqualToString:@"2"]) {
        type                                                    = YXBankCardInformationControllerDebitCardInformation;
    }
    
    /**
     *  信用卡
     */
    if ([dataDic[@"card_type"] isEqualToString:@"3"]) {
        type                                                    = YXBankCardInformationControllerCreditCardInformation;
    }
    
    
    /**
     *  获取数据
     */
    YXBankCardInformationModel *model                           = self.dataArray.firstObject;
    YXBankCardInformationSubModel *subModelCardNumber           = model.contentData[1];
    
    YXBankCardInformationController *debitCardController        = [YXBankCardInformationController bankCardInformationControllerWithType:type
                                                                                                                          cardholderName:self.cardholderName
                                                                                                                              cardNumber:subModelCardNumber.userInputText
                                                                                                                                  extend:@(self.popControllerIdentifier)];
    debitCardController.title                                   = self.popControllerIdentifier == 2 ? @"重置支付密码" : @"填写银行卡信息";
    [self.navigationController pushViewController:debitCardController animated:YES];
}

/**
 显示提示

 @param objc objc
 */
- (void)showTipsWithObjc:(id)objc
{
    if ([objc[@"errorMsg"] isKindOfClass:[NSString class]]) {
        
        [YXAlertViewTool showAlertView:self title:@"提示" message:objc[@"errorMsg"] confrimBlock:^{
            
        }];
        
        return;
    }
    
    NSDictionary *errorMsg;
    NSString *ret_msg;
    @try {
        errorMsg = objc[@"errorMsg"];
        ret_msg = errorMsg[@"ret_msg"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    [YXAlertViewTool showAlertView:self title:@"提示" message:ret_msg confrimBlock:^{
        
    }];
}

#pragma mark <UITableViewDataSource>

/**
 返回组
 
 @param tableView tableView
 
 @return 组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

/**
 返回行
 
 @param tableView tableView
 @param section   section
 
 @return 每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] contentData].count;
}

/**
 自定义cell
 
 @param tableView tableView
 @param indexPath indexPath
 
 @return 自定义cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXBankCardInformationModel *model = self.dataArray[indexPath.section];
    YXBankCardInformationSubModel *subModel = model.contentData[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:subModel.reId];
    if (!cell) {
        if (indexPath.section == 0
            || indexPath.section == 1) {
            cell = [[YXBankCardInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subModel.reId];
            __weak YXBankCardInformationCell *tempCell = (YXBankCardInformationCell *)cell;
            tempCell.model = subModel;
        }
        
        if (indexPath.section == 2) {
            cell = [[YXSendMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subModel.reId];
            __weak YXSendMessageCell *tempCell = (YXSendMessageCell *)cell;
            tempCell.delegate = self;
            tempCell.model = subModel;
        }
    }
    return cell;
}

/**
 组头

 @param tableView tableView
 @param section section
 @return 组头
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YXBankCardInformationModel *model = self.dataArray[section];
    YXBankCardInformationTitleHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYXBankCardInformationTitleHeaderReusableIdentifyId];
    if (!header) {
        header = [[YXBankCardInformationTitleHeader alloc] initWithReuseIdentifier:kYXBankCardInformationTitleHeaderReusableIdentifyId];
        header.model = model;
    }
    
    return header;
}

/**
 组尾

 @param tableView tableView
 @param section section
 @return 组尾
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    YXBankCardInformationModel *model = self.dataArray[section];
    if (section == self.dataArray.count - 1) {
        YXBankCardInformationBottomFuncFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYXBankCardInformationBottomFuncFooterReusableIdentifyId];
        if (!footer) {
            footer = [[YXBankCardInformationBottomFuncFooter alloc] initWithReuseIdentifier:kYXBankCardInformationBottomFuncFooterReusableIdentifyId];
            footer.model = model;
            footer.delegate = self;
        }
        
        return footer;
    }else{
        return nil;
    }
}

#pragma mark <UITableViewDelegate>

/**
 *  点击事件
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  信用卡环境下点击有效期响应
     */
    if (indexPath.section == 1
        && indexPath.row == 1
        && self.type == YXBankCardInformationControllerCreditCardInformation) {
        
        [self.contentTableView endEditing:YES];
        
        /**
         *  获取数据
         */
        YXBankCardInformationModel *dataArray = self.dataArray[indexPath.section];
        YXBankCardInformationSubModel *subModel = dataArray.contentData[indexPath.row];
        
        MTDatePickerView *picker = [MTDatePickerView datePickerViewWithIsShowBar:YES
                                                                           title:nil
                                                                        leftText:@"取消"
                                                                       rightText:@"完成"
                                                                  additionalText:nil];
        picker.mode             = MTDatePickerModeDateYearAndMonth;
        picker.defaultDate      = [NSDate date];
        picker.minDate          = [NSDate date];
        
        [picker pickerSelected:^(NSDate *date) {
            subModel.placeHolder = [date dataStrWithDateFormat:@"MM/yy"];
            self.currentDateStr = subModel.placeHolder;
            [self refreshCellViews];
        } done:^(NSDate *date) {
            subModel.placeHolder = [date dataStrWithDateFormat:@"MM/yy"];
            self.currentDateStr = subModel.placeHolder;
            [self refreshCellViews];
        } additional:^(id date) {
            
        } cancel:^{
            if ([self.currentDateStr isEqualToString:@""]
                || self.currentDateStr.length == 0) {
                subModel.placeHolder = @"请选择有效期";
            }else{
                subModel.placeHolder = self.currentDateStr;
            }
            [self refreshCellViews];
        }];
        [picker show];
    }
}

/**
 刷新指定行

 @param section     section
 @param row         row
 */
- (void)refreshCellViews
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kBankCardInformationSelectedTimeNotificaiton"
                                                        object:nil
                                                      userInfo:nil];
}

/**
 组头高度

 @param tableView tableView
 @param section section
 @return 组头高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    YXBankCardInformationModel *model = self.dataArray[section];
    return model.cacheSectionHeaderHeight;
}

/**
 组尾高度

 @param tableView tableView
 @param section section
 @return 组尾高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    YXBankCardInformationModel *model = self.dataArray[section];
    return model.cacheFooterHeight;
}

#pragma mark - Fifth.控制器生命周期

/**
 初始化方法
 
 @param type type 类型
 @param cardholderName 持卡人姓名
 @param cardNumber 卡号
 @param extend 扩展参数（暂传nil）
 @return 对应类型的对象
 */
+ (instancetype)bankCardInformationControllerWithType:(YXBankCardInformationControllerType)type
                                       cardholderName:(NSString *)cardholderName
                                           cardNumber:(NSString *)cardNumber
                                               extend:(id)extend
{
    YXBankCardInformationController *banCardInformationController   = [[YXBankCardInformationController alloc] init];
    banCardInformationController.type                               = type;
    banCardInformationController.cardholderName                     = cardholderName;
    banCardInformationController.cardNumber                         = cardNumber;
    banCardInformationController.popControllerIdentifier            = [extend integerValue];
    return banCardInformationController;
}

- (instancetype)init
{
    if (self == [super init]) {
        [self initCustomUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.popControllerIdentifier == 2 ? @"重置支付密码" : @"填写银行卡信息";
}

#pragma mark - Sixth.界面配置

/**
 创建界面
 */
- (void)initCustomUI
{
    self.view.backgroundColor = [UIColor themLightGrayColor];
    [self.view addSubview:self.contentTableView];
}

#pragma mark - Seventh.懒加载

- (NSTimer *)countDownTimer
{
    if (!_countDownTimer) {
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                           target:self
                                                         selector:@selector(timerEventCountDown)
                                                         userInfo:nil
                                                          repeats:YES];
    }
    return _countDownTimer;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        
        /**
         *  默认类型或添加银行卡
         */
        if (self.type == YXBankCardInformationControllerNone
            || self.type == YXBankCardInformationControllerAddBankCard) {
            _dataArray = @[@{@"sectionTitle":@"请绑定持卡人本人的银行卡",
                             @"cacheSectionHeaderHeight":@37.f,
                             @"contentData":@[@{@"title":@"持卡人",
                                                @"placeHolder":self.cardholderName,
                                                @"reId":@"kYXBankCardInformationCellReusableIdentifyId",
                                                @"userInteraction":@0},
                                              @{@"title":@"卡号",
                                                @"placeHolder":self.cardNumber ? self.cardNumber : @"请输入银行卡号",
                                                @"reId":@"kYXBankCardInformationCellReusableIdentifyId",
                                                @"userInteraction":self.cardNumber ? @0 : @1,
                                                @"keyboardType":@4,
                                                @"maxTextCount":@"50"}],
                             @"cacheFooterHeight":@120.f,
                             @"footerHiddenAgreementButton":@YES}];
        }
        
        /**
         *  储蓄卡
         */
        if (self.type == YXBankCardInformationControllerDebitCardInformation) {
            _dataArray = @[@{@"sectionTitle":@"请绑定持卡人本人的银行卡",
                             @"cacheSectionHeaderHeight":@37.f,
                             @"contentData":@[@{@"title":@"持卡人",
                                                @"placeHolder":self.cardholderName,
                                                @"reId":@"kYXBankCardInformationCellReusableIdentifyId",
                                                @"userInteraction":@0},
                                              @{@"title":@"卡号",
                                                @"placeHolder":self.cardNumber ? self.cardNumber : @"请输入银行卡号",
                                                @"reId":@"kYXBankCardInformationCellReusableIdentifyId",
                                                @"userInteraction":@0}],
                             @"cacheFooterHeight":@0.1f},
                           @{@"sectionTitle":@"",
                             @"cacheSectionHeaderHeight":@37.f,
                             @"contentData":@[@{@"title":@"手机号",
                                                @"placeHolder":@"银行预留手机号",
                                                @"reId":@"kYXBankCardInformationCellReusableIdentifyId",
                                                @"userInteraction":@1,
                                                @"keyboardType":@4,
                                                @"maxTextCount":@"11"}],
                             @"cacheFooterHeight":@0.1f},
                           @{@"sectionTitle":@"请输入验证码完成验证",
                             @"cacheSectionHeaderHeight":@37.f,
                             @"contentData":@[@{@"title":@"获取验证码",
                                                @"placeHolder":@"输入短信验证码",
                                                @"reId":@"kYXBankCardInformationSendMessageCellReusableIdentifyId",
                                                @"userInteraction":@1,
                                                @"keyboardType":@4,
                                                @"maxTextCount":@"6"}],
                             @"cacheFooterHeight":@170.f,
                             @"footerHiddenAgreementButton":@NO,
                             @"footerArgeementStatus":@YES}];
        }
        
        /**
         *  信用卡
         */
        if (self.type == YXBankCardInformationControllerCreditCardInformation) {
            _dataArray = @[@{@"sectionTitle":@"请绑定持卡人本人的银行卡",
                             @"cacheSectionHeaderHeight":@37.f,
                             @"contentData":@[@{@"title":@"持卡人",
                                                @"placeHolder":self.cardholderName,
                                                @"reId":@"kYXBankCardInformationCellReusableIdentifyId",
                                                @"userInteraction":@0},
                                              @{@"title":@"卡号",
                                                @"placeHolder":self.cardNumber ? self.cardNumber : @"请输入银行卡号",
                                                @"reId":@"kYXBankCardInformationCellReusableIdentifyId",
                                                @"userInteraction":@0}],
                             @"cacheFooterHeight":@0.1f},
                           @{@"sectionTitle":@"",
                             @"cacheSectionHeaderHeight":@37.f,
                             @"contentData":@[@{@"title":@"手机号",
                                                @"placeHolder":@"银行预留手机号",
                                                @"reId":@"kYXBankCardInformationCellReusableIdentifyId",
                                                @"userInteraction":@1,
                                                @"keyboardType":@4,
                                                @"maxTextCount":@"11"},
                                              @{@"title":@"有效期",
                                                @"placeHolder":@"请选择有效期",
                                                @"reId":@"kYXBankCardInformationCellReusableIdentifyId",
                                                @"userInteraction":@0,
                                                @"maxTextCount":@"10"},
                                              @{@"title":@"CVV2",
                                                @"placeHolder":@"银行卡背面后末尾三位数字",
                                                @"reId":@"kYXBankCardInformationCellReusableIdentifyId",
                                                @"userInteraction":@1,
                                                @"keyboardType":@4,
                                                @"maxTextCount":@"3"}],
                             @"cacheFooterHeight":@0.1f},
                           @{@"sectionTitle":@"请输入验证码完成验证",
                             @"cacheSectionHeaderHeight":@37.f,
                             @"contentData":@[@{@"title":@"获取验证码",
                                                @"placeHolder":@"输入短信验证码",
                                                @"reId":@"kYXBankCardInformationSendMessageCellReusableIdentifyId",
                                                @"userInteraction":@1,
                                                @"keyboardType":@4,
                                                @"maxTextCount":@"6"}],
                             @"cacheFooterHeight":@170.f,
                             @"footerHiddenAgreementButton":@NO,
                             @"footerArgeementStatus":@YES}];
        }
        
        _dataArray = [YXBankCardInformationModel mj_objectArrayWithKeyValuesArray:_dataArray];
    }
    return _dataArray;
}

- (UITableView *)contentTableView
{
    if (!_contentTableView) {
        UITableView *tableViewTemp                      = [[UITableView alloc] initWithFrame:self.view.bounds
                                                                                       style:UITableViewStyleGrouped];
        tableViewTemp.separatorStyle                    = UITableViewCellSeparatorStyleNone;
        tableViewTemp.delegate                          = self;
        tableViewTemp.dataSource                        = self;
        tableViewTemp.keyboardDismissMode               = YES;
        tableViewTemp.backgroundColor                   = [UIColor themLightGrayColor];
        tableViewTemp.rowHeight                         = ADJUST_PERCENT_FLOAT(50);
        tableViewTemp.keyboardDismissMode               = UIScrollViewKeyboardDismissModeOnDrag;
        _contentTableView                               = tableViewTemp;
    }
    return _contentTableView;
}

@end
