//
//  glucoseView.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class glucoseView: UIView ,UITextFieldDelegate{

    // 记录h血糖值
    var glucoseValue:Double = 0
    //***********************血糖********************
    // 血糖图标
    private lazy var XTimageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconxt")
        return imageView
    }()
    // 血糖label
    private lazy var XTLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "血糖")
        return label
    }()
    // 血糖值输入文本框
    private lazy var XTTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "")
        textfield.keyboardType = .numbersAndPunctuation
        textfield.textAlignment = .center
        textfield.addTarget(self, action: #selector(tfvalueChange), for: UIControl.Event.editingChanged)
        textfield.font = UIFont.systemFont(ofSize: 20)
        return textfield
    }()
    
    @objc func tfvalueChange(){
        if XTTextfield.text != nil{
            XTSlider.value = (XTTextfield.text! as NSString).floatValue
        }
        
    }
    // 血糖单位label
    private lazy var XTUnitLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "mmol/L")
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    // 血糖滑块
    private lazy var XTSlider:UISlider = {
        let slider = UISlider()
        slider.isContinuous = true
        slider.minimumValue = 0.6
        slider.maximumValue = 16.6
        slider.minimumTrackTintColor = UIColor.blue
        slider.maximumTrackTintColor = UIColor.white
        slider.addTarget(self, action: #selector(valueChange), for: UIControl.Event.valueChanged)
        slider.thumbTintColor = UIColor.blue
        return slider
    }()
    // 血糖滑块的动作
    @objc func valueChange(){
        glucoseValue = Double(XTSlider.value)
        // 结果保留1位小数
        XTTextfield.text = String(format:"%.1f",glucoseValue)
    }
    // 滑块左侧 - 符号
    private lazy var reduceLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "-")
        label.font = UIFont.systemFont(ofSize: 20)
        label.sizeToFit()
        return label
    }()
    // 滑块右侧 + 符号
    private lazy var addLabel:UILabel = {
        let label = UILabel()        
        label.normalLabel(text: "+")
        label.font = UIFont.systemFont(ofSize: 20)
        label.sizeToFit()
        return label
    }()
    //**********************************事件*************************
    // 事件图标
    private lazy var eventImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "事件")
        return imageView
    }()
    // 事件label
    private lazy var eventLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "事件")
        return label
    }()

    // 事件选择按钮
    lazy var eventButton:UIButton = {
        let button = UIButton()
        button.NorStyle(title: "无")
        return button
    }()
    
    func setupUI(){
        
        // 设置视图背景颜色和边框
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.lightGray
        
        //***********************血糖********************
        // 血糖图标布局设置
        self.addSubview(XTimageView)
        XTimageView.snp.makeConstraints{(make) in
            make.left.top.equalToSuperview().offset(AJScreenWidth/20)
            make.height.width.equalTo(AJScreenWidth/15)
        }
        
        // 血糖label布局z设置
        self.addSubview(XTLabel)
        XTLabel.snp.makeConstraints{(make) in
            make.left.equalTo(XTimageView.snp.right).offset(AJScreenWidth/40)
            make.centerY.equalTo(XTimageView.snp.centerY)
            make.height.equalTo(XTimageView.snp.height)
        }
        
        // 血糖值输入框布局
        self.addSubview(XTTextfield)
        XTTextfield.delegate = self
        XTTextfield.snp.makeConstraints{(make) in
            make.left.equalTo(XTLabel.snp.right).offset(AJScreenWidth/40)
            make.top.equalTo(XTLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/4)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // 血糖单位label布局
        self.addSubview(XTUnitLabel)
        XTUnitLabel.snp.makeConstraints{(make) in
            make.left.equalTo(XTTextfield.snp.right).offset(AJScreenWidth/40)
            make.bottom.equalTo(XTTextfield.snp.bottom)
            make.height.equalTo(XTTextfield.snp.height)
        }
        
        // 血糖值滑块布局
        self.addSubview(XTSlider)
        XTSlider.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(XTTextfield.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/4*3)
            make.height.equalTo(AJScreenWidth/15)
        }
        
        // 滑块两侧添加 - + 符号
        self.addSubview(reduceLabel)
        reduceLabel.snp.makeConstraints{(make) in
            make.right.equalTo(XTSlider.snp.left).offset(-AJScreenWidth/40)
            make.height.centerY.equalTo(XTSlider)
            
        }
        
        self.addSubview(addLabel)
        addLabel.snp.makeConstraints{(make) in
            make.left.equalTo(XTSlider.snp.right).offset(AJScreenWidth/40)
            make.height.centerY.equalTo(XTSlider)
            
        }
        //***********************事件********************
        // 事件图标布局
        self.addSubview(eventImageView)
        eventImageView.snp.makeConstraints{(make) in
            make.left.right.height.equalTo(XTimageView)
            make.top.equalTo(XTSlider.snp.bottom).offset(AJScreenWidth/40)
        }
        
        // 事件label布局
        self.addSubview(eventLabel)
        eventLabel.snp.makeConstraints{(make) in
            make.left.height.equalTo(XTLabel)
            make.bottom.equalTo(eventImageView)
        }
        
        // 事件按钮布局
        self.addSubview(eventButton)
        eventButton.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(eventLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/5*3)
            make.height.equalTo(AJScreenWidth/12)
        }
    }
    
    // 设置键盘按 return 键弹回
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
