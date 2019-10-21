//
//  UseDirViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  用户使用指导页

import UIKit
import AVFoundation
import MediaPlayer


class UseDirViewController: UIViewController {

    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Instruction"
        
//        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let imageArray1: [String] = ["yindao01","yindao02"]
        let guideView = PageView.init(imageNameArray: imageArray1)
        self.view.addSubview(guideView)
        guideView.snp.remakeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
        }
        
    }
    
    @objc private func leftButtonClick(){
        self.navigationController?.popViewController(animated: false)
    }
    
    
  
    
}

