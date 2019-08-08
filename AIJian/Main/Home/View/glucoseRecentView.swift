//
//  glucoseRecentView.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class glucoseRecentView: UIView {

    private lazy var titleLabel:UILabel = {
        let label = initLabel(textContent: "血糖-最近7天", textFont: 20)
        return label
    }()
    
    private lazy var avgValueLabel:UILabel = {
        let label = initLabel(textContent: "6.0mmol/L", textFont: 18)

        return label
    }()
    
    private lazy var avgLabel:UILabel = {
        let label = initLabel(textContent: "平均值", textFont: 18)
        return label
    }()
    
    private lazy var checkNumLabel:UILabel = {
        let label = initLabel(textContent: "2",textFont: 18)

        label.sizeToFit()
        return label
    }()
    
    private lazy var checkLabel:UILabel = {
        let label = initLabel(textContent: "检测次数", textFont: 18)
        return label
    }()
    
    // 为方便初始化label
    func initLabel(textContent string:String,textFont font:CGFloat)->UILabel{
        let label = UILabel()
        label.text = string
        label.font = UIFont.systemFont(ofSize: font)
        label.textAlignment = .left
        label.backgroundColor = UIColor.yellow
        label.textColor = UIColor.black
        
        return label
    }
    
    func setupUI(){
        self.addSubview(titleLabel)
        // 设置视图边框
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        
        titleLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.width.equalTo(AJScreenWidth/2)
            make.top.equalToSuperview().offset(AJScreenWidth/20)
            make.height.equalTo(AJScreenWidth/15)
        }
        
        self.addSubview(avgValueLabel)
        avgValueLabel.snp.makeConstraints{(make) in
            make.left.equalTo(titleLabel.snp.left)
            make.width.equalTo(AJScreenWidth/4)
            make.top.equalTo(titleLabel.snp.bottom).offset(AJScreenWidth/20)
            make.height.equalTo(AJScreenWidth/15)
        }
        
        self.addSubview(avgLabel)
        avgLabel.snp.makeConstraints{(make) in
            make.left.equalTo(titleLabel.snp.left)
            make.width.equalTo(AJScreenWidth/4)
            make.top.equalTo(avgValueLabel.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
        }
        
        self.addSubview(checkNumLabel)
        checkNumLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self.snp.centerX).offset(AJScreenWidth/20)
            //make.width.equalTo(AJScreenWidth/4)
            make.top.equalTo(avgValueLabel.snp.top)
            make.height.equalTo(AJScreenWidth/15)
        }
        
        self.addSubview(checkLabel)
        checkLabel.snp.makeConstraints{(make) in
            make.left.equalTo(checkNumLabel.snp.left)
            make.width.equalTo(AJScreenWidth/4)
            make.top.equalTo(avgLabel.snp.top)
            make.height.equalTo(AJScreenWidth/15)
        }
        
    }

}
