

import Foundation
import UIKit

class UpdateManager:NSObject{
    
    
    /// app版本更新检测
    ///
    /// - Parameter appId: apple ID - 开发者帐号对应app处获取
    override init() {
        super.init()
        let appId:String = "1421026171"
        //获取appstore上的最新版本号
        let appUrl = URL.init(string: "https://itunes.apple.com/lookup?id=" + appId)
        //        let appUrl = URL.init(string: "http://itunes.apple.com/lookup?bundleId=" + appId)
        guard let appMsg = try? String.init(contentsOf: appUrl!, encoding: .utf8) else{
            return
        }
        //得到字典类型的app相关信息
        let appMsgDict:NSDictionary = getDictFromString(jString: appMsg)
        let appResultsArray:NSArray = (appMsgDict["results"] as? NSArray)!
        let appResultsDict:NSDictionary = appResultsArray.lastObject as! NSDictionary
        //获得一个内容的版本，版本的格式:2.0.2
        let appStoreVersion:String = appResultsDict["version"] as! String
        //获取当前手机安装使用的版本号
        let localVersion:String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        //用户是否设置不再提示
        let userDefaults = UserDefaults.standard
        let res = userDefaults.bool(forKey: "NO_ALERt_AGAIN")
        //appstore上的版本号大于本地版本号 - 说明有更新
        //直接通过字符串来比较，避免无法转为float类型的尴尬
        if appStoreVersion > localVersion && !res {
            let alertC = UIAlertController.init(title: "版本更新了", message: "是否前往更新", preferredStyle: .alert)
            let yesAction = UIAlertAction.init(title: "去更新", style: .default, handler: { (handler) in
                self.updateApp(appId:appId)
            })
            let noAction = UIAlertAction.init(title: "下次再说", style: .cancel, handler: nil)
            let cancelAction = UIAlertAction.init(title: "不再提示", style: .default, handler: { (handler) in
                self.noAlertAgain()
            })
            alertC.addAction(yesAction)
            alertC.addAction(noAction)
            alertC.addAction(cancelAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertC, animated: true, completion: nil)
        }else{
            let alertC = UIAlertController.init(title: "已经是最新版本了", message: "", preferredStyle: .alert)
            let noAction = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
            alertC.addAction(noAction)
            
            UIApplication.shared.keyWindow?.rootViewController?.present(alertC, animated: true, completion: nil)
        }
        
    }
    
    //去更新
    func updateApp(appId:String) {
        let updateUrl:URL = URL.init(string: "https://www.apple.com/ios/app-store/id" + appId)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(updateUrl)
        }
    }
    
    //不再提示
    func noAlertAgain() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "NO_ALERt_AGAIN")
        userDefaults.synchronize()
    }
    
    //JSONString转字典
    func getDictFromString(jString:String) -> NSDictionary {
        let jsonData:Data = jString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        
        return NSDictionary()
    }
    
    
}

