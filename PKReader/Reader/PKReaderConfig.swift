//
//  PKReaderConfig.swift
//  PKReader
//
//  Created by qwer on 2018/3/23.
//  Copyright © 2018年 qwer. All rights reserved.
//

import UIKit

class PKReaderConfig: NSObject {

    static let config = PKReaderConfig()
    static func shared()->PKReaderConfig{
        return config
    }
    
    var contentFrame = CGRect()
    var lineHeightMutiplier: CGFloat = 2
    var fontSize: CGFloat = 19.0
    var fontName:String! = "PingFang-SC-Medium"
    var textColor = UIColor.white
    var textAlignment = NSTextAlignment.left
    
    override init() {
        super.init()
        let font = UIFont.systemFont(ofSize: self.fontSize)
        self.fontName = font.fontName
        let safeAreaTopHeight: CGFloat = UIScreen.main.bounds.size.height == 812.0 ? 24 : 0
        let safeAreaBottomHeight: CGFloat = UIScreen.main.bounds.size.height == 812.0 ? 0 : 0
        self.contentFrame = CGRect(x: 15, y: 30 + safeAreaTopHeight, width: UIScreen.main.bounds.size.width - 30, height: UIScreen.main.bounds.size.height - 60.0 - safeAreaTopHeight - safeAreaBottomHeight)
        
    }
    
}
