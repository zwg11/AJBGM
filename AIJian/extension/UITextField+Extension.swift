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
        // z设置边框
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
        self.borderStyle = .roundedRect
        // 设置文字内容在文本框中的内边距
        self.textRect(forBounds: CGRect(x: 10, y: 0, width: self.bounds.width, height: self.bounds.height))
        // 设置placeholder
        
        
        let placeholderString = NSMutableAttributedString(string: string, attributes: [.foregroundColor:UIColor.gray])
        self.attributedPlaceholder = placeholderString
        // 设置背景颜色
        self.backgroundColor = SendButtonColor
        // 设置字体大小
        self.font = UIFont.systemFont(ofSize: 15)
        // 设置字体颜色
        self.textColor = UIColor.white
    }
    
    //初始化textField的placeholder大小及颜色和键盘类型
    func initTextField(placeholder string:String,keyboardType type:UIKeyboardType){
//        let textField = UITextField()
//        self.placeholder = string
        self.textAlignment = .left
        self.keyboardType = type
        self.textColor = TextColor
        self.autocapitalizationType = .none
//        self.beginFloatingCursor(at: CGPoint(x:0,y:-5))
        self.setValue(NSNumber(value: 10), forKey: "paddingLeft")
        let str:NSMutableAttributedString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        self.attributedPlaceholder = str
//        return textField
    }
    //另一种方式
    func init_secondmethod_TextField(imageName image:String,placeholder text:String){
//            let textField = UITextField()
            let imageView = UIImageView(image: UIImage(named: image))
            self.leftView = imageView
    //        textField.placeholder = text
            self.leftViewMode = .always
            self.autocapitalizationType = .none
            self.font = UIFont.systemFont(ofSize: 16)
            self.textColor = TextColor
            let str:NSMutableAttributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
            self.attributedPlaceholder = str
//            return textField
    }
}
