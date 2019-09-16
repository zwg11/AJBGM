//
//  bodyInfoView.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class bodyInfoView: UIView ,UITextFieldDelegate{

    //********************体重********************
    // 体重图标
    private lazy var weightImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconxt")
        return imageView
    }()
    // 体重label
    private lazy var weightLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "体重")
        return label
    }()
    // 体重值输入文本框
     lazy var weightTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "")
//        textfield.keyboardType = .numbersAndPunctuation
        textfield.textAlignment = .center
        //textfield.font = UIFont.systemFont(ofSize: 16)
        return textfield
    }()
    
    // 体重单位label
    private  var weightUnitLabel:UILabel = {
        let label = UILabel()
        label.text = GetUnit.getWeightUnit()
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()

    //***********************身高***********************
    // 身高图标
    private lazy var heightImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconxt")
        return imageView
    }()
//    // 身高label
//     lazy var heightLabel:UILabel = {
//        let label = UILabel()
//        label.normalLabel(text: "身高")
//        return label
//    }()
//    // 身高值输入文本框
//     lazy var heightTextfield:UITextField = {
//        let textfield = UITextField()
//        textfield.norStyle(placeholder: "")
//        textfield.keyboardType = UIKeyboardType.decimalPad
////        textfield.keyboardType = .numbersAndPunctuation
//        textfield.textAlignment = .center
//        //textfield.font = UIFont.systemFont(ofSize: 16)
//        return textfield
//    }()
//    
//    // 身高单位label
//    private lazy var heightUnitLabel:UILabel = {
//        let label = UILabel()
//        label.normalLabel(text: "cm")
//        label.font = UIFont.systemFont(ofSize: 16)
//        
//        return label
//    }()
    
    //***********************血压***********************
    // 血压图标
    private lazy var bloodPressureImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconxt")
        return imageView
    }()
    // 血压label
    private lazy var bloodPressureLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "血压")
        return label
    }()
    // 收缩压 血压值输入文本框
     lazy var blood_sysPressureTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "")
//        textfield.keyboardType = .numberPad
        textfield.textAlignment = .center
        //textfield.font = UIFont.systemFont(ofSize: 16)
        return textfield
    }()
    // 舒张压 血压值输入文本框
     lazy var blood_diaPressureTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "")
