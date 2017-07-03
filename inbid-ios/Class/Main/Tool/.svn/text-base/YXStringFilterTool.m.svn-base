//
//  YXStringFilterTool.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/31.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXStringFilterTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSDate+YXExtension.h"


//

/*****
 * 手机正则匹配
 */
#define PHONENO  @"\\b(1)[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b"

/*****
 * 注册密码正则匹配 字母 数字 符号 至少2种
 */
//#define PWORDS @"(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{8,20}$"

/*****
 * 昵称正则匹配  支持中文、字母、数字、'-''_'的组合，4-10个字符"
 */
#define NICKENAME  @"^[\u4e00-\u9fa5-_a-zA-Z0-9]{4,10}$"

/*
 @brief 身份证IDCARD
 */
#define CHECKIDCARD @"^(\\d{14}|\\d{17})(\\d|[xX])$"
/*
 @brief 中文
 */
#define CHINESTR  @"^[\u4E00-\u9FA5]*$"

/*
 @brief 银行卡，
 */
#define BANKCARD    @"^([0-9]{16}|[0-9]{19})$"

//** 邮箱正则 */
#define MAIL       @"/^([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+\\.[a-zA-Z]{2,3}$/"

/**
 正整数
 */
#define GOLD        @"^[1-9]\d*$"

/*设置支付密码 密码请使用字母，数字和[!#$%^&*]两种及其以上的组合，8～20位字符
*/
//#define PAYMENTPASSWORED    @"(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{8,20}$"
//
#define PAYMENTPASSWORED    @"^[^\u4E00-\u9FA5\s]{8,20}$"

//^[^\u4E00-\u9FA5\s]{8,20}$
//^(?![\d]+$)(?![a-zA-Z]+$)(?![!#$%^&*]+$)[\da-zA-Z!#$%^&*]{6,20}$

/**
 重置或忘记密码验证正则
 */
#define RESETPWD        @"^(?![\\d]+$)(?![a-zA-Z]+$)(?![!#$%^&*]+$)[\\da-zA-Z!#$%^&*]{8,20}$"

@implementation YXStringFilterTool


/*
 @brief 设置支付密码
 */
+(BOOL)CheckPaymentPassword:(NSString *)paypassword
{
    if (paypassword.length == 0) {
        return NO;
    }
    NSPredicate * telePhoneNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",RESETPWD];
    BOOL isTelephoneNumber = [telePhoneNumberPred evaluateWithObject:paypassword];
    return isTelephoneNumber;
}

/**
 重置密码验证&修改登录密码
 
 @param newPwd          newPwd
 @return                是否符合密码规则
 */
+ (BOOL)checkResetPwd:(NSString *)newPwd
{
    if(newPwd.length<=0){
        return NO;
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", RESETPWD];
    BOOL isPwd = [pred evaluateWithObject:newPwd];
    return isPwd;
}

/*
 @brief 银行卡
 */
+(BOOL)CheckBankCard:(NSString *)cardID
{
    if(cardID.length<=0)
    {
        return NO;
    }
    NSPredicate * telePhoneNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BANKCARD];
    BOOL isTelephoneNumber = [telePhoneNumberPred evaluateWithObject:cardID];
    return isTelephoneNumber;
}

+(BOOL)IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length<=0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

+(BOOL)filterCheckChines:(NSString *)namestr
{
    if(namestr.length<=0)
    {
        return NO;
    }
        
    NSPredicate * telePhoneNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CHINESTR];
    BOOL isTelephoneNumber = [telePhoneNumberPred evaluateWithObject:namestr];
    return isTelephoneNumber;
}


/*
 @brief 身份证验证
 */
+(BOOL)filterCheckIDCard:(NSString *)IDCard
{
    if(IDCard.length<=0)
    {
        return NO;
    }
    NSPredicate * telePhoneNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CHECKIDCARD];
    BOOL isTelephoneNumber = [telePhoneNumberPred evaluateWithObject:IDCard];
    return isTelephoneNumber;
}


+(BOOL)filterByPhoneNumber:(NSString *)phone
{
    if(phone.length<=0)
    {
        return NO;
    }
    NSPredicate * telePhoneNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHONENO];
    BOOL isTelephoneNumber = [telePhoneNumberPred evaluateWithObject:phone];
    return isTelephoneNumber;
}


//** 验证邮箱号 */
+ (BOOL)filterByMailNumber:(NSString *)mailNumber
{
    if(mailNumber.length<=0)
    {
        return NO;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:mailNumber];
}


/*
 @brief 注册密码
 */
