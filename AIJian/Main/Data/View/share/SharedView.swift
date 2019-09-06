//
//  SharedView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class SharedView: UIView {
    
    var date:String?
    // MARK: - 共享界面发送按钮及其说明
    // view框
    private lazy var explainView:UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        //view.layer.cornerRadius = AJScreenWidth/40
        return view
    }()
    // 按钮说明
    private lazy var explainLabel:UILabel = {
        let label = UILabel()
        label.text = "通过以下按钮，您可以使用电子邮件发送本报告"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    // 按钮，用来发d送报告
    lazy var sendButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("发送", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
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
        label.text = "本报告包含以下内容"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    // 姓名label
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.text = "姓名："
        label.textAlignment = .left
        return label
    }()
    // 姓名文本框
    lazy var nameTextField:UITextField = {

        let textField = UITextField()
        textField.placeholder = " 请输入姓名"
        textField.textAlignment = .left
        textField.keyboardType = .default
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.borderStyle = .line
        textField.setValue(NSNumber(value: 10), forKey: "paddingLeft")
        return textField
    }()
    // 出生日期label
    private lazy var birthdayLabel:UILabel = {
        let label = UILabel()
        label.text = "出生日期："
        label.textAlignment = .left
        return label
        
    }()
    // 选择出生日期的按钮，其实现弹出时间选择器视图
    lazy var birthdayButton:UIButton = {
        let button = UIButton()
        // 此处修改了***************************************
        //button.addTarget(chatViewController.self, action: #selector(chatViewController.chooseDate), for: .touchUpInside)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.setTitle(date ?? "请选择日期", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    

    
    func setupUI(){

        self.backgroundColor = UIColor.white
        UIView.setAnimationCurve(.linear)
        
        // MARK: - 发送按钮及其说明框
        self.addSubview(explainView)
        // 说明文本布局
        self.explainView.addSubview(explainLabel)
        self.explainLabel.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
            
        }
        // 发送按钮布局
        self.explainView.addSubview(sendButton)
        self.sendButton.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(AJScreenWidth/40)
            make.right.equalToSuperview().offset(-AJScreenWidth/40)
            make.top.equalTo(explainLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/12)
            
        }
        // 框布局
        self.explainView.snp.makeConstraints{
            (make) in
            make.left.equalToSuperview().offset(AJScreenWidth/40)
            make.right.equalToSuperview().offset(-AJScreenWidth/40)
            make.top.equalToSuperview().offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/4)
        }
        
        // MARK: - 发送报告信息框
        self.addSubview(reportInfo)
        // 标题说明布局
        self.reportInfo.addSubview(infoExpLabel)
        self.infoExpLabel.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalToSuperview()
        }
        // 姓名label
        self.reportInfo.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/40)
            make.top.equalTo(infoExpLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
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
            make.top.equalTo(nameTextField.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
            make.right.equalTo(infoExpLabel.snp.centerX)
        }
        // 设置出生日期按钮
        self.reportInfo.addSubview(birthdayButton)
        self.birthdayButton.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/40)
            make.right.equalToSuperview().offset(-AJScreenWidth/40)
            make.top.equalTo(birthdayLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/12)
        }
//        // 邮箱label
//        self.reportInfo.addSubview(emailLabel)
//        self.emailLabel.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/40)
//            make.top.equalTo(birthdayButton.snp.bottom).offset(AJScreenWidth/40)
//            make.height.equalTo(AJScreenWidth/15)
//            make.right.equalTo(infoExpLabel.snp.centerX)
//        }
//        // 邮箱文本框
//        self.reportInfo.addSubview(emailTextField)
//        self.emailTextField.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/40)
//            make.right.equalToSuperview().offset(-AJScreenWidth/40)
//            make.top.equalTo(emailLabel.snp.bottom).offset(AJScreenWidth/40)
//            make.height.equalTo(AJScreenWidth/12)
//        }
        
        //发送报告信息框布局
        self.reportInfo.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/40)
            make.right.equalToSuperview().offset(-AJScreenWidth/40)
            make.top.equalTo(explainView.snp.bottom).offset(AJScreenWidth/20)
            make.height.equalTo(AJScreenWidth/20*11)
        }

    }

}




