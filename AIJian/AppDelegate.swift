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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var isFirstStart:Bool?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabBarController = AJTabbarController()
       
        /*
         此处需要判断是否为第一次登陆？
         如果是，则跳到登陆界面。
         如果否，则跳到首页界面。
         */     
        let viewController = loginViewController()
        let nv = loginNavigationController(rootViewController: viewController)  //登陆界面
        
        //判断文件中的token是否为空。  如果为空时，则为第一次登陆。
        //如果不为空时，则需要再次判断
        if UserInfo.getToken() == ""{  //跳转到登陆界面
            print("token为空")
            window?.rootViewController = nv
        }else{
            print("token不为空")
            //此处分为两种情况：一种是判断token过没过期。第二种是没有网络怎么办
            let dictString:Dictionary = [ "userId":UserInfo.getUserId() ,"token":UserInfo.getToken()] as [String : Any]
            Alamofire.request(CHECK_TOKEN,method: .post,parameters: dictString).responseString{ (response) in
                if response.result.isSuccess {
                    if let jsonString = response.result.value {
                        if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                            print(responseModel.toJSONString(prettyPrint: true)!)
                            if(responseModel.code == 1 ){  //token没过期
                                //没过期，允许使用，跳转到tabBar这个地方
                                self.window?.rootViewController = tabBarController
                            }else{  //token过期了,不让用
                                //过期了，需要清空app文件中的token
                                UserInfo.setToken("")
                                self.window?.rootViewController = nv
                            }
                        }
                    }
                }else{  //没网的时候
                    self.window?.rootViewController = tabBarController  //没网的时候也跳到选择界面
                    //具体的提示，homeViewController   自己会做
                }
            }
        }
        
        window?.makeKeyAndVisible()
        

//        let startImageView = AJStartView.init(imageName: "startView-1", timer: 3)
//        self.window?.rootViewController?.view.addSubview(startImageView)
        isFirstStart = false
        if isFirstStart == true{
            self.setStaticGuidePage()
        }
        return true
    }

    // 设置启动页轮播图
    func setStaticGuidePage() {
        let imageNameArray: [String] = ["yindao01", "yindao02","yindao03"]
        let guideView = AJGuidePageView.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.window?.rootViewController?.view.addSubview(guideView)
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
      
    }
    // MARK: - Core Data stack
    
 
    
    // MARK: - Core Data Saving support
 

}

