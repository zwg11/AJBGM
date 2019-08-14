//
//  remarkView.swift
//  st
//
//  Created by ADMIN on 2019/8/11.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class remarkView: UIView {

    // ***********************备注*********************
    // 备注图标
    private lazy var remarkImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "事件")
        return imageView
    }()
    // 备注label
    private lazy var remarkLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "备注")
        return label
    }()
    
    // 备注选择按钮
    lazy var remarkChooseButton:UIButton = {
        let button = UIButton()
        button.NorStyle(title: "无")
        return button
    }()
    
    // 备注编辑按钮
    private lazy var remarkEditButton:UIButton = {
        let button = UIButton()
        button.NorStyle(title: "编辑")
        return button
    }()
    
    
    func setupUI(){
        //*********************备注**********************
        self.backgroundColor = UIColor.lightGray
        // 备注图标布局
        self.addSubview(remarkImageView)
        remarkImageView.snp.makeConstraints{(make) in
            make.left.top.equalToSuperview().offset(AJScreenWidth/20)
            make.height.width.equalTo(AJScreenWidth/15)
        }
        
        // 备注label布局
        self.addSubview(remarkLabel)
        remarkLabel.snp.makeConstraints{(make) in
            make.left.equalTo(remarkImageView.snp.right).offset(AJScreenWidth/40)
            make.centerY.equalTo(remarkImageView.snp.centerY)
            make.height.equalTo(remarkImageView.snp.height)
        }
        
        // 备注选择按钮布局
        self.addSubview(remarkChooseButton)
        remarkChooseButton.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(remarkLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/5*3)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // 备注添加按钮布局
        self.addSubview(remarkEditButton)
        remarkEditButton.snp.makeConstraints{(make) in
            make.left.equalTo(remarkChooseButton.snp.right).offset(10)
            make.top.equalTo(remarkChooseButton)
            make.width.equalTo(AJScreenWidth/8)
            make.height.equalTo(AJScreenWidth/12)
        }
    }

}