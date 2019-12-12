//
//  AppDelegate.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//  打开APP第一次加载的文件

import UIKit
import HandyJSON
import Alamofire
import Siren
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    
    var isFirstStart:Bool?

    var blockRotation = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.


        // 设置文本框适应键盘
        IQKeyboardManager.shared.enable = true
        // 先确认是否初始化plist文件，没有则初始化
        let isPlistInit = PlistSetting.initPlistFile()
        
        
        let tabBarController = AJTabbarController()
//        tabBarController.tabBar.barTintColor = ThemeColor
//        tabBarController.tabBar.barTintColor = UIColor.clear
        /*
         此处需要判断是否为第一次登陆？
         如果是，则跳到登陆界面。
         如果否，则跳到首页界面。
         */     
        let viewController = loginViewController()
        let loginNv = loginNavigationController(rootViewController: viewController)  //登陆界面
        // 跳转到登录界面
        self.window?.rootViewController = loginNv
//        if UserInfo.getIsFirst() == true{
//
//        }else{
//            sleep(2)
//
//        }
        
        //判断文件中的token是否为空。  如果为空时，则为第一次登陆。
        //如果不为空时，则需要再次判断
        if isPlistInit{
            print(UserInfo.getIsFirst())
            //****************
            if UserInfo.getToken() == ""{  //跳转到登陆界面
                print("token为空:\(UserInfo.getToken())")
                window?.rootViewController = loginNv
            }else{
                // 跳转到主页
                self.window?.rootViewController = tabBarController
                print("token不为空:\(UserInfo.getToken())")
//                //此处分为两种情况：一种是判断token过没过期。第二种是没有网络怎么办
//                let dictString:Dictionary = [ "userId":UserInfo.getUserId() ,"token":UserInfo.getToken()] as [String : Any]
//                // alamofire begin
//                AlamofireManager.request(CHECK_TOKEN,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
//                    if response.result.isSuccess {
//                        if let jsonString = response.result.value {
//                            if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
//                                print(responseModel.toJSONString(prettyPrint: true)!)
//                                if(responseModel.code == 1 ){  //token没过期
//                                    //没过期，允许使用，跳转到tabBar这个地方
//                                    print("你的token还能用")
//                                    self.window?.rootViewController = tabBarController
//                                }else{  //token过期了,不让用
//                                    //过期了，需要清空app文件中的token
//                                    print("你的token过期了")
//                                    //                                UserInfo.setToken("")
//                                    // 跳转到登录界面
//                                    self.window?.rootViewController = loginNv
//                                }
//                            }
//                        }
//                    }else{  //没网的时候
//                        print("网络链接失败")
//                        self.window?.rootViewController = tabBarController  //没网的时候也跳到选择界面
//                        //具体的提示，homeViewController   自己会做
//                    }
//                }
//                // alamofire end
            }
            //**********************
            if UserInfo.getIsFirst() == true{
                self.setStaticGuidePage()
                print("进入轮播图")
                UserInfo.setIsFirst(false)

            }else{
                //请求网络，是否有最新版本，需要更新
                print(UIDevice.current.systemVersion)
                AlamofireManager.request(VersionUpdate,method: .post, headers:vheader).responseString{ (response) in
                    if response.result.isSuccess {
                        if let jsonString = response.result.value {
                            if let responseModel = JSONDeserializer<UPDATA_INFO_RESPONSE>.deserializeFrom(json: jsonString) {
                                print(responseModel.toJSONString(prettyPrint: true)!)
                                if(responseModel.data?.update == 1 ){
                                    let alertUpdate = UIAlertController.init(title: "Version Update", message: responseModel.data?.log!, preferredStyle: .alert)
                                    let yesAction = UIAlertAction.init(title: "Update", style: .default, handler: { (handler) in
                                        let updateUrl:URL = URL.init(string: (responseModel.data?.url!)!)!
                                        if #available(iOS 10.0, *) {
                                            UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
                                        } else {
                                            UIApplication.shared.openURL(updateUrl)
                                        }
                                    })
                                    let noAction = UIAlertAction.init(title: "Later", style: .default, handler: nil)
                                    yesAction.setValue(UIColor.black, forKey: "_titleTextColor")
                                    noAction.setValue(UIColor.black, forKey: "_titleTextColor")
                                    alertUpdate.addAction(yesAction)
                                    alertUpdate.addAction(noAction)
                                    UIApplication.shared.keyWindow?.rootViewController?.present(alertUpdate, animated: true, completion: nil)
                                }else{
                                    print("没有")
                                }
                            }
                        }
                    }else{  //没网的时候
                        print("网络链接失败")
                        self.window?.rootViewController = tabBarController  //没网的时候也跳到选择界面
                        //具体的提示，homeViewController   自己会做
                    }
                }
            }
        }
        window?.makeKeyAndVisible()
        Siren.shared.wail()
        return true
    }

    // 设置启动页轮播图
    func setStaticGuidePage() {
        let imageNameArray: [String] = ["yindao01", "yindao02"]
        let guideView = AJGuidePageView.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        print(imageNameArray)
        self.window?.rootViewController?.view.addSubview(guideView)
        guideView.snp.remakeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    // 设置启动页轮播图
    func setStaticPage() {
        let StartView = UIImageView.init(image: UIImage(named: "750"))
        
        self.window?.rootViewController?.view.addSubview(StartView)
        StartView.snp.remakeConstraints{ (make) in
//            make.width.equalToSuperview()
//            make.height.equalToSuperview()
//            make.top.equalToSuperview()
            make.edges.equalToSuperview()
        }
        UIView.animate(withDuration: 3) {
            StartView.removeFromSuperview()
        }
//        sleep(5)
//        StartView.removeFromSuperview()
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    //程序即将进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    //程序即将进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    //程序终止
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
      
    }
    
    // 如果blockRotation为false，当前应用支持横屏；否则支持竖屏
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if blockRotation{
            return .allButUpsideDown
        }else{
            return .portrait
        }
    }
}


