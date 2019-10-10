//
//  glucoseRecentView.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class glucoseRecentView: UIView {

    lazy var ValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    private lazy var TitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var UnitLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    func setupUI(title:String,value:String,unit:String){
        self.backgroundColor = UIColor.clear
        
        ValueLabel.text = value
        TitleLabel.text = title
        UnitLabel.text = unit
        
        self.addSubview(TitleLabel)
        self.addSubview(ValueLabel)
        self.addSubview(UnitLabel)
        
        TitleLabel.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(AJScreenWidth/30)
            make.height.equalTo(AJScreenWidth/20+3)
            make.width.equalTo(AJScreenWidth/4)
        }
        ValueLabel.sizeToFit()
        ValueLabel.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(TitleLabel.snp.bottom).offset(AJScreenWidth/30)
            make.bottom.equalToSuperview().offset(-AJScreenWidth/30)
        }
        UnitLabel.sizeToFit()
        UnitLabel.snp.makeConstraints{(make) in
            make.left.equalTo(ValueLabel.snp.right).offset(10)
            make.top.equalTo(ValueLabel.snp.centerY)
        }
    }

}
