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
    // 日期图标
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "riqi")
        return imageView
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
        // 日期图标布局
        self.addSubview(imageView)
        imageView.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.top.equalToSuperview().offset(AJScreenWidth/20)
            make.width.height.equalTo(AJScreenWidth/15)
        }
        
        // 日期按钮布局
        self.addSubview(dateButton)
        dateButton.snp.makeConstraints{(make) in
            make.left.equalTo(imageView.snp.right).offset(AJScreenWidth/40)
            make.height.top.equalTo(imageView)
            make.width.equalTo(AJScreenWidth/2)
        }
        
        // 时间按钮布局
        self.addSubview(timeButton)
        timeButton.snp.makeConstraints{(make) in
            make.left.equalTo(dateButton.snp.right).offset(AJScreenWidth/40)
            make.height.top.equalTo(imageView)
            make.width.equalTo(AJScreenWidth/5)
        }
    }

}
