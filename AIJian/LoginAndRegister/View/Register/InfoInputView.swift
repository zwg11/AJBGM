//
//  InfoInputView.swift
//  AIJian
//
//  Created by zzz on 2019/8/18.
//  Copyright © 2019 apple. All rights reserved.
//  注册时，填写个人信息

import UIKit
import SnapKit

class InfoInputView: UIView {

//    /*用户名标签*/
//    lazy var username_label:UILabel = {
//        let username_label = UILabel(frame: CGRect())
//        username_label.text = "用户名"
//        username_label.font = UIFont.systemFont(ofSize: 18)
//        return username_label
//    }()
    
    // 输入用户名文本框
    lazy var userNameTextField:UITextField = {
        let textField = UITextField()
        textField.initTextField(placeholder: " Name",keyboardType: .default)
//        let textField = initTextField(placeholder: " Name",keyboardType: .default)
        let imageView = UIImageView(image: UIImage(named: "Name"))
        textField.leftView = imageView
        textField.leftViewMode = .always
//        textField.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
        return textField
    }()
    
    /*性别标签*/
    lazy var gender_label:UIButton = {
        let gender_man_label = UIButton(frame: CGRect())
        gender_man_label.setImage(UIImage(named: "Gender"), for: .normal)
        gender_man_label.setTitle(" Gender", for: .normal)
        gender_man_label.contentHorizontalAlignment = .left
        gender_man_label.setTitleColor(TextColor, for: .normal)
        gender_man_label.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return gender_man_label
    }()
    
    /*性别男标签*/
    lazy var gender_man_button:UIButton = {
        let gender_man_label = UIButton(frame: CGRect())
        gender_man_label.setImage(UIImage(named: "selected"), for: .normal)
        gender_man_label.setTitle("Male", for: .normal)
        gender_man_label.setTitleColor(TextColor, for: .normal)
//        gender_man_label.backgroundColor = UIColor.gray
        gender_man_label.titleLabel?.font = UIFont.systemFont(ofSize: 16)
       // gender_man_label.font = UIFont.systemFont(ofSize: 18)
        return gender_man_label
    }()
    /*性别女标签*/
    lazy var gender_woman_button:UIButton = {
        let gender_woman_button = UIButton(frame: CGRect())
        gender_woman_button.setImage(UIImage(named: "unselected"), for: .normal)
        gender_woman_button.setTitle("Female", for: .normal)
        gender_woman_button.setTitleColor(TextColor, for: .normal)
//       gender_woman_button.backgroundColor = UIColor.gray
        gender_woman_button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return gender_woman_button
    }()
    
    
//    /*身高标签*/
//    lazy var height_label:UILabel = {
//        let height_label = UILabel(frame: CGRect())
//        height_label.text = "身   高"
//        height_label.font = UIFont.systemFont(ofSize: 18)
//        return height_label
//    }()
//
//    // 输入身高文本框
//    lazy var heightTextField:UITextField = {
//        let textField = initTextField(placeholder: " 输入身高",keyboardType: .numberPad)
//        return textField
//    }()
//
//    /*身高单位标签*/
//    lazy var height_unit_label:UILabel = {
//        let height_unit_label = UILabel(frame: CGRect())
//        height_unit_label.text = "cm"
//        height_unit_label.font = UIFont.systemFont(ofSize: 18)
//        return height_unit_label
//    }()
//
//
//    /*体重标签*/
//    lazy var weight_label:UILabel = {
//        let weight_label = UILabel(frame: CGRect())
//        weight_label.text = "体   重"
//        weight_label.font = UIFont.systemFont(ofSize: 18)
//        return weight_label
//    }()
    
//    // 输入体重文本框
//    lazy var weightTextField:UITextField = {
//        let textField = initTextField(placeholder: " 输入体重",keyboardType: .numberPad)
//        return textField
//    }()
//
//    /*体重单位标签*/
//    lazy var weight_unit_label:UILabel = {
//        let weight_unit_label = UILabel(frame: CGRect())
//        weight_unit_label.text = "kg"
//        weight_unit_label.font = UIFont.systemFont(ofSize: 18)
//        return weight_unit_label
//    }()
//
    
//    /*国家标签*/
//    lazy var nation_label:UILabel = {
//        let nation_label = UILabel(frame: CGRect())
//        nation_label.text = "国   家"
//        nation_label.font = UIFont.systemFont(ofSize: 18)
//        return nation_label
//    }()
    
