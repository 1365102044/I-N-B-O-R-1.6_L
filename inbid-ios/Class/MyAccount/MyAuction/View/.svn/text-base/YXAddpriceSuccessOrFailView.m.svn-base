//
//  YXAddpriceSuccessOrFailView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 16/9/18.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXAddpriceSuccessOrFailView.h"

@interface YXAddpriceSuccessOrFailView ()

@property (weak, nonatomic) IBOutlet UIImageView *statusimage;

@property (weak, nonatomic) IBOutlet UILabel *statustext;


@property (weak, nonatomic) IBOutlet UILabel *statusdesctext;
@property (weak, nonatomic) IBOutlet UIView *bigbackview;

@end

@implementation YXAddpriceSuccessOrFailView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        
        
        self =  [[NSBundle mainBundle] loadNibNamed:@"YXAddpriceSuccessOrFailView" owner:nil options:nil].lastObject;

        
       
        self.bigbackview.layer.masksToBounds = YES;
        self.bigbackview.layer.cornerRadius = 4;
        
        
        if (YXScreenW <= 320) {
            [self.bigbackview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX);
                make.centerY.equalTo(self.mas_centerY);
                make.width.mas_offset(270);
                make.height.mas_offset(380);
            }];
        }
        
        if (YXScreenW >= 414) {
            [self.bigbackview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX);
                make.centerY.equalTo(self.mas_centerY);
                make.width.mas_offset(370);
                make.height.mas_offset(420);
            }];
        }

    }
    return self;
}

- (IBAction)ClickCancelBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(AddPriceStatusviewDelegate:cancelButtonClick:)]) {
        [self.delegate AddPriceStatusviewDelegate:self cancelButtonClick:sender];
    }
}

-(void)setStatus:(NSString *)status
{
    if ([status isEqualToString:@"success"]) {
        
        NSString *addpri = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%@",self.addpricestr]];
        NSString *currpri = [YXStringFilterTool strmethodComma:[NSString stringWithFormat:@"%@",self.currentpricestr]];
        self.statusdesctext.text = [NSString stringWithFormat:@"您已成功出价¥%@，最新当前价为￥%@",addpri,currpri];
        
    }else if ([status isEqualToString:@"fail"])
    {
        self.statusimage.image = [UIImage imageNamed:@"取消图标"];
        self.statustext.text = @"加价失败";
        self.statusdesctext.text = @"您未能成功加价，系统建议您再试一次";
    
    }else if ([status isEqualToString:@"notenough"])
    {
        self.statusimage.image = [UIImage imageNamed:@"取消图标"];
        self.statustext.text = @"加价失败";
        self.statusdesctext.text = @"您输入的金额不能低于最低加价金额";

    }
}

@end
