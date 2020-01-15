//
//  HZtextview.swift
//  time
//
//  Created by ADMIN on 2019/9/9.
//  Copyright © 2019 xiaozuo. All rights reserved.
//  覆写textView组件

import UIKit

class HZTextView: UITextView {
    /// 占位文字
    var placeholder: String?
    /// 占位文字颜色
    var placeholderColor: UIColor? = TextColor
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        // 设置默认字体
        self.font = UIFont.systemFont(ofSize: 15)
        
        // 使用通知监听文字改变
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // 如果有文字,就直接返回,不需要画占位文字
        if self.hasText {
            return
        }
        
        // 属性
        let attrs: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: self.placeholderColor as Any, NSAttributedString.Key.font: self.font!]
        
        // 文字
        var rect1 = rect
        print(rect1)
        print("rect1.origin.x", rect1.origin.x)
        print("rect1.origin.y", rect1.origin.y)
        rect1.origin.x = 5
        rect1.origin.y = 8
        rect1.size.width = rect1.size.width - 2*rect1.origin.x
         print("rect1.origin.x", rect1.origin.x)
         print("rect1.origin.y", rect1.origin.y)
        print("rect1.size.width",rect1.size.width)
        
        (self.placeholder! as NSString).draw(in: rect1, withAttributes: attrs)
    }
    
    @objc func textDidChange(_ note: Notification) {
        // 会重新调用drawRect:方法
        self.setNeedsDisplay()
    }
}
