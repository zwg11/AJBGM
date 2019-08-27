//
//  GetBloodLimit.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/27.
//  Copyright © 2019 apple. All rights reserved.
//  获取血糖上下限的值

import Foundation

public class GetBloodLimit{
    
    static let instance = GetBloodLimit()
    
    static func getEmptyStomachTop()->Double{
        let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let save_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_path!)!
        let a:Double = Double(((save_data["emptyStomachHighLimit"]  as? NSNumber)?.stringValue)!)!
        return a
    }
    
    static func getEmptyStomachLow()->Double{
        let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let save_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_path!)!
        let a:Double = Double(((save_data["emptyStomachLowLimit"]  as? NSNumber)?.stringValue)!)!
        return a
    }
    
    static func getBeforeDinnerTop()->Double{
        let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let save_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_path!)!
        let a:Double = Double(((save_data["beforeDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
        return a
    }
    
    static func getBeforeDinnerLow()->Double{
        let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let save_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_path!)!
        let a:Double = Double(((save_data["beforeDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
        return a
    }
    
    static func getAfterDinnerTop()->Double{
        let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let save_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_path!)!
        let a:Double = Double(((save_data["afterDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
        return a
    }
    
    static func getAfterDinnerLow()->Double{
        let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let save_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_path!)!
        let a:Double = Double(((save_data["afterDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
        return a
    }
    
    static func getRandomDinnerTop()->Double{
        let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let save_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_path!)!
        let a:Double = Double(((save_data["randomDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
        return a
    }
    
    static func getRandomDinnerLow()->Double{
        let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let save_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_path!)!
        let a:Double = Double(((save_data["randomDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
        return a
    }
}
