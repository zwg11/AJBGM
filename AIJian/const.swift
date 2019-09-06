//
//  File.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//  常量文件

import Foundation
import UIKit

//全局登录逻辑值
let shift_path = Bundle.main.path(forResource: "GlobalValue", ofType: "plist")
let shift_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: shift_path!)!

let SHIFT = shift_data["shift"]


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


let ABOUTUS_STRING = "艾康生物科技有限公司"

var weightUnit : String = "kg"
var heightUnit : String = "cm"
var bloodUnit : String = "mmol/L"


/// 宽度比
let kScalWidth = (AJScreenWidth / 375)
/// 高度比
let kScalHeight = (AJScreenHeight / 667)
/// RGB颜色
func kRGBColor(_ r:CGFloat,_ g : CGFloat, _ b : CGFloat, _ p : CGFloat) -> UIColor {
    
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: p)
}

let kPrintLog = 1  // 控制台输出开关 1：打开   0：关闭
// 控制台打印
func PLog(item: Any...) {
    if kPrintLog == 1 {
        print(item.last!)
    }
}
