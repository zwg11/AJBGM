//
//  StaticView.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/11.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class StaticView: UIView {

    // 检测标签
    private lazy var frequencyLabel:UILabel = {
       let label = UILabel()
        label.text = "Frequency"
        label.textColor = TextGrayColor
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    // 平均标签
    private lazy var AverageLabel:UILabel = {
        let label = UILabel()
        label.text = "Average"
        label.textColor = TextGrayColor
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    // 最大标签
    private lazy var MaxLabel:UILabel = {
        let label = UILabel()
        label.text = "Max"
        label.textColor = TextGrayColor
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    // 最小标签
    private lazy var MinLabel:UILabel = {
        let label = UILabel()
        label.text = "Min"
        label.textColor = TextGrayColor
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    // 检测次数值标签
    private lazy var freValueLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.green
        
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    // 平均值标签
    private lazy var AvgValueLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.green
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    // 最大值标签
    private lazy var MaxValueLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    // 最小值标签
    private lazy var MinValueLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    func setupUI(){
        
//        self.backgroundColor = kRGBColor(24, 45, 65, 1)
        self.backgroundColor = UIColor.clear
        let labels = [freValueLabel,frequencyLabel,AvgValueLabel,AverageLabel,MinValueLabel,MinLabel,MaxValueLabel,MaxLabel]
        
        for i in labels{
            self.addSubview(i)
        }
        
        // 检测次数标签布局
        frequencyLabel.sizeToFit()
        frequencyLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/10)
            make.top.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
        }
        // 检测次数值标签布局
        freValueLabel.snp.makeConstraints{(make) in
        make.left.equalTo(frequencyLabel.snp.right).offset(AJScreenWidth/20)
            make.right.equalTo(self.snp.centerX)
            make.top.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
        }
        // 最大标签布局
        MaxLabel.sizeToFit()
        MaxLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self.snp.centerX).offset(AJScreenWidth/10)
            make.top.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
        }
        // 最大值标签布局
        MaxValueLabel.snp.makeConstraints{(make) in
            make.left.equalTo(MaxLabel.snp.right).offset(AJScreenWidth/20)
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
        }
        // 平均标签布局
        AverageLabel.snp.makeConstraints{(make) in
            make.left.right.equalTo(frequencyLabel)
            make.top.equalTo(frequencyLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
//        AverageLabel.sizeToFit()
        
        // 最小标签布局
        MinLabel.snp.makeConstraints{(make) in
            make.left.right.equalTo(MaxLabel)
            make.top.equalTo(frequencyLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        //平均值标签布局
//        AvgValueLabel.sizeToFit()
        AvgValueLabel.snp.makeConstraints{(make) in
            make.left.equalTo(freValueLabel)
            make.top.equalTo(frequencyLabel.snp.bottom)
            make.right.equalTo(MinLabel.snp.left)
            make.bottom.equalToSuperview()
        }
        // 最小值标签布局
        MinValueLabel.sizeToFit()
        MinValueLabel.snp.makeConstraints{(make) in
            make.left.equalTo(MaxValueLabel)
            make.right.equalToSuperview()
            make.top.equalTo(frequencyLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func initLabelText(){
        // 得到该时间范围的 血糖平均值、检测次数、最大值、最小值
        let result = getDataInHome.getRecentValue(startD!, endD!, false)
        // 获得血糖单位
        let unit = GetUnit.getBloodUnit()
        // 初始化对应的label
        AvgValueLabel.text = "\(result[0]) "  + unit
        freValueLabel.text = "\(result[1])"
        
        MaxValueLabel.text = "\(result[2]) " + unit
        MinValueLabel.text = "\(result[3]) " + unit
        
        
    }
    

}
