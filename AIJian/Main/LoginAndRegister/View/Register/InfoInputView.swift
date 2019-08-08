//
//  InfoInputView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class InfoInputView: UIView {

    // 记录性别是否是男性
    var isMan:Bool = true
    // 记录出生日期
    var date:String?
    
    // 姓名label
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "姓 名"
        return label
    }()
    
    // 输入姓名文本框
    lazy var nameTextField:UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        return textField
        
    }()
    
    // 性别label
    private lazy var genderLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "性 别"
        return label
    }()
    
    // 选择男性的按钮
    lazy var manButton:UIButton = {
        let button = UIButton()

        button.setTitleColor(UIColor.black, for: .normal)
        //button.backgroundColor = UIColor.yellow
        button.setTitle("男", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.setImage(UIImage(named: "selected"), for: .normal)
        return button
    }()
    
    // 选择女性的按钮
    lazy var womanButton:UIButton = {
        let button = UIButton()
        
        button.setTitleColor(UIColor.black, for: .normal)
        //button.backgroundColor = UIColor.yellow
        button.setTitle("女", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.setImage(UIImage(named: "unselected"), for: .normal)
        return button
    }()
    
    // 出生日期label
    private lazy var birthdayLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "出生日期"
        return label
    }()
    
    // 选择出生日期的按钮，其实现弹出时间选择器视图
    lazy var birthdayButton:UIButton = {
        let button = UIButton()

        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.setTitle(date ?? "请选择日期", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // 完成注册按钮
    lazy var registerFinishButton:UIButton = {
        let button = UIButton()
        button.setTitle("完成注册", for: .normal)
        //button.setImage(UIImage(named: "xuanzhong-2"), for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // 设置布局函数
    func setupUI(){
        
        //**************** 三个label的布局****************
        // 左对齐父视图，宽度均为屏幕宽度的2/5
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(self.snp.top).offset(44)
            make.width.equalTo(AJScreenWidth/4)
        }
        
        self.addSubview(genderLabel)
        genderLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(nameLabel.snp.bottom).offset(AJScreenWidth/20)
            make.right.equalTo(nameLabel.snp.right)
        }
        
        self.addSubview(birthdayLabel)
        birthdayLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(genderLabel.snp.bottom).offset(AJScreenWidth/20)
            make.right.equalTo(nameLabel.snp.right)
        }
        
        // 姓名文本输入框
        self.addSubview(nameTextField)
        nameTextField.snp.makeConstraints{(make) in
            make.right.equalTo(self.snp.right).offset(-AJScreenWidth/7)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(nameLabel.snp.top)
            make.left.equalTo(nameLabel.snp.right).offset(AJScreenWidth/30)
        }
        
        // 性别选择按钮，分两个，点击时会改变图片为高亮，并且点击一个另一个状态会为正常
        self.addSubview(manButton)
        manButton.snp.makeConstraints{(make) in
            make.left.equalTo(nameTextField.snp.left)
            make.width.equalTo(AJScreenWidth/6)
            make.top.equalTo(genderLabel.snp.top)
            make.bottom.equalTo(genderLabel.snp.bottom)
            
        }
        
        self.addSubview(womanButton)
        womanButton.snp.makeConstraints{(make) in
            make.left.equalTo(manButton.snp.right).offset(15)
            make.width.equalTo(AJScreenWidth/6)
            make.top.equalTo(genderLabel.snp.top)
            make.bottom.equalTo(genderLabel.snp.bottom)
        }
        
        // 生日选择按钮
        self.addSubview(birthdayButton)
        birthdayButton.snp.makeConstraints{(make) in
            make.right.equalTo(nameTextField.snp.right)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(birthdayLabel.snp.top)
            make.left.equalTo(nameTextField.snp.left)
        }
        
        // 完成注册按钮
        self.addSubview(registerFinishButton)
        registerFinishButton.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            //make.right.equalTo(passwordTextField.snp.right)
            make.height.equalTo(AJScreenWidth/10)
            make.width.equalTo(AJScreenWidth/5*3)
            make.top.equalTo(birthdayButton.snp.bottom).offset(44)
        }
    }

}
