//
//  sugComponent.swift
//  time
//
//  Created by ADMIN on 2019/9/8.
//  Copyright © 2019 xiaozuo. All rights reserved.
//  反馈中，用到的国家组件

import UIKit

class nationComponent: UIView {
    
    
    lazy var imageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "aboutUs")
        return image
    }()
    
//    var textField:UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "*************"
//        textField.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
//        return textField
//    }()
    lazy var nationButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(TextColor, for: .normal)
        button.setTitle("China", for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    func  setupUI(title:String){
        self.frame = CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight/15)
        nationButton.setTitle(title, for: .normal)
        
        self.addSubview(imageView)
        self.addSubview(nationButton)
        
        imageView.snp.makeConstraints{ (make) in
            make.width.equalTo(AJScreenHeight/15)
            make.height.equalTo(AJScreenHeight/15)
            //            make.left.equalTo(AJScreenWidth/25)
            make.left.equalToSuperview()
        }
        
        nationButton.snp.makeConstraints{ (make) in
            make.width.equalTo(AJScreenWidth*4/5)
            make.height.equalTo(AJScreenHeight/15)
            make.left.equalTo(imageView.snp.right).offset(5)
        }
        
        
    }
    
    
    
}
