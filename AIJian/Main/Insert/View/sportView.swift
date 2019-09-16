//
//  sportView.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class sportView: UIView ,UITextFieldDelegate{

    var intensityLevel = 1
    //***************************运动*************************
    // 运动图标
    private lazy var sportImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "事件")
        return imageView
    }()
    // 运动label
    private lazy var sportLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "运动")
        return label
    }()
    
    // 运动选择按钮
    lazy var sportButton:UIButton = {
        let button = UIButton()
        button.NorStyle(title: "Nothing")
        return button
    }()
    //******************持续时间*****************
    // 持续时间label
    private lazy var timeOfDurationLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "持续时间")
        return label
    }()
    // 持续时间输入文本框
     lazy var timeOfDurationTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "")
//        textfield.keyboardType = .numbersAndPunctuation
        textfield.keyboardType = UIKeyboardType.numberPad
        textfield.textAlignment = .center
        //textfield.font = UIFont.systemFont(ofSize: 16)
        return textfield
    }()
    
    // 持续时间单位label
    private lazy var timeOfDurationUnitLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "分钟")
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    // ************************运动强度********************
    // 运动强度label
    private lazy var exerIntensityLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "运动强度")
        return label
    }()
    
//    // 运动强度选择按钮
//    lazy var exerIntensityButton:UIButton = {
//        let button = UIButton()
//        button.NorStyle(title: "(未指定)")
//        return button
//    }()
    private lazy var intensityLight:UIButton = {
        let button = UIButton()
        button.setTitle("Light", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)

        button.tag = 0
        button.setDeselected()
        button.addTarget(self, action: #selector(intensityChange(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var intensityMedium:UIButton = {
        let button = UIButton()
        button.setTitle("Medium", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)

        button.tag = 1
        button.setDeselected()
        button.addTarget(self, action: #selector(intensityChange(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var intensityHard:UIButton = {
        let button = UIButton()
        button.setTitle("Hard", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)

        button.tag = 2
        button.setDeselected()
        button.addTarget(self, action: #selector(intensityChange(_:)), for: .touchUpInside)
        return button
    }()
    
    
    // 将选中的按钮高亮，其他按钮不高亮
    @objc func intensityChange(_ sender:UIButton){
        let buttons = [intensityHard,intensityMedium,intensityLight]
        for i in buttons{
            i.setSelected()
        }
        sender.setDeselected()
        intensityLevel = sender.tag
    }
    
    func initIntensity(_ intensity:Int){
        if intensity == 0 {
            intensityChange(intensityLight)
        }else if intensity == 1 {
            intensityChange(intensityMedium)
        }else{
            intensityChange(intensityHard)
        }
    }

    func setupUI(){
        initIntensity(intensityLevel)
        // 设置视图背景颜色和边框
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = kRGBColor(130, 154, 249, 1)
        
        //***********************运动********************
        // 运动图标布局设置
        self.addSubview(sportImageView)
        sportImageView.snp.makeConstraints{(make) in
            make.left.top.equalToSuperview().offset(AJScreenWidth/20)
            make.height.width.equalTo(AJScreenWidth/15)
        }
        
        // 运动label布局z设置
        self.addSubview(sportLabel)
        sportLabel.snp.makeConstraints{(make) in
            make.left.equalTo(sportImageView.snp.right).offset(AJScreenWidth/40)
            make.centerY.equalTo(sportImageView.snp.centerY)
            make.height.equalTo(sportImageView.snp.height)
        }
        
        // 运动选择按钮
        self.addSubview(sportButton)
        sportButton.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/40)
            make.top.equalTo(sportLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/5*3)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        //***********************运动持续时间********************
        
        // 运动持续时间label布局设置
        self.addSubview(timeOfDurationLabel)
        timeOfDurationLabel.snp.makeConstraints{(make) in
            make.right.equalTo(sportLabel.snp.right)
            make.top.equalTo(sportButton.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // 运动持续时间输入框布局
        self.addSubview(timeOfDurationTextfield)
        timeOfDurationTextfield.delegate = self
        timeOfDurationTextfield.snp.makeConstraints{(make) in
            make.left.equalTo(timeOfDurationLabel)
            make.top.equalTo(timeOfDurationLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/5)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // 运动持续时间单位label布局
        self.addSubview(timeOfDurationUnitLabel)
        timeOfDurationUnitLabel.snp.makeConstraints{(make) in
            make.left.equalTo(timeOfDurationTextfield.snp.right).offset(AJScreenWidth/40)
            make.bottom.top.equalTo(timeOfDurationTextfield)
            make.height.equalTo(timeOfDurationTextfield.snp.height)
        }
        
        // ************************运动强度********************
        // 运动强度label布局设置
        self.addSubview(exerIntensityLabel)
        exerIntensityLabel.snp.makeConstraints{(make) in
            make.left.equalTo(timeOfDurationLabel)
            make.top.equalTo(timeOfDurationTextfield.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
        }
        
        // 运动强度选择按钮布局
//        self.addSubview(exerIntensityButton)
//
//        exerIntensityButton.snp.makeConstraints{(make) in
//            make.left.right.equalTo(sportButton)
//            make.bottom.equalTo(exerIntensityLabel.snp.top).offset(AJScreenWidth/40)
//            make.height.equalTo(AJScreenWidth/12)
//        }
        
        self.addSubview(intensityLight)
        self.addSubview(intensityMedium)
        self.addSubview(intensityHard)
        
        intensityLight.snp.makeConstraints{(make) in
            make.left.equalTo(exerIntensityLabel)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/5)
            make.top.equalTo(exerIntensityLabel.snp.bottom).offset(AJScreenWidth/40)
        }
        
        intensityMedium.snp.makeConstraints{(make) in
            make.left.equalTo(intensityLight.snp.right).offset(AJScreenWidth/30)
            make.width.equalTo(AJScreenWidth/5)
            make.top.bottom.equalTo(intensityLight)
        }
        
        intensityHard.snp.makeConstraints{(make) in
            make.left.equalTo(intensityMedium.snp.right).offset(AJScreenWidth/30)
            make.width.equalTo(AJScreenWidth/5)
            make.top.bottom.equalTo(intensityLight)
        }
    }
    
    // 设置键盘按 return 键弹回
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
