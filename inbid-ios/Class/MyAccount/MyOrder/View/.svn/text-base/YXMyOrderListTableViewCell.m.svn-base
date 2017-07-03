
//
//  YXMyOrderListTableViewCell.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/12/15.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyOrderListTableViewCell.h"
#import "UILabel+Extension.h"
#import "YXOrderDetailBaseDataModel.h"
#import "NSDate+YXExtension.h"


@interface YXMyOrderListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *dingdanNumberLable;
@property (weak, nonatomic) IBOutlet UILabel *dingdanStatusLable;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@property (weak, nonatomic) IBOutlet UILabel *creatTimeLable;
@property (weak, nonatomic) IBOutlet UIButton *boomRightBtn;

@property (weak, nonatomic) IBOutlet UIButton *boomLeftBtn;

@property (weak, nonatomic) IBOutlet UIView *goodsbackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodNameHeightContent;

@property(nonatomic,strong) YXOrderDetailBaseDataModel *basemodle ;
@property (weak, nonatomic) IBOutlet UILabel *OrderCutTimeLable;
//暂时没用
@property (weak, nonatomic) IBOutlet UILabel *descLable;

@end

@implementation YXMyOrderListTableViewCell


- (IBAction)ClickRightBtn:(UIButton *)sender {
    if (self.clickCellBtnBlock) {
        self.clickCellBtnBlock(self.myordermodle,sender.titleLabel.text);
    }
}

- (IBAction)ClickLeftBtn:(UIButton *)sender {
    if (self.clickCellBtnBlock) {
        self.clickCellBtnBlock(self.myordermodle,sender.titleLabel.text);
    }
}

-(void)setMyordermodle:(YXOrderDetailBaseDataModel *)myordermodle
{
    _myordermodle = myordermodle;

    [self setUI];
    
    if (myordermodle.dataModel.CurrentVcType == MyCheckOutType) {
        //  鉴定的
        [self myCheckOutBtnStatus:myordermodle];
        self.priceLable.hidden = YES;
    }else if (myordermodle.dataModel.CurrentVcType == MySellOutType){
        //        我卖出的
        self.dingdanStatusLable.text = myordermodle.dataModel.orderShowStatusStr;
        self.boomLeftBtn.hidden = YES;
        self.boomRightBtn.hidden = YES;

    }else if (myordermodle.dataModel.CurrentVcType == MyReturnType){
        //退回
        [self myReturnGoodsBtnStatus:myordermodle];
        self.priceLable.hidden = YES;
        self.boomLeftBtn.hidden = YES;
//        self.boomRightBtn.hidden = YES;
    }else if (myordermodle.dataModel.CurrentVcType == MyReleaseSellType){
        //发布 ->出售中／已下架
        [self MyResalseSellGoodsBtnStatus:myordermodle];
        self.priceLable.hidden = YES;
    }else if (myordermodle.dataModel.CurrentVcType == MyReleaseType){
        [self myRealseGoodsBtnStatus:myordermodle];
        self.priceLable.hidden = YES;
    }else if(myordermodle.dataModel.CurrentVcType == MyBuyOrderType){
        [self setBtnStatus:myordermodle];
    }else if (myordermodle.dataModel.CurrentVcType==MyPlaformReturnType){
        [self myPloformReturnGoodsBtnStatus:myordermodle];
    }
    
    self.dingdanNumberLable.text = [NSString stringWithFormat:@"订单编号：%@",myordermodle.dataModel.orderNumber];

    self.goodsNameLable.text = [NSString stringWithFormat:@"%@",myordermodle.dataModel.prodName];
    CGFloat nameH =  [self.goodsNameLable heightWithWidth:(YXScreenW- 30-self.goodsImageView.width)];
    if (nameH<=20) {
        nameH = 20;
    }else if (nameH>50)
    {
        nameH = 50;
    }
    
    self.goodNameHeightContent.constant = nameH;
    
    NSInteger price = myordermodle.dataModel.orderTotalAmount;
    if (myordermodle.dataModel.CurrentVcType == MyPlaformReturnType) {
        price = myordermodle.dataModel.recycleMoney/100;
    }
    NSString *pricestr = [NSString stringWithFormat:@"成交价格：￥%@",[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%ld",(long)price]]];
    NSMutableAttributedString *attrstr = [[NSMutableAttributedString alloc]initWithString:pricestr];
    [attrstr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xae0404) range:NSMakeRange(5, attrstr.length-5)];
    self.priceLable.attributedText = attrstr;
    
    
    self.creatTimeLable.text = [NSString stringWithFormat:@"创建时间：%@",[NSDate dateStrFromCstampTime:[myordermodle.dataModel.createTime longLongValue] withDateFormat:@"YYYY-MM-dd HH:mm"]];
    if(myordermodle.dataModel.CurrentVcType == MyReleaseSellType){
        self.creatTimeLable.text = [NSString stringWithFormat:@"结束时间：%@",myordermodle.dataModel.endTime];
    }
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:myordermodle.dataModel.imgUrl] placeholderImage:[UIImage imageNamed:@"newsGoodslogo"]];
    
}


