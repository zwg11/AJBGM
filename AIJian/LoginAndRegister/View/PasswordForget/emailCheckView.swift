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
        let textField = UITextField()
        textField.initTextField(placeholder: " Email",keyboardType: .emailAddress)
        let imageView = UIImageView(image: UIImage(named: "email"))
        textField.leftView = imageView
        textField.leftViewMode = .always
//        textField.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
        return textField
    }()
    
    // 输入验证码文本框
    lazy var authCodeTextField:UITextField = {
        let textField = UITextField()
        textField.initTextField(placeholder: " Code",keyboardType: .default)
//        let textField = initTextField(placeholder: " Code",keyboardType: .numberPad)
        let imageView = UIImageView(image: UIImage(named: "mima"))
        textField.leftView = imageView
        textField.leftViewMode = .always
//        textField.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
        return textField
    }()
    
    // 获取验证码按钮
    lazy var getAuthCodeButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(" Send Code", for: .normal)
        //这个验证码按钮的颜色，和其他按钮的颜色不同
        button.backgroundColor = SendButtonColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
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



//    func initTextField(placeholder text:String,keyboardType type:UIKeyboardType) -> UITextField{
//        let textField = UITextField()
//        textField.placeholder = text
//        textField.textAlignment = .left
//        textField.keyboardType = type
//        textField.layer.borderColor = UIColor.gray.cgColor
//        textField.setValue(NSNumber(value: 10), forKey: "paddingLeft")
//
//        return textField
//    }



    func setupUI(){
        // 输入邮箱文本框布局
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/12)
            make.right.equalToSuperview().offset(-AJScreenWidth/12)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalToSuperview().offset(AJScreenHeight/12)
        }
        let line_frame1 = UIView(frame: CGRect())
        line_frame1.backgroundColor = LineColor
        self.addSubview(line_frame1)
        line_frame1.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.left.equalTo(AJScreenWidth/12)
            make.right.equalTo(-AJScreenWidth/12)
            make.top.equalTo(emailTextField.snp.bottom).offset(1)
        }
   
        // 输入验证码文本框布局
        self.addSubview(authCodeTextField)
        authCodeTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/12)
            make.right.equalToSuperview().offset(-AJScreenWidth/7*3)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(emailTextField.snp.bottom).offset(AJScreenWidth/20)
        }
        
        let line_frame2 = UIView(frame: CGRect())
        line_frame2.backgroundColor = LineColor
        self.addSubview(line_frame2)
        line_frame2.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(AJScreenWidth/12)
            make.right.equalToSuperview().offset(-AJScreenWidth/7*3)
            make.top.equalTo(authCodeTextField.snp.bottom).offset(1)
        }
        
        
        // 验证码按钮
        self.addSubview(getAuthCodeButton)
        getAuthCodeButton.snp.makeConstraints{(make) in
            make.right.equalTo(emailTextField.snp.right)
            make.left.equalTo(authCodeTextField.snp.right).offset(15)
            make.height.equalTo(AJScreenWidth/12)
            make.centerY.equalTo(authCodeTextField.snp.centerY)
        }
        
        // 下一步按钮
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/12)
            make.right.equalToSuperview().offset(-AJScreenWidth/12)
            make.height.equalTo(AJScreenWidth/10)
            make.top.equalTo(authCodeTextField.snp.bottom).offset(AJScreenHeight/3)
        }
    }
}
