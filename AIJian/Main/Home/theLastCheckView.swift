//
//  theLastCheckView.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class theLastCheckView: UIView {

    private lazy var titleLabel:UILabel = {
        let label = initLabel(textContent: "最近一次检测结果", textFont: 20)
        return label
    }()

    private lazy var dateImage:UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "riqi")
        return imageview
    }()
    
    private lazy var dateLabel:UILabel = {
        let label = initLabel(textContent: "日期", textFont: 18)
        return label
    }()
    
    private lazy var glucoseImage:UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "血糖")
        return imageview
    }()
    
    private lazy var glucoseResultLabel:UILabel = {
        let label = initLabel(textContent: "血糖结果", textFont: 18)
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
        self.backgroundColor = UIColor.clear
        self.addSubview(titleLabel)
        // 最近一次检测结果label
        titleLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.top.equalToSuperview().offset(AJScreenWidth/20)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/2)
            
        }
        
        self.addSubview(dateImage)

        //日期图标
        dateImage.snp.makeConstraints{(make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(AJScreenWidth/20)
            make.height.width.equalTo(AJScreenWidth/15)
            
            
        }
        
        self.addSubview(dateLabel)
        // 日期label
        dateLabel.snp.makeConstraints{(make) in
            make.left.equalTo(dateImage.snp.right).offset(AJScreenWidth/40)
            make.centerY.equalTo(dateImage.snp.centerY)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/4)
            
        }
        
        self.addSubview(glucoseImage)
        // 血糖图标
        glucoseImage.snp.makeConstraints{(make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(dateImage.snp.bottom).offset(AJScreenWidth/40)
            make.height.width.equalTo(AJScreenWidth/15)
        }
        
        self.addSubview(glucoseResultLabel)
        // 血糖label
        glucoseResultLabel.snp.makeConstraints{(make) in
            make.left.equalTo(dateLabel.snp.left)
            make.centerY.equalTo(glucoseImage.snp.centerY)
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/4)
        }
    }
}