+(BOOL)filterByResginPwordsNumber:(NSString *)pwords
{
    if(pwords.length<=0)
    {
        return NO;
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PAYMENTPASSWORED];
    BOOL isMatch = [pred evaluateWithObject:pwords];
    return isMatch;
    
}

/*
 @brief 注册昵称
 */
+ (BOOL)filterByReginsterNickName:(NSString *)nickname
{
    if(nickname.length<=0)
    {
        return NO;
    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NICKENAME];
    BOOL isMatch = [pred evaluateWithObject:nickname];
    return isMatch;
    
}


//sha1加密方式
+ (NSString *)getSha1String:(NSString *)srcString{
    
    if (srcString.length == 0) {
        return @"";
    }
    
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

+(BOOL)checkInput:(NSString *)textString andsupview:(UIView *)supview
{
    
    BOOL accountNumGood = [YXStringFilterTool filterByPhoneNumber:textString];
    
    if (!accountNumGood) {
        
//        [[[YXAlerErrorViewTool alloc]init] showAlerErrorView:@"手机号码格式不正确" andSupview:supview];
        return NO;
    }else{
        return YES;
    }
    
}

/*
 @brief 当前毫秒值
 */
+ (NSString *)getTimeNow
{
    NSDate *datenow =[NSDate date];//现在时间,你可以输出来看下是什么格式
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
    NSString *timestr =  [NSString stringWithFormat:@"%ld",[timeSp integerValue]*1000];
    return timestr;
}

//把字符串替换成星号
+(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght
{
    NSString *newStr = originalStr;
    for (int i = 0; i < lenght; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation ++;
    }
    return newStr;
}


+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}


/*
 @brief 金额用逗号 分割
 */
+(NSString*)strmethodComma:(NSString*)string
{
    NSMutableString *pricestr = string.mutableCopy;
    NSRange range = [pricestr rangeOfString:@"."];
    NSInteger index = 0;
    if (range.length >0) {
        
        index = range.location;
    }else{
    
        index = pricestr.length;
    }
    while ((index-3) > 0) {
        index-=3;
        [pricestr insertString:@"," atIndex:index];
    }
    return pricestr;
}



/*
 @brief 计算2个时间差
 */

-(NSInteger)compareTwoTime:(long)time1 time2:(long)time2

{
    
    NSTimeInterval balance = time2 /1000- time1 /1000;
    
    NSString*timeString = [[NSString alloc]init];
    
    timeString = [NSString stringWithFormat:@"%f",balance /60];
    
    timeString = [timeString substringToIndex:timeString.length-7];
    
    NSInteger timeInt = [timeString integerValue];
    
//    NSInteger hour = timeInt /60;
//    
//    NSInteger mint = timeInt %60;
//    
//    if(hour ==0) {
//
//        timeString = [NSString stringWithFormat:@"%ld分钟",(long)mint];
//        
//    }
//    
//    else
//        
//    {
//        
//        if(mint ==0) {
//            
//            timeString = [NSString stringWithFormat:@"%ld小时",(long)hour];
//            
//        }
//        
//        else
//            
//        {
//            
//            timeString = [NSString stringWithFormat:@"%ld小时%ld分钟",(long)hour,(long)mint];
//            
//        }
//        
//    }
//    YXLog(@"------timecah ----%@--",timeString);
//    
    return timeInt;
    
}

//	createTime = 1476958289000,  转化成 时间的str
+(NSString *)transformfromenumbertoTiemstr:(long long )timenumber
{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(timenumber / 1000.0)];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateStyle:NSDateFormatterShortStyle];
//    [formatter setTimeStyle:NSDateFormatterNoStyle];
//    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSString *strtime = [formatter stringFromDate:date];
//    return strtime;
    
    return  [NSDate dateStrFromCstampTime:timenumber withDateFormat:@"YYYY-MM-dd HH:mm"];
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSString *str;
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
}

-(void)limitTextFiledEditChange:(UITextField *)textField LimitNumber:(NSInteger)Number
{
    
    // 需要限制的长度
    NSUInteger maxLength = 0;
    maxLength = Number;
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
/**
 打电话 默认是 客服电话
 */
+(void)YXCallPhoneWith:(UIView*)backview
{
    NSString *kefuphone = [YXLoadZitiData objectZiTiWithforKey:@"customerPhone"];
    //打开电话
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",kefuphone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [backview addSubview:callWebview];
}

/**
 显示金额 接受“分” 传出 “￥元”
 */
+(NSString *)formFenTransformaYuanWith:(NSString *)Fenstr
{
    NSString *yuanstr = [NSString stringWithFormat:@"￥%@",[self strmethodComma:[NSString stringWithFormat:@"%.0f",[Fenstr floatValue]/100]]];
    return yuanstr;
}
@end
