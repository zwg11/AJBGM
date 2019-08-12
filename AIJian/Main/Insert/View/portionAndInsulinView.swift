//
//  portionAndInsulinView.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class portionAndInsulinView: UIView {

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
    
    // 进餐量选择按钮
    lazy var portionButton:UIButton = {
        let button = UIButton()
        button.NorStyle(title: "(未指定)")
        return button
    }()
    
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
    private lazy var insulinTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "")
        textfield.keyboardType = .numberPad
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
        // 设置视图背景颜色和边框
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.lightGray
        
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
        
        // 进餐量选择按钮
        self.addSubview(portionButton)
        portionButton.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(portionLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/2)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // **********************胰岛素***********************
        // 胰岛素图标布局
        self.addSubview(insulinImageView)
        insulinImageView.snp.makeConstraints{(make) in
            make.left.right.height.equalTo(portionImageView)
            make.top.equalTo(portionButton.snp.bottom).offset(AJScreenWidth/40)
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
