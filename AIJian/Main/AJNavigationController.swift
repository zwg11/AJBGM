//
//  AJNavigationController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class AJNavigationController: UINavigationController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarAppearence()
        //navigationController

//        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "bg")!)
        let img = UIImage(named: "bg")
        self.view.layer.contents = img?.cgImage
        self.view.backgroundColor = UIColor.clear

        
    }

    func setNavBarAppearence()
    {
//        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationBar.shadowImage = UIImage()
//        self.navigationBar.isTranslucent = false
        
        // 设置 导航栏颜色 和 标题字体颜色
//        self.navigationBar.barTintColor = kRGBColor(0, 0, 0, 0)
//        self.navigationBar.tintColor = kRGBColor(0, 0, 0, 0)
//        self.navigationBar.barTintColor = UIColor.init(patternImage: UIImage(named: "bg")!)
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: UIColor.white, forKey: NSAttributedString.Key.foregroundColor as NSCopying)
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as? [NSAttributedString.Key : Any]    
    
    }
}
extension AJNavigationController
{
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    // 设置页面横竖屏
   override var shouldAutorotate: Bool {
        return self.visibleViewController?.shouldAutorotate ?? false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.visibleViewController?.supportedInterfaceOrientations ?? .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.visibleViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
}
