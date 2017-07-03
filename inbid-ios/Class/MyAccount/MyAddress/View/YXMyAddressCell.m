//
//  YXMyAddressCell.m
//  inbid-ios
//
//  Created by 郑键 on 16/9/13.
//  Copyright © 2016年 胤讯. All rights reserved.
//

#import "YXMyAddressCell.h"
#import "YXStringFilterTool.h"
#import "YXMyAddressList.h"

@interface YXMyAddressCell()

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;

//** 收件人姓名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//** 收件人联系方式 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
//** 地址label */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
//** 是否是默认地址 */
@property (weak, nonatomic) IBOutlet UIButton *defaultButton;

@end

@implementation YXMyAddressCell

#pragma mark - 赋值

- (void)setAddressListModel:(YXMyAddressList *)addressListModel
{
    _addressListModel = addressListModel;
    
    self.nameLabel.text = addressListModel.consigneeName;
    self.phoneNumberLabel.text = addressListModel.consigneeMobile;
    
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@", addressListModel.consigneeProvince, addressListModel.consigneeCity, addressListModel.consigneeAddressDetail];
    
    if (addressListModel.isDefault) {
        if ([self.delegate respondsToSelector:@selector(myAddressCell:withCurrentButton:withDefaultAddressId:)]) {
            [self.delegate myAddressCell:self withCurrentButton:self.defaultButton withDefaultAddressId:self.addressListModel.addressId];
        }
    }else{
        self.defaultButton.enabled = YES;
    }
}



#pragma mark - 响应事件

//** 删除按钮点击事件 */
- (IBAction)cancleButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(myAddressCell:withDeleteAddressId:)]) {
        [self.delegate myAddressCell:self withDeleteAddressId:self.addressListModel.addressId];
    }
}

//** 编辑按钮点击事件 */
- (IBAction)editButtonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(myAddressCell:withEditAddressModel:)]) {
        [self.delegate myAddressCell:self withEditAddressModel:self.addressListModel];
    }
}


//** 选择默认地址 */
- (IBAction)setDefaultAddress:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(myAddressCell:withCurrentButton:withDefaultAddressId:)]) {
        [self.delegate myAddressCell:self withCurrentButton:sender withDefaultAddressId:self.addressListModel.addressId];
    }
}

//** 入口 */
- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.editButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.cancleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    self.addressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

//** 选中 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

//** 设置frame */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}


@end
