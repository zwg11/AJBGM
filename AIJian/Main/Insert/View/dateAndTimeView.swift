//
//  dateAndTimeView.swift
//  st
//
//  Created by ADMIN on 2019/8/7.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class dateAndTimeView: UIView {
    // 日期label
    private lazy var dateLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "Date")
        return label
    }()
    
    // 时间label
    private lazy var TimeLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "Time")
        return label
    }()
    // 选择日期按钮
    lazy var dateButton:UIButton = {
        let button = UIButton()
        // 获取当前时间
        let now = Date()
        // 创建一个时间格式器
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        button.NorStyle(title: "\(dateFormatter.string(from: now))")
        return button
    }()
    // 选择时间按钮
    lazy var timeButton:UIButton = {
        let button = UIButton()
        // 获取当前时间
        let now = Date()
        // 创建一个时间格式器
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        button.NorStyle(title: "\(dateFormatter.string(from: now))")
        return button
    }()
    
    
    
    func setupUI(){
        self.backgroundColor = UIColor.clear
        
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
        // 日期label布局
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.top.equalToSuperview().offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/10)
        }
        
        
        
        // 日期按钮布局
        self.addSubview(dateButton)
        dateButton.snp.makeConstraints{(make) in
            make.left.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(dateLabel)
            make.right.equalToSuperview().offset(-AJScreenWidth/20)
        }
        
        // 时间label布局
        self.addSubview(TimeLabel)
        TimeLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.top.equalTo(dateButton.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/10)
        }
        
        // 时间按钮布局
        self.addSubview(timeButton)
        timeButton.snp.makeConstraints{(make) in
            make.left.right.equalTo(dateButton)
            make.top.equalTo(TimeLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(dateLabel)
        }
    }

}
