//
//  emailCheckView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
//
// *******************密码找回的邮箱验证界面，需输入邮箱和验证码验证邮箱**********************

import UIKit
import SnapKit

class emailCheckView: UIView {
    
    // 输入邮箱文本框
    lazy var emailTextField:UITextField = {
        let textField = initTextField(placeholder: " 输入邮箱",keyboardType: .emailAddress)
        return textField
    }()
    
    // 输入验证码文本框
    lazy var authCodeTextField:UITextField = {
        let textField = initTextField(placeholder: " 输入验证码",keyboardType: .numberPad)
        return textField
    }()
    
    // 获取验证码按钮
    lazy var getAuthCodeButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(" 获取验证码", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    // 下一步按钮
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("下一步", for: .normal)
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
        // 输入邮箱文本框布局
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/7)
            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalToSuperview().offset(44)
        }
        
        // 输入验证码文本框布局
        self.addSubview(authCodeTextField)
        authCodeTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/7)
            make.right.equalToSuperview().offset(-AJScreenWidth/7*3)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(emailTextField.snp.bottom).offset(AJScreenWidth/20)
        }
        
        // 验证码按钮
        self.addSubview(getAuthCodeButton)
        getAuthCodeButton.snp.makeConstraints{(make) in
            make.right.equalTo(emailTextField.snp.right)
            make.left.equalTo(authCodeTextField.snp.right).offset(15)
            make.height.equalTo(AJScreenWidth/18)
            make.centerY.equalTo(authCodeTextField.snp.centerY)
        }
        
        // 下一步按钮
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints{(make) in
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(authCodeTextField.snp.bottom).offset(AJScreenWidth/20)
        }
    }
}
