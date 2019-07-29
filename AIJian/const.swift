//
//  File.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//  常量文件

import Foundation
import UIKit


let AJScreenWidth = UIScreen.main.bounds.width
let AJScreenHeight = UIScreen.main.bounds.height

//白色
let DominantColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
//黑色
let FooterViewColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

// 导航栏默认颜色
let barDefaultColor = UIColor.init(red: 86.0/255.0, green: 119.0/255.0, blue: 252.0/255.0, alpha: 1)

// 边框颜色
let borderColor = UIColor.init(red: 187.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1)

// iphone X
let isIphoneX = AJScreenHeight == 812 ? true : false
// navigationBarHeight
let navigationBarHeight : CGFloat = isIphoneX ? 88 : 64
// tabBarHeight
let tabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49
