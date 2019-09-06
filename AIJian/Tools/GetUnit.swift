//
//  GetUnit.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/27.
//  Copyright © 2019 apple. All rights reserved.
//  获得单位

import Foundation
public class GetUnit{
    
    static let instance = GetUnit()
    
    
    //获取当前血压单位
    static func getPressureUnit() -> String{
        let unit_path = Bundle.main.path(forResource: "UnitSetting", ofType: "plist")
        let unit_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_path!)!
        let unit = unit_data["PressureUnit"]! as! String
        return unit
    }
    //获取当前体重单位
    static func getWeightUnit() -> String{
        let unit_path = Bundle.main.path(forResource: "UnitSetting", ofType: "plist")
        let unit_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_path!)!
        let unit = unit_data["WeightUnit"]! as! String
        return unit
    }
    //获取当前血糖单位
    static func getBloodUnit() -> String{
        let unit_path = Bundle.main.path(forResource: "UnitSetting", ofType: "plist")
        let unit_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_path!)!
        let unit = unit_data["BloodUnit"]! as! String
        return unit
    }
    
}



