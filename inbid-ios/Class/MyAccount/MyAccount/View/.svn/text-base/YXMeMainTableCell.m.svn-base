//
//  YXMeMainTableCell.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/14.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMeMainTableCell.h"

@interface YXMeMainTableCell ()
{
    UIImageView *rightimageview;
    UILabel *titlelable;
    UILabel *desclable;
}
@end

@implementation YXMeMainTableCell

/**
 赋值
 */
-(void)SetBaseMyAccountInforModle:(YXMyAccountBaseData *)Model indexPath:(NSIndexPath *)indexPath titleArr:(NSArray *)titleArr{
    desclable.hidden = NO;
    desclable.textColor = UIColorFromRGB(0xcccccc);
    if(indexPath.section>1){
        titlelable.text = titleArr[indexPath.section-2][indexPath.row];
    }
    if (Model==nil) return;
    if (indexPath.section ==1) {
        if (Model.isShowMoney!=1) {
            return;
        }
        titlelable.text = @"我的钱包";
        if(Model.openingStatus){
            desclable.textColor = UIColorFromRGB(0xcccccc);
            desclable.text = [NSString stringWithFormat:@"¥%@",[YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%.2f",[Model.balanceMoney floatValue]]]];
        }else{
            desclable.textColor = UIColorFromRGB(0xff3a2f);
            desclable.text = @"申请开通钱包";
        }
    }else if (indexPath.section ==2){
        NSMutableArray *numberArr = [NSMutableArray array];
        [numberArr addObject:[NSString stringWithFormat:@"%ld",(long)Model.publishCount]];
        [numberArr addObject:[NSString stringWithFormat:@"%ld",(long)Model.identifyCount]];
        [numberArr addObject:[NSString stringWithFormat:@"%ld",(long)Model.sellCount]];
        [numberArr addObject:[NSString stringWithFormat:@"%ld",(long)Model.recycleCount]];
        [numberArr addObject:[NSString stringWithFormat:@"%ld",(long)Model.refundCount]];
//        if (![numberArr[indexPath.row] isEqualToString:@"0"]) {
            desclable.text = numberArr[indexPath.row];
//        }
    }else if (indexPath.section==3){
        desclable.textColor = UIColorFromRGB(0xff3a2f);
        if (indexPath.row==1) {
         
            if (Model.qqCount==0&&Model.wechatCount==0) {
                desclable.text = @"立即绑定";
            }
        }else if (indexPath.row==2){
            /**
             * 实名认证状态：0=未认证，1=认证中，2=认证成功，3=认证失败
             */
            if (Model.validateStatus !=2) {
                desclable.text = @"立即认证";
            }
        }else if (indexPath.row==3){
            if (!Model.consigneeCount) {
                desclable.text = @"添加地址";
            }
        }else if (indexPath.row ==4){
            if (!Model.pickupCount) {
                desclable.text = @"添加提货人";
            }
        }
    }else if (indexPath.section==4){
        desclable.hidden= YES;
    }
    
}

-(void)setCellname:(NSString *)cellname
{
    titlelable.text = cellname;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        rightimageview = [[UIImageView alloc]initWithFrame:CGRectMake(YXScreenW-17, (50-12.5)/2, 7, 12.5)];
        rightimageview.image = [UIImage imageNamed:@"icon_newmyAccounjiantou"];
        [self addSubview:rightimageview];
        
        titlelable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, YXScreenW-30, 50)];
        titlelable.text = @"test";
        titlelable.textAlignment = NSTextAlignmentLeft;
        titlelable.font = YXSFont(16);
        [self addSubview:titlelable];
        
        desclable = [[UILabel alloc]initWithFrame:CGRectMake(YXScreenW-25-200, 0, 200, 50)];
        desclable.textAlignment = NSTextAlignmentRight;
        desclable.font = YXSFont(15);
        [self addSubview:desclable];
        desclable.hidden = YES;
        
    }
    return self;
}

@end
