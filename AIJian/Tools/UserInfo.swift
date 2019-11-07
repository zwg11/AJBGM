//
//  GetUserInfo.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//   获取用户最原始的token信息和userId信息

import Foundation

class UserInfo{
    
    static let path = PlistSetting.getFilePath(File: "User.plist")
    // 从plist 文件中提取 userId
    static func getUserId() -> Int64{
        //let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        var userId:Int64
        userId = data["userId"] as! Int64
        print("userId:\(userId)")
        return userId
    }

    // 从plist 文件中提取 token
    static func getToken() -> String{
        //let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        var token:String
        token = data["token"] as! String
        return token
    }
    
    // 从plist 文件中提取 email
    static func getEmail() -> String{
        //let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        var email:String
        email = data["email"] as! String
        return email
    }
    
    // 从plist 文件中提取 meterID
    static func getMeterID() -> Dictionary<String, String>{
        //let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        var meterID:Dictionary<String, String>
        meterID = data["meterID"] as! Dictionary
        return meterID
    }
    
    //从Plist文件中提取 isFirst
    static func getIsFirst() ->Bool{
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        var isFirst:Bool
        isFirst = data["isFirst"] as! Bool
        return isFirst
    }
    
    
    // 设置plist 文件中的 userId
    static func setUserId(_ id:Int64){
        //let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
    
        data["userId"] = id
        data.write(toFile: path, atomically: true)
    }
    
    // 设置plist 文件中的 token
    static func setToken(_ token:String){
        //let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        data["token"] = token
        data.write(toFile: path, atomically: true)
    }
    
    // 设置plist 文件中的 email
    static func setEmail(_ email:String){
        //let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        data["email"] = email
        data.write(toFile: path, atomically: true)
    }
    
    // 设置plist 文件中的 meterID
    static func setMeterID(_ meterID:String,_ record:String){
        //let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        let arr = data["meterID"] as! NSMutableDictionary
        // 更新配置文件内容
        arr[meterID] = record
        data["meterID"] = arr
        data.write(toFile: path, atomically: true)
    }
    //设置Plist文件中提取 isFirst
    static func setIsFirst(_ isFirst:Bool) {
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        data["isFirst"] = isFirst
        data.write(toFile: path, atomically: true)
    }
}

