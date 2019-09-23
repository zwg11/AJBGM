//
//  SharedStaticView.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/20.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class SharedStaticView: UIView {

    private lazy var staticTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Statistics"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var line:UIView = UIView()
    
    private lazy var bloodGlucoseLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Blood Glucose"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var TestNumTitleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Number of Tests"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var AvgTitleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Average(\(GetUnit.getBloodUnit()))"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var SDTitleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Standard Deviation"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var AboveNumTitleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Above Target Range"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var WithinNumTitleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Within Target Range"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var BelowNumTitleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Below Target Range"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var PerMealStatic:MealStatic = {
        let view = MealStatic()
        view.setupUI()
        view.MealTitleLabel.text = "Before Meal"
        return view
    }()
    
    private lazy var AfterMealStatic:MealStatic = {
        let view = MealStatic()
        view.setupUI()
        view.MealTitleLabel.text = "After Meal"
        return view
    }()
    
    private lazy var ToltalStatic:MealStatic = {
        let view = MealStatic()
        view.setupUI()
        view.MealTitleLabel.text = "Total"
        return view
    }()
    

    func setupUI(){
        self.addSubview(staticTitleLabel)
        self.addSubview(line)
        self.addSubview(bloodGlucoseLabel)
        self.addSubview(TestNumTitleLabel)
        self.addSubview(AvgTitleLabel)
        self.addSubview(SDTitleLabel)
        self.addSubview(AboveNumTitleLabel)
        self.addSubview(WithinNumTitleLabel)
        self.addSubview(BelowNumTitleLabel)
        self.addSubview(PerMealStatic)
        self.addSubview(AfterMealStatic)
        self.addSubview(ToltalStatic)
        
        staticTitleLabel.snp.makeConstraints{(make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.width.equalTo(300)
        }
        
        line.backgroundColor = UIColor.gray
        line.snp.makeConstraints{(make) in
            make.top.equalTo(staticTitleLabel.snp.bottom)
            make.left.equalTo(staticTitleLabel)
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        
        bloodGlucoseLabel.snp.makeConstraints{(make) in
            make.top.equalTo(staticTitleLabel.snp.bottom)
            make.left.equalTo(staticTitleLabel)
            make.height.equalTo(40)
            make.width.equalTo(300)
        }
        
        TestNumTitleLabel.snp.makeConstraints{(make) in
            make.right.equalTo(bloodGlucoseLabel).offset(-10)
            make.width.equalTo(200)
            make.top.equalTo(bloodGlucoseLabel.snp.bottom)
            make.height.equalTo(40)
        }
        
        
        AvgTitleLabel.snp.makeConstraints{(make) in
            make.right.width.equalTo(TestNumTitleLabel)
            make.top.equalTo(TestNumTitleLabel.snp.bottom)
            make.height.equalTo(TestNumTitleLabel)
        }
        
        SDTitleLabel.snp.makeConstraints{(make) in
            make.right.width.equalTo(TestNumTitleLabel)
            make.top.equalTo(AvgTitleLabel.snp.bottom)
            make.height.equalTo(TestNumTitleLabel)
        }
        
        AboveNumTitleLabel.snp.makeConstraints{(make) in
            make.right.width.equalTo(TestNumTitleLabel)
            make.top.equalTo(SDTitleLabel.snp.bottom)
            make.height.equalTo(TestNumTitleLabel)
        }
        
        WithinNumTitleLabel.snp.makeConstraints{(make) in
            make.right.width.equalTo(TestNumTitleLabel)
            make.top.equalTo(AboveNumTitleLabel.snp.bottom)
            make.height.equalTo(TestNumTitleLabel)
        }
        
        BelowNumTitleLabel.snp.makeConstraints{(make) in
            make.right.width.equalTo(TestNumTitleLabel)
            make.top.equalTo(WithinNumTitleLabel.snp.bottom)
            make.height.equalTo(TestNumTitleLabel)
        }
        
        PerMealStatic.snp.makeConstraints{(make) in
            make.left.equalTo(bloodGlucoseLabel.snp.right)
            make.top.equalTo(bloodGlucoseLabel)
            make.height.equalTo(220)
            make.width.equalTo(260)
        }
        AfterMealStatic.snp.makeConstraints{(make) in
            make.left.equalTo(PerMealStatic.snp.right)
            make.top.equalTo(bloodGlucoseLabel)
            make.height.equalTo(220)
            make.width.equalTo(260)
        }
        
        ToltalStatic.snp.makeConstraints{(make) in
            make.left.equalTo(AfterMealStatic.snp.right)
            make.top.equalTo(bloodGlucoseLabel)
            make.height.equalTo(220)
            make.width.equalTo(260)
        }
    }
    
    func initViewData(){
        
        var perMealData:[glucoseDate] = []
        var AfterMealData:[glucoseDate] = []
        var TotalData:[glucoseDate] = []
        if sortedByDateOfData!.count > 0{
            TotalData = sortedByDateOfData!
            for i in TotalData{
                if i.detectionTime! == 0{
                    perMealData.append(i)
                }else if i.detectionTime! == 1{
                    AfterMealData.append(i)
                }
            }
        }
        
        PerMealStatic.initContent(perMealData)
        AfterMealStatic.initContent(AfterMealData)
        ToltalStatic.initContent(TotalData)
    }

}


class MealStatic: UIView {
    // 标题
    lazy var MealTitleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    // label的统一行形式
    func initLabel() -> UILabel{
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.layer.borderWidth = 1
        //label.frame.size = CGSize(width: 200, height: 30)
        return label
    }
    // 检测次数
    private lazy var TestNumLabel:UILabel = {
        let label = initLabel()
        return label
    }()
    // 平均检测值
    private lazy var AvgLabel:UILabel = {
        let label = initLabel()
        return label
    }()
    // 标准差
    private lazy var SDLabel:UILabel = {
        let label = initLabel()
        return label
    }()
    // 高于正常值百分比和次数
    private lazy var AboveNumLabel:UILabel = {
        let label = initLabel()
        return label
    }()
    // 正常值范围百分比和次数
    private lazy var WithinNumLabel:UILabel = {
        let label = initLabel()
        return label
    }()
    // 低于正常值百分比和次数
    private lazy var BelowNumLabel:UILabel = {
        let label = initLabel()
        return label
    }()
    
    // 布局
    func setupUI(){
        self.addSubview(MealTitleLabel)
        self.addSubview(TestNumLabel)
        self.addSubview(AvgLabel)
        self.addSubview(SDLabel)
        self.addSubview(AboveNumLabel)
        self.addSubview(WithinNumLabel)
        self.addSubview(BelowNumLabel)
        
        MealTitleLabel.snp.makeConstraints{(make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        TestNumLabel.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(MealTitleLabel.snp.bottom)
            make.height.equalTo(40)
        }
        
        
        AvgLabel.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(TestNumLabel.snp.bottom)
            make.height.equalTo(40)
        }
        
        SDLabel.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(AvgLabel.snp.bottom)
            make.height.equalTo(40)
        }
        
        AboveNumLabel.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(SDLabel.snp.bottom)
            make.height.equalTo(40)
        }
        
        WithinNumLabel.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(AboveNumLabel.snp.bottom)
            make.height.equalTo(40)
        }
        
        BelowNumLabel.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(WithinNumLabel.snp.bottom)
            make.height.equalTo(40)
        }
    }// func setupUI() end
    
    // label 内容设置
    func initContent(_ datas:[glucoseDate]){
        TestNumLabel.text = "\(datas.count)"
        
        if datas.count <= 0{
            AvgLabel.text = "-"
            SDLabel.text = "-"
            AboveNumLabel.text = "0%(0)"
            WithinNumLabel.text = "0%(0)"
            BelowNumLabel.text = "0%(0)"
        }// 如果有数据
        else{
            var avg = 0.0
            var SD = 0.0
            var sum = 0.0
            var belowNum = 0
            var withinNum = 0
            var aboveNum = 0
            
            // 计算总血糖值
            if GetUnit.getBloodUnit() == "mmol/L"{
                for i in datas{
                    sum += i.bloodGlucoseMmol!
                }
            }else{
                for i in datas{
                    sum += i.bloodGlucoseMg!
                }
            }
            
            // 计算平均值
            avg = sum/Double(datas.count)
            //AvgLabel.text = "\(avg)"
            if GetUnit.getBloodUnit() == "mg/dL"{
                AvgLabel.text = String(format: "%.0f", avg)
            }else{
                AvgLabel.text = String(format: "%.1f", avg)
            }
            
            // 标准差
            if GetUnit.getBloodUnit() == "mg/dL"{
                for i in datas{
                    SD += (avg - i.bloodGlucoseMg!)*(avg - i.bloodGlucoseMg!)
                }
            }else{
                for i in datas{
                    SD += (avg - i.bloodGlucoseMmol!)*(avg - i.bloodGlucoseMmol!)
                }
            }
            
            SD = SD/Double(datas.count)
            SDLabel.text = String(format: "%.1f", SD)
            
            // 不同血糖值范围检测次数及其百分比
            // 检测次数
            for i in datas{
                if Double(i.bloodGlucoseMg!) < GetBloodLimit.getBeforeDinnerLow(){
                    
                    belowNum += 1
                }else if Double(i.bloodGlucoseMg!) < GetBloodLimit.getBeforeDinnerTop(){
                    
                    withinNum += 1
                }else{
                    aboveNum += 1
                }
            }
            // 显示百分比和次数，格式 0%(0)
            let x:Int = 100*aboveNum/datas.count
            let y:Int = 100*withinNum/datas.count
            let z:Int = 100*belowNum/datas.count
            AboveNumLabel.text = "\(x)%(\(aboveNum))"
            WithinNumLabel.text = "\(y)%(\(withinNum))"
            BelowNumLabel.text = "\(z)%(\(belowNum))"
            
        }// 有数据
       
    }// func initContent() end
}
