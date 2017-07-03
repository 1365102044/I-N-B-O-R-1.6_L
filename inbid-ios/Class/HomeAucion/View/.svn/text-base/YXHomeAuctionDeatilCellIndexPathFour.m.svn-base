//
//  YXHomeAuctionDeatilCellIndexPathFour.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/8/30.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXHomeAuctionDeatilCellIndexPathFour.h"

@interface YXHomeAuctionDeatilCellIndexPathFour ()<UIWebViewDelegate>

{
     UIButton *btn;
    UILabel *contentLable;
    UITextView*deatilContentLable;
    UILabel *leftLable;
    UIView*viewline;
    
    UIWebView*Mywebview;
}
@end

@implementation YXHomeAuctionDeatilCellIndexPathFour

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor whiteColor];
        
        btn = [[UIButton alloc]init];
        [btn setTitle:@"商品描述" forState:UIControlStateNormal];
        [btn setTitleColor:YXHomeDeatilcolor forState:UIControlStateNormal];
        btn.titleLabel.font = YXRegularfont(13);
        [btn setImage:[UIImage imageNamed:@"icon_miaoshu"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -48, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 0);
        [self addSubview:btn];

        viewline =[[ UIView alloc]init];
        viewline.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:viewline];

        leftLable = [[UILabel alloc]init];
        leftLable.text = @"·";
        [self addSubview:leftLable];
        

        
        deatilContentLable = [[UITextView alloc]init];
        [self addSubview:deatilContentLable];
        deatilContentLable.editable = NO;
    
        
    }
    return self;
}

-(void)setModle:(YXHomeDeatilModle *)modle
{
    _modle = modle;

    
    if (modle.prodDetailContent) {
//    NSString *htmlstr = [modle.debugDescription stringByReplacingOccurrencesOfString:<#(nonnull NSString *)#> withString:<#(nonnull NSString *)#>]
        
        @try {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithData:[[NSString stringWithFormat:@"%@",modle.prodDetailContent]  dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:5.0];
            [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [attrStr length])];
            [attrStr addAttribute:NSForegroundColorAttributeName value:YXHomeDeatilcolor range:NSMakeRange(0, attrStr.length)];
            [attrStr addAttribute:NSFontAttributeName value:YXRegularfont(13) range:NSMakeRange(0, attrStr.length)];
            deatilContentLable.attributedText = attrStr;
            [deatilContentLable sizeToFit ];
        } @catch (NSException *exception) {
            YXLog(@"%@", exception);
        } @finally {
        }
        
    }else{
        
        deatilContentLable.hidden = YES;
    }
    
   
}


-(void)layoutSubviews
{
    [super layoutSubviews];

    
    btn.frame = CGRectMake(10, 5, 120, 30);
    
    viewline.frame = CGRectMake(0, btn.bottom+5, YXScreenW, 1);
    
    
    YXLog(@"======++++%f",deatilContentLable.contentSize.height);
    
    deatilContentLable.frame = CGRectMake(15, viewline.bottom+3, YXScreenW-25, deatilContentLable.contentSize.height);

   
    
    if (self.heightblock) {

        self.heightblock(deatilContentLable.bottom+10);
    }
}

-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];

    paraStyle.lineSpacing = 5;

    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}



@end
