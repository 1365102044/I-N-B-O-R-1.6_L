//
//  YXMyAccoutWaitPaymentBaseview.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/10/8.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAccoutWaitPaymentBaseview.h"
#import "YXMyAccountPaymentChooseTitleView.h"
#import "YXMyAccoutWaitPaymentTypeView.h"
#import "YXYmAccountPaymentUserInformationView.h"
#import "YXMyAccountPaymenChooseFenbiOrQuaneView.h"
#import "YXMyAccountPaymentChoosePayTypeView.h"
#import "UILabel+Extension.h"
#import "YXMyaccountGotoPayMentTopUserInformationView.h"


#pragma mark  ******************* 临时界面 只有银联支付的情况 下**********************
#import "YXMyWaitPayMentTempraryTopView.h"



@interface YXMyAccoutWaitPaymentBaseview ()

{
    
    UILabel*dingdanNmuberLable;
    
    UIView  *topview;
    
    
    
    CGFloat uesrinformationheight;
    
    CGFloat choosepaytypeheight;
    
    /*
     @brief 保证金中的 继续支付 剩余金额
     */
    UIView*shengyujineview;
    UILabel*shengyulable;
    
    /*
     @brief 剩余价钱是否大于 2000   大于 1   小于 2
     */
    NSInteger  shengyupriceCountStatus;
    
    
    /*
     @brief  top 地址信息view的height
     */
    CGFloat addressViewHeight;
    
    
    
    /*
     @brief 保证金的编号
     */
    NSString *MarginNumber;
}

@property(nonatomic,strong) YXMyAccountPaymentChooseTitleView * choosetitleView;

@property(nonatomic,strong) YXMyAccountPaymenChooseFenbiOrQuaneView * choosefenbiorquaneView;

@property(nonatomic,strong) YXMyAccountPaymentChoosePayTypeView * ChoosePayTypeView;

@property(nonatomic,strong) YXMyaccountGotoPayMentTopUserInformationView * TopUserInformationView;


@property(nonatomic,strong) YXMyWaitPayMentTempraryTopView * WaitPayMentLinshiTopView;


@end

@implementation YXMyAccoutWaitPaymentBaseview
/*
 @brief 上面的地址信息 商品名，价格。。
 */
-(YXMyaccountGotoPayMentTopUserInformationView*)TopUserInformationView
{
    if (!_TopUserInformationView) {
        _TopUserInformationView = [[YXMyaccountGotoPayMentTopUserInformationView alloc]init];
    }
    return _TopUserInformationView;
}

-(YXMyAccountPaymentChooseTitleView*)choosetitleView
{
    if (!_choosetitleView) {
        _choosetitleView = [[YXMyAccountPaymentChooseTitleView alloc]init];
    }
    return _choosetitleView;
}
-(YXMyAccountPaymenChooseFenbiOrQuaneView*)choosefenbiorquaneView
{
    if (!_choosefenbiorquaneView) {
        _choosefenbiorquaneView = [[YXMyAccountPaymenChooseFenbiOrQuaneView alloc]init];
        
    }
    return _choosefenbiorquaneView;
}

-(YXMyAccountPaymentChoosePayTypeView*)ChoosePayTypeView
{
    if (!_ChoosePayTypeView) {
        _ChoosePayTypeView = [[YXMyAccountPaymentChoosePayTypeView alloc]init];
        
    }
    return _ChoosePayTypeView;
}

/*
 @brief 临时 使用 11.4
 */
-(YXMyWaitPayMentTempraryTopView*)WaitPayMentLinshiTopView
{
    if (!_WaitPayMentLinshiTopView) {
        _WaitPayMentLinshiTopView = [[YXMyWaitPayMentTempraryTopView alloc]init];
        
    }
    return _WaitPayMentLinshiTopView;
}

-(void)setIsPartPay:(NSInteger)isPartPay
{
    _isPartPay = isPartPay;
    
//    _choosetitleView.isPartPay = isPartPay;
//    _ChoosePayTypeView.isPartPay = isPartPay;
    _TopUserInformationView.isPartPay = isPartPay;
    [self layoutSubviews];
    
}


-(void)setFomreVC:(NSInteger)fomreVC
{
    _fomreVC = fomreVC;
    
    self.TopUserInformationView.fomreVC = fomreVC;
    
    [self layoutSubviews];
}

