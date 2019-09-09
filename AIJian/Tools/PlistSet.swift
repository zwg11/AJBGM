//
//  PlistSet.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/9.
//  Copyright © 2019 apple. All rights reserved.
//

// MARK: - 该文件的作用：使得plist文件可以在真机上读写
// 需要读写的plist文件有:
// GlobalValue.plist、UnitSetting.plist、User.plist、inputChoose.plist、userBloodSetting.plist

import Foundation

class PlistSetting{
    
    // 初始化plist文件，
    // 当Document目录文件夹中无对应plist文件
    // 从源文件夹中复制文件到Document目录文件夹中
    class func initPlistFile(){
        let fileManager = FileManager.default
        
        // 获取文件夹路径
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray

        // 获取目标文件路径，实际上就是在文件夹路径添加文件名
        let GlobalValuePath = (documentDirectory[0] as AnyObject).appendingPathComponent("GlobalValue.plist") as String
        
        let UnitSettingPath = (documentDirectory[0] as AnyObject).appendingPathComponent("UnitSetting.plist") as String
        
        let UserPath = (documentDirectory[0] as AnyObject).appendingPathComponent("User.plist") as String
        
        let inputChoosePath = (documentDirectory[0] as AnyObject).appendingPathComponent("inputChoose.plist") as String
        
        let userBloodSettingPath = (documentDirectory[0] as AnyObject).appendingPathComponent("userBloodSetting.plist") as String
        
        print("文件路径1：\(GlobalValuePath)")
        print("文件路径2：\(UnitSettingPath)")
        print("文件路径3：\(UserPath)")
        print("文件路径4：\(inputChoosePath)")
        print("文件路径5：\(userBloodSettingPath)")
        
        // 检查文件夹中是否存在对应的文件
        let GlobalValueExit      = fileManager.fileExists(atPath: GlobalValuePath)
        let UnitSettingExit      = fileManager.fileExists(atPath: UnitSettingPath)
        let UserExit             = fileManager.fileExists(atPath: UserPath)
        let inputChooseExit      = fileManager.fileExists(atPath: inputChoosePath)
        let userBloodSettingExit = fileManager.fileExists(atPath: userBloodSettingPath)
        
        // 如果文件不存在说明App是第一次运行，需要将相关文件拷贝至目标路径
        // GlobalValue.plist 配置文件检查
        if(GlobalValueExit != true){
            // 获取源文件路径
            let path = Bundle.main.path(forResource: "GlobalValue", ofType: "plist")!
            //let path = PlistSetting.getFilePath(File: "GlobalValue.plist")
            
            do{
                // 将文件从源文件夹复制到目标文件夹
                try fileManager.copyItem(atPath: path, toPath: GlobalValuePath)
                print("源文件路径：\(path)")
                print("GlobalValuePath文件\(GlobalValuePath)")
                
            }catch{
                print("异常")
            }
        }
        
        // UnitSetting.plist 配置文件检查
        if(UnitSettingExit != true){
            let path = Bundle.main.path(forResource: "UnitSetting", ofType: "plist")!
//            let path = PlistSetting.getFilePath(File: "UnitSetting.plist")
            
            do{
                try fileManager.copyItem(atPath: path, toPath: UnitSettingPath)
                print("源文件路径：\(path)")
                print("UnitSettingPath文件\(UnitSettingPath)")
                
            }catch{
                print("异常")
            }
        }
        
        // User.plist 配置文件检查
        if(UserExit != true){
            // 取得源文件路径
            let path = Bundle.main.path(forResource: "User", ofType: "plist")!
//            let path = PlistSetting.getFilePath(File: "User.plist")
            
            do{
                try fileManager.copyItem(atPath: path, toPath: UserPath)
                print("源文件路径：\(path)")
                print("UserPath文件\(UserPath)")
                
            }catch{
                print("异常")
            }
        }
        
        // inputChoose.plist 配置文件检查
        if(inputChooseExit != true){
            let path = Bundle.main.path(forResource: "inputChoose", ofType: "plist")!
//            let path = PlistSetting.getFilePath(File: "inputChoose.plist")
            
            do{
                let _ = try fileManager.copyItem(atPath: path, toPath: inputChoosePath)
                print("源文件路径：\(path)")
                print("inputChoosePath文件\(inputChoosePath)")
                
            }catch{
                print("异常")
            }
            
        }
        
        // userBloodSetting.plist 配置文件检查
        if(userBloodSettingExit != true){
            let path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")!
//            let path = PlistSetting.getFilePath(File: "userBloodSetting.plist")
            
            do{
                let _ = try fileManager.copyItem(atPath: path, toPath: userBloodSettingPath)
                print("源文件路径：\(path)")
                print("userBloodSettingPath文件\(userBloodSettingPath)")
                
            }catch{
                print("异常")
            }
            
        }
        
        
    }
    
    // 输入plist文件名，获取其文件路径
    class func getFilePath(File:String) -> String{
        // 获取文件夹路径
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        
        // 获取目标文件路径，实际上就是在文件夹路径添加文件名
        let Path = (documentDirectory[0] as AnyObject).appendingPathComponent(File) as String
        
        return Path
    }
}
