//
//  portionAndInsulinView.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class portionAndInsulinView: UIView,UITextFieldDelegate {

    var PortionNum:Int = 2
    //**********************进餐量*********************
//    // 进餐量图标
//    private lazy var portionImageView:UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "事件")
//        return imageView
//    }()
    // 进餐量label
    private lazy var portionLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "Food")
        return label
    }()
    
//    // 进餐量选择按钮
//    lazy var portionButton:UIButton = {
//        let button = UIButton()
//        button.NorStyle(title: "(未指定)")
//        return button
//    }()
    private lazy var portionNoButton:UIButton = {
        let button = UIButton()
        button.setNormalStyle("No Meal", 0)
        button.addTarget(self, action: #selector(intensityChange(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var portionMuchButton:UIButton = {
        let button = UIButton()
        button.setNormalStyle("Too Much", 1)

        button.addTarget(self, action: #selector(intensityChange(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var portionNormalButton:UIButton = {
        let button = UIButton()
        button.setNormalStyle("Normal", 2)
        button.addTarget(self, action: #selector(intensityChange(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var portionLittleButton:UIButton = {
        let button = UIButton()
        button.setNormalStyle("Little", 3)
        button.addTarget(self, action: #selector(intensityChange(_:)), for: .touchUpInside)
        return button
    }()
    
    // 将选中的按钮高亮，其他按钮不高亮
    @objc func intensityChange(_ sender:UIButton){
        let buttons = [portionNoButton,portionMuchButton,portionNormalButton,portionLittleButton]
        for i in buttons{
            i.setDeselected()
        }
        sender.setSelected()
        PortionNum = sender.tag
    }
    
    // 初始化进餐量按钮的选择
    func initPortion(portion:Int){
        switch portion {
        case 0:
            intensityChange(portionNoButton)
        case 1:
            intensityChange(portionMuchButton)
        case 2:
            intensityChange(portionNormalButton)
        case 3:
            intensityChange(portionLittleButton)
        default:
            intensityChange(portionNormalButton)
        }
    }
    
    // **********************胰岛素***********************
    // 胰岛素label
    private lazy var insulinLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "Insulin")
        return label
    }()
    
    // 胰岛素选择按钮
    lazy var insulinButton:UIButton = {
        let button = UIButton(type: .system)
        button.NorStyle(title: "None")
        return button
    }()
    
    // 胰岛素量输入文本框
    lazy var insulinTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "")
        textfield.keyboardType = UIKeyboardType.decimalPad
        textfield.textAlignment = .center
        textfield.delegate = self
        //textfield.font = UIFont.systemFont(ofSize: 16)
        return textfield
    }()
    // 胰岛素单位label
    private lazy var insulinUnitLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "U")
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.sizeToFit()
        label.textColor = TextGrayColor
        return label
    }()
    
    

    func setupUI(){
        initPortion(portion: PortionNum)
        // 设置视图背景颜色和边框
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
//        self.backgroundColor = kRGBColor(130, 154, 249, 1)
        self.backgroundColor = UIColor.clear
        // **********************进餐量***********************
        
        // 进餐量label布局z设置
        self.addSubview(portionLabel)
        portionLabel.snp.makeConstraints{(make) in
            make.left.top.equalToSuperview().offset(AJScreenWidth/20)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/2)
        }
        
        // 进餐量选择按钮，共4个
        self.addSubview(portionNoButton)
        self.addSubview(portionMuchButton)
        self.addSubview(portionNormalButton)
        self.addSubview(portionLittleButton)
        
        portionNoButton.snp.makeConstraints{(make) in
            make.left.equalTo(portionLabel)
            make.width.equalTo(AJScreenWidth/5)
            make.height.equalTo(AJScreenWidth/15)
            make.top.equalTo(portionLabel.snp.bottom).offset(AJScreenWidth/40)
        }
        
        portionMuchButton.snp.makeConstraints{(make) in
            make.left.equalTo(portionNoButton.snp.right).offset(AJScreenWidth/30)
            make.width.equalTo(AJScreenWidth/5)
            make.top.bottom.equalTo(portionNoButton)
        }
        
        portionNormalButton.snp.makeConstraints{(make) in
            make.left.equalTo(portionMuchButton.snp.right).offset(AJScreenWidth/30)
            make.width.equalTo(AJScreenWidth/5)
            make.top.bottom.equalTo(portionNoButton)
        }
        
        portionLittleButton.snp.makeConstraints{(make) in
            make.left.equalTo(portionNormalButton.snp.right).offset(AJScreenWidth/30)
            make.width.equalTo(AJScreenWidth/5)
            make.top.bottom.equalTo(portionNoButton)
        }
        
        // **********************胰岛素***********************
        
        // 胰岛素label布局
        self.addSubview(insulinLabel)
        insulinLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.top.equalTo(portionNoButton.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/2)
        }
        // 胰岛素选择按钮
        self.addSubview(insulinButton)
        insulinButton.snp.makeConstraints{(make) in
            make.left.equalTo(insulinLabel)
            make.top.equalTo(insulinLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/5*3)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // 胰岛素值输入框布局
        self.addSubview(insulinTextfield)
        insulinTextfield.snp.makeConstraints{(make) in
            make.left.equalTo(insulinButton.snp.right).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/6)
            make.top.bottom.equalTo(insulinButton)

        }
        
        // 胰岛素单位label布局
        self.addSubview(insulinUnitLabel)
        insulinUnitLabel.snp.makeConstraints{(make) in
            make.left.equalTo(insulinTextfield.snp.right).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/40)
            make.top.bottom.equalTo(insulinButton)
        }
    }
    

    // 详细用法请看glucoseView中的注释
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let testString = ".0123456789"
        let char = NSCharacterSet.init(charactersIn: testString).inverted

        let inputString = string.components(separatedBy: char).joined(separator: "")

        if string == inputString{
            let numFrontDot:Int = 2
            let numAfterDot:Int = 3

            let futureStr:NSMutableString = NSMutableString(string: textField.text!)
            futureStr.insert(string, at: range.location)
            var flag = 0
            var flag1 = 0
            var dotNum = 0
            var isFrontDot = true
            
            if futureStr.length >= 1{
                // 如果第一个就是小数点，不能输入
                let char = Character(UnicodeScalar(futureStr.character(at:0))!)
                if char == "."{
                    return false
                }
                // 如果第一个为0，第二位不为小数点，不能输入
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
