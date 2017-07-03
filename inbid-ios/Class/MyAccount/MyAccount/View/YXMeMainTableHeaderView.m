//
//  YXMeMainTableHeaderView.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/14.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMeMainTableHeaderView.h"
#import "YXMeMainTapGestureRecognizer.h"
@interface YXMeMainTableHeaderView ()
{
    UIImageView *backBigImageview;
    UIImageView *iconImageview;
    UIButton *namebtn;
    UIButton *collectGoodsBtn;
    UIButton *myRecordBtn;
    UIButton *SetBtn;
}
@end

@implementation YXMeMainTableHeaderView

-(void)setDataModle:(YXMyAccountBaseData *)dataModle{
    
    _dataModle = dataModle;
    
    [collectGoodsBtn setTitle:[NSString stringWithFormat:@"喜欢(%ld)",(long)dataModle.colletionCount] forState:UIControlStateNormal];
    [myRecordBtn setTitle:[NSString stringWithFormat:@"足迹(%ld)",dataModle.recordCount] forState:UIControlStateNormal];
    
    NSString *str  = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_100", [dataModle.head componentsSeparatedByString:@"?"].firstObject];
    [iconImageview sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"ic_default"]];
    if (dataModle.head.length==0) {
        iconImageview.image = [UIImage imageNamed:@"ic_default"];
    }
    
    [namebtn setTitle:dataModle.nickname forState:UIControlStateNormal];
    
}
-(void)setSetBtn:(UIButton *)setBtn{
    
    self.setBtn = SetBtn;
}
-(void)ClickMyRecord:(UIButton *)sender{
    if (self.headerBlock) {
        self.headerBlock(recordSLE);
    }
}
-(void)ClickCollect:(UIButton *)sender{
    if (self.headerBlock) {
        self.headerBlock(colectSLE);
    }
}
-(void)ClickSetBtn:(UIButton *)sender{
    if (self.headerBlock) {
        self.headerBlock(setSLE);
    }
}

-(void)clickselfview{
    if (self.headerBlock) {
        self.headerBlock(iconSLE);
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        backBigImageview = [[UIImageView alloc]initWithFrame:self.bounds];
        backBigImageview.image = [UIImage imageNamed:@"icon_mywalletBackImage"];
        backBigImageview.userInteractionEnabled = YES;
        [self addSubview:backBigImageview];
        
        iconImageview =[[UIImageView alloc]initWithFrame:CGRectMake(22, 70, 66, 66)];
        iconImageview.image = [UIImage imageNamed:@"ic_default"];
        iconImageview.userInteractionEnabled = YES;
        iconImageview.layer.masksToBounds = YES;
        iconImageview.layer.cornerRadius = 33;
        [backBigImageview addSubview:iconImageview];
        
        namebtn = [[UIButton alloc]initWithFrame:CGRectMake(iconImageview.right+20, iconImageview.y+5, YXScreenW-iconImageview.right-20, 25)];
//        [namebtn setTitle:@"test-胤宝" forState:UIControlStateNormal];
        namebtn.titleLabel.font = YXSFont(18);
        [namebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        namebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backBigImageview addSubview:namebtn];
        namebtn.userInteractionEnabled = NO;
        
        
        collectGoodsBtn = [[UIButton alloc]initWithFrame:CGRectMake(namebtn.x, iconImageview.bottom-30, 100, 30)];
        [collectGoodsBtn setTitle:@"喜欢(0)" forState:UIControlStateNormal];
        [collectGoodsBtn addTarget:self action:@selector(ClickCollect:) forControlEvents:UIControlEventTouchUpInside];
        collectGoodsBtn.titleLabel.font = YXSFont(15);
        [collectGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        collectGoodsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [collectGoodsBtn setImage:[UIImage imageNamed:@"icon_mycolect"] forState:UIControlStateNormal];
        [backBigImageview addSubview:collectGoodsBtn];
        collectGoodsBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        myRecordBtn = [[UIButton alloc]initWithFrame:CGRectMake(collectGoodsBtn.right, iconImageview.bottom-30, 100, 30)];
        [myRecordBtn setTitle:@"足迹(0)" forState:UIControlStateNormal];
        myRecordBtn.titleLabel.font = YXSFont(15);
        [myRecordBtn addTarget:self action:@selector(ClickMyRecord:) forControlEvents:UIControlEventTouchUpInside];
        [myRecordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        myRecordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [myRecordBtn setImage:[UIImage imageNamed:@"icon_Zuji"] forState:UIControlStateNormal];
        [backBigImageview addSubview:myRecordBtn];
        myRecordBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        SetBtn = [[UIButton alloc]initWithFrame:CGRectMake(YXScreenW-80, 27, 60, 30)];
        [SetBtn setTitle:@"设置" forState:UIControlStateNormal];
        SetBtn.titleLabel.font = YXSFont(15);
        [SetBtn addTarget:self action:@selector(ClickSetBtn:) forControlEvents:UIControlEventTouchUpInside];
        [SetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        SetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [backBigImageview addSubview:SetBtn];
        
        UITapGestureRecognizer *tapview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickselfview)];
        [self addGestureRecognizer:tapview];
        
    }
    return self;
}

@end
