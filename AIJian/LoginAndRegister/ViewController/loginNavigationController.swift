//
//  loginNavigationController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class loginNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarAppearence()
//        let login = loginViewController()
//        
//        // 向导航控制器压入控制器
//        self.setViewControllers([login], animated: true)
//        login.navigationItem.title = "登录"

        
    }
    
    func setNavBarAppearence()
    {
        
        // 设置 导航栏颜色 和 标题字体颜色
        self.navigationBar.barTintColor = barDefaultColor
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: UIColor.white, forKey: NSAttributedString.Key.foregroundColor as NSCopying)
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as? [NSAttributedString.Key : Any]
        
    }
    

    

}
