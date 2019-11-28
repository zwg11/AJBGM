//
//  sliderView.swift
//  AIJian
//
//  Created by Zwg on 2019/9/26.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class sliderView: UIView {

    private var lowView = UILabel()
    private var normalView = UIView()
    private var highView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lowView.backgroundColor = UIColor.orange
        normalView.backgroundColor = UIColor.green
        highView.backgroundColor = UIColor.red
        self.addSubview(lowView)
        self.addSubview(normalView)
        self.addSubview(highView)

        self.backgroundColor = UIColor.black
        // 低血糖范围
        let low = GetBloodLimit.getRandomDinnerLow()
        // 正常血糖范围
        let high = GetBloodLimit.getRandomDinnerTop() - GetBloodLimit.getRandomDinnerLow()
        if GetUnit.getBloodUnit() == "mmol/L"{
            // 低于视图
            lowView.snp.makeConstraints{(make) in
                make.left.top.height.equalToSuperview()
                make.width.equalToSuperview().multipliedBy((low-0.6)/16)
                
            }
            // 正常视图
            normalView.snp.makeConstraints{(make) in
//                make.top.bottom.equalTo(lowView)
                make.top.height.equalToSuperview()
                make.left.equalTo(lowView.snp.right)
                make.width.equalToSuperview().multipliedBy(high/16)
                
            }
            // 高于视图
            highView.snp.makeConstraints{(make) in
                make.left.equalTo(normalView.snp.right)
//                make.top.bottom.equalTo(lowView)
                make.top.height.equalToSuperview()
                make.right.equalToSuperview()
            }
        }else{
            // 低于视图
            lowView.snp.makeConstraints{(make) in
                make.left.top.height.equalToSuperview()
                make.width.equalToSuperview().multipliedBy((low-10)/290)
                
            }
            // 正常视图
            normalView.snp.makeConstraints{(make) in
                make.top.height.equalToSuperview()
                make.left.equalTo(lowView.snp.right)
                make.width.equalToSuperview().multipliedBy(high/300)
                
            }
            // 高于视图
            highView.snp.makeConstraints{(make) in
                make.left.equalTo(normalView.snp.right)
                make.top.height.right.equalToSuperview()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
