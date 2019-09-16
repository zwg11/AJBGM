//
//  portionAndInsulinView.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class portionAndInsulinView: UIView {

    var PortionNum:Int = 2
    //**********************进餐量*********************
    // 进餐量图标
    private lazy var portionImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "事件")
        return imageView
    }()
    // 进餐量label
    private lazy var portionLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "进餐量")
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
        button.setTitle("No Meal", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setDeselected()
        button.tag = 0
        button.addTarget(self, action: #selector(intensityChange(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var portionMuchButton:UIButton = {
        let button = UIButton()
        button.setTitle("Too Much", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setDeselected()
        button.tag = 1
        button.addTarget(self, action: #selector(intensityChange(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var portionNormalButton:UIButton = {
        let button = UIButton()
        button.setTitle("Normal", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setDeselected()
        button.tag = 2
        button.addTarget(self, action: #selector(intensityChange(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var portionLittleButton:UIButton = {
        let button = UIButton()
        button.setTitle("Little", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setDeselected()
        button.tag = 3
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
            intensityChange(portionLittleButton)
        }
    }
    
    // **********************胰岛素***********************
    // 胰岛素图标
    private lazy var insulinImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "事件")
        return imageView
    }()
    // 胰岛素label
    private lazy var insulinLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "胰岛素")
        return label
    }()
    
    // 胰岛素选择按钮
    lazy var insulinButton:UIButton = {
        let button = UIButton()
        button.NorStyle(title: "无")
        return button
    }()
    
    // 胰岛素量输入文本框
    lazy var insulinTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "")
        textfield.keyboardType = UIKeyboardType.decimalPad
        textfield.textAlignment = .center
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
        
        return label
    }()
    
    

    func setupUI(){
        initPortion(portion: PortionNum)
        // 设置视图背景颜色和边框
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = kRGBColor(130, 154, 249, 1)
        
        // **********************进餐量***********************
        // 进餐量图标布局设置
        self.addSubview(portionImageView)
        portionImageView.snp.makeConstraints{(make) in
            make.left.top.equalToSuperview().offset(AJScreenWidth/20)
            make.height.width.equalTo(AJScreenWidth/15)
        }
        
        // 进餐量label布局z设置
        self.addSubview(portionLabel)
        portionLabel.snp.makeConstraints{(make) in
            make.left.equalTo(portionImageView.snp.right).offset(AJScreenWidth/40)
            make.centerY.equalTo(portionImageView.snp.centerY)
            make.height.equalTo(portionImageView.snp.height)
        }
        
//        // 进餐量选择按钮
//        self.addSubview(portionButton)
//        portionButton.snp.makeConstraints{(make) in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(portionLabel.snp.bottom).offset(AJScreenWidth/40)
//            make.width.equalTo(AJScreenWidth/2)
//            make.height.equalTo(AJScreenWidth/12)
//        }
        // 进餐量选择按钮，共4个
        self.addSubview(portionNoButton)
        self.addSubview(portionMuchButton)
        self.addSubview(portionNormalButton)
        self.addSubview(portionLittleButton)
        
        portionNoButton.snp.makeConstraints{(make) in
            make.left.equalTo(portionImageView)
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
        // 胰岛素图标布局
        self.addSubview(insulinImageView)
        insulinImageView.snp.makeConstraints{(make) in
            make.left.right.height.equalTo(portionImageView)
            make.top.equalTo(portionLittleButton.snp.bottom).offset(AJScreenWidth/40)
        }
        
        // 胰岛素label布局
        self.addSubview(insulinLabel)
        insulinLabel.snp.makeConstraints{(make) in
            make.left.equalTo(insulinImageView.snp.right).offset(AJScreenWidth/40)
            make.height.equalTo(insulinImageView)
            make.bottom.equalTo(insulinImageView)
        }
        // 胰岛素选择按钮
        self.addSubview(insulinButton)
        insulinButton.snp.makeConstraints{(make) in
            make.left.equalTo(insulinImageView)
            make.top.equalTo(insulinImageView.snp.bottom).offset(AJScreenWidth/40)
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
            make.centerY.equalTo(insulinButton)
            make.height.equalTo(insulinButton)
        }
    }
}
