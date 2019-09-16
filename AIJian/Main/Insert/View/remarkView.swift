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
    lazy var remarkTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.borderStyle = .line
        return textField
    }()
    
    
    func setupUI(){
        //*********************备注**********************
        self.backgroundColor = kRGBColor(130, 154, 249, 1)
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
        
        // 备注文本框布局
        self.addSubview(remarkTextField)
        remarkTextField.snp.makeConstraints{(make) in
            make.left.equalTo(AJScreenWidth/20)
            make.right.equalTo(-AJScreenWidth/20)
            make.top.equalTo(remarkLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/12)
        }
        
    }

}
