//
//  emailCheckSecondView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
//
// ********************密码找回的输入新密码界面***********************

import UIKit
import SnapKit

class emailCheckSecondView: UIView {

    // 输入新密码文本框
    lazy var passwordTextField:UITextField = {
        let textField = initTextField(placeholder: "输入新密码",keyboardType: .default)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // 输入确认新密码文本框
    lazy var passwordSecTextField:UITextField = {
        let textField = initTextField(placeholder: "确认新密码",keyboardType: .default)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // 确认修改按钮
    lazy var changeSureButton:UIButton = {
        let button = UIButton()
        button.setTitle("确认修改", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        return button
    }()
    
    func initTextField(placeholder text:String,keyboardType type:UIKeyboardType) -> UITextField{
        let textField = UITextField()
        textField.placeholder = text
        textField.textAlignment = .left
        textField.keyboardType = type
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        //textField.borderStyle = .line
        textField.layer.cornerRadius = 5
        textField.setValue(NSNumber(value: 10), forKey: "paddingLeft")
        
        return textField
    }

    func setupUI(){
        // 输入密码文本框布局
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/7)
            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalToSuperview().offset(44)
        }
        
        // 再次输入密码文本框布局
        self.addSubview(passwordSecTextField)
        passwordSecTextField.snp.makeConstraints{(make) in
            //            make.left.equalToSuperview().offset(AJScreenWidth/7)
            //            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.left.right.equalTo(passwordTextField)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(passwordTextField.snp.bottom).offset(AJScreenWidth/20)
        }
        
        // 下一步按钮
        self.addSubview(changeSureButton)
        changeSureButton.snp.makeConstraints{(make) in
            make.left.right.equalTo(passwordTextField)
            //make.right.equalTo(passwordTextField.snp.right)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(passwordSecTextField.snp.bottom).offset(AJScreenWidth/20)
        }
    }
}
