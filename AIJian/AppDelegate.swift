//
//  AppDelegate.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var isFirstStart:Bool?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabBarController = AJTabbarController()
        // tabBarController的主题颜色
        tabBarController.tabBar.tintColor = UIColor.init(red: 9.0/255.0, green: 187.0/255.0, blue: 7.0/255.0, alpha: 0.5)
        // tabBarController子视图控制器集合
        //tabBarController.viewControllers = [weChat,addressBook,find]
        // 添加到rootViewController
        /*
         此处需要判断是否为第一次登陆？
         如果是，则跳到登陆界面。
         如果否，则跳到首页界面。
         */     
        let viewController = loginViewController()
        let nv = loginNavigationController(rootViewController: viewController)
        window?.rootViewController = nv
        window?.makeKeyAndVisible()
        

        let startImageView = AJStartView.init(imageName: "startView-1", timer: 3)
        self.window?.rootViewController?.view.addSubview(startImageView)
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


}

