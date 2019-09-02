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
            case "nothing":
                 a = 0
            case "AfterMeal":
                 a = 1
            case "BeforeMeal":
                 a = 2
            case "AfterFasting":
                 a = 3
            case "BeforeFasting":
                 a = 4
            case "AfterDinner":
                 a = 5
            case "BeforeDinner":
                 a = 6
            case "AfterSnacks":
                 a = 7
            case "BeforeSnacks":
                 a = 8
            case "AfterNight":
                 a = 9
            case "Empty":
                 a = 10
            case "Other":
                 a = 11
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
                a = "nothing"
            case 1:
                a = "AfterMeal"
            case 2:
                a = "BeforeMeal"
            case 3:
                a = "AfterFasting"
            case 4:
                a = "BeforeFasting"
            case 5:
                a = "AfterDinner"
            case 6:
                a = "BeforeDinner"
            case 7:
                a = "AfterSnacks"
            case 8:
                a = "BeforeSnacks"
            case 9:
                a = "AfterNight"
            case 10:
                a = "Empty"
            case 11:
                a = "Other"
            default:
                a = "Nothing"
        }
        return a
    }
    
    
}
