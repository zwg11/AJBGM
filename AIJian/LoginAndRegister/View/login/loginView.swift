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
        imageView.image = UIImage(named: "version")
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = borderColor.cgColor
        return imageView
    }()
    
    //登录的文字
    private lazy var label:UILabel = {
        let information = UILabel(frame: CGRect())
        information.text = "Sign In"
        information.textAlignment = .center
        information.textColor = TextColor
        information.font = UIFont.systemFont(ofSize: 18)
        return information
    }()
    
    
    
    // 输入用户文本框
    lazy var userNameTextField:UITextField = {
        let textField = initTextField(imageName: "email", placeholder: "Email Address")
        textField.keyboardType = UIKeyboardType.emailAddress
        return textField
    }()
    // 输入密码文本框
    lazy var passwordTextField:UITextField = {
        let textField = initTextField(imageName: "mima", placeholder: "Password")
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        if #available(iOS 11.0, *) {
            textField.textContentType = UITextContentType.password;
        }
        if #available(iOS 12.0, *) {
            textField.textContentType = UITextContentType.newPassword;
        } else {
            // Fallback on earlier versions
        }
        return textField
    }()

    // 忘记密码按钮
    lazy var forgetPasswordButton:UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(TextColor, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    // 登录按钮
    lazy var loginwordButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = ButtonColor
        button.tintColor = UIColor.white
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        button.layer.cornerRadius = 5
        return button
    }()
    
    
    // 注册按钮
    lazy var registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("New here?Sign up", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(TextColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return button
    }()
    
    func initTextField(imageName image:String,placeholder text:String) -> UITextField{
        let textField = UITextField()
        let imageView = UIImageView(image: UIImage(named: image))
        textField.leftView = imageView
//        textField.placeholder = text
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = TextColor
        let str:NSMutableAttributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        textField.attributedPlaceholder = str
        return textField
    }
    
    func setupUI(){
//        self.backgroundColor = ThemeColor
        // 艾康图标布局
        self.addSubview(AJImageView)
        AJImageView.snp.makeConstraints{(make) in
//            make.width.equalTo(AJScreenWidth/2)
            make.height.equalTo(AJScreenWidth/5)
            make.left.equalTo(AJScreenWidth/5)
            make.right.equalTo(-AJScreenWidth/5)
            make.top.equalTo(navigationBarHeight)
        }
        
        //登录文字布局
        self.addSubview(label)
        label.snp.makeConstraints{ (make) in
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(AJScreenWidth/5)
            make.right.equalToSuperview().offset(-AJScreenWidth/5)
            make.top.equalTo(AJImageView.snp.bottom).offset(AJScreenWidth/20)
        }
        
        
        // 邮箱文本框布局
        self.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/12)
            make.right.equalToSuperview().offset(-AJScreenWidth/12)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(label.snp.bottom).offset(AJScreenWidth/5)
        }
        
        let line_frame1 = UIView(frame: CGRect())
        line_frame1.backgroundColor = LineColor
        self.addSubview(line_frame1)
        line_frame1.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
//            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(userNameTextField.snp.bottom).offset(1)
        }
        
        // 密码文本框布局
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/12)
            make.right.equalToSuperview().offset(-AJScreenWidth/12)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(userNameTextField.snp.bottom).offset(30)
        }
        
        let line_frame2 = UIView(frame: CGRect())
        line_frame2.backgroundColor = LineColor
        self.addSubview(line_frame2)
        line_frame2.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
//            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(passwordTextField.snp.bottom).offset(1)
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
            make.height.equalTo(AJScreenWidth/10)
            make.top.equalTo(forgetPasswordButton.snp.bottom).offset(AJScreenHeight/8)
        }
        
        // 注册按钮
        self.addSubview(registerButton)
        registerButton.snp.makeConstraints{(make) in
            make.centerX.equalTo(passwordTextField.snp.centerX)
            make.width.equalTo(AJScreenWidth/2)
            make.height.equalTo(AJScreenWidth/18)
            make.top.equalTo(loginwordButton.snp.bottom).offset(AJScreenWidth/30)
        }
        
    }
}
