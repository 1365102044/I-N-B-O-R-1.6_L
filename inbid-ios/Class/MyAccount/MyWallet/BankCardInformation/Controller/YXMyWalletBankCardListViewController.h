//
//  YXMyWalletBankCardListViewController.h
//  inbid-ios
//
//  Created by 刘文强 on 2017/2/22.
//  Copyright © 2017年 胤讯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXMyWalletBankCardListViewController;

@protocol YXMyWalletBankCardListViewControllerDelegate <NSObject>

/**
 选中的银行卡
 
 @param myWalletBankCardListViewController              myWalletBankCardListViewController
 @param banCardModel                                    banCardModel
 */
- (void)myWalletBankCardListViewController:(YXMyWalletBankCardListViewController *)myWalletBankCardListViewController
                             bankCardModel:(id)banCardModel;

@end

@interface YXMyWalletBankCardListViewController : UIViewController
/**
 1钱包过来的， 2重置密码流程过来的, 3是从绑定银行卡，4提现选择银行卡（用于过滤提现到信用卡）
 */
@property(nonatomic,assign) NSInteger  PushFormeVCIdentifier;

/**
 代理
 */
@property (nonatomic, weak) id<YXMyWalletBankCardListViewControllerDelegate> delegate;

@end
