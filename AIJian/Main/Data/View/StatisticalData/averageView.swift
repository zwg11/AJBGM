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

    var avgGlucoseValue:Double?
    var avgCheckNum:Double?
    var standardDaviation:Double?
    // 标题
    private lazy var averageTitle:UILabel = {
        let label = UILabel()
        label.text = "Average"
        label.font = UIFont.systemFont(ofSize: 18)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
        label.textAlignment = .left
        return label
    }()
    // 平均值视图
    private lazy var avgView:UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = TextGrayColor.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    // 血糖label
    private lazy var glucoseLabel:UILabel = {
        let label = UILabel()
        label.text = "Blood Glucose"
        label.textColor = TextGrayColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
        
    }()
   // 标准差label
    private lazy var sDLabel:UILabel = {
        let label = UILabel()
        label.text = "Standard Deviation"
        label.textColor = TextGrayColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
        
    }()
    // 每天检测次数label
    private lazy var checkNumLabel:UILabel = {
        let label = UILabel()
        label.text = "Frequency/Day"
        label.textColor = TextGrayColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
        
    }()
    
    // MARK: - content of the view
    // 显示统计数据
    
    private lazy var glucoseValue:UILabel = {
        let label = UILabel()
        label.text = String(avgGlucoseValue ?? 0)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = UIColor.clear
//        label.layer.borderColor = borderColor.cgColor
//        label.layer.borderWidth = 1
//        label.layer.cornerRadius = AJScreenWidth/24
        return label
        
    }()
    // 单位
    private lazy var glucoseUnit:UILabel = {
        let label = UILabel()
        label.text = GetUnit.getBloodUnit()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
        
    }()
    // 标准差
    private lazy var standardDeValue:UILabel = {
        let label = UILabel()
        label.text = String(standardDaviation ?? 0)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
        
    }()

    
   // 每天检测次数
    private lazy var testNum:UILabel = {
        let label = UILabel()
        label.text = String(avgCheckNum ?? 0)
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
        
    }()
    
    
    func setupUI(){
        self.backgroundColor = UIColor.clear
        // 标题布局设置
        self.addSubview(averageTitle)
        self.averageTitle.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        // 平均值视图布局
        self.addSubview(avgView)
        self.avgView.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(averageTitle.snp.bottom)
            make.height.equalTo(115)
            //make.width.equalTo(AJScreenWidth-20)
            
        }
        // 血糖label布局
        self.avgView.addSubview(glucoseLabel)
        self.glucoseLabel.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.width.equalTo((AJScreenWidth-20)/2)
            
        }

        // 标准差label布局
        self.avgView.addSubview(sDLabel)
        self.sDLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(glucoseLabel.snp.left)
            make.top.equalTo(glucoseLabel.snp.bottom).offset(10)
            make.height.equalTo(glucoseLabel.snp.height)
            make.width.equalTo((AJScreenWidth-20)/2 )
        }

        // 每天检测次数label布局
        self.avgView.addSubview(checkNumLabel)
        self.checkNumLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(glucoseLabel.snp.left)
            make.top.equalTo(sDLabel.snp.bottom).offset(10)
            make.height.equalTo(glucoseLabel.snp.height)
            make.width.equalTo((AJScreenWidth-20)/2 )
        }
        
        // 血糖单位label布局
        self.avgView.addSubview(glucoseUnit)
        glucoseUnit.sizeToFit()
        self.glucoseUnit.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(glucoseLabel.snp.bottom)
            make.height.equalTo(glucoseLabel.snp.height)
            //make.width.equalTo((AJScreenWidth-20)/6)
        }
        
        // 血糖值label布局
        self.avgView.addSubview(glucoseValue)
        
        self.glucoseValue.snp.makeConstraints{ (make) in
            make.right.equalTo(glucoseUnit.snp.left).offset(-10)
            make.bottom.equalTo(glucoseLabel.snp.bottom)
            make.height.equalTo(glucoseLabel.snp.height)
            make.width.equalTo(AJScreenWidth/10)
        }
        
        // 标准差label布局
        self.avgView.addSubview(standardDeValue)
        standardDeValue.sizeToFit()
        self.standardDeValue.snp.makeConstraints{ (make) in
            make.centerX.equalTo(glucoseValue)
            make.bottom.equalTo(sDLabel.snp.bottom)
            make.height.equalTo(sDLabel.snp.height)
            make.width.equalTo((AJScreenWidth-20)/8 )
            
        }
        
        // 检测次数label布局
        self.avgView.addSubview(testNum)
        self.testNum.snp.makeConstraints{ (make) in
            make.centerX.equalTo(glucoseValue)
            make.bottom.equalTo(checkNumLabel.snp.bottom)
            make.height.equalTo(20)
            make.width.equalTo((AJScreenWidth-20)/8 )
            
        }

    }
    

    // 初始化视图数据
    func labelUpdate(){
        DispatchQueue.main.async {
            // 单位更新
            self.glucoseUnit.text = GetUnit.getBloodUnit()
        }
        // 单位更新
//        glucoseUnit.text = GetUnit.getBloodUnit()
        // 如果有数据
        if sortedByDateOfData!.count > 0{
            // 计算各个label应有的内容
            // 总血糖值
            var sumBloodGlucoseValue = 0.0
            // 总检测次数
            var sumCheckNum = 0
            // 总标准差和
            var sumStandardDaviation = 0.0
            // 总检测次数
            for i in 0..<sortedTime.count{
                sumCheckNum += sortedTime[i].count
                
            }
            // 平均检测次数
            avgCheckNum = Double(sumCheckNum)/Double(daysNum!)
            
            // 检测血糖值总和
            // 别忘了判断单位
            if GetUnit.getBloodUnit() == "mg/dL"{
                for i in sortedByDateOfData!{
                    sumBloodGlucoseValue += Double(i.bloodGlucoseMg!)
                }
            }else{
                for i in sortedByDateOfData!{
                    sumBloodGlucoseValue += i.bloodGlucoseMmol!
                }
            }
            
            // 血糖平均值
            avgGlucoseValue = sumBloodGlucoseValue/Double(sumCheckNum)
            
            // 标准差
            if GetUnit.getBloodUnit() == "mg/dL"{
                for i in sortedByDateOfData!{
                    sumStandardDaviation += (avgGlucoseValue! - i.bloodGlucoseMg!)*(avgGlucoseValue! - i.bloodGlucoseMg!)
                }
            }else{
                for i in sortedByDateOfData!{
                    sumStandardDaviation += (avgGlucoseValue! - i.bloodGlucoseMmol!)*(avgGlucoseValue! - i.bloodGlucoseMmol!)
                }
            }
            
            standardDaviation = sqrt(sumStandardDaviation/Double(sumCheckNum))
            DispatchQueue.main.async {
                // 将计算结果赋值给对应的label
                if GetUnit.getBloodUnit() == "mg/dL"{
                    self.glucoseValue.text = String(format: "% .0f", self.avgGlucoseValue!)
                }else{
                    self.glucoseValue.text = String(format: "% .1f", self.avgGlucoseValue!)
                }
                
                self.standardDeValue.text = String(format: "% .1f", self.standardDaviation!)
                self.testNum.text = String(format: "% .1f", self.avgCheckNum!)
            }
            // 将计算结果赋值给对应的label
//            if GetUnit.getBloodUnit() == "mg/dL"{
//                glucoseValue.text = String(format: "% .0f", avgGlucoseValue!)
//            }else{
//                glucoseValue.text = String(format: "% .1f", avgGlucoseValue!)
//            }
//
//            standardDeValue.text = String(format: "% .1f", standardDaviation!)
//            testNum.text = String(format: "% .1f", avgCheckNum!)
 
        }else{
            DispatchQueue.main.async {
                // 如果e没数据，则至为 ” - “
                self.glucoseValue.text = "-"
                self.standardDeValue.text = "-"
                self.testNum.text = "-"
            }
            // 如果e没数据，则至为 ” - “
//            glucoseValue.text = "-"
//            standardDeValue.text = "-"
//            testNum.text = "-"
        }
    }
    

}