    // 输入国家文本框
//    lazy var nationTextField:UITextField = {
//        let textField = initTextField(placeholder: " China",keyboardType: .default)
//        let imageView = UIImageView(image: UIImage(named: "email"))
//        textField.leftView = imageView
//        textField.leftViewMode = .always
//        textField.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
//        return textField
//    }()
    lazy var nationButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Country"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        button.setTitleColor(TextColor, for: .normal)
        button.setTitle("China", for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    lazy var nationTextField:UITextField = {
        let textField = UITextField()
        textField.initTextField(placeholder: " China",keyboardType: .default)
//        let textField = initTextField(placeholder: " China",keyboardType: .default)
        let imageView = UIImageView(image: UIImage(named: "Country"))
        textField.leftView = imageView
        textField.leftViewMode = .always
//        textField.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
        return textField
    }()
    
//    /*电话标签*/
//    lazy var phone_label:UILabel = {
//        let phone_label = UILabel(frame: CGRect())
//        phone_label.text = "电   话"
//        phone_label.font = UIFont.systemFont(ofSize: 18)
//        return phone_label
//    }()
//
    // 输入电话文本框
    lazy var phoneTextField:UITextField = {
        let textField = UITextField()
        textField.initTextField(placeholder: " Phone",keyboardType: .numberPad)
//        let textField = initTextField(placeholder: " Phone",keyboardType: .emailAddress)
        let imageView = UIImageView(image: UIImage(named: "Phone"))
        textField.leftView = imageView
        textField.leftViewMode = .always
//        textField.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
        return textField
    }()
    
    /*出生日期标签*/
    lazy var brithday_label:UIButton = {
        let gender_woman_button = UIButton(frame: CGRect())
        gender_woman_button.setImage(UIImage(named: "Date-of-Birth"), for: .normal)
        gender_woman_button.setTitle(" Data of Birth", for: .normal)
        gender_woman_button.contentHorizontalAlignment = .left
        gender_woman_button.setTitleColor(TextColor, for: .normal)
        gender_woman_button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return gender_woman_button
    }()
    
    
    // 选择出生日期按钮
    lazy var dateButton:UIButton = {
        let button = UIButton()
        // 获取当前时间
        let now = Date()
        // 创建一个时间格式器
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        button.NorStyle(title: "\(dateFormatter.string(from: now))")
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    
    
    // 完成按钮
    lazy var finishButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = ButtonColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
//    //初始化textField的模板
//    func initTextField(placeholder string:String,keyboardType type:UIKeyboardType) -> UITextField{
//        let textField = UITextField()
//        textField.placeholder = string
//        textField.textAlignment = .left
//        textField.keyboardType = type
//
//        textField.setValue(NSNumber(value: 10), forKey: "paddingLeft")
//
//        return textField
//    }
    
    func setupUI(){
        
        // 用户名标签
//        self.addSubview(username_label)
//        username_label.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/7)
//           // make.right.equalToSuperview().offset(-AJScreenWidth/7)
//            make.height.equalTo(AJScreenWidth/12)
//            make.width.equalTo(AJScreenWidth/5)
//            make.top.equalToSuperview().offset(AJScreenHeight/15)
//        }
        
//        self.backgroundColor = ThemeColor
        // 输入用户名文本框布局
        self.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            make.right.equalToSuperview().offset(-AJScreenWidth/15)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalToSuperview().offset(AJScreenHeight/12)
        }
        
        let line_frame1 = UIView(frame: CGRect())
        line_frame1.backgroundColor = LineColor
        self.addSubview(line_frame1)
        line_frame1.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(userNameTextField.snp.bottom).offset(1)
        }
        
    
        // 性别标签
        self.addSubview(gender_label)
        gender_label.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            // make.right.equalToSuperview().offset(-AJScreenWidth/7)
            make.height.equalTo(AJScreenWidth/12)
            make.width.equalTo(AJScreenWidth/3)
//            make.top.equalToSuperview().offset(44)
            make.top.equalTo(userNameTextField.snp.bottom).offset(AJScreenWidth/11)
        }
        
