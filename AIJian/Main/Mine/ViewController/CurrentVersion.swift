//
//  CurrentVersion.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/4.
//  Copyright © 2019 apple. All rights reserved.
//  当前版本页面

import Foundation
import SnapKit

class CurrentVersion:UIViewController{
    
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
        
        
        self.title = "Current Version"
//        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
      
        
        //图标
        let glucoseImage = UIImageView()
        glucoseImage.image = UIImage(named:"version")
        self.view.addSubview(glucoseImage)
        glucoseImage.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(AJScreenWidth/5)
            make.right.equalToSuperview().offset(-AJScreenWidth/5)
            make.height.equalTo(AJScreenWidth*2/5)
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(AJScreenHeight / 7)
        }
        
        
        //图标下面的一条线
        let line = UIView(frame: CGRect())
        line.backgroundColor = TextColor
        self.view.addSubview(line)
        line.snp.makeConstraints{ (make) in
            make.height.equalTo(2)
            make.left.equalToSuperview().offset(AJScreenWidth/8)
            make.right.equalToSuperview().offset(-AJScreenWidth/8)
            make.top.equalTo(glucoseImage.snp.bottom).offset(AJScreenHeight/20)
        }
        
        let information = UILabel(frame: CGRect())
        information.text = "On Call v1.0"
        information.textAlignment = .center
        information.textColor = TextColor
        information.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(information)
        information.snp.makeConstraints{ (make) in
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(AJScreenWidth/5)
            make.right.equalToSuperview().offset(-AJScreenWidth/5)
            make.top.equalTo(line.snp.bottom).offset(AJScreenHeight/30)
        }
        
    }
    @objc private func leftButtonClick(){
        //按返回的时候，需要将数据进行更新
        self.navigationController?.popViewController(animated: false)
    }
    
    
}
