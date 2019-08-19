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
        self.title="Direction for use"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        
        let imageNameArray: [String] = ["yindao01", "yindao02","yindao03"]
        let guideView = PageView.init(imageNameArray: imageNameArray)
        self.view.addSubview(guideView)
        
    }
    
    @objc private func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
  
    
}

