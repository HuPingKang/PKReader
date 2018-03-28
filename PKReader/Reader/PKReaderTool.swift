//
//  PKReaderTool.swift
//  PKReader
//
//  Created by qwer on 2018/3/23.
//  Copyright © 2018年 qwer. All rights reserved.
//
import DTCoreText
import UIKit

class PKReaderTool: NSObject {
    
    //获取数据上的文字内容：
    static func getBookString(_ bookPath:String) -> NSAttributedString? {
        
        let tmpUrl = URL.init(fileURLWithPath:bookPath)
        guard let tmpString = try? String.init(contentsOf: tmpUrl, encoding: String.Encoding.utf8) else {
            return nil
        }
        
        return NSAttributedString.init(string: tmpString)
        
    }
    
    //获取每个页面的数据模型；
    static func getPageModels(_ bookPath:String,_ config:PKReaderConfig = PKReaderConfig.shared())->[PKPageModel]?{
        
        guard let bookAttrs = self.getBookString(bookPath) else{
            return nil;
        }
        
        var pageModels:[PKPageModel] = [PKPageModel]()
        self.cutPageWith(attrString: bookAttrs, config: config) { (count, mod, completed) in
            pageModels.append(mod)
        }
        
        print(pageModels)
        
        pageModels.forEach { (mod) in
            print(mod.attributedString!,mod.pageIndex)
        }
        return pageModels
        
    }
    
    //切割：
    static func cutPageWith(attrString: NSAttributedString, config: PKReaderConfig, completeHandler: (Int, PKPageModel, Bool) -> Void) -> Void {
        
        //计算一个页面的总体字符串的range：
        let attr = NSMutableAttributedString(attributedString: attrString)
        attr.addAttribute(NSAttributedStringKey.font, value: UIFont(name: config.fontName, size: config.fontSize)!, range: NSRange(location: 0, length: attrString.length))
        
        let layouter = DTCoreTextLayouter.init(attributedString: attr)
        
        let rect = CGRect(x: config.contentFrame.origin.x, y: config.contentFrame.origin.y, width: config.contentFrame.size.width, height: config.contentFrame.size.height - 5)
        var frame = layouter?.layoutFrame(with: rect, range: NSRange(location: 0, length: attrString.length))
        
        var pageVisibleRange = frame?.visibleStringRange()
        var rangeOffset = pageVisibleRange!.location + pageVisibleRange!.length
        var count = 1
        
        while rangeOffset <= attrString.length && rangeOffset != 0 {
            let pageModel = PKPageModel.init()
            pageModel.attributedString = attrString.attributedSubstring(from: pageVisibleRange!) as? NSMutableAttributedString
            pageModel.range = pageVisibleRange
            pageModel.pageIndex = count - 1
            
            frame = layouter?.layoutFrame(with: rect, range: NSRange(location: rangeOffset, length: attrString.length - rangeOffset))
            pageVisibleRange = frame?.visibleStringRange()
            if pageVisibleRange == nil {
                rangeOffset = 0
            }else {
                rangeOffset = pageVisibleRange!.location + pageVisibleRange!.length
            }
            
            let completed = (rangeOffset <= attrString.length && rangeOffset != 0) ? false : true
            completeHandler(count, pageModel, completed)
            count += 1
        }
    }
    
    
}
