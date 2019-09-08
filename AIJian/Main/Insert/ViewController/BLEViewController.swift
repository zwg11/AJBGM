//
//  BLEViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/7.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class BLEViewController: UIViewController {
    
    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    // 点击左按钮的动作
    @objc func leftButtonClick(){
        // 设置返回首页
        self.tabBarController?.selectedIndex = 0
    }
    
    // 设置导航栏右按钮样式
    private lazy var rightButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "shuru"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        return button
    }()
    // 点击右按钮的动作
    @objc func rightButtonClick(){
        // 设置去手动输入界面
        let insert = InsertViewController()
        self.navigationController?.pushViewController(insert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        // 添加导航栏右按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        // Do any additional setup after loading the view.
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
