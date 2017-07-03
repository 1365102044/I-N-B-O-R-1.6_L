//
//  YXShareSDKBridgeManager.swift
//  inbid-ios
//
//  Created by 郑键 on 17/1/10.
//  Copyright © 2017年 胤讯. All rights reserved.
//

import UIKit

@objc protocol YXShareSDKBridgeManagerDelegate {
    func shareButtonClick(shareSDKBridgeManager:(YXShareSDKBridgeManager), button:(UIButton))
}

class YXShareSDKBridgeManager: NSObject, YXShareViewDelegate {

    /// proprites
    public var delegate: YXShareSDKBridgeManagerDelegate?
    var shareView: YXShareView?
    
    /// 显示分享菜单
    public func showShareMenu() {
        let shareView       = YXShareView.getView()
        shareView.delegate  = self;
        shareView.show()
    }
    
    /// 移除分享视图
    public func dismissShareMenu() {
        shareView?.cancle()
    }
    
    /// 点击事件方法
    ///
    /// - Parameters:
    ///   - shareView: 分享菜单视图
    ///   - button: 点击的按钮
    func shareButtonClick(shareView: YXShareView, button: UIButton) {
        self.shareView = shareView
        if let delegate = delegate {
            delegate .shareButtonClick(shareSDKBridgeManager: self, button: button)
        }
    }
}
