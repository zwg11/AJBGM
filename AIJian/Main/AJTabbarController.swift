//
//  AJTabbarController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class AJTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let Home = HomeViewController()
        let nv1 = AJNavigationController(rootViewController: Home)
        Home.navigationItem.title = "Home"
        Home.navigationController?.navigationBar.tintColor = barDefaultColor
        //未选中状态的图标
        nv1.tabBarItem.image = UIImage(named: "zhuye.png")?.withRenderingMode(.alwaysOriginal)
        //选中状态的tab图标
        nv1.tabBarItem.selectedImage = UIImage(named: "zhuye-2.png")?.withRenderingMode(.alwaysOriginal)
        //tab的文本
        nv1.tabBarItem.title = "Home"
        self.addChild(nv1)
        
        
        let Data = DataViewController()
        let nv2 = AJNavigationController(rootViewController: Data)
        Data.navigationItem.title = "Data"
        nv2.tabBarItem.image = UIImage(named: "shuju.png")?.withRenderingMode(.alwaysOriginal)
        nv2.tabBarItem.selectedImage = UIImage(named: "shuju-2.png")?.withRenderingMode(.alwaysOriginal)
        nv2.tabBarItem.title = "Data"
        self.addChild(nv2)
        
        let Insert = InsertViewController()
        let nv3 = AJNavigationController(rootViewController: Insert)
        Insert.navigationItem.title = "Insert"
        nv3.tabBarItem.image = UIImage(named: "shuru.png")?.withRenderingMode(.alwaysOriginal)
        nv3.tabBarItem.selectedImage = UIImage(named: "shuru-2.png")?.withRenderingMode(.alwaysOriginal)
        nv3.tabBarItem.title = "Insert"
        self.addChild(nv3)
        
        let Mine = InsertViewController()
        let nv4 = AJNavigationController(rootViewController: Mine)
        Mine.navigationItem.title = "Mine"
        nv4.tabBarItem.image = UIImage(named: "wode.png")?.withRenderingMode(.alwaysOriginal)
        nv4.tabBarItem.selectedImage = UIImage(named: "wode-2.png")?.withRenderingMode(.alwaysOriginal)
        nv4.tabBarItem.title = "Mine"
        self.addChild(nv4)
        
        // 设置tabbar颜色
        self.tabBar.tintColor = barDefaultColor
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