/*
 @brief把保证金 编号 传递过来
 */
//-(void)marginNmuber:(NSNotification*)noti
//{
//    MarginNumber = noti.userInfo[@"MarginNumber"];
//    dingdanNmuberLable.text = [NSString stringWithFormat:@"保证金编号：%@",MarginNumber];
//
//}

/*
 @brief 拍品 订单的赋值
 */

-(void)setDingdanDataModle:(YXMyAccoutWaitPayModle *)DingdanDataModle
{
    _DingdanDataModle = DingdanDataModle;
    
//    self.TopUserInformationView.dataDict = dict;
    
    self.TopUserInformationView.DingdanDataModle = DingdanDataModle;
    
 
        dingdanNmuberLable.text = [NSString stringWithFormat:@"订单编号：%@",DingdanDataModle.orderID];
    
    
    
//    NSString *pricestr = dict[@"alreadyPayAmount"];
//    /*
//     @brief 在保证金的情况下 就代表着总金额
//     */
//    NSString *allpricestr = dict[@"orderPayAmount"];
//    
//    NSInteger alearyprice = [pricestr integerValue];
//    NSInteger allprice = [allpricestr integerValue];
//    
//    NSInteger shengyuprice = allprice - alearyprice;
//    
//    if (self.fomreVC) {
//        if (self.isPartPay) {
//            
//            NSString * shengyu = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",shengyuprice/100]];
//            shengyulable.text = [NSString stringWithFormat:@"剩余金额：￥%@",shengyu];
//        }
//    }
//
//    
//    _ChoosePayTypeView.shengyuMoneyCount = shengyuprice;
//    
//    _choosetitleView.alearypaycount = dict[@"alreadyPayAmount"];
//    
//    if (self.isPartPay==2) {
//        
//        //    剩余价钱是否大于 2000   大于 1   小于 2
//        if (shengyuprice <= 200000) {
//            
//            shengyupriceCountStatus = 2;
//        }else
//        {
//            shengyupriceCountStatus = 1;
//        }
//    }
//    
    
    [self layoutSubviews];
    

}


/*
 @brief 保证金 的赋值
 */
-(void)setNoPayMarginPriceOrderModle:(YXMySureMoneyNopaymentModle *)NoPayMarginPriceOrderModle
{
    _NoPayMarginPriceOrderModle = NoPayMarginPriceOrderModle;
    
    self.TopUserInformationView.NoPayMarginPriceOrderModle = NoPayMarginPriceOrderModle;
    

    dingdanNmuberLable.text = [NSString stringWithFormat:@"保证金编号：%lld",NoPayMarginPriceOrderModle.NopaymentId];
 
    
    
//    NSString *pricestr = [ NSString stringWithFormat:@"%ld",(long)NoPayMarginPriceOrderModle.alreadyPayAmount];
//    /*
//     @brief 在保证金的情况下 就代表着总金额
//     */
//    NSString *allpricestr = dict[@"orderPayAmount"];
//    
//    NSInteger alearyprice = [pricestr integerValue];
//    NSInteger allprice = [allpricestr integerValue];
//    
//    NSInteger shengyuprice = allprice - alearyprice;
//    
//    if (self.fomreVC) {
//        if (self.isPartPay) {
//            
//            NSString * shengyu = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",shengyuprice/100]];
//            shengyulable.text = [NSString stringWithFormat:@"剩余金额：￥%@",shengyu];
//        }
//    }
//    
//    
//    _ChoosePayTypeView.shengyuMoneyCount = shengyuprice;
//    
//    _choosetitleView.alearypaycount = dict[@"alreadyPayAmount"];
//    
//
//    if (self.isPartPay==2) {
//        
//        //    剩余价钱是否大于 2000   大于 1   小于 2
//        if (shengyuprice <= 200000) {
//            
//            shengyupriceCountStatus = 2;
//        }else
//        {
//            shengyupriceCountStatus = 1;
//        }
//    }
    
    
    [self layoutSubviews];
    

}






