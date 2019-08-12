//
//  UILsbel+Extension.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    // 设置一般标签格式
    // 颜色为黑 字体大小为18 靠左 背景颜色为黄
    func normalLabel(text string:String){
        self.textColor = UIColor.black
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: 18)
        self.text = string
        self.backgroundColor = UIColor.yellow
        self.sizeToFit()
        
    }
}
