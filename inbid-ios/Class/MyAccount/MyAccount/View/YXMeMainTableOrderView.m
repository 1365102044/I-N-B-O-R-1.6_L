//
//  YXMeMainTableOrderView.m
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/14.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import "YXMeMainTableOrderView.h"
#import "YXMeMainOrderItemView.h"
#import "YXMeMainTapGestureRecognizer.h"
@interface YXMeMainTableOrderView ()
{
    UILabel *titleLable;
    UIButton *returnGoodsBtn;
    UIImageView *imageview;
    UIView *line;
    
    UIView *itemBackView;
    YXMeMainOrderItemView *itemView;
    NSArray *dataarr;
}
@end

@implementation YXMeMainTableOrderView


-(void)setOrderViewModle:(YXMyAccountBaseData *)orderViewModle{

    _orderViewModle = orderViewModle;
    NSMutableArray *numberArr = [NSMutableArray array];
    [numberArr addObject:[NSString stringWithFormat:@"%ld",(long)orderViewModle.noPayOrder]];
    [numberArr addObject:[NSString stringWithFormat:@"%ld",(long)orderViewModle.hasPayOrder]];
    [numberArr addObject:[NSString stringWithFormat:@"%ld",(long)orderViewModle.getOrder]];
    [numberArr addObject:[NSString stringWithFormat:@"%ld",(long)orderViewModle.confrimOrder]];
    
    for (YXMeMainOrderItemView *views in itemBackView.subviews) {
        if (views.tag>=1) {
            views.orderNumber = numberArr[views.tag-1];
        }
    }
}

-(void)Clickreturngoods:(UIButton *)sender{
    if (self.clickItemBlock) {
        self.clickItemBlock(alearlyReturnSEL);
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
        titleLable.textAlignment = NSTextAlignmentLeft;
        titleLable.text = @"我买到的";
        titleLable.font = YXSFont(15);
        [self addSubview:titleLable];
        
        returnGoodsBtn = [[UIButton alloc]initWithFrame:CGRectMake(titleLable.right, 3.5, YXScreenW-titleLable.right-10, 38)];
        [returnGoodsBtn setTitle:@"全部订单" forState:UIControlStateNormal];
        returnGoodsBtn.titleLabel.font = YXSFont(13);
        [returnGoodsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [returnGoodsBtn setImage:[UIImage imageNamed:@"icon_newmyAccounjiantou"] forState:UIControlStateNormal];
        [returnGoodsBtn addTarget:self action:@selector(Clickreturngoods:) forControlEvents:UIControlEventTouchUpInside];
        [returnGoodsBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -returnGoodsBtn.imageView.size.width-5, 0, returnGoodsBtn.imageView.size.width+5)];
        [returnGoodsBtn setImageEdgeInsets:UIEdgeInsetsMake(0, returnGoodsBtn.titleLabel.bounds.size.width, 0, -returnGoodsBtn.titleLabel.bounds.size.width)];
        
        returnGoodsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:returnGoodsBtn];
    
        line = [[UIView alloc]initWithFrame:CGRectMake(0, titleLable.bottom+5, YXScreenW, 1)];
        line.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self addSubview:line];
        
        itemBackView = [[UIView alloc]initWithFrame:CGRectMake(0, line.bottom+5, YXScreenW, 80)];
        [self addSubview:itemBackView];
        
        dataarr = [NSArray new];
        dataarr = @[@"待付款",@"待发货",@"待收货",@"待确认"];
        CGFloat W = (YXScreenW-60)/dataarr.count;
        for (int i=0; i<dataarr.count; i++) {
            
            YXMeMainOrderItemView *item = [[YXMeMainOrderItemView alloc]init];
            item.frame = CGRectMake(i*(W+20), 0, W, itemBackView.height);
            item.backgroundColor = [UIColor clearColor];
            item.tag = i+1;
            item.ItemTitle = dataarr[i];
    
            [itemBackView addSubview:item];
            YXMeMainTapGestureRecognizer *tap = [[YXMeMainTapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickItem:)];
            tap.index = i+1;
            [item addGestureRecognizer:tap];
        }
    }
    return self;
}

-(void)ClickItem:(YXMeMainTapGestureRecognizer *)tap{

    if (self.clickItemBlock) {
        self.clickItemBlock(tap.index);
    }
}

@end
