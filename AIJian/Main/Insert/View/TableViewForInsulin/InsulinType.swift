//
//  File.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/17.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

// 获取配置文件中的胰岛素类型
class getInsulin{
    
    // 该路径为手动输入界面的配置文件路径
    static let path1 = PlistSetting.getFilePath(File: "inputChoose.plist")
    
    // 获取手动输入界面的配置文件中的Insulin
    // 传值key，得到对应array
    static func getInsArray() -> NSMutableArray{
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path1)!
        let InsulinArray = data["insulin"] as! NSMutableArray
        return InsulinArray
    }
    
    // 改变手动输入界面的配置文件中的Insulin
    static func setInsArray(_ array:NSMutableArray){
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path1)!
        data["insulin"] = array
        data.write(toFile: path1, atomically: true)
    }

    // 该路径为选择胰岛素页面表格所需配置文件路径
    static let path = Bundle.main.path(forResource: "Insulin", ofType: "plist")
    // 传值key，得到对应array
    static func getInsulinArray(_ str:String) -> NSArray{
        let data = NSDictionary.init(contentsOfFile: path!)
        let Insulin = data![str] as! NSArray
        return Insulin
    }
}
