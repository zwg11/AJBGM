//
//  chooseModelViewController.swift
//  On_Call
//
//  Created by Zwg on 2020/1/17.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class chooseModelViewController: UIViewController {
    
    
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
        self.tabBarController?.tabBar.isHidden = false
    }
    // 蓝牙输入模式选择
    private lazy var bleButton:UIButton = {
       let button = UIButton()
        button.modeStyle(title: "Bluetooth", image: "ble")
        return button
    }()
    // 手动输入模式选择
    private lazy var editButton:UIButton = {
       let button = UIButton()
        button.modeStyle(title: "Edit", image: "input")
        button.addTarget(self, action: #selector(modeClick(_ :)), for: .touchUpInside)
        return button
    }()
    
    @objc func modeClick(_ button:UIButton){
        editButton.setBackgroundImage(UIImage.init(named: "buttonnor"), for: .normal)
        bleButton.setBackgroundImage(UIImage.init(named: "buttonnor"), for: .normal)
        button.setBackgroundImage(UIImage.init(named: "buttonclick"), for: .normal)    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.title = "Input Mode"
        // Do any additional setup after loading the view.
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        // 添加两个按钮并设置布局
        self.view.addSubview(bleButton)
        self.view.addSubview(editButton)
        
        bleButton.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(44)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(44)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(44)
            }
        }
        
        editButton.snp.makeConstraints{(make) in
            make.left.right.height.equalTo(bleButton)
            make.top.equalTo(bleButton.snp.bottom).offset(38)
            
        }
    }
    

    

}
