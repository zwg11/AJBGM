//
//  sugComponent.swift
//  time
//
//  Created by ADMIN on 2019/9/8.
//  Copyright © 2019 xiaozuo. All rights reserved.
//  反馈中，用到的组件

import UIKit

class sugComponent: UIView {
    
    
    lazy var imageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Email")
        return image
    }()
    
    var textField:UITextField = {
        let textField = UITextField()
        textField.textColor = ThemeColor
        return textField
    }()
    
    
    func  setupUI(title:String){
        self.frame = CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight/15)
//        print("调用了组件层")
        let str:NSMutableAttributedString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        textField.attributedPlaceholder = str
//        textField.placeholder = title
        
        self.addSubview(imageView)
        self.addSubview(textField)
        
        imageView.snp.makeConstraints{ (make) in
            make.top.equalTo(AJScreenHeight/90)
            make.width.equalTo(AJScreenWidth/12)
            make.height.equalTo(AJScreenWidth/12)
            make.left.equalToSuperview()
        }
        
        textField.snp.makeConstraints{ (make) in
            make.top.equalTo(AJScreenHeight/90)
            make.width.equalTo(AJScreenWidth*4/5)
            make.height.equalTo(AJScreenWidth/12)
            make.left.equalTo(imageView.snp.right).offset(5)
        }
        
        
    }
    
    
    
}
