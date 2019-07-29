//
//  averageViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/22.
//  Copyright © 2019 apple. All rights reserved.
//  Author : zwg

import UIKit
import SnapKit

// 平均值展示框
class averageView: UIView {
    let greenColor = UIColor.init(red: 97.0/255.0, green: 213.0/255.0, blue: 96.0/255.0, alpha: 1)

    private lazy var averageTitle:UILabel = {
        let label = UILabel()
        label.text = "Average"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var avgView:UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = borderColor.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
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
        label.text = "standard deviation"
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
        label.text = "tests number per day"
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
        label.layer.cornerRadius = 17.5
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
        label.textAlignment = .center
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
        self.addSubview(averageTitle)
        self.averageTitle.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        self.addSubview(avgView)
        self.avgView.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(averageTitle.snp.bottom)
            make.height.equalTo(145)
            //make.width.equalTo(AJScreenWidth-20)
            
        }
        
        self.avgView.addSubview(label1)
        self.label1.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.width.equalTo((AJScreenWidth-20)/2)
            
        }

        
        self.avgView.addSubview(label2)
        self.label2.snp.makeConstraints{ (make) in
            make.left.equalTo(label1.snp.left)
            make.top.equalTo(label1.snp.bottom).offset(10)
            make.height.equalTo(label1.snp.height)
            make.width.equalTo((AJScreenWidth-20)/2 )
            
            
        }
        
        self.avgView.addSubview(label3)
        self.label3.snp.makeConstraints{ (make) in
            make.left.equalTo(label1.snp.left)
            make.top.equalTo(label2.snp.bottom).offset(10)
            make.height.equalTo(label1.snp.height)
            make.width.equalTo((AJScreenWidth-20)/2 )
            
        }
        
        self.avgView.addSubview(label4)
        self.label4.snp.makeConstraints{ (make) in
            make.left.equalTo(label1.snp.left)
            make.top.equalTo(label3.snp.bottom).offset(10)
            make.height.equalTo(label1.snp.height)
            make.width.equalTo((AJScreenWidth-20)/2 )
            
        }
        
        self.avgView.addSubview(sugarBloodUnit)
        self.sugarBloodUnit.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(label1.snp.bottom)
            make.height.equalTo(label1.snp.height)
            make.width.equalTo((AJScreenWidth-20)/6 )
            
        }
        
        self.avgView.addSubview(sugarBloodValue)
        self.sugarBloodValue.snp.makeConstraints{ (make) in
            make.right.equalTo(sugarBloodUnit.snp.left)
            make.bottom.equalTo(label1.snp.bottom)
            make.height.width.equalTo(35)
            
        }
        
        self.avgView.addSubview(standardDeValue)
        self.standardDeValue.snp.makeConstraints{ (make) in
            make.centerX.equalTo(sugarBloodUnit.snp.centerX)
            make.bottom.equalTo(label2.snp.bottom)
            make.height.equalTo(label2.snp.height)
            make.width.equalTo((AJScreenWidth-20)/8 )
            
        }
        
        self.avgView.addSubview(minAndMaxSBValue)
        self.minAndMaxSBValue.snp.makeConstraints{ (make) in
            make.centerX.equalTo(sugarBloodUnit.snp.centerX)
            make.bottom.equalTo(label3.snp.bottom)
            make.height.equalTo(20)
            make.width.equalTo((AJScreenWidth-20)/4 )
            
        }
        
        self.avgView.addSubview(testNum)
        self.testNum.snp.makeConstraints{ (make) in
            make.centerX.equalTo(standardDeValue.snp.centerX)
            make.bottom.equalTo(label4.snp.bottom)
            make.height.equalTo(20)
            make.width.equalTo((AJScreenWidth-20)/8 )
            
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    

}