//-(void)setDict:(NSDictionary *)dict
//{
//    _dict = dict;
//    if(dict.count==0)
//    {
//        return;
//    }
//    
//    self.TopUserInformationView.dataDict = dict;
//    
//    if (self.fomreVC==1) {
//        
//        dingdanNmuberLable.text = [NSString stringWithFormat:@"保证金编号：%@",dict[@"id"]];
//    }else{
//        dingdanNmuberLable.text = [NSString stringWithFormat:@"订单编号：%@",dict[@"id"]];
//    }
//    
//    
//    NSString *pricestr = dict[@"alreadyPayAmount"];
//    /*
//     @brief 在保证金的情况下 就代表着总金额
//     */
//    NSString *allpricestr = dict[@"orderPayAmount"];
//    
//    NSInteger alearyprice = [pricestr integerValue];
//    NSInteger allprice = [allpricestr integerValue];
//    
//    NSInteger shengyuprice = allprice - alearyprice;
//    
//    if (self.fomreVC) {
//        if (self.isPartPay) {
//            
//            NSString * shengyu = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",shengyuprice/100]];
//            shengyulable.text = [NSString stringWithFormat:@"剩余金额：￥%@",shengyu];
//        }
//    }
//    
//  
//    
//    
//    _ChoosePayTypeView.shengyuMoneyCount = shengyuprice;
//    
//    _choosetitleView.alearypaycount = dict[@"alreadyPayAmount"];
//    
//    if (self.isPartPay==2) {
//        
//        //    剩余价钱是否大于 2000   大于 1   小于 2
//        if (shengyuprice <= 200000) {
//            
//            shengyupriceCountStatus = 2;
//        }else
//        {
//            shengyupriceCountStatus = 1;
//        }
//    }
//    
//    
//    [self layoutSubviews];
//    
//}
//




