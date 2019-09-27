//
//  AJTabbarController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class AJTabbarController: UITabBarController {

    var isLogin = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let Home = HomeViewController()
        let nv1 = AJNavigationController(rootViewController: Home)
        // 设置导航栏背景色，并且不渲染
        nv1.navigationBar.barTintColor = ThemeColor
        nv1.navigationBar.isTranslucent = false
        // 设置导航栏标题
        Home.navigationItem.title = "Home"
        //Home.navigationController?.navigationBar.tintColor = barDefaultColor
        //未选中状态的图标
        nv1.tabBarItem.image = UIImage(named: "zhuye.png")?.withRenderingMode(.alwaysOriginal)
        //选中状态的tab图标
        nv1.tabBarItem.selectedImage = UIImage(named: "zhuye-2.png")?.withRenderingMode(.alwaysOriginal)
        //tab的文本
        nv1.tabBarItem.title = "Home"
        self.addChild(nv1)
        
        
        let Data = DataViewController()
        Data.pageViewManager.titleView.currentIndex = 0
        let nv2 = AJNavigationController(rootViewController: Data)
        nv2.navigationBar.barTintColor = ThemeColor
        nv2.navigationBar.isTranslucent = false
        Data.navigationItem.title = "Data"
        nv2.tabBarItem.image = UIImage(named: "shuju.png")?.withRenderingMode(.alwaysOriginal)
        nv2.tabBarItem.selectedImage = UIImage(named: "shuju-2.png")?.withRenderingMode(.alwaysOriginal)
        nv2.tabBarItem.title = "Data"
        self.addChild(nv2)
        
        let BLE = BLEViewController()
        let nv3 = AJNavigationController(rootViewController: BLE)
        nv3.navigationBar.barTintColor = ThemeColor
        nv3.navigationBar.isTranslucent = false
        BLE.navigationItem.title = "Data Transfer"
        nv3.tabBarItem.image = UIImage(named: "shuru.png")?.withRenderingMode(.alwaysOriginal)
        nv3.tabBarItem.selectedImage = UIImage(named: "shuru-2.png")?.withRenderingMode(.alwaysOriginal)
        nv3.tabBarItem.title = "Add"
        self.addChild(nv3)
        
        let Mine = MineViewController()
        let nv4 = AJNavigationController(rootViewController: Mine)
        nv4.navigationBar.barTintColor = ThemeColor
        nv4.navigationBar.isTranslucent = false
        Mine.navigationItem.title = "Mine"
        nv4.tabBarItem.image = UIImage(named: "wode.png")?.withRenderingMode(.alwaysOriginal)
        nv4.tabBarItem.selectedImage = UIImage(named: "wode-2.png")?.withRenderingMode(.alwaysOriginal)
        nv4.tabBarItem.title = "Mine"
        self.addChild(nv4)
        
        // 设置tabbar背景颜色
        self.tabBar.barTintColor = ThemeColor
        
    }
    
    func isLoadData(){
        if isLogin{
            // 加载数据
        }else{
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
