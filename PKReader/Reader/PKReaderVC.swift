//
//  PKReaderVC.swift
//  PKReader
//
//  Created by qwer on 2018/3/23.
//  Copyright © 2018年 qwer. All rights reserved.
//

import DTCoreText
import UIKit

class PKReaderVC: UIViewController {

    var pageIndex:Int = 0
    var content:NSAttributedString? = NSAttributedString(string: "")
    
    private lazy var contentLabel:DTAttributedLabel? = {
        
        let xx = DTAttributedLabel()
        xx.backgroundColor = UIColor.clear
        xx.frame = PKReaderConfig.shared().contentFrame
        xx.numberOfLines = 0
        self.view.addSubview(xx)
        return xx
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attrs:NSMutableAttributedString = NSMutableAttributedString.init(attributedString: content!)
        
        let range = NSRange.init(location: 0, length: (content?.length)!)
        
        attrs.addAttribute(NSAttributedStringKey.font, value: UIFont(name: PKReaderConfig.shared().fontName, size: PKReaderConfig.shared().fontSize)!, range:range )
        attrs.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range:range )
        self.view.backgroundColor = UIColor.red
        self.contentLabel?.attributedString = attrs
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
