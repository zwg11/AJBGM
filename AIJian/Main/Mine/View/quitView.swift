
//
//  quitView.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit


class quitView: UIView {

    public lazy var quitButton:UIButton = {
        let quitLogin = UIButton(type:.system)
        quitLogin.backgroundColor = UIColor.red
        quitLogin.setTitle("退出登录", for:.normal)
        quitLogin.layer.cornerRadius = 8
        quitLogin.layer.masksToBounds = true
        quitLogin.titleLabel?.font = UIFont.systemFont(ofSize:18)
        quitLogin.titleLabel?.textColor = UIColor.white
        return quitLogin
    }()
    
    public func setupUI(){
        
        self.addSubview(quitButton)
        quitButton.snp.makeConstraints{ (make) in
            make.top.equalTo(AJScreenHeight-AJScreenHeight/9)
            make.centerX.equalToSuperview()
            make.height.equalTo(AJScreenHeight/15)
            make.width.equalTo(AJScreenWidth)
        }
    }
}
