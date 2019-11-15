//
//  File.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//  常量文件

import Foundation
import UIKit
import Alamofire

// 设置网络请求时间限制
let AlamofireManager:Alamofire.SessionManager = {
    let conf = URLSessionConfiguration.default
    // 请求时间显示为10s
    conf.timeoutIntervalForRequest = 10
    return Alamofire.SessionManager(configuration: conf)
}()

//全局登录逻辑值
let shift_path = Bundle.main.path(forResource: "GlobalValue", ofType: "plist")
let shift_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: shift_path!)!

let SHIFT = shift_data["shift"]
//用于滑块的图片
var sliderImage = UIImage()

let AJScreenWidth = UIScreen.main.bounds.width
let AJScreenHeight = UIScreen.main.bounds.height

//页面背景主题色
let ThemeColor = UIColor.init(red: 11/255.0, green: 41/255.0, blue: 63/255.0, alpha: 1)
let NavBarColor = UIColor.init(red: 9/255.0, green: 39/255.0, blue: 55/255.0, alpha: 1)
//页面字体颜色
let TextColor = UIColor.init(red: 141/255.0, green: 177/255.0, blue: 213/255.0, alpha: 1)
// h字体灰色
let TextGrayColor = UIColor.init(red: 136/255.0, green: 136/255.0, blue: 136/255.0, alpha: 1)
//按钮背景色
let ButtonColor = UIColor.init(red: 14/255.0, green: 60/255.0, blue: 100/255.0, alpha: 1)
//线的颜色
let LineColor = UIColor.init(red: 70/255.0, green: 102/255.0, blue: 131/255.0, alpha: 1)
//navigationBar中文字的颜色
let NaviTitleColor = UIColor.init(red: 173/255.0, green: 176/255.0, blue: 181/255.0, alpha: 1)
//send code 按钮背景色
let SendButtonColor = UIColor.init(red: 9/255.0, green: 68/255.0, blue: 108/255.0, alpha: 1)

//我的页面姓名的字体颜色
let MineNameTextColor = UIColor.init(red: 196/255.0, green: 197/255.0, blue: 198/255.0, alpha: 1)

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
