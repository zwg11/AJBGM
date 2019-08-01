//
//  loginView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/30.
//  Copyright © 2019 apple. All rights reserved.
//
// **************************登录界面，填写用户名和密码，支持用户注册和密码找回****************

import UIKit
import SnapKit

class loginView: UIView {

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
        let textField = initTextField(imageName: "email", placeholder: "请输入用户名")
        return textField
    }()
    // 输入密码文本框
    lazy var passwordTextField:UITextField = {
        let textField = initTextField(imageName: "mima", placeholder: "请输入密码")
        textField.keyboardType = .default
        textField.isSecureTextEntry = true

        return textField
    }()

    // 忘记密码按钮
    lazy var forgetPasswordButton:UIButton = {
        let button = UIButton()
        button.setTitle("忘记密码", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    // 登录按钮
    lazy var loginwordButton:UIButton = {
        let button = UIButton()
        button.setTitle("登录", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // 注册按钮
    lazy var registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("新用户注册", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return button
    }()
    
    func initTextField(imageName image:String,placeholder text:String) -> UITextField{
        let textField = UITextField()
        let imageView = UIImageView(image: UIImage(named: image))
        textField.leftView = imageView
        textField.placeholder = text
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        return textField
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.white
        // 艾康图标布局
        self.addSubview(AJImageView)
        AJImageView.snp.makeConstraints{(make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(AJScreenWidth)
        }
        
        // 邮箱文本框布局
        self.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/7)
            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(AJImageView.snp.bottom).offset(AJScreenWidth/20)
        }
        
        // 密码文本框布局
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/7)
            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(userNameTextField.snp.bottom).offset(AJScreenWidth/20)
        }
        
        // 忘记密码按钮
        self.addSubview(forgetPasswordButton)
        forgetPasswordButton.snp.makeConstraints{(make) in
            make.right.equalTo(passwordTextField.snp.right)
            make.height.equalTo(AJScreenWidth/18)
            make.top.equalTo(passwordTextField.snp.bottom).offset(AJScreenWidth/30)
        }
        
        // 登录按钮
        self.addSubview(loginwordButton)
        loginwordButton.snp.makeConstraints{(make) in
            make.left.right.equalTo(passwordTextField)
            //make.right.equalTo(passwordTextField.snp.right)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(forgetPasswordButton.snp.bottom).offset(AJScreenWidth/20)
        }
        
        // 注册按钮
        self.addSubview(registerButton)
        registerButton.snp.makeConstraints{(make) in
            make.centerX.equalTo(passwordTextField.snp.centerX)
            make.height.equalTo(AJScreenWidth/18)
            make.top.equalTo(loginwordButton.snp.bottom).offset(AJScreenWidth/30)
        }
        
    }
}
