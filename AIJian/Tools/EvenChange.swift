//
//  EvenChange.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/30.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

public class EvenChang{
    
    static let instance = EvenChang()
    //将事件转为数字
    static func evenTonum(_ str:String)->Int{
        var a:Int
        switch str {
            case "Before Meal":
                 a = 0
            case "After Meal":
                 a = 1
            case "Fasting":
                 a = 2
            case "Random":
                 a = 3
            default:
                 a = 0
        }
        return a
    }
    //将数字转为事件
    static func numToeven(_ num:Int)->String{
        var a:String = "nothing"
        switch num {
            case 0:
                a = "Before Meal"
            case 1:
                a = "After Meal"
            case 2:
                a = "Fasting"
            case 3:
                a = "Random"
            default:
                a = "Before Meal"
        }
        return a
    }
    
    
}
