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
        imageView.image = UIImage(named: "version")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = borderColor.cgColor
        return imageView
    }()
    
//    //登录的文字
//    private lazy var label:UILabel = {
//        let information = UILabel(frame: CGRect())
//        information.text = "Sign Up"
//        information.textAlignment = .center
//        information.font = UIFont.systemFont(ofSize: 18)
//        information.textColor = TextColor
//        return information
//    }()
    
    // 输入邮箱文本框
    lazy var emailTextField:UITextField = {
        let textField = UITextField()
        textField.initTextField(placeholder: " Email",keyboardType: .emailAddress)
//        let textField = initTextField(placeholder: " Email",keyboardType: .emailAddress)
        let imageView = UIImageView(image: UIImage(named: "email"))
        textField.leftView = imageView
        textField.leftViewMode = .always

        return textField
    }()
    
    // 输入验证码文本框
    lazy var authCodeTextField:UITextField = {
        let textField = UITextField()
        textField.initTextField(placeholder: " Code",keyboardType: .numberPad)
//        let textField = initTextField(placeholder: " Code",keyboardType: .numberPad)
        let imageView = UIImageView(image: UIImage(named: "email"))
        textField.leftView = imageView
        textField.leftViewMode = .always

        return textField
    }()
    
    // 获取验证码按钮
    lazy var getAuthCodeButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(" Send Code", for: .normal)
        button.backgroundColor = SendButtonColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    // 输入密码文本框
    lazy var passwordTextField:UITextField = {
        let textField = UITextField()
        textField.initTextField(placeholder: " Password",keyboardType: .default)
//        let textField = initTextField(placeholder: " Password",keyboardType: .default)
        textField.isSecureTextEntry = true
        let imageView = UIImageView(image: UIImage(named: "email"))
        textField.leftView = imageView
        textField.leftViewMode = .always

        return textField
    }()
    
    // 输入确认密码文本框
    lazy var passwordSecTextField:UITextField = {
        let textField = UITextField()
        textField.initTextField(placeholder: " Confirm the Password",keyboardType: .default)
//        let textField = initTextField(placeholder: " Confirm the Password",keyboardType: .default)
        textField.isSecureTextEntry = true
        let imageView = UIImageView(image: UIImage(named: "email"))
        textField.leftView = imageView
        textField.leftViewMode = .always

        return textField
    }()
    //免责条例的Logo
    lazy var NoResponseProtocolLogo:UIButton = {
        let NoResponseProtocol = UIButton(frame: CGRect())
        NoResponseProtocol.setImage(UIImage(named: "unselected"), for: .normal)
        NoResponseProtocol.setTitleColor(TextColor, for: .normal)
        return NoResponseProtocol
    }()
    //免责条例的用户信息
    lazy var NoResponseProtocolInfo:UIButton = {
        let NoResponseProtocol = UIButton(frame: CGRect())
        NoResponseProtocol.setTitle("Agreed \"Registration Protocol and submit the information\" ", for: .normal)
        NoResponseProtocol.setTitleColor(TextColor, for: .normal)
        NoResponseProtocol.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return NoResponseProtocol
    }()
    
    // 下一步按钮
    lazy var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = ButtonColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    

//    func initTextField(placeholder string:String,keyboardType type:UIKeyboardType) -> UITextField{
//        let textField = UITextField()
//        textField.placeholder = string
//        textField.textAlignment = .left
//        textField.keyboardType = type
//        textField.layer.borderColor = UIColor.gray.cgColor
//        textField.setValue(NSNumber(value: 10), forKey: "paddingLeft")
//        return textField
//    }
    
    func setupUI(){
        self.backgroundColor = ThemeColor
        // 艾康图标布局
        self.addSubview(AJImageView)
        AJImageView.snp.makeConstraints{(make) in
            make.width.equalTo(AJScreenWidth/2)
            make.height.equalTo(AJScreenWidth/5)
            make.left.equalTo(AJScreenWidth/4)
            make.right.equalTo(-AJScreenWidth/4)
            make.top.equalTo(AJScreenWidth/8)
        }
        
//        //登录文字布局
//        self.addSubview(label)
//        label.snp.makeConstraints{ (make) in
//            make.height.equalTo(20)
//            make.left.equalToSuperview().offset(AJScreenWidth/5)
//            make.right.equalToSuperview().offset(-AJScreenWidth/5)
//            make.top.equalTo(AJImageView.snp.bottom).offset(20)
//        }
        
        // 输入邮箱文本框布局
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints{(make) in
//            make.left.right.equalTo(userNameTextField)
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            make.right.equalToSuperview().offset(-AJScreenWidth/15)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(AJImageView.snp.bottom).offset(40)
        }
        
        let line_frame1 = UIView(frame: CGRect())
        line_frame1.backgroundColor = LineColor
        self.addSubview(line_frame1)
        line_frame1.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(emailTextField.snp.bottom).offset(1)
        }
        
        
        // 输入验证码文本框布局
        self.addSubview(authCodeTextField)
        authCodeTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            make.right.equalToSuperview().offset(-AJScreenWidth/7*3)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(emailTextField.snp.bottom).offset(AJScreenWidth/15)
        }
        
        let line_frame2 = UIView(frame: CGRect())
        line_frame2.backgroundColor = LineColor
        self.addSubview(line_frame2)
        line_frame2.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            make.right.equalToSuperview().offset(-AJScreenWidth/7*3)
            make.top.equalTo(authCodeTextField.snp.bottom).offset(1)
        }
        
        // 验证码按钮
        self.addSubview(getAuthCodeButton)
        getAuthCodeButton.snp.makeConstraints{(make) in
            make.left.equalTo(line_frame2.snp.right).offset(10)
            make.right.equalToSuperview().offset(-AJScreenWidth/15)
            make.height.equalTo(AJScreenWidth/12)
            make.centerY.equalTo(authCodeTextField.snp.centerY)
        }
        
        // 输入密码文本框布局
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(authCodeTextField.snp.bottom).offset(AJScreenWidth/15)
        }
        
        let line_frame3 = UIView(frame: CGRect())
        line_frame3.backgroundColor = LineColor
        self.addSubview(line_frame3)
        line_frame3.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(passwordTextField.snp.bottom).offset(1)
        }
        
        // 再次输入密码文本框布局
        self.addSubview(passwordSecTextField)
        passwordSecTextField.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(passwordTextField.snp.bottom).offset(AJScreenWidth/15)
        }
        
        let line_frame4 = UIView(frame: CGRect())
        line_frame4.backgroundColor = LineColor
        self.addSubview(line_frame4)
        line_frame4.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(passwordSecTextField.snp.bottom).offset(1)
        }
        
        self.addSubview(NoResponseProtocolLogo)
        NoResponseProtocolLogo.snp.makeConstraints{ (make) in
            make.height.equalTo(20)
            make.width.equalTo(AJScreenWidth/18)
            make.left.equalTo(AJScreenWidth/15)
            make.top.equalTo(line_frame4.snp.bottom).offset(5)
        }
        self.addSubview(NoResponseProtocolInfo)
        NoResponseProtocolInfo.snp.makeConstraints{ (make) in
            make.height.equalTo(20)
            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(NoResponseProtocolLogo.snp.right).offset(1)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(line_frame4.snp.bottom).offset(5)
        }
        
        // 下一步按钮
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints{(make) in
            make.left.right.equalTo(emailTextField)
            //make.right.equalTo(passwordTextField.snp.right)
            make.height.equalTo(AJScreenWidth/10)
            make.top.equalTo(passwordSecTextField.snp.bottom).offset(AJScreenHeight/8)
        }
        
        
        
    }
}