-(void)layoutSubviews
{
    [super layoutSubviews];
    topview.frame = CGRectMake(0, 8, YXScreenW, 38);
    
    dingdanNmuberLable.frame = CGRectMake(10, 0, YXScreenW-20, 38);
    
    
    if (!addressViewHeight) {
        addressViewHeight = 200;
    }
    
    self.TopUserInformationView.frame  =CGRectMake(0, topview.bottom+8, YXScreenW, addressViewHeight);
    
    self.WaitPayMentLinshiTopView.frame= CGRectMake(5, self.TopUserInformationView.bottom+10, YXScreenW-10, 120);
    
    
    //        if (self.isPartPay == 1) {
    //
    //            self.choosetitleView.frame = CGRectMake(0, self.TopUserInformationView.bottom+10, YXScreenW, 40);
    //
    //            shengyujineview.frame = CGRectMake(0, self.choosetitleView.bottom, YXScreenW, 60);
    //            shengyulable.frame = CGRectMake(10, 15, YXScreenW-20, 30);
    //
    //            if (!choosepaytypeheight) {
    //                choosepaytypeheight = 200;
    //            }
    //            self.ChoosePayTypeView.frame = CGRectMake(5, shengyujineview.bottom+10, YXScreenW-10, choosepaytypeheight);
    //
    //            if ((self.baseviewheightblock)) {
    //
    //                self.baseviewheightblock(self.ChoosePayTypeView.bottom);
    //            }
    //
    //            if (self.fomreVC !=1) {
    //
    //                self.choosetitleView.frame = CGRectMake(0, self.TopUserInformationView.bottom+10, YXScreenW, 40);
    //                if (!choosepaytypeheight) {
    //                    choosepaytypeheight = 200;
    //                }
    //                self.ChoosePayTypeView.frame = CGRectMake(5, self.choosetitleView.bottom+10, YXScreenW-10, choosepaytypeheight);
    //
    //                if ((self.baseviewheightblock)) {
    //
    //                    self.baseviewheightblock(self.ChoosePayTypeView.bottom);
    //                }
    //            }
    //
    //
    //        }else if(self.isPartPay == 2)
    //        {
    ////          1  大于2000   2小于2000
    //            if (shengyupriceCountStatus==1) {
    //
    //                self.choosetitleView.frame = CGRectMake(0, self.TopUserInformationView.bottom+10, YXScreenW, 40);
    //
    //                self.choosefenbiorquaneView.frame = CGRectMake(5, self.choosetitleView.bottom+10, YXScreenW-10, 45);
    //                if (!choosepaytypeheight) {
    //                    choosepaytypeheight = 200;
    //                }
    //                self.ChoosePayTypeView.frame = CGRectMake(5, self.choosefenbiorquaneView.bottom+10, YXScreenW-10, choosepaytypeheight);
    //
    //                if (self.baseviewheightblock) {
    //                    self.baseviewheightblock(self.ChoosePayTypeView.bottom);
    //                }
    //
    //
    //            }else if(shengyupriceCountStatus ==2){
    //
    //                self.choosetitleView.frame = CGRectMake(0, self.TopUserInformationView.bottom+10, YXScreenW, 40);
    //
    //                self.ChoosePayTypeView.frame = CGRectMake(5, self.choosetitleView.bottom+10, YXScreenW-10, choosepaytypeheight);
    //
    //                if (self.baseviewheightblock) {
    //                    self.baseviewheightblock(self.ChoosePayTypeView.bottom);
    //                }
    //
    //            }else{
    //
    //                self.choosetitleView.frame = CGRectMake(0, self.TopUserInformationView.bottom+10, YXScreenW, 40);
    //
    //                self.choosefenbiorquaneView.frame = CGRectMake(5, self.choosetitleView.bottom+10, YXScreenW-10, 45);
    //                if (!choosepaytypeheight) {
    //                    choosepaytypeheight = 200;
    //                }
    //                self.ChoosePayTypeView.frame = CGRectMake(5, self.choosefenbiorquaneView.bottom+10, YXScreenW-10, choosepaytypeheight);
    //
    if (self.baseviewheightblock) {
        self.baseviewheightblock(self.WaitPayMentLinshiTopView.bottom+20);
    }
    
    //            }
    //
    //
    //        }
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        dingdanNmuberLable = [[UILabel alloc]init];
        dingdanNmuberLable.textColor = [UIColor mainThemColor];
        dingdanNmuberLable.font = [UIFont systemFontOfSize:13];
        [topview addSubview:dingdanNmuberLable];
        
        topview = [[UIView alloc]init];
        topview.backgroundColor = [UIColor whiteColor];
        topview.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        topview.layer.borderWidth = 1;
        
        __weak typeof(self) weakself = self;
        self.TopUserInformationView.heightBlock =^(CGFloat heigth){
            
            addressViewHeight = heigth;
            [weakself layoutSubviews];
        };
        
        [self addSubview:self.TopUserInformationView];
        self.TopUserInformationView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        self.TopUserInformationView.layer.borderWidth = 0.5;
        self.TopUserInformationView.backgroundColor = [UIColor whiteColor];
        
        
        shengyujineview = [[UIView alloc]init];
        shengyujineview.backgroundColor = [UIColor whiteColor];
        [self addSubview:shengyujineview];
        
        shengyulable = [[UILabel alloc]init];
        shengyulable.textColor = [UIColor mainThemColor];
        shengyulable.font = YXRegularfont(16);
        shengyulable.text = @"剩余金额：￥00元";
        shengyulable.textAlignment = NSTextAlignmentCenter;
        [shengyujineview addSubview:shengyulable];
        
        
        [self addSubview:topview];
        [topview addSubview:dingdanNmuberLable];
        
        
        //        [self addSubview:self.choosetitleView];
        //        [self addSubview:self.choosefenbiorquaneView];
        //        [self addSubview:self.ChoosePayTypeView];
        
        _ChoosePayTypeView.layer.masksToBounds = YES;
        _ChoosePayTypeView.layer.cornerRadius = 5;
        _ChoosePayTypeView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        _ChoosePayTypeView.layer.borderWidth = 0.5;
        
        _choosetitleView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        _choosetitleView.layer.borderWidth = 0.5;
        
        _choosefenbiorquaneView.layer.masksToBounds=YES;
        _choosefenbiorquaneView.layer.cornerRadius = 10;
        _choosefenbiorquaneView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        _choosefenbiorquaneView.layer.borderWidth = 0.5;
        
        
        
        _ChoosePayTypeView.editingblock = ^(NSInteger number ,NSInteger paycount){
            
            if (weakself.textfieldSatusblock) {
                weakself.textfieldSatusblock(number,paycount);
            }
            
        };
        
        _ChoosePayTypeView.heightblock = ^(CGFloat height){
            
            choosepaytypeheight = height;
            [weakself layoutSubviews];
        };
        
        
        [self addSubview:self.WaitPayMentLinshiTopView];
        self.WaitPayMentLinshiTopView.layer.cornerRadius = 4;
        self.WaitPayMentLinshiTopView.layer.masksToBounds = YES;
        self.WaitPayMentLinshiTopView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        self.WaitPayMentLinshiTopView.layer.borderWidth = 0.5;
        
    }
    return self;
}
@end
