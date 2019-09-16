//
//  IntensityChange.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/31.
//  Copyright © 2019 apple. All rights reserved.
//  运动强度类型转换

import Foundation

public class IntensityChange{
    
    static let instance = IntensityChange()
    
    //运动强度转数字
    static func intensityTonum(_ str:String)->Int{
        var a:Int
        switch str {
        case "Nothing":
            a = 0
        case "Light":  //低
            a = 1
        case "Medium":
            a = 2
        case "Hard":
            a = 3
        default:
            a = 0
        }
        return a
    }
    
    
    //数字转运动强度
    static func numTointensity(_ num:Int)->String{
        var a:String = "No Meal"
        switch num {
        case 0:
            a = "Nothing"    //无运动类型
        case 1:
            a = "Light"      //运动强度低
        case 2:
            a = "Medium"     //运动强度中
        case 3:
            a = "Hard"       //运动强度高
        default:
            a = "Nothing"
        }
        return a
    }
}
