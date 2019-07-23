//
//  averageViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/22.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class averageView: UIView {
    let greenColor = UIColor.init(red: 97.0/255.0, green: 213.0/255.0, blue: 96.0/255.0, alpha: 1)
//    let redColor = UIColor.init(red: 229.0/255.0, green: 28.0/255.0, blue: 35.0/255.0, alpha: 1)
//    let yellowColor = UIColor.init(red: 229.0/255.0, green: 217.0/255.0, blue: 28.0/255.0, alpha: 1)
//    let blueColor = UIColor.init(red: 139.0/255.0, green: 159.0/255.0, blue: 74.0/255.0, alpha: 1)
    
    private lazy var label1:UILabel = {
        let label = UILabel()
        label.text = "blood sugar"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
        
    }()
   
    private lazy var label2:UILabel = {
        let label = UILabel()
        label.text = "standard de"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
        
    }()
    
    private lazy var label3:UILabel = {
        let label = UILabel()
        label.text = "min/max sugar blood"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
        
    }()
    
    private lazy var label4:UILabel = {
        let label = UILabel()
        label.text = "text number per day"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
        
    }()
    
    // MARK: - content of the view
    // 显示统计数据
    
    // ***************************注意***************************
    // 由于未进行数据初始化暂时使用其他数据表示
    private lazy var sugarBloodValue:UILabel = {
        let label = UILabel()
        label.text = String("8.7")
        label.textColor = greenColor
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.layer.borderColor = borderColor.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = label.frame.size.width/2
        return label
        
    }()
    
    private lazy var sugarBloodUnit:UILabel = {
        let label = UILabel()
        label.text = "mmol/L"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
        
    }()
    
    private lazy var standardDeValue:UILabel = {
        let label = UILabel()
        label.text = String("1.2")
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
        
    }()
    
    private lazy var minAndMaxSBValue:UILabel = {
        let label = UILabel()
        label.text = String("- / -")
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
        
    }()
    
   
    private lazy var testNum:UILabel = {
        let label = UILabel()
        label.text = "0.5"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI(){
        self.addSubview(label1)
        self.label1.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(20)
            make.width.equalTo((self.superview?.frame.size.width)!/8 )
            
        }
        
        self.addSubview(label2)
        self.label2.snp.makeConstraints{ (make) in
            make.left.equalTo(label1.snp.left)
            make.top.equalTo(label1.snp.bottom).offset(10)
            make.height.equalTo(label1.snp.height)
            make.width.equalTo((self.superview?.frame.size.width)!/8 )
            
            
        }
        
        self.addSubview(label3)
        self.label3.snp.makeConstraints{ (make) in
            make.left.equalTo(label1.snp.left)
            make.top.equalTo(label2.snp.bottom).offset(10)
            make.height.equalTo(label1.snp.height)
            make.width.equalTo((self.superview?.frame.size.width)!/2 )
            
        }
        
        self.addSubview(label4)
        self.label4.snp.makeConstraints{ (make) in
            make.left.equalTo(label1.snp.left)
            make.top.equalTo(label3.snp.bottom).offset(10)
            make.height.equalTo(label1.snp.height)
            make.width.equalTo((self.superview?.frame.size.width)!/3 )
            
        }
        
        self.addSubview(sugarBloodValue)
        self.sugarBloodValue.snp.makeConstraints{ (make) in
            make.right.equalTo(sugarBloodUnit.snp.left)
            make.bottom.equalTo(label1.snp.bottom)
            make.height.width.equalTo(30)
            
        }
        
        self.addSubview(sugarBloodUnit)
        self.sugarBloodUnit.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(label1.snp.bottom)
            make.height.equalTo(label1.snp.height)
            make.width.equalTo((self.superview?.frame.size.width)!/8 )
            
        }
        
        self.addSubview(standardDeValue)
        self.standardDeValue.snp.makeConstraints{ (make) in
            make.centerX.equalTo(sugarBloodUnit.snp.centerX)
            make.bottom.equalTo(label2.snp.bottom)
            make.height.equalTo(label2.snp.height)
            make.width.equalTo((self.superview?.frame.size.width)!/10 )
            
        }
        
        self.addSubview(minAndMaxSBValue)
        self.minAndMaxSBValue.snp.makeConstraints{ (make) in
            make.right.equalTo(sugarBloodUnit.snp.right)
            make.bottom.equalTo(label3.snp.bottom)
            make.height.equalTo(20)
            make.width.equalTo((self.superview?.frame.size.width)!/5 )
            
        }
        
        self.addSubview(testNum)
        self.testNum.snp.makeConstraints{ (make) in
            make.centerX.equalTo(standardDeValue.snp.centerX)
            make.bottom.equalTo(label4.snp.bottom)
            make.height.equalTo(20)
            make.width.equalTo((self.superview?.frame.size.width)!/8 )
            
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    

}