/**
 平台回收
 */
-(void)myPloformReturnGoodsBtnStatus:(YXOrderDetailBaseDataModel *)modle{
    NSString *statusStr;
    if (modle.dataModel.manageStatus==3) {
        statusStr = @"回收价卖给平台";
    }else if (modle.dataModel.manageStatus==4){
        statusStr = @"平台已打款";
    }
    self.dingdanStatusLable.text = statusStr;
    [self.boomRightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    self.boomLeftBtn.hidden = YES;

}


/**
    我买到的 按钮的状态
 */
-(void)setBtnStatus:(YXOrderDetailBaseDataModel *)modle
{
    NSString *statuslableStr ;
    NSString *leftBtnStr;
    NSString *rightBtnStr;
    leftBtnStr =@"查看详情";
    if (modle.status == YXOrderStatusPendingPayment) {
        statuslableStr = @"待付款";
        rightBtnStr = @"去支付";
     
    }else if (modle.status == YXOrderStatusPendingPayment_lineTransfer)
    {
        statuslableStr = @"待付款";
        rightBtnStr = @"上传凭证";
    }
    else if (modle.status == YXOrderStatusPendingDelivery||modle.status ==YXOrderStatusPendingDelivery_notPayBond )
    {
        if (modle.dataModel.deliveryType == 0) {
            statuslableStr = @"已付款，待平台发货";
            rightBtnStr = @"查看详情";
        }
        
        if (modle.dataModel.deliveryType == 1) {
            statuslableStr = @"已付款，待平台配货";
            rightBtnStr = @"查看详情";
        }
        
    }else if (modle.status == YXOrderStatusPendingDelivery_alreadyPayBond){
        if (modle.dataModel.deliveryType == 0) {
            statuslableStr = @"已付定金，待平台发货";
            rightBtnStr = @"查看详情";
        }
        
        if (modle.dataModel.deliveryType == 1) {
            statuslableStr = @"已付定金，待平台配货";
            rightBtnStr = @"查看详情";
        }

    }
    else if (modle.status == YXOrderStatusPartPayment|| modle.status == YXOrderStatusPartPayment_alreadyPayBond || modle.status == YXOrderStatusPartPayment_notPayBond)
    {
        statuslableStr = @"待支付余额";
        leftBtnStr =@"查看详情";
        rightBtnStr = @"继续支付";
        
    }else if (modle.status == YXOrderStatusPendingRecive)
    {
        if(modle.dataModel.deliveryType ==0)
        {
            statuslableStr = @"已发货，待买家收货";
        }else if (modle.dataModel.deliveryType == 1)
        {
            statuslableStr = @"已配货，待买家自提";
        }
        rightBtnStr = @"查看详情";
        
    }else if ( modle.status == YXOrderStatusCheckTransfer || modle.status == YXOrderStatusCheckTransferFaild)
    {
        statuslableStr = @"待付款";
        rightBtnStr = @"编辑凭证";
        
    }else if (modle.status == YXOrderStatusSuccess)
    {
        statuslableStr = @"交易已完成";
        rightBtnStr = @"查看详情";
        
    }else if (modle.status == YXOrderStatusCancelNeedRefund_partPayment
              ||modle.status == YXOrderStatusCancelNeedRefund_bondAndPartPayment)
    {
        if (modle.dataModel.isUserCancel == 0) {
            statuslableStr = @"超时已取消";
        }else if (modle.dataModel.isUserCancel == 1)
        {
            statuslableStr = @"已取消";
        }
     
            rightBtnStr = @"申请退款";
        
        
        
    }else if (modle.status == YXOrderStatusCancelNotNeedRefund_payedDeposit
              || modle.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund
              || modle.status == YXOrderStatusCancelNotNeedRefund_alreadyRefund_payedDeposit)
    {
        if (modle.dataModel.isUserCancel == 0) {
            statuslableStr = @"超时已取消";
        }else if (modle.dataModel.isUserCancel == 1)
        {
            statuslableStr = @"已取消";
        }
        rightBtnStr = @"查看详情";
    }
    
    else if (modle.status == YXOrderStatusCancelNotNeedRefund_userCancel)
    {
        statuslableStr = @"已取消";
        rightBtnStr = @"查看详情";
        
    }else if (modle.status == YXOrderStatusCancelNotNeedRefund_timeOut)
    {
        statuslableStr = @"超时已取消";
        rightBtnStr = @"查看详情";
    }
    else if (modle.status == YXOrderStatusPendingSure)
    {
        if(modle.dataModel.deliveryType ==0)
        {
            statuslableStr = @"已签收，待确认收货";
        }else if (modle.dataModel.deliveryType == 1)
        {
            statuslableStr = @"已提货，待确认收货";
        }
        rightBtnStr = @"查看详情";
    }
    
    
    if ([rightBtnStr isEqualToString:@"查看详情"]) {
        self.boomLeftBtn.hidden = YES;
    }else{
        self.boomLeftBtn.hidden = NO;
    }
    self.OrderCutTimeLable.hidden = YES;
    self.dingdanStatusLable.text = statuslableStr;
    [self.boomLeftBtn setTitle:leftBtnStr forState:UIControlStateNormal];
    [self.boomRightBtn setTitle:rightBtnStr forState:UIControlStateNormal];
}

/**
 鉴定的全部状态
 */
-(void)myCheckOutBtnStatus:(YXOrderDetailBaseDataModel *)modle{
    NSString*statusStr;
    NSString *rightbtnStr;
    
//    if (modle.dataModel.orderStatus == 1) {
//        statusStr = @"等待审核";
//        
//    }else if (modle.dataModel.orderStatus == 2){
//        statusStr = @"审核不通过";
//        rightbtnStr = @"重新提交";
//    }else
    
    if (modle.dataModel.orderStatus == 3){
        if ([[NSString stringWithFormat:@"%@",[YXUserDefaults objectForKey:@"cardStatus"]] isEqualToString:@"1"]) {
            rightbtnStr = @"立即鉴定";
        }else{
            //立即验证
            rightbtnStr = @"立即验证";
        }
        statusStr = @"审核通过";
    }else if (modle.dataModel.orderStatus == 4){
        
        /**
         *  数据异常
         */
        statusStr = @"数据异常"; //不允许分笔支付
        
    }else if (modle.dataModel.orderStatus == 5){
        //立即邮寄
        rightbtnStr  = @"立即邮寄";
        statusStr  = @"待邮寄";
    }else if (modle.dataModel.orderStatus == 6){
        if (modle.dataModel.deliveryType == 1) {
            //--已邮寄
            statusStr = @"待送往胤宝平台";
        }else if (modle.dataModel.deliveryType == 0){

            statusStr = @"已邮寄";
        }
        
        
    }else if (modle.dataModel.orderStatus == 7){
        /**
         * 鉴定状态
         * 0待鉴定 1为鉴定中，2为鉴定成功；3为鉴定失败
         */
        if (modle.dataModel.identifyStatus == 0) {
            //添加鉴定中按钮
            statusStr = @"待鉴定";
    
        }else if (modle.dataModel.identifyStatus == 1) {
            //添加鉴定中按钮
            statusStr = @"鉴定中";
      
        }else if (modle.dataModel.identifyStatus == 2) {
                
            if (modle.dataModel.refundStatus ==2) {
                
                statusStr = @"已申请退回";
                rightbtnStr = @"鉴定报告";
            }else if (modle.dataModel.refundStatus ==3){
                statusStr = @"退回中";
                rightbtnStr = @"鉴定报告";
            }else if (modle.dataModel.refundStatus ==4){
                statusStr = @"已退回";
                rightbtnStr = @"鉴定报告";
            }else if (modle.dataModel.refundStatus == 1){
                
                if (modle.dataModel.manageStatus == 5) {
                    if (modle.dataModel.refundStatus ==1) {
                        statusStr = @"已寄卖";
                        rightbtnStr = @"鉴定报告";
                    }
                }else if (modle.dataModel.manageStatus == 1) {
                    if (modle.dataModel.refundStatus ==1) {
                        statusStr = @"不同意交易";
                        rightbtnStr = @"鉴定报告";
                    }
                }else if (modle.dataModel.manageStatus == 2) {
                    if (modle.dataModel.refundStatus ==1) {
                        statusStr = @"平台寄拍";
                        rightbtnStr = @"鉴定报告";
                    }
                }else if (modle.dataModel.manageStatus == 3) {
                    if (modle.dataModel.refundStatus ==1) {
                        statusStr = @"回收价卖给平台";
                        rightbtnStr = @"鉴定报告";
                    }
                }else if (modle.dataModel.manageStatus == 4) {
                    if (modle.dataModel.refundStatus ==1) {
                        statusStr = @" ";
                        rightbtnStr = @"鉴定报告";
                    }
                }else{
                    statusStr = @"鉴定成功";
                    rightbtnStr = @"鉴定结果";
                }
            }else{
                statusStr  =@"鉴定成功";
                rightbtnStr = @"鉴定结果";
                
            }
            
        }else if (modle.dataModel.identifyStatus == 3) {
            
            if(modle.dataModel.refundStatus == 2){
                statusStr = @"已申请退回";
            }else if (modle.dataModel.refundStatus == 3){
                statusStr = @"退回中";
            }else if (modle.dataModel.refundStatus ==4){
                statusStr = @"已退回";
            }else{
                statusStr = @"鉴定失败";
            }
            rightbtnStr = @"鉴定报告";
        }
 
    }else if (modle.dataModel.orderStatus == 8){
        
        statusStr = @"鉴定已取消";

    }
    
    /**
    ,鉴定结果, 我要退回
     */
    self.dingdanStatusLable.text = statusStr;
    if (rightbtnStr.length !=0 ) {
        [self.boomRightBtn setTitle:rightbtnStr forState:UIControlStateNormal];
        [self.boomLeftBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.boomLeftBtn.hidden= NO;
        
    }else{
        self.boomLeftBtn.hidden= YES;
        [self.boomRightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    }
}


/**
 我的出售的 (吴帅---2017/3/3)
 */
-(void)mySellOutGoodsBtnStatus:(YXOrderDetailBaseDataModel *)modle{
    
    NSString *rightBtnStr;
    NSString *statusStr;
    if (modle.dataModel.bidStatus == 1) {
        statusStr = @"平台下架";
    }else if (modle.dataModel.bidStatus == 2) {
        statusStr = @"出售中";
    }else if (modle.dataModel.bidStatus == 3||modle.dataModel.bidStatus==4) {
        statusStr = @"已售罄";
    }else if (modle.dataModel.bidStatus == 5) {
        statusStr = @"逾期下架";
        rightBtnStr = @"逾期处理";
    }
    self.dingdanStatusLable.text = statusStr;
    if (rightBtnStr.length) {
        self.boomLeftBtn.hidden = NO;
        [self.boomRightBtn setTitle:rightBtnStr forState:UIControlStateNormal];
        [self.boomLeftBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.boomRightBtn.userInteractionEnabled = YES;
    }else{
        [self.boomRightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.boomLeftBtn.hidden = YES;
    }
}

/**
 退回列表
 退货状态：1,未申请 2,已申请,3,退回中,4,已退回
 */
-(void)myReturnGoodsBtnStatus:(YXOrderDetailBaseDataModel *)model{

    NSString *statusStr;
    NSString *rightBtnStr;
    if (model.dataModel.refundStatus ==1) {
        statusStr = @"未申请";
    }else if (model.dataModel.refundStatus ==2){
        statusStr = @"已申请";
    }else if (model.dataModel.refundStatus ==3){
        statusStr = @"退回中";
    }else if (model.dataModel.refundStatus ==4){
        statusStr = @"已退回";
    }
//    if(model.dataModel.deliveryType==1&&(model.dataModel.deliveryStatus==3||model.dataModel.deliveryStatus ==4)){
//        rightBtnStr = @"查看物流";
//    }
    self.dingdanStatusLable.text = statusStr;
    if (rightBtnStr.length) {
        [self.boomRightBtn setTitle:rightBtnStr forState:UIControlStateNormal];
        [self.boomLeftBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    }else{
        [self.boomRightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.boomLeftBtn.hidden = YES;
    }


}

/**
 我发布的 ->待上架
 */
-(void)myRealseGoodsBtnStatus:(YXOrderDetailBaseDataModel *)modle
{
    NSString*statusStr;
    NSString *rightbtnStr;
    
    if (modle.dataModel.orderStatus == 1) {
        statusStr = @"刚提交";
    }else if (modle.dataModel.orderStatus == 2){
        statusStr = @"审核不通过";
        rightbtnStr = @"重新提交";
    }else if (modle.dataModel.orderStatus == 3){
    
        rightbtnStr = @"查看鉴定";
        statusStr = @"审核通过";

    }else if (modle.dataModel.orderStatus == 4){
        
        /**
         *  数据异常
         */
        statusStr = @"数据异常"; //不允许分笔支付
        
    }else if (modle.dataModel.orderStatus == 5){
        
        rightbtnStr  = @"查看鉴定";
        statusStr  = @"鉴定中";

    }else if (modle.dataModel.orderStatus == 6){
        
        statusStr = @"鉴定中";
        rightbtnStr  = @"查看鉴定";

    }else if (modle.dataModel.orderStatus == 7){
        
        /**
         * 鉴定状态
         * 0待鉴定 1为鉴定中，2为鉴定成功；3为鉴定失败
         */
        if (modle.dataModel.identifyStatus == 0) {

            statusStr = @"待鉴定";
            rightbtnStr  = @"查看鉴定";

        }else if (modle.dataModel.identifyStatus == 1) {
            
            statusStr = @"鉴定中";
            rightbtnStr  =@"查看鉴定";

        }else if (modle.dataModel.identifyStatus == 2) {
            
            statusStr = @"鉴定成功";
            rightbtnStr  =@"查看鉴定";
            if (modle.dataModel.manageStatus == 2||modle.dataModel.manageStatus == 3) {
                statusStr = @"待上架";
                rightbtnStr  = nil;
            }
            
        }else if (modle.dataModel.identifyStatus == 3) {
            statusStr = @"鉴定失败";
            rightbtnStr  =@"查看鉴定";
        }
        
    }else if (modle.dataModel.orderStatus == 8){
        
        statusStr = @"交易已取消";
        rightbtnStr  =@"查看鉴定";
    }
    
    /**
     ,鉴定结果, 我要退回
     */
    self.dingdanStatusLable.text = statusStr;
    if (rightbtnStr.length !=0) {
        [self.boomRightBtn setTitle:rightbtnStr forState:UIControlStateNormal];
        [self.boomLeftBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.boomLeftBtn.hidden= NO;
        
    }else{
        self.boomLeftBtn.hidden= YES;
        [self.boomRightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.boomRightBtn.userInteractionEnabled = YES;
    }
}

/*
 @brief 发布中的 出售中（只有查看详情）／已下架（查看详情，预期处理）
 */
-(void)MyResalseSellGoodsBtnStatus:(YXOrderDetailBaseDataModel *)modle{

    NSString *rightBtnStr;
    NSString *statusStr;
    if (modle.dataModel.bidStatus == 1) {
        statusStr = @"待出售";
    }else if (modle.dataModel.bidStatus == 2) {
        statusStr = @"出售中";
    }else if (modle.dataModel.bidStatus == 3||modle.dataModel.bidStatus ==4) {
        
        statusStr = @"已售罄";
    }else if (modle.dataModel.bidStatus == 5) {
        if (modle.dataModel.auctionStatus == 4) {
            
            statusStr = @"已申请退回";
        }else{
            
            rightBtnStr = @"逾期处理";
            statusStr = @"逾期处理";
        }
    }
    
    self.dingdanStatusLable.text = statusStr;
    if (rightBtnStr.length) {
        self.boomLeftBtn.hidden = NO;
        [self.boomRightBtn setTitle:rightBtnStr forState:UIControlStateNormal];
        [self.boomLeftBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.boomRightBtn.userInteractionEnabled = YES;
    }else{
        
        [self.boomRightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        self.boomLeftBtn.hidden = YES;
    }

}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}
-(void)setUI
{
    self.goodsbackView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
    self.goodsbackView.layer.borderWidth = 0.5;
    
    self.boomLeftBtn.layer.borderColor = [UIColor mainThemColor].CGColor;
    self.boomLeftBtn.layer.borderWidth = 1;
    self.boomLeftBtn.layer.masksToBounds = YES;
    self.boomLeftBtn.layer.cornerRadius = 2;
    self.boomRightBtn.layer.borderColor =  [UIColor mainThemColor].CGColor;
    self.boomRightBtn.layer.borderWidth = 1;
    self.boomRightBtn.layer.masksToBounds = YES;
    self.boomRightBtn.layer.cornerRadius = 2;
    self.boomRightBtn.backgroundColor = [UIColor mainThemColor];
    [self.boomRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}


@end
