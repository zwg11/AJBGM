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
    
   
    override func viewDidLoad() {
        
        //图标
        let glucoseImage = UIImageView()
        glucoseImage.image = UIImage(named:"version")
        self.view.addSubview(glucoseImage)
        glucoseImage.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(AJScreenWidth/5)
            make.right.equalToSuperview().offset(-AJScreenWidth/5)
            make.height.equalTo(AJScreenWidth*2/5)
            make.top.equalTo(navigationBarHeight + AJScreenHeight / 7)
        }
        
        
        //图标下面的一条线
        let line = UIView(frame: CGRect())
        line.backgroundColor = UIColor.black
        self.view.addSubview(line)
        line.snp.makeConstraints{ (make) in
            make.height.equalTo(2)
            make.left.equalToSuperview().offset(AJScreenWidth/5)
            make.right.equalToSuperview().offset(-AJScreenWidth/5)
            make.top.equalTo(glucoseImage.snp.bottom).offset(5)
        }
        
        let information = UILabel(frame: CGRect())
        information.text = "On Call v1.0"
        information.textAlignment = .center
        information.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(information)
        information.snp.makeConstraints{ (make) in
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(AJScreenWidth/5)
            make.right.equalToSuperview().offset(-AJScreenWidth/5)
            make.top.equalTo(line.snp.bottom).offset(5)
        }
        
    }
    
    
}