        //男
        self.addSubview(gender_man_button)
        gender_man_button.snp.makeConstraints{ (make) in
            make.top.equalTo(userNameTextField.snp.bottom).offset(AJScreenWidth/11)
            make.left.equalTo(gender_label.snp.right).offset(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/5)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        //女
        self.addSubview(gender_woman_button)
        gender_woman_button.snp.makeConstraints{ (make) in
            make.top.equalTo(userNameTextField.snp.bottom).offset(AJScreenWidth/11)
            make.left.equalTo(gender_man_button.snp.right).offset(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/4)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        let line_frame2 = UIView(frame: CGRect())
        line_frame2.backgroundColor = LineColor
        self.addSubview(line_frame2)
        line_frame2.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(gender_label.snp.bottom).offset(1)
        }
        
//        //身高标签
//        self.addSubview(height_label)
//        height_label.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            // make.right.equalToSuperview().offset(-AJScreenWidth/7)
//            make.height.equalTo(AJScreenWidth/12)
//            make.width.equalTo(AJScreenWidth/5)
//            //            make.top.equalToSuperview().offset(44)
//            make.top.equalTo(gender_label.snp.bottom).offset(10)
//        }
//
//        // 输入身高文本框布局
//        self.addSubview(heightTextField)
//        heightTextField.snp.makeConstraints{(make) in
//            //            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            make.left.equalTo(height_label.snp_right).offset(10)
////            make.right.equalToSuperview().offset(-AJScreenWidth/7)
//            make.height.equalTo(AJScreenWidth/12)
//             make.top.equalTo(gender_label.snp.bottom).offset(10)
//        }
//
//        //身高单位标签
//        self.addSubview(height_unit_label)
//        height_unit_label.snp.makeConstraints{(make) in
//            //            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            make.left.equalTo(heightTextField.snp_right).offset(10)
//            make.right.equalToSuperview().offset(-AJScreenWidth/7)
//            make.height.equalTo(AJScreenWidth/12)
//            make.width.equalTo(AJScreenWidth/7)
//            make.top.equalTo(gender_label.snp.bottom).offset(10)
//        }
//
//        //体重标签
//        self.addSubview(weight_label)
//        weight_label.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            // make.right.equalToSuperview().offset(-AJScreenWidth/7)
//            make.height.equalTo(AJScreenWidth/12)
//            make.width.equalTo(AJScreenWidth/5)
//            //            make.top.equalToSuperview().offset(44)
//            make.top.equalTo(height_label.snp.bottom).offset(10)
//        }
//
//        // 输入体重文本框布局
//        self.addSubview(weightTextField)
//        weightTextField.snp.makeConstraints{(make) in
//            //            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            make.left.equalTo(weight_label.snp_right).offset(10)
////            make.right.equalToSuperview().offset(-AJScreenWidth/7)
//            make.height.equalTo(AJScreenWidth/12)
//             make.top.equalTo(height_label.snp.bottom).offset(10)
//        }
//
//        //体重单位标签
//        self.addSubview(weight_unit_label)
//        weight_unit_label.snp.makeConstraints{(make) in
//            make.left.equalTo(weightTextField.snp_right).offset(10)
//            make.right.equalToSuperview().offset(-AJScreenWidth/7)
//            make.height.equalTo(AJScreenWidth/12)
//            make.width.equalTo(AJScreenWidth/7)
//            make.top.equalTo(height_label.snp.bottom).offset(10)
//        }
        
//        //国家标签
//        self.addSubview(nation_label)
//        nation_label.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            // make.right.equalToSuperview().offset(-AJScreenWidth/7)
//            make.height.equalTo(AJScreenWidth/12)
//            make.width.equalTo(AJScreenWidth/5)
//            //            make.top.equalToSuperview().offset(44)
//            make.top.equalTo(weight_label.snp.bottom).offset(10)
//        }
//
        // 输入国家文本框布局
        self.addSubview(nationButton)
        nationButton.snp.makeConstraints{(make) in
            //            make.left.equalToSuperview().offset(AJScreenWidth/7)
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            make.right.equalToSuperview().offset(-AJScreenWidth/15)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(gender_label.snp.bottom).offset(AJScreenWidth/11)
        }
        
        let line_frame3 = UIView(frame: CGRect())
        line_frame3.backgroundColor = LineColor
        self.addSubview(line_frame3)
        line_frame3.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(nationButton.snp.bottom).offset(1)
        }
        
//        //电话标签
//        self.addSubview(phone_label)
//        phone_label.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/7)
//            // make.right.equalToSuperview().offset(-AJScreenWidth/7)
//            make.height.equalTo(AJScreenWidth/12)
//            make.width.equalTo(AJScreenWidth/5)
//            //            make.top.equalToSuperview().offset(44)
//            make.top.equalTo(nation_label.snp.bottom).offset(10)
//        }
//
        // 输入电话文本框布局
        self.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            make.right.equalToSuperview().offset(-AJScreenWidth/15)
            make.height.equalTo(AJScreenWidth/12)
            make.top.equalTo(nationButton.snp.bottom).offset(AJScreenWidth/11)
        }
        
        let line_frame4 = UIView(frame: CGRect())
        line_frame4.backgroundColor = LineColor
        self.addSubview(line_frame4)
        line_frame4.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(phoneTextField.snp.bottom).offset(1)
        }
        
        //出生日期标签
        self.addSubview(brithday_label)
        brithday_label.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            make.height.equalTo(AJScreenWidth/12)
            make.width.equalTo(AJScreenWidth/2)
            make.top.equalTo(phoneTextField.snp.bottom).offset(AJScreenWidth/11)
        }
        
        
        // 输入出生日期按钮布局
        self.addSubview(dateButton)
        dateButton.snp.makeConstraints{(make) in
            make.right.equalToSuperview().offset(-AJScreenWidth/15)
            make.height.equalTo(AJScreenWidth/12)
            make.width.equalTo(AJScreenWidth*2/5)
            make.top.equalTo(phoneTextField.snp.bottom).offset(AJScreenWidth/11)
        }
        
        

      //完成按钮
        self.addSubview(finishButton)
        finishButton.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            make.right.equalToSuperview().offset(-AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/15)
            make.top.equalToSuperview().offset(AJScreenHeight*12/15)
        }
    }

}
