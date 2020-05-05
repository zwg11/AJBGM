//
//  LoginOff.swift
//  On_Call
//
//  Created by ADMIN on 2019/12/12.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class LoginOff{
    
    static let instance = LoginOff()
    static let path = PlistSetting.getFilePath(File: "User.plist")
   
    static func loginOff(_ viewController:UIViewController){
        //用do...catch语句来做。。。无论怎么样，都进行dismiss。如果出错了，就直接present
        // 回到登录界面
//        viewController.dismiss(animated: true, completion: nil)
        viewController.dismiss(animated: true, completion: nil)
        let vc = loginViewController()
        let nv = loginNavigationController(rootViewController: vc)
        // 设置弹出模式为占满屏幕
        nv.modalPresentationStyle = .fullScreen
        viewController.present(nv, animated: true, completion: nil)
        
        // 将对应的用户的token设为空
        //退出登录，需要把token清空
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        data.setObject("", forKey: "token" as NSCopying )
        data.write(toFile: path, atomically: true)
        // 删除数据库中所有的血糖数据
        DBSQLiteManager.manager.deleteAllGlucoseRecord()
        
        // 清空meterid的数据
        let path0 = PlistSetting.getFilePath(File: "otherSettings.plist")
        let data0:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path0)!
        
        let arr:NSMutableDictionary = [:]
        
        data0["meterID"] = arr
        data0.write(toFile: path0, atomically: true)
    }
    
}
