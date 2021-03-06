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
        let textField = UITextField()
        textField.init_secondmethod_TextField(imageName: "mima", placeholder: "New Password")
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
    
    // 输入确认新密码文本框
    lazy var passwordSecTextField:UITextField = {
        let textField = UITextField()
        textField.init_secondmethod_TextField(imageName: "mima", placeholder: "Confirm the Password")
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
    
    // 确认修改按钮
    lazy var changeSureButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
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
//        textField.textColor = TextColor
//        textField.setValue(NSNumber(value: 10), forKey: "paddingLeft")
//        let str:NSMutableAttributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
//        textField.attributedPlaceholder = str
//        return textField
//    }

    func setupUI(){
        // 输入密码文本框布局
//        self.backgroundColor = ThemeColor
        
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/12)
            make.right.equalToSuperview().offset(-AJScreenWidth/12)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalToSuperview().offset(44)
        }
        
        let line_frame1 = UIView(frame: CGRect())
        line_frame1.backgroundColor = LineColor
        self.addSubview(line_frame1)
        line_frame1.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.left.equalTo(AJScreenWidth/12)
            make.right.equalTo(-AJScreenWidth/12)
            make.top.equalTo(passwordTextField.snp.bottom).offset(1)
        }
        
        // 再次输入密码文本框布局
        self.addSubview(passwordSecTextField)
        passwordSecTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/12)
            make.right.equalToSuperview().offset(-AJScreenWidth/12)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
        }
        
        let line_frame2 = UIView(frame: CGRect())
        line_frame2.backgroundColor = LineColor
        self.addSubview(line_frame2)
        line_frame2.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(AJScreenWidth/12)
            make.right.equalToSuperview().offset(-AJScreenWidth/12)
            make.top.equalTo(passwordSecTextField.snp.bottom).offset(1)
        }
        
        
        
        // 下一步按钮
        self.addSubview(changeSureButton)
        changeSureButton.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/12)
            make.right.equalToSuperview().offset(-AJScreenWidth/12)
            make.height.equalTo(AJScreenWidth/10)
            make.top.equalTo(passwordSecTextField.snp.bottom).offset(AJScreenHeight/3)
        }
    }
}
