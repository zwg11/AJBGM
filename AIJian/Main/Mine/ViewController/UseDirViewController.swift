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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Instruction"
        
        self.view.backgroundColor = ThemeColor
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        
        let imageNameArray: [String] = ["LaunchImage", "LaunchImage-1"]
        let guideView = PageView.init(imageNameArray: imageNameArray)
        self.view.addSubview(guideView)
        guideView.snp.remakeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
        }
        
    }
    
    @objc private func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
  
    
}

