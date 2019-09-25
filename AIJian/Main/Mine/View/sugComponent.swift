//
//  sugComponent.swift
//  time
//
//  Created by ADMIN on 2019/9/8.
//  Copyright © 2019 xiaozuo. All rights reserved.
//

import UIKit

class sugComponent: UIView {
    
    
    lazy var imageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "aboutUs")
        return image
    }()
    
    var textField:UITextField = {
        let textField = UITextField()
        let str:NSMutableAttributedString = NSMutableAttributedString(string: "*************", attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        textField.attributedPlaceholder = str
//        textField.placeholder = "*************"
//        textField.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
        return textField
    }()
    
    
    func  setupUI(title:String){
        self.frame = CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight/15)
        print("调用了组件层")
        textField.placeholder = title
        
        self.addSubview(imageView)
        self.addSubview(textField)
        
        imageView.snp.makeConstraints{ (make) in
            make.width.equalTo(AJScreenHeight/15)
            make.height.equalTo(AJScreenHeight/15)
//            make.left.equalTo(AJScreenWidth/25)
            make.left.equalToSuperview()
        }
        
        textField.snp.makeConstraints{ (make) in
            make.width.equalTo(AJScreenWidth/2)
            make.height.equalTo(AJScreenHeight/15)
            make.left.equalTo(imageView.snp.right).offset(5)
        }
        
        
    }
    
    
    
}
