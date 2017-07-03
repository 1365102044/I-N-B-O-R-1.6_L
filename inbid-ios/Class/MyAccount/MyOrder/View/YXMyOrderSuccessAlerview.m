//
//  YXMyOrderSuccessAlerview.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyOrderSuccessAlerview.h"
#import "NSString+File.h"
@interface YXMyOrderSuccessAlerview ()
@property (weak, nonatomic) IBOutlet UIView *BigBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BigBackViewContantWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHightContanst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigviewHeightContanst;
@end


@implementation YXMyOrderSuccessAlerview

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"YXMyOrderSuccessAlerview" owner:nil options:nil].lastObject;
        
        self.backgroundColor = [UIColor clearColor];
    
        NSInteger rad = 5;
        self.BigBackView.layer.cornerRadius = rad;
        self.BigBackView.layer.masksToBounds = YES;
        

        

    }
    return self;
}

-(void)setType:(NSString *)Type
{
    _Type = Type;
    
    if ([self.Type isEqualToString:@"MyOrder"]) {
        self.AlearTextLable.text = @"提醒成功";
    }else if([self.Type isEqualToString:@"GoodsDeatilAtten"]){
        self.AlearTextLable.text = @"关注成功";
    }else if ([self.Type isEqualToString:@"GoodsDeatilAlreadyAtten"])
    {
        self.AlearTextLable.text = @"取消关注成功";
//        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"] ;


    }else if ([self.Type isEqualToString:@"attentionNOT"])
    {
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"] ;
        self.AlearTextLable.text = @"关注失败";
    }else if ([self.Type isEqualToString:@"canclesuccess"])
    {
    
    }else if ([self.Type isEqualToString:@"图片未上传完毕"])
    {
        self.AlearTextLable.text = @"图片未上传完毕";
    }else if ([self.Type isEqualToString:@"未输入描述文字"])
    {
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
        self.AlearTextLable.text = @"请详细描述下商品属性";
    }else if ([self.Type isEqualToString:@"未输入商品名"])
    {
        self.AlearTextLable.text = @"未输入商品名";
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
    }else if ([self.Type isEqualToString:@"未选择图片"])
    {
        self.AlearTextLable.text = @"请至少提供一张商品图片";
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
    }else if ([self.Type isEqualToString:@"未选择品牌"])
    {
        self.AlearTextLable.text = @"请选择品牌";
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
    }else if ([self.Type isEqualToString:@"邮寄地址为空"])
    {
        self.AlearTextLable.text = @"您当前还没有邮寄地址";
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
    }else if ([self.Type isEqualToString:@"请重新输入支付密码"])
    {
        self.AlearTextLable.text = @"您输入的支付密码有误";
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
    }else if ([self.Type isEqualToString:@"网络异常"])
    {
        self.Alearimageview.image = [UIImage imageNamed:@"ic_network_fail"];
        self.AlearTextLable.text = @"网络异常";
    }else if ([self.Type isEqualToString:@"登录状态异常"])
    {
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
        self.AlearTextLable.text = @"登录状态异常";
    }else if([self.Type isEqualToString:@"扫码支付成功"])
    {
        self.AlearTextLable.text = @"支付失败";
    }else if([self.Type isEqualToString:@"扫码支付失败"])
    {
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
        self.AlearTextLable.text = @"支付失败";
    }else if ([self.Type isEqualToString:@"注册成功"]){

        self.AlearTextLable.text = @"注册成功";
    }else if ([self.Type isEqualToString:@"头像更换成功"])
    {
      self.AlearTextLable.text = @"修改成功";
        
    }else if([self.Type isEqualToString:@"头像更换失败"]){
         self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
        self.AlearTextLable.text = @"修改失败";
    }else if ([self.Type isEqualToString:@"身份证格式不对"])
    {
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
        self.AlearTextLable.text = @"身份证格式不对";
    
    }else if ([self.Type isEqualToString:@"一口价不能为空"])
    {
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
        self.AlearTextLable.text = @"请输入商品价格";
        
    }else if ([self.Type isEqualToString:@"寄卖周期不能为空"])
    {
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
        self.AlearTextLable.text = @"请选择寄卖周期";
        
    }else if ([self.Type isEqualToString:@"未同意协议"])
    {
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
        self.AlearTextLable.text = @"发布商品需遵守售卖协议";
        
    }else if ([self.Type isEqualToString:@"请输入正确的一口价"])
    {
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"];
        self.AlearTextLable.text = @"请输入正确的一口价";
        
    }
}

-(void)setLonginVCStr:(NSString *)longinVCStr
{
    _longinVCStr = longinVCStr;
    
    if([longinVCStr isKindOfClass:[NSDictionary class]])
    {
                
        longinVCStr =  [[[YXStringFilterTool alloc]init] dictionaryToJson:(NSDictionary*)longinVCStr];
        
    }else{
    
        self.AlearTextLable.font = YXRegularfont(13);
        CGFloat textW = [longinVCStr widthWithFont:YXRegularfont(13)];
        if (textW > (YXScreenW*0.6-20)) {
            
            self.descHightContanst.constant = 40;
            self.bigviewHeightContanst.constant = 120;
        }
    }
    
    
    self.Alearimageview.image = [UIImage imageNamed:@"取消图标"] ;
    self.AlearTextLable.text = longinVCStr;
    self.BigBackViewContantWidth.constant = YXScreenW*0.6;
    
}

-(void)setFeedbookstr:(NSString *)feedbookstr
{
    _feedbookstr = feedbookstr;
    if([feedbookstr isEqualToString:@"提交成功"]){
    
    }else if ([feedbookstr isEqualToString:@""]){
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"] ;
    }

    self.AlearTextLable.text = feedbookstr;
}

/**
 1 成功，2 警示 3继续支付图标 4售罄图标
 */
-(void)ShowAlearViewWith:(NSString *)AlearStr type:(NSInteger)type
{
    /**
     防止 在展示objc时 后台返回字典对象
     */
    if([AlearStr isKindOfClass:[NSDictionary class]])
    {
        
        AlearStr =  [[[YXStringFilterTool alloc]init] dictionaryToJson:(NSDictionary*)AlearStr];
        
    }else{
        
        self.AlearTextLable.font = YXRegularfont(13);
        CGFloat textW = [AlearStr widthWithFont:YXRegularfont(13)];
        if (textW > (YXScreenW*0.6-20)) {
            
            self.descHightContanst.constant = 40;
            self.bigviewHeightContanst.constant = 120;
        }
    }
    
    self.BigBackViewContantWidth.constant = YXScreenW*0.6;
    
    if (type == 1) {
        
    }else if (type == 2)
    {
        self.Alearimageview.image = [UIImage imageNamed:@"取消图标"] ;

    }else if (type == 3) //继续支付
    {
        self.Alearimageview.image = [UIImage imageNamed:@"icon_onepricedeatiljixupay"];
    }else if (type == 4) //售罄
    {
        self.Alearimageview.image = [UIImage imageNamed:@"已售罄"];
    }
    
     self.AlearTextLable.text = AlearStr;
}

@end
