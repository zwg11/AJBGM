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
    static let unit_mmol_save_path = PlistSetting.getFilePath(File: "userBloodSetting.plist")
    static let unit_mgdl_save_path = PlistSetting.getFilePath(File: "userBloodSettingMgdl.plist")
    
    static func getEmptyStomachTop()->Double{
//        let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        
        let mmsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mmol_save_path)!
        let a:Double = Double(((mmsave_data["emptyStomachHighLimit"]  as? NSNumber)?.stringValue)!)!
        
        let mgsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mgdl_save_path)!
        let b:Double = Double(((mgsave_data["emptyStomachHighLimit"]  as? NSNumber)?.stringValue)!)!
        // 根据单位返回对应的正常范围
        if GetUnit.getBloodUnit() == "mmol/L"{
            return a
        }else{
            return b
        }
        
    }
    
    static func getEmptyStomachLow()->Double{
        //let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let mmsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mmol_save_path)!
        let a:Double = Double(((mmsave_data["emptyStomachLowLimit"]  as? NSNumber)?.stringValue)!)!
        
        let mgsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mgdl_save_path)!
        let b:Double = Double(((mgsave_data["emptyStomachLowLimit"]  as? NSNumber)?.stringValue)!)!
        // 根据单位返回对应的正常范围
        if GetUnit.getBloodUnit() == "mmol/L"{
            return a
        }else{
            return b
        }
    }
    
    static func getBeforeDinnerTop()->Double{
        //let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let mmsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mmol_save_path)!
        let a:Double = Double(((mmsave_data["beforeDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
        
        let mgsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mgdl_save_path)!
        let b:Double = Double(((mgsave_data["beforeDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
        // 根据单位返回对应的正常范围
        if GetUnit.getBloodUnit() == "mmol/L"{
            return a
        }else{
            return b
        }
    }
    
    static func getBeforeDinnerLow()->Double{
        //let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let mmsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mmol_save_path)!
        let a:Double = Double(((mmsave_data["beforeDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
        
        let mgsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mgdl_save_path)!
        let b:Double = Double(((mgsave_data["beforeDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
        // 根据单位返回对应的正常范围
        if GetUnit.getBloodUnit() == "mmol/L"{
            return a
        }else{
            return b
        }
    }
    
    static func getAfterDinnerTop()->Double{
        //let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let mmsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mmol_save_path)!
        let a:Double = Double(((mmsave_data["afterDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
        
        let mgsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mgdl_save_path)!
        let b:Double = Double(((mgsave_data["afterDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
        // 根据单位返回对应的正常范围
        if GetUnit.getBloodUnit() == "mmol/L"{
            return a
        }else{
            return b
        }
    }
    
    static func getAfterDinnerLow()->Double{
        //let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let mmsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mmol_save_path)!
        let a:Double = Double(((mmsave_data["afterDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
        
        let mgsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mgdl_save_path)!
        let b:Double = Double(((mgsave_data["afterDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
        // 根据单位返回对应的正常范围
        if GetUnit.getBloodUnit() == "mmol/L"{
            return a
        }else{
            return b
        }
    }
    
    static func getRandomDinnerTop()->Double{
        //let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let mmsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mmol_save_path)!
        let a:Double = Double(((mmsave_data["randomDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
        
        let mgsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mgdl_save_path)!
        let b:Double = Double(((mgsave_data["randomDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
        // 根据单位返回对应的正常范围
        if GetUnit.getBloodUnit() == "mmol/L"{
            return a
        }else{
            return b
        }
    }
    
    static func getRandomDinnerLow()->Double{
        //let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
        let mmsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mmol_save_path)!
        let a:Double = Double(((mmsave_data["randomDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
        
        let mgsave_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_mgdl_save_path)!
        let b:Double = Double(((mgsave_data["randomDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
        // 根据单位返回对应的正常范围
        if GetUnit.getBloodUnit() == "mmol/L"{
            return a
        }else{
            return b
        }
    }
}

