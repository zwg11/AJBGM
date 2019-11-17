//
//  tableViewCellCustomLabel.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class tableViewCellCustomLabel: UILabel {

    // 为设计带有图片的label重新定义初始化函数
    convenience init(text:String,image:String){
        self.init()
        
        let markLabelText = text
        self.textAlignment = .center
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 13)
//        self.backgroundColor = SendButtonColor
        self.backgroundColor = kRGBColor(8, 52, 84, 1)
        self.numberOfLines = 0
//        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderWidth = 1

        
        let markAttr = NSMutableAttributedString(string: markLabelText)
        // 设置富文本的某一范围 range 的属性 NSAttributedString.Key 的值 value 。
        //markAttr.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 6, length: text.count))
        
        // 添加图片
        let markattach = NSTextAttachment()
        markattach.image = UIImage(named: image)
        markattach.bounds = CGRect(x: 0, y: -5, width: 30, height: 30)
        
        let markAttackStr = NSAttributedString(attachment: markattach)
        // 放置 markAttackStr 的位置
        markAttr.insert(markAttackStr, at: 0)
        self.attributedText = markAttr
    }
}
