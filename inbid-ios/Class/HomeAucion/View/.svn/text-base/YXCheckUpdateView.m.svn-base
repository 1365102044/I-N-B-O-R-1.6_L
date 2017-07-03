//
//  YXCheckUpdateView.m
//  inbid-ios
//
//  Created by 胤讯测试 on 17/1/3.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXCheckUpdateView.h"
#import "UILabel+Extension.h"
@interface YXCheckUpdateView ()
{
    CGRect myframe;
}
@property (weak, nonatomic) IBOutlet UIView *backbigview;

@property (weak, nonatomic) IBOutlet UILabel *topdescLable;

@property (weak, nonatomic) IBOutlet UILabel *versionNumberLable;

@property (weak, nonatomic) IBOutlet UITextView *VersionUpdateDescTextView;
@property (weak, nonatomic) IBOutlet UIButton *LaterUpdateBtn;

@end

@implementation YXCheckUpdateView

-(void)setVersionModle:(YXVersionModle *)versionModle
{
    _versionModle = versionModle;
    
    NSString *minddescstr = [NSString stringWithFormat:@"您当前的版本：%@\n最新版本：%@\n更新说明：",versionModle.CurrenVersion,versionModle.appVersion];
    NSMutableAttributedString *attristrmind = [[NSMutableAttributedString alloc]initWithString:minddescstr];
    //调整行距
    NSMutableParagraphStyle *paragraphStylemind = [[NSMutableParagraphStyle alloc] init];
    paragraphStylemind.lineSpacing = 10;
    [attristrmind addAttribute:NSParagraphStyleAttributeName value:paragraphStylemind range:NSMakeRange(0, [attristrmind length])];
    _versionNumberLable.attributedText = attristrmind;
    
    if (versionModle.forceUpdate == 2) {
        //**强制更新**/
        _LaterUpdateBtn.userInteractionEnabled = NO;
        [_LaterUpdateBtn setTitleColor:UIColorFromRGB(0xaaa7a7) forState:UIControlStateNormal];
    }
    

    NSMutableAttributedString *attrisupdatedesc = [[NSMutableAttributedString alloc]initWithString:versionModle.updateDesc];
    //调整行距
    NSMutableParagraphStyle *paragraphStyledesc = [[NSMutableParagraphStyle alloc] init];
    paragraphStyledesc.lineSpacing = 8;
    [attrisupdatedesc addAttribute:NSParagraphStyleAttributeName value:paragraphStyledesc range:NSMakeRange(0, [attrisupdatedesc length])];
    _VersionUpdateDescTextView.attributedText = attrisupdatedesc;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"YXCheckUpdateView" owner:nil options:nil].lastObject;
        
//        [self.backbigview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.mas_centerX);
//            make.centerY.equalTo(self.mas_centerY);
//            make.width.mas_offset(275);
//            make.height.mas_offset(380);
//        }];
        
        myframe = frame;
        
        self.backbigview.layer.cornerRadius = 4;
        self.backbigview.layer.masksToBounds = YES;
        
        NSString *strtop = @"为了获得更好的用户体验，我们会在App Store中定期更新应用，建议打开手机”设置“-“iTuns Store与App Store”-自动下载的项目，确保第一时间体验更好的胤宝！";
        NSMutableAttributedString *attristrtop = [[NSMutableAttributedString alloc]initWithString:strtop];
        //调整行距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;
        [attristrtop addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [strtop length])];
        _topdescLable.attributedText = attristrtop;
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    self.frame = myframe;//关键点在这里
    
}

- (IBAction)ClickLaterBtn:(id)sender {

    
    if (self.UpdateBlock) {
        self.UpdateBlock(@"Later");
    }
}

- (IBAction)ClickNowUpdateVersionBtn:(id)sender {
    
    
    if (self.UpdateBlock) {
        self.UpdateBlock(@"Now");
    }
}

@end
