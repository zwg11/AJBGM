//
//  UnitConversion.swift
//  AIJian
//
//  Created by zzz on 2019/8/23.
//  Copyright © 2019 apple. All rights reserved.
//  功能：单位换算

import Foundation

public class UnitConversion{
    
    static let instance = UnitConversion()
    
    //mg/dL转mmol/L，为大单位转小单位，除以18.02
    static func  mgTomm(num:Double) -> Double{
        var a:Double = num
        //先利用string格式化数值，保留一位,默认向上取整
//        print(a/18.02)
        let x = String(format: "%.1f", a/18.02)
//        print("截取三位以后：",x)
        //再转double
        a = Double(x)!
        return a
    }
    //mmol/L转mg/dL，为小单位转大单位，乘以18.02
    static func mmTomg(num:Double) -> Int {
        var a:Double = num
        a = num * 18.02
        let num1:Int = Int(a)
        return num1
    }
    //mmol/L转mg/dL，为小单位转大单位，乘以18.02  保留一位小数
    static func mmTomgDouble(num:Double) -> Double {
        var a:Double = num
        let x = String(format: "%.1f", num * 18.02)
        a = Double(x)!
        return a
    }
}
