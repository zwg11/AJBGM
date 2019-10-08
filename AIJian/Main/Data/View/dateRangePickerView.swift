//
//  dateRangePickerView.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/26.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class dateRangePickerView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rangeDate[row]
    }

    private let rangeDate:[String] = ["Last 3 days","Last 7 days","Last 30 days","Custom"]
    // 确定按钮和取消按钮
    // 确定按钮
    lazy var sureButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sure", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.contentHorizontalAlignment = .right
        // 设置内边界，使得按钮的字体不那么靠右
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width/20)
        return button
    }()
    // 取消按钮
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width/20, bottom: 0, right: 0)
        return button
    }()
    
    lazy var rangePicker:UIPickerView = {
       let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    var selectedContent:String?
    
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
        self.addSubview(rangePicker)
        rangePicker.snp.makeConstraints{(make) in
            make.right.left.bottom.equalToSuperview()
            
            make.top.equalTo(sureButton.snp.bottom)
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedContent = rangeDate[row]
    }

}
