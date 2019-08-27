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
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    // title image
    private lazy var titleImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "tend_pic")
        return imageView
    }()
    
    
    func setUpUI(){
        
        
        self.addSubview(self.titleImageView)
        self.titleImageView.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(AJScreenWidth/15)
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()

        }
        
        self.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(titleImageView.snp.right).offset(AJScreenWidth/40)
 
            make.bottom.height.equalTo(titleImageView)
            
        }
    }
    
    
    
    

}
