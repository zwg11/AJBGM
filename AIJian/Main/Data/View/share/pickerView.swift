//
//  pickerView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/29.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class pickerView: UIView {

    // 确定按钮和取消按钮
    // 确定按钮
    lazy var sureButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sure", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .right
        // 设置内边界，使得按钮的字体不那么靠右
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width/20)
        return button
    }()
    // 取消按钮
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width/20, bottom: 0, right: 0)
        //button.addTarget(chatViewController.self, action: #selector(chatViewController.pickViewDismiss), for: .touchUpInside)
        
        return button
    }()
    
    // 创建时间选择器
    lazy var datePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        //datePicker.frame.size = CGSize(width: UIScreen.main.bounds.width - 20, height: 150)
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        // 创建一个日期格式器
        let dateFormatter = DateFormatter()
        // 为格式器设置格式字符串,时间所属区域
        dateFormatter.dateFormat="yyyy年MM月dd日"
        datePicker.layer.borderColor = UIColor.gray.cgColor
        datePicker.layer.borderWidth = 1
        return datePicker
        
    }()
    
    func setupUI(){
        // 设置视图背景、边框
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        // 取消按钮布局
        self.addSubview(cancelButton)
        self.cancelButton.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width/3)
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/15)
        }
        // 确定按钮布局
        self.addSubview(sureButton)
        self.sureButton.snp.makeConstraints{(make) in
            make.right.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width/3)
            make.top.bottom.equalTo(cancelButton)
            //make.height.equalTo(UIScreen.main.bounds.height/15)
        }
        // 时间选择器布局
        self.addSubview(datePicker)
        self.datePicker.snp.makeConstraints{(make) in
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(sureButton.snp.bottom)
            //make.height.equalTo(self.frame.size.height/3 - UIScreen.main.bounds.height/15)
        }
        
    }

}
