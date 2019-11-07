//
//  ChartView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class ChartHeaderView: UIView {

    // title
    private lazy var textLabel:UILabel = {
       let label = UILabel()
        label.text = "Trend"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    
    func setUpUI(){
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.width.equalTo(AJScreenWidth/8)
            
        }
    }
    
    
    
    

}
