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

    // 体重label
    private lazy var weightLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "Weight")
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
        label.textColor = TextGrayColor
        label.text = GetUnit.getWeightUnit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //***********************血压***********************

    // 血压label
    private lazy var bloodPressureLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "Blood Pressure")
        return label
    }()
    // 收缩压 血压值输入文本框
     lazy var blood_sysPressureTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "SBP")
//        textfield.backgroundColor = UIColor.red
//        textfield.keyboardType = .numberPad
        textfield.textAlignment = .center
        //textfield.font = UIFont.systemFont(ofSize: 16)
        return textfield
    }()
    // 舒张压 血压值输入文本框
     lazy var blood_diaPressureTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "DBP")
//        textfield.backgroundColor = UIColor.yellow
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
        label.textColor = TextGrayColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // ***********************药物*********************

    // 药物label
    private lazy var medicineLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "Medications")
        return label
    }()
    
    // 药物选择按钮
    lazy var medicineChooseButton:UIButton = {
        let button = UIButton(type: .system)
        button.NorStyle(title: "None")
        return button
    }()
    
    // 药物编辑按钮
    lazy var medicineEditButton:UIButton = {
        let button = UIButton(type: .system)
        button.NorStyle(title: "Manually")
        return button
    }()
    
    func setupUI(){
        resetWeightAndPressureUnit()
        
        self.backgroundColor = UIColor.clear
        
        // 设置视图背景颜色和边框
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
//        self.backgroundColor = kRGBColor(130, 154, 249, 1)
        
        //***********************体重********************
        
        // 体重label布局z设置
        self.addSubview(weightLabel)
        weightLabel.snp.makeConstraints{(make) in
            make.left.top.equalToSuperview().offset(AJScreenWidth/20)
            make.width.equalTo(AJScreenWidth/2)
            make.height.equalTo(AJScreenWidth/15)
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
            make.width.equalTo(AJScreenWidth/15)
            make.bottom.equalTo(weightTextfield.snp.bottom)
            make.height.equalTo(weightTextfield.snp.height)
        }
        
        // 血压label布局设置
        self.addSubview(bloodPressureLabel)
        bloodPressureLabel.snp.makeConstraints{(make) in
            make.left.equalTo(weightLabel)
            make.top.equalTo(weightTextfield.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/2)
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
            make.width.equalTo(AJScreenWidth/8)
            make.bottom.top.equalTo(blood_diaPressureTextfield)

        }
        
        //***********************药物********************
        
        // 药物label布局
        self.addSubview(medicineLabel)
        medicineLabel.snp.makeConstraints{(make) in
            make.left.height.equalTo(weightLabel)
            make.top.equalTo(blood_sysPressureTextfield.snp.bottom).offset(AJScreenWidth/40)
        }
        
        // 药物选择按钮布局
        self.addSubview(medicineChooseButton)
        medicineChooseButton.snp.makeConstraints{(make) in
            make.left.equalTo(medicineLabel)
            make.top.equalTo(medicineLabel.snp.bottom).offset(AJScreenWidth/40)
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
        self.weightUnitLabel.text = GetUnit.getWeightUnit()
        self.bloodPressureUnitLabel.text = GetUnit.getPressureUnit()
        self.weightUnitLabel.textColor = TextGrayColor
        self.bloodPressureUnitLabel.textColor = TextGrayColor
        //设置体重单位
        if GetUnit.getWeightUnit() == "kg"{
//            self.weightUnitLabel.normalLabel(text: "kg")
            self.weightTextfield.keyboardType = UIKeyboardType.decimalPad //弹出带小数点的文本框
            
            
        }else{
//            self.weightUnitLabel.normalLabel(text: "lbs")
            self.weightTextfield.keyboardType = UIKeyboardType.numberPad  //弹出不带小数点的文本框
        }
        //设置血压单位
        if GetUnit.getPressureUnit() == "mmHg"{
//            self.bloodPressureUnitLabel.normalLabel(text: "mmHg")
            //不能有小数
            self.blood_sysPressureTextfield.keyboardType = UIKeyboardType.numberPad  //收缩压
            self.blood_diaPressureTextfield.keyboardType = UIKeyboardType.numberPad  //舒张压
        }else{
//            self.bloodPressureUnitLabel.normalLabel(text: "kPa")
            //可以有小数
            self.blood_sysPressureTextfield.keyboardType = UIKeyboardType.decimalPad
            self.blood_diaPressureTextfield.keyboardType = UIKeyboardType.decimalPad
        }
    }
    
    // *************** 详细用法请看glucoseView中的注释 *****************
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let testString = ".0123456789"
        let char = NSCharacterSet.init(charactersIn: testString).inverted
        
        let inputString = string.components(separatedBy: char).joined(separator: "")
        
        if string == inputString{
            var numFrontDot:Int = 2
            var numAfterDot:Int = 2
            if textField == weightTextfield{
                if GetUnit.getWeightUnit() == "kg"{
                    numFrontDot = 3
                    numAfterDot = 2
                }else{
                    numFrontDot = 3
                    numAfterDot = 0
                }
            }else{
                if GetUnit.getPressureUnit() == "kPa"{
                    numFrontDot = 2
                    numAfterDot = 2
                }else{
                    numFrontDot = 3
                    numAfterDot = 0
                }
            }
            
            let futureStr:NSMutableString = NSMutableString(string: textField.text!)
            futureStr.insert(string, at: range.location)
            var flag = 0
            var flag1 = 0
            var dotNum = 0
            var isFrontDot = true
            
            if futureStr.length >= 1{
                let char = Character(UnicodeScalar(futureStr.character(at:0))!)
                if char == "."{
                    return false
                }
                if futureStr.length >= 2{
                    let char2 = Character(UnicodeScalar(futureStr.character(at:1))!)
                    if char2 != "." && char == "0"{
                        return false
                    }
                }
            }
            
            if !futureStr.isEqual(to: ""){
                for i in 0..<futureStr.length{
                    let char = Character(UnicodeScalar(futureStr.character(at:i))!)
                    if char == "."{
                        isFrontDot = false
                        dotNum += 1
                        if dotNum > 1{
                            return false
                        }
                    }
                    if isFrontDot{
                        flag += 1
                        if flag > numFrontDot{
                            return false
                        }
                    }
                    else{
                        flag1 += 1
                        if flag1 > numAfterDot{
                            return false
                        }
                    }
                }
            }
            return true
            
        }else{
            return false
        }
    }
}
