//
//  YXApplyRefundViewController.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/19.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXApplyRefundViewController.h"
#import "YXApplyRefundHeaderView.h"
#import "YXApplyRefundRequestTool.h"
#import "YXApplyRefundSultModle.h"
#import "YXAlearlyCommitApplyViewController.h"
#import "YXHaveBanKModle.h"
#import "YXAlertViewTool.h"
@interface YXApplyRefundViewController ()
@property(nonatomic,strong) YXApplyRefundHeaderView * applyrefundView;
@property(nonatomic,strong) YXApplyRefundSultModle * RefundModle;
@property(nonatomic,assign) NSInteger  timeNumber;
@end

@implementation YXApplyRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退款申请";
    self.view.backgroundColor= YXBackMainColor;
    self.tableview.tableHeaderView = self.applyrefundView;
    __weak typeof(self)weakself = self;
    self.applyrefundView.clickBlock = ^(NSInteger tag,NSString *smscode){
        if (tag==100){
            [weakself CommitResultData:smscode];
        }else if(tag ==200) {
            [weakself RequestSmsCode];
        }
    };
    [self requestResultData];
}

/**
 获取验证码
 */
-(void)RequestSmsCode{

    [[YXApplyRefundRequestTool sharedTool] GetSMSCodeWithphone:[YXUserDefaults objectForKey:@"PHONE"] Success:^(id objc, id respodHeader) {
        if([respodHeader[@"Status"] isEqualToString:@"1"])
        {
            self.timeNumber = 60;
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime1:) userInfo:nil repeats:YES];
            [timer fire];
        }else{
            [YXAlearMnager ShowAlearViewWith:objc[@"errorMsg"] Type:2];
        }
    } failure:^(NSError *error) {
    }];
}

//计算定时器时间
-(void)updateTime1:(NSTimer *)Timer
{
    self.timeNumber--;
    self.applyrefundView.SmsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.applyrefundView.SmsBtn setTitle:[NSString stringWithFormat:@"%ld s",(long)self.timeNumber] forState:UIControlStateNormal];
    [self.applyrefundView.SmsBtn setTitleColor:UIColorFromRGB(0xaaa7a7) forState:UIControlStateNormal];
    self.applyrefundView.SmsBtn.userInteractionEnabled = NO;
    
    if (self.timeNumber <= 0)
    {
        [Timer invalidate];
        [self.applyrefundView.SmsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.applyrefundView.SmsBtn setTitleColor:UIColorFromRGB(0x70ADEF) forState:UIControlStateNormal];
        self.applyrefundView.SmsBtn.userInteractionEnabled = YES;
    }
}
/**
 提交 信息 网络请求
 */
-(void)CommitResultData:(NSString *)SmsCode
{
    
    if (SmsCode.length==0) {
        [YXAlearMnager ShowAlearViewWith:@"请输入验证码" Type:2];
        return;
    }
    
    [[YXApplyRefundRequestTool sharedTool] CommitRefundMoneyDataWith:self.RefundModle.refundId
                                                             orderId:self.orderId
                                                             SmsCode:SmsCode
                                                             Success:^(id objc, id respodHeader) {
                                                                 
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            
            YXHaveBanKModle *modle = [YXHaveBanKModle mj_objectWithKeyValues:objc[@"data"]];
            self.RefundModle.refundDays = modle.refundDays;
            self.RefundModle.refundDealDays = modle.refundDealDays;
            self.RefundModle.refundWorkDays = modle.refundWorkDays;
            YXAlearlyCommitApplyViewController *alearlyCommitVC = [[YXAlearlyCommitApplyViewController alloc]init];
            alearlyCommitVC.refundModle =  self.RefundModle;
            [self.navigationController pushViewController:alearlyCommitVC animated:YES];
            
        }else{
            
            [YXAlearMnager ShowAlearTopBarViewWith:objc[@"errorMsg"]];
        }
    } failure:^(NSError *error) {
    }];
}

/**
 进入的时候 网络请求
 */
-(void)requestResultData
{
    [[YXApplyRefundRequestTool sharedTool] RequestRefundResultDataWith:self.orderId Success:^(id objc, id respodHeader) {
        if ([respodHeader[@"Status"] isEqualToString:@"1"]) {
            YXLog(@"====reques==%@===",objc);
            self.RefundModle = [YXApplyRefundSultModle mj_objectWithKeyValues:objc[@"data"]];
            self.applyrefundView.RefundModle = self.RefundModle;
            
        }else{
            [YXAlearMnager ShowAlearViewWith:objc[@"errorMsg"] Type:2];
        }
    } failure:^(NSError *error) {
    }];
}


/**
 懒加载
 */
-(YXApplyRefundHeaderView *)applyrefundView
{
    if (!_applyrefundView) {
        _applyrefundView = [YXApplyRefundHeaderView loadheaderview];
        _applyrefundView.frame =self.view.bounds;
        _applyrefundView.backgroundColor = YXBackMainColor;
    }
    return  _applyrefundView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}



@end
