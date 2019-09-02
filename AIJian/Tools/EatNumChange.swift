//
//  EatNumChange.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/30.
//  Copyright © 2019 apple. All rights reserved.
//  进餐量转换函数

import Foundation

public class EatNumChange{
    
    static let instance = EatNumChange()
    
    //进餐量转数字
    static func eatTonum(_ str:String)->Int{
        var a:Int
        switch str {
            case "No Meal":
                a = 0
            case "Too Much":
                a = 1
            case "Normal":
                a = 2
            case "Little":
                a = 3
            default:
                a = 0
        }
        return a
    }
    //数字转进餐量
    static  func numToeat(_ num:Int)->String{
        var a:String = "No Meal"
        switch num {
            case 0:
                a = "No Meal"   //不进餐
            case 1:
                a = "Too Much"  //进餐量大
            case 2:
                a = "Normal"    //进餐量中
            case 3:
                a = "Little"    //进餐量小
            default:
                a = "No Meal"
        }
        return a 
    }
    
    
}
