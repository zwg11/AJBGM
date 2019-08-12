//
//  UITextField+Extension.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit
extension UITextField{
    // 设置一般文本框风格
    // 边框设置 字体大小设置 文本框提示文本设置
    func norStyle(placeholder string:String){
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
        self.borderStyle = .roundedRect
        self.textRect(forBounds: CGRect(x: 10, y: 0, width: self.bounds.width, height: self.bounds.height))
        self.placeholder = string

        self.font = UIFont.systemFont(ofSize: 16)
    }
}
