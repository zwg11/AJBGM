//
//  registerView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
//
// **********************注册界面，需填写用户名、邮箱、邮箱验证码、密码**********************

import UIKit
import SnapKit

class registerView: UIView {

    // 艾康图标
    private lazy var AJImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AiKang")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = borderColor.cgColor
        return imageView
    }()
    
    // 输入用户文本框
    lazy var userNameTextField:UITextField = {
        let textField = initTextField(placeholder: " 输入用户名",keyboardType: .default)
        return textField
    }()
    
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
    
    // 输入密码文本框
    lazy var passwordTextField:UITextField = {
        let textField = initTextField(placeholder: " 密码",keyboardType: .default)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // 输入确认密码文本框
    lazy var passwordSecTextField:UITextField = {
        let textField = initTextField(placeholder: " 确认密码",keyboardType: .default)
        textField.isSecureTextEntry = true
        return textField
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
    

    func initTextField(placeholder string:String,keyboardType type:UIKeyboardType) -> UITextField{
        let textField = UITextField()
        textField.placeholder = string
        textField.textAlignment = .left
        textField.keyboardType = type
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        //textField.borderStyle = .bezel
        textField.layer.cornerRadius = 5
        textField.setValue(NSNumber(value: 10), forKey: "paddingLeft")
        
        return textField
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        // 艾康图标布局
        self.addSubview(AJImageView)
        AJImageView.snp.makeConstraints{(make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(AJScreenWidth/3*2)
        }
        
        // 输入用户文本框布局
        self.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/7)
            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(AJImageView.snp.bottom).offset(AJScreenWidth/20)
        }
        
        // 输入邮箱文本框布局
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.left.right.equalTo(userNameTextField)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(userNameTextField.snp.bottom).offset(AJScreenWidth/20)
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
        
        // 输入密码文本框布局
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.left.right.equalTo(userNameTextField)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(authCodeTextField.snp.bottom).offset(AJScreenWidth/20)
        }
        
        // 再次输入密码文本框布局
        self.addSubview(passwordSecTextField)
        passwordSecTextField.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.left.right.equalTo(userNameTextField)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(passwordTextField.snp.bottom).offset(AJScreenWidth/20)
        }
        
        // 下一步按钮
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints{(make) in
            make.left.right.equalTo(userNameTextField)
            //make.right.equalTo(passwordTextField.snp.right)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(passwordSecTextField.snp.bottom).offset(AJScreenWidth/20)
        }
        
        
        
    }
}
