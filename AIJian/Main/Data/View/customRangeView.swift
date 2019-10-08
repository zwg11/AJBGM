//
//  customRangeView.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/30.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class customRangeView: UIView {

    // 创建开始时间选择器
    lazy var startDatePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = UIColor.white
        datePicker.layer.borderColor = UIColor.gray.cgColor
        datePicker.layer.borderWidth = 1
        datePicker.locale = Locale(identifier: Locale.current.identifier)
        return datePicker
        
    }()
    
    // 创建结束时间选择器
    lazy var endDatePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = UIColor.white
        datePicker.layer.borderColor = UIColor.gray.cgColor
        datePicker.layer.borderWidth = 1
        // 获取本地时间，使得datePicker 日期与本地一致
        datePicker.locale = Locale(identifier: Locale.current.identifier)
        return datePicker
        
    }()
    
    lazy var startLabel:UILabel = {
        let label = UILabel()
        label.text = "input end date"
        label.textAlignment = .center
        label.textColor = UIColor.blue
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var endLabel:UILabel = {
        let label = UILabel()
        label.text = "input start date"
        label.textAlignment = .center
        label.textColor = UIColor.blue
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var endbutton:UIButton = {
        let button = UIButton()
        button.setTitle("Setting Date Range", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
     // 该视图包含2个时间选择器，2个label，一个按钮
    lazy var contentView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    // 该按钮为 该视图 出现时的背景
    // 实现点击背景 该视图 消失的效果
    private lazy var backButton:UIButton = {
        let button = UIButton.init(type: .system)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(dismissCustom), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight)
        return button
    }()
    // 实现点击背景 该视图 消失的效果
    @objc func dismissCustom(){
        print("back button 00000000 clicked")
        //backButton1.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    func setupUI(){
        self.addSubview(backButton)
        self.frame = CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight)
        self.backgroundColor = kRGBColor(0, 0, 0, 0.2)
        
        contentView.addSubview(startLabel)
        startLabel.snp.makeConstraints{(make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(20)
        }
        
        contentView.addSubview(startDatePicker)
        startDatePicker.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(startLabel.snp.bottom)
            make.height.equalTo(150)
        }
        
        contentView.addSubview(endLabel)
        endLabel.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(startDatePicker.snp.bottom)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(endDatePicker)
        endDatePicker.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(endLabel.snp.bottom)
            make.height.equalTo(150)
        }
        
        contentView.addSubview(endbutton)
        endbutton.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(endDatePicker.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        //contentView.backgroundColor = UIColor.yellow
        self.addSubview(contentView)
        contentView.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/5)
            make.right.equalToSuperview().offset(-AJScreenWidth/5)
            make.center.equalToSuperview()
            make.height.equalTo(400)
        }
        
        
    }

}