//        textfield.keyboardType = .numberPad
        textfield.textAlignment = .center
        //textfield.font = UIFont.systemFont(ofSize: 16)
        return textfield
    }()
    
    // 收缩压 与 舒张压之间的分隔
    private lazy var spaceLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "/")
        label.textAlignment = .center
        return label
    }()
    
    // 血压单位label
    private lazy var bloodPressureUnitLabel:UILabel = {
        let label = UILabel()
        label.text = GetUnit.getPressureUnit()
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    // ***********************药物*********************
    // 药物图标
    private lazy var medicineImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "事件")
        return imageView
    }()
    // 药物label
    private lazy var medidineLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "药物")
        return label
    }()
    
    // 药物选择按钮
    lazy var medicineChooseButton:UIButton = {
        let button = UIButton()
        button.NorStyle(title: "无")
        return button
    }()
    
    // 药物编辑按钮
    lazy var medicineEditButton:UIButton = {
        let button = UIButton()
        button.NorStyle(title: "编辑")
        return button
    }()
    
    // 药物删除编辑按钮
    private lazy var medicineDeleteButton:UIButton = {
        let button = UIButton()
        button.NorStyle(title: "编辑")
        return button
    }()
    
    func setupUI(){
        
        // 设置视图背景颜色和边框
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = kRGBColor(130, 154, 249, 1)
        
        //***********************体重********************
        // 体重图标布局设置
        self.addSubview(weightImageView)
        weightImageView.snp.makeConstraints{(make) in
            make.left.top.equalToSuperview().offset(AJScreenWidth/20)
            make.height.width.equalTo(AJScreenWidth/15)
        }
        
        // 体重label布局z设置
        self.addSubview(weightLabel)
        weightLabel.snp.makeConstraints{(make) in
            make.left.equalTo(weightImageView.snp.right).offset(AJScreenWidth/40)
            make.centerY.equalTo(weightImageView.snp.centerY)
            make.height.equalTo(weightImageView.snp.height)
        }
        
        // 体重值输入框布局
        self.addSubview(weightTextfield)
        weightTextfield.delegate = self
        weightTextfield.snp.makeConstraints{(make) in
            make.left.equalTo(weightLabel.snp.left)
            make.top.equalTo(weightLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/5)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // 体重单位label布局
        self.addSubview(weightUnitLabel)
        weightUnitLabel.snp.makeConstraints{(make) in
            make.left.equalTo(weightTextfield.snp.right).offset(AJScreenWidth/40)
            make.bottom.equalTo(weightTextfield.snp.bottom)
            make.height.equalTo(weightTextfield.snp.height)
        }
        
//        //***********************身高********************
//        // 身高图标布局设置
//        self.addSubview(heightImageView)
//        heightImageView.snp.makeConstraints{(make) in
//            make.left.equalToSuperview().offset(AJScreenWidth/20)
//            make.top.equalTo(weightTextfield.snp.bottom).offset(AJScreenWidth/40)
//            make.height.width.equalTo(AJScreenWidth/15)
//        }
//
//        // 身高label布局z设置
//        self.addSubview(heightLabel)
//        heightLabel.snp.makeConstraints{(make) in
//            make.left.equalTo(heightImageView.snp.right).offset(AJScreenWidth/40)
//            make.centerY.equalTo(heightImageView.snp.centerY)
//            make.height.equalTo(heightImageView.snp.height)
//        }
//
//        // 身高值输入框布局
//        self.addSubview(heightTextfield)
//        heightTextfield.delegate = self
//        heightTextfield.snp.makeConstraints{(make) in
//            make.left.equalTo(weightLabel.snp.left)
//            make.top.equalTo(heightLabel.snp.bottom).offset(AJScreenWidth/40)
//            make.width.equalTo(AJScreenWidth/5)
//            make.height.equalTo(AJScreenWidth/12)
//        }
//
//        // 身高单位label布局
//        self.addSubview(heightUnitLabel)
//        heightUnitLabel.snp.makeConstraints{(make) in
//            make.left.equalTo(heightTextfield.snp.right).offset(AJScreenWidth/40)
//            make.bottom.equalTo(heightTextfield.snp.bottom)
//            make.height.equalTo(heightTextfield.snp.height)
//        }
        
        //***********************血压********************
        // 血压图标布局设置
        self.addSubview(bloodPressureImageView)
        bloodPressureImageView.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.top.equalTo(weightTextfield.snp.bottom).offset(AJScreenWidth/40)
            make.height.width.equalTo(AJScreenWidth/15)
        }
        
        // 血压label布局设置
        self.addSubview(bloodPressureLabel)
        bloodPressureLabel.snp.makeConstraints{(make) in
            make.left.equalTo(bloodPressureImageView.snp.right).offset(AJScreenWidth/40)
            make.centerY.equalTo(bloodPressureImageView.snp.centerY)
            make.height.equalTo(bloodPressureImageView.snp.height)
        }
        
        
        
        // 舒张压 血压值输入框布局,靠右
        self.addSubview(blood_diaPressureTextfield)
        blood_diaPressureTextfield.delegate = self
        blood_diaPressureTextfield.snp.makeConstraints{(make) in
            make.left.equalTo(weightTextfield.snp.right).offset(AJScreenWidth/20)
            make.top.equalTo(bloodPressureLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/5)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // 收缩压 血压值输入框布局，靠左
        self.addSubview(blood_sysPressureTextfield)
        blood_sysPressureTextfield.delegate = self
        blood_sysPressureTextfield.snp.makeConstraints{(make) in
            make.left.right.equalTo(weightTextfield)
            make.top.equalTo(bloodPressureLabel.snp.bottom).offset(AJScreenWidth/40)
            //make.width.equalTo(AJScreenWidth/5)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // 血压分隔label布局
        self.addSubview(spaceLabel)
        spaceLabel.snp.makeConstraints{(make) in
            make.right.equalTo(blood_diaPressureTextfield.snp.left)
            make.left.equalTo(blood_sysPressureTextfield.snp.right)
            make.top.bottom.equalTo(blood_diaPressureTextfield)
        }
        
        // 血压单位label布局  在收缩压右边
        self.addSubview(bloodPressureUnitLabel)
        bloodPressureUnitLabel.snp.makeConstraints{(make) in
            make.left.equalTo(blood_diaPressureTextfield.snp.right).offset(AJScreenWidth/40)

            make.bottom.top.equalTo(blood_diaPressureTextfield)

        }
        
        //***********************药物********************
        // 药物图标布局
        self.addSubview(medicineImageView)
        medicineImageView.snp.makeConstraints{(make) in
            make.left.right.height.equalTo(bloodPressureImageView)
            make.top.equalTo(blood_sysPressureTextfield.snp.bottom).offset(AJScreenWidth/40)
        }
        
        // 药物label布局
        self.addSubview(medidineLabel)
        medidineLabel.snp.makeConstraints{(make) in
            make.left.height.equalTo(bloodPressureLabel)
            make.bottom.equalTo(medicineImageView)
        }
        
        // 药物选择按钮布局
        self.addSubview(medicineChooseButton)
        medicineChooseButton.snp.makeConstraints{(make) in
            make.left.equalTo(medicineImageView.snp.left)
            make.top.equalTo(medidineLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/5*3)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // 药物添加按钮布局
        self.addSubview(medicineEditButton)
        medicineEditButton.snp.makeConstraints{(make) in
            make.left.equalTo(medicineChooseButton.snp.right).offset(10)
            make.top.equalTo(medicineChooseButton)
            make.width.equalTo(AJScreenWidth/8)
            make.height.equalTo(AJScreenWidth/12)
        }
    }
    
    // 设置键盘按 return 键弹回
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //重新设置单位
    func resetWeightAndPressureUnit(){
        //设置体重单位
        if GetUnit.getWeightUnit() == "kg"{
            self.weightUnitLabel.normalLabel(text: "kg")
            self.weightTextfield.keyboardType = UIKeyboardType.decimalPad //弹出带小数点的文本框
            
            
        }else{
            self.weightUnitLabel.normalLabel(text: "lbs")
            self.weightTextfield.keyboardType = UIKeyboardType.numberPad  //弹出不带小数点的文本框
        }
        //设置血压单位
        if GetUnit.getPressureUnit() == "mmHg"{
            self.bloodPressureUnitLabel.normalLabel(text: "mmHg")
            //不能有小数
            self.blood_sysPressureTextfield.keyboardType = UIKeyboardType.numberPad  //收缩压
            self.blood_diaPressureTextfield.keyboardType = UIKeyboardType.numberPad  //舒张压
        }else{
            self.bloodPressureUnitLabel.normalLabel(text: "kPa")
            //可以有小数
            self.blood_sysPressureTextfield.keyboardType = UIKeyboardType.decimalPad
            self.blood_diaPressureTextfield.keyboardType = UIKeyboardType.decimalPad
        }
    }
}
