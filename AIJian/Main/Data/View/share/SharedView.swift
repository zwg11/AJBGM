//
//  SharedView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class SharedView: UIView ,UITextFieldDelegate{
    
    var date:String?
    // MARK: - 共享界面发送按钮及其说明
    // 按钮说明
    private lazy var explainLabel:UILabel = {
        let label = UILabel()
        label.text = "Shared the Report by Email"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    // 按钮，用来发d送报告
    lazy var sendButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = UIColor.gray
        
        //button.addTarget(self, action: #selector(sendCheck), for: .touchUpInside)
        return button
    }()
    
    // 发送报告的动作
//    @objc func sendCheck(){
//        print("send.")
//        sendButton.setTitleColor(UIColor.red, for: .highlighted)
//    }
    
    // MARK: - 报告内容大致信息说明
    // view框
    private lazy var reportInfo:UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        //view.layer.cornerRadius = AJScreenWidth/40
        return view
    }()
    // 标题说明
    private lazy var infoExpLabel:UILabel = {
        let label = UILabel()
        label.text = "Information Including"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.white
        label.textAlignment = .left
        return label
    }()
    // 姓名label
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = UIColor.white
        label.textAlignment = .left
        return label
    }()
    // 姓名文本框
    lazy var nameTextField:UITextField = {

        let textField = UITextField()
        //textField.placeholder = " Please Input"
        textField.textAlignment = .left
        textField.keyboardType = .default
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.borderStyle = .line
        textField.delegate = self
        textField.setValue(NSNumber(value: 10), forKey: "paddingLeft")
        return textField
    }()
    // 电话label
    private lazy var birthdayLabel:UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.textColor = UIColor.white
        label.textAlignment = .left
        return label
        
    }()
    // 电话文本框
    lazy var phoneTextField:UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.keyboardType = .default
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.borderStyle = .line
        textField.setValue(NSNumber(value: 10), forKey: "paddingLeft")
        textField.delegate = self
        return textField
    }()
  
    func setupUI(){

        self.backgroundColor = UIColor.clear

        // MARK: - 发送报告信息框
        self.addSubview(reportInfo)
        // 标题说明布局
        self.addSubview(infoExpLabel)
        self.infoExpLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.top.equalToSuperview().offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalToSuperview()
        }
        // 姓名label
        self.reportInfo.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/40)
            make.top.equalToSuperview().offset(AJScreenWidth/30)
            make.height.equalTo(AJScreenWidth/18)
            make.right.equalTo(infoExpLabel.snp.centerX)
        }
        // 姓名文本框
        self.reportInfo.addSubview(nameTextField)
        self.nameTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/40)
            make.right.equalToSuperview().offset(-AJScreenWidth/40)
            make.top.equalTo(nameLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/12)
        }
        // 出生日期label
        self.reportInfo.addSubview(birthdayLabel)
        self.birthdayLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/40)
            make.top.equalTo(nameTextField.snp.bottom).offset(AJScreenWidth/30)
            make.height.equalTo(AJScreenWidth/18)
            make.right.equalTo(infoExpLabel.snp.centerX)
        }
        // 设置出生日期按钮
        self.reportInfo.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/40)
            make.right.equalToSuperview().offset(-AJScreenWidth/40)
            make.top.equalTo(birthdayLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        //发送报告信息框布局
        self.reportInfo.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.right.equalToSuperview().offset(-AJScreenWidth/20)
            make.top.equalTo(infoExpLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/2-AJScreenWidth/20)
        }
        
        // 说明文本布局
        self.addSubview(explainLabel)
        explainLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(reportInfo)
            make.top.equalTo(reportInfo.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
            
        }
        
        // 发送按钮布局
        self.addSubview(sendButton)
        sendButton.snp.makeConstraints{ (make) in
            make.left.right.equalTo(reportInfo)
            make.top.equalTo(explainLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/10)
            
        }

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




