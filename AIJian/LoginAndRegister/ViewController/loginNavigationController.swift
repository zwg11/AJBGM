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
        let img = UIImage(named: "bg")
//        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg")!)
        self.view.layer.contents = img?.cgImage
        self.view.backgroundColor = UIColor.clear
        
//        let login = loginViewController()
//        
//        // 向导航控制器压入控制器
//        self.setViewControllers([login], animated: true)
//        login.navigationItem.title = "登录"

        
    }
//
    func setNavBarAppearence()
    {
        // 设置 导航栏颜色 和 标题字体颜色
        //        self.navigationBar.barTintColor = UIColor.clear
        self.navigationBar.barTintColor = UIColor.init(patternImage: UIImage(named: "bg")!)
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: UIColor.white, forKey: NSAttributedString.Key.foregroundColor as NSCopying)
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as? [NSAttributedString.Key : Any]
        
    }


    

}
