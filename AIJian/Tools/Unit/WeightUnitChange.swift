//
//  WeightUnitChange.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/1.
//  Copyright © 2019 apple. All rights reserved.
//  体重单位转换

import Foundation

public class WeightUnitChange{
    
    static let instace = WeightUnitChange()
    
    //kg单位转Lbs  乘以2.20654 不保留
    static func KgToLbs(num:Double) -> Double{
        var a:Double = num
        a = num * 2.20654
        let x = String(format: "%.1f", a)
        a = Double(x)!
        return a
    }
    //Lbs单位转kg  除以2.20654 保留一位
    static func LbsToKg(num:Double) -> Double{
        var a:Double = num
        let x = String(format: "%.1f", a/2.20654)
        a = Double(x)!
        return a
    }
    
    
}
