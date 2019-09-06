//
//  GetUserInfo.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/29.
//  Copyright © 2019 apple. All rights reserved.
//   获取用户最原始的token信息和userId信息

import Foundation


// 用户id
var userId:Int64? = 0

// 用户token
var token:String?

// 从plist 文件中提取 userId 和 token
func getUserInfo(){
    let path = Bundle.main.path(forResource: "User", ofType: "plist")
    let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path!)!
    userId = data["userId"] as? Int64
    token = data["token"] as? String
}
