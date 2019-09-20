//
//  PressureUnitChange.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/1.
//  Copyright © 2019 apple. All rights reserved.
//  血压单位转换

import Foundation


public class PressureUnitChange{
    
    static let instance = PressureUnitChange()
    
    //mmHg转kpa  -->  得到是Kpa单位的数值
    static func mmHgTokPa(num:Double) -> Double{
        var a:Double = num
        let x = String(format: "%.1f", a/7.5)
        a = Double(x)!
        return a
    }
    //kpa转mmHg  -->  得到是mmHg单位的数值
    static func kPaTommHg(num:Double) -> Double{
        var a:Double = num
        let x = String(format: "%.1f", a * 7.5)
        a = Double(x)!
        return a
    }
    
}
