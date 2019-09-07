//
//  perAndAfterMealTests.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/22.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class perAndAfterMealTests: UIView {

    // 由于总体检测、餐前、餐后窗口布局一样，只有标题不同
    // 故设置枚举变量
    // 在初始化该类时初始化该字符串实现不同的标题
    enum titleContent{
        case total
        case perMeal
        case afterMeal
    }
    
    var style = titleContent.total

    // 初始化字体颜色，红 黄 绿 蓝
    let greenColor = UIColor.init(red: 97.0/255.0, green: 213.0/255.0, blue: 96.0/255.0, alpha: 1)
    let yellowColor = UIColor.init(red: 229.0/255.0, green: 217.0/255.0, blue: 28.0/255.0, alpha: 1)
    let blueColor = UIColor.init(red: 97.0/255.0, green: 112.0/255.0, blue: 227.0/255.0, alpha: 1)


    
    // 该函数为方便初始化标签
    func initLabel(setTextColor color:UIColor,setText text:String) -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.text = text
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }
    
    // 以下为4个下划线
    private lazy var lineView1:UIView = {
        let view = UIView()
        view.backgroundColor = borderColor
        return view
    }()
    
    private lazy var lineView2:UIView = {
        let view = UIView()
        view.backgroundColor = borderColor
        return view
    }()
    
    private lazy var lineView3:UIView = {
        let view = UIView()
        view.backgroundColor = borderColor
        return view
    }()
    
    private lazy var lineView4:UIView = {
        let view = UIView()
        view.backgroundColor = borderColor
        return view
    }()
    // 设置标题
    private lazy var checkViewTitle:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    // 检测视图
    private lazy var testView:UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = borderColor.cgColor
        return view
    }()

    
    //***********低于正常值*************
    private lazy var lower:UILabel = {
        let label = initLabel(setTextColor: yellowColor, setText: "Low")
        return label
    }()
    
    private lazy var lowerValue:UILabel = {
        let label = initLabel(setTextColor: yellowColor, setText: "0")
        return label
    }()
    
    private lazy var lowerPercent:UILabel = {
        let label = initLabel(setTextColor: yellowColor, setText: "0%")
        return label
    }()
    
    //***********正常*************
    private lazy var normal:UILabel = {
        let label = initLabel(setTextColor: greenColor, setText: "Normal")
        return label
    }()
    
    private lazy var normalValue:UILabel = {
        let label = initLabel(setTextColor: greenColor, setText: "0")
        return label
    }()
    
    private lazy var normalPercent:UILabel = {
        let label = initLabel(setTextColor: greenColor, setText: "0%")
        return label
    }()
    
    //***********高于正常值*************
    private lazy var higherNormal:UILabel = {
        let label = initLabel(setTextColor: blueColor, setText: "Hyper")
        return label
    }()
    
    private lazy var higherNormalValue:UILabel = {
        let label = initLabel(setTextColor: blueColor, setText: "0")
        return label
    }()
    
    private lazy var higherNormalPercent:UILabel = {
        let label = initLabel(setTextColor: blueColor, setText: "0%")
        
        return label
    }()
    
    // 设置label显示内容
    // 根据style的不同显示不同的标题和label内容
    func setupLabel(){
        // 初始化 检测次数，根据detectionTime处理数据
        checkInit()
        switch style {
        case .total:
            totalInit()
        case .perMeal:
            perMealInit()
        default:
            afterMealInit()
        }
    }
    
    
    // MARK: - 设置所有部件的布局约束
    // setupUI() start
    func setupUI(){
        
        
        // 设置 标题 布局
        self.addSubview(checkViewTitle)
        
        self.checkViewTitle.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo((AJScreenWidth-20)/2)
        }
        
        // 设置 检测视图 布局
        self.addSubview(testView)
        self.testView.snp.makeConstraints{ (make) in
            make.top.equalTo(checkViewTitle.snp.bottom)
            make.height.equalTo(96)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            
        }
        
        
        // MARK: - Label布局约束
        // 所有Label 高30 宽testView的 1/4
        
        // ***************************低于*****************************
        self.testView.addSubview(lower)
        self.lower.snp.makeConstraints{ (make) in
            
            make.left.top.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalToSuperview().dividedBy(3)
            
        }
        
        self.testView.addSubview(lowerValue)
        self.lowerValue.snp.makeConstraints{ (make) in
            make.left.right.equalTo(lower)
            make.top.equalTo(lower.snp.bottom)
            make.height.equalTo(30)
            
        }
        
        self.testView.addSubview(lowerPercent)
        self.lowerPercent.snp.makeConstraints{ (make) in
            make.left.right.equalTo(lower)
            make.top.equalTo(lowerValue.snp.bottom)
            make.height.equalTo(30)
            
        }
        
        // ***************************正常*****************************
        self.testView.addSubview(normal)
        self.normal.snp.makeConstraints{ (make) in
            make.left.equalTo(lower.snp.right)
            make.top.equalToSuperview()
            make.width.height.equalTo(lower)
            
            
        }
        
        self.testView.addSubview(normalValue)
        self.normalValue.snp.makeConstraints{ (make) in
            make.left.right.equalTo(normal)
            make.top.equalTo(normal.snp.bottom)
            make.width.height.equalTo(lower)
            
        }
        
        self.testView.addSubview(normalPercent)
        self.normalPercent.snp.makeConstraints{ (make) in
            make.left.right.equalTo(normal)
            make.top.equalTo(normalValue.snp.bottom)
            make.width.height.equalTo(lower)
            
        }
        
        // ***************************高于*****************************
        self.testView.addSubview(higherNormal)
        self.higherNormal.snp.makeConstraints{ (make) in
            make.left.equalTo(normal.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(lower)
            make.right.equalToSuperview()
            
        }
        
        self.testView.addSubview(higherNormalValue)
        self.higherNormalValue.snp.makeConstraints{ (make) in
            make.left.right.equalTo(higherNormal)
            make.top.equalTo(higherNormal.snp.bottom)
            make.height.equalTo(lower)
            
        }
        
        self.testView.addSubview(higherNormalPercent)
        self.higherNormalPercent.snp.makeConstraints{ (make) in
            make.left.right.equalTo(higherNormal)
            make.top.equalTo(higherNormalValue.snp.bottom)
            make.height.equalTo(lower)

            
        }
        
        // ***************************下划线******************************
        
        self.testView.addSubview(lineView2)
        self.lineView2.snp.makeConstraints{ (make) in
            make.left.equalTo(lower).offset(AJScreenWidth/40)
            make.right.equalTo(lower).offset(-AJScreenWidth/40)
            make.centerY.equalTo(lowerValue.snp.bottom)
            make.height.equalTo(2)
            
        }
        
        self.testView.addSubview(lineView3)
        self.lineView3.snp.makeConstraints{ (make) in
            make.left.equalTo(normal).offset(AJScreenWidth/40)
            make.right.equalTo(normal).offset(-AJScreenWidth/40)
            make.centerY.equalTo(normalValue.snp.bottom)
            make.height.equalTo(2)
            
        }
        
        self.testView.addSubview(lineView4)
        self.lineView4.snp.makeConstraints{ (make) in
            make.left.equalTo(higherNormal).offset(AJScreenWidth/40)
            make.right.equalTo(higherNormal).offset(-AJScreenWidth/40)
            make.centerY.equalTo(higherNormalValue.snp.bottom)
            make.height.equalTo(2)
            
        }
        
        
        
    }// setupUI() end
    
    // 用于记录饭前、总体饭后检测次数和对应数据
    var perMealNum:Int = 0
    var perMealData:[glucoseDate] = []
    var totalNum:Int = 0
    var afterMealNum:Int = 0
    var afterMealData:[glucoseDate] = []
    var otherNum:Int = 0
    var otherData:[glucoseDate] = []
    // 检测视图检测次数初始化
    func checkInit(){
        // 全部s初始化为0，避免受之前的值的影响
        perMealNum = 0
        afterMealNum = 0
        otherNum = 0
        var per:[glucoseDate] = []
        var after:[glucoseDate] = []
        var other:[glucoseDate] = []
        totalNum = sortedByDateOfData!.count
        if totalNum > 0{
            for i in sortedByDateOfData!{
                switch i.detectionTime{
                case 1,3,5,7:
                    perMealNum += 1
                    per.append(i)
                case 2,4,6,8:
                    afterMealNum += 1
                    after.append(i)
                default:
                    otherNum += 1
                    other.append(i)
                    
                }
            }
            perMealData = per
            afterMealData = after
            otherData = other
        }
    }
    // 总体检测视图内容初始化
    func totalInit(){
        checkViewTitle.text = "Total - \(totalNum) Tests"
        var lower = 0   // 低于
        var normal = 0  // 正常
        var high = 0    // 高于
        // 遍历数据，根据范围得到对应的次数
        // 由于餐前餐后和随机其正常血糖范围不一致
        // 因此需依次判断
        if totalNum > 0{
            if GetUnit.getBloodUnit() == "mg/dL"{
                
                if perMealNum > 0{
                    // perMeal
                    for i in perMealData{
                        if Double(i.bloodGlucoseMg!) < GetBloodLimit.getBeforeDinnerLow(){
                            
                            lower += 1
                        }else if Double(i.bloodGlucoseMg!) < GetBloodLimit.getBeforeDinnerTop(){
                            
                            normal += 1
                        }else{
                            high += 1
                        }
                    }
                }
                
                if afterMealNum > 0{
                    // afterMeal
                    for i in afterMealData{
                        if Double(i.bloodGlucoseMg!) < GetBloodLimit.getAfterDinnerLow(){
                            lower += 1
                        }else if Double(i.bloodGlucoseMg!) < GetBloodLimit.getAfterDinnerTop(){
                            
                            normal += 1
                        }else{
                            high += 1
                        }
                    }

                }
                
                if otherNum > 0{
                    // other
                    for i in otherData{
                        if Double(i.bloodGlucoseMg!) < GetBloodLimit.getRandomDinnerLow(){
                            lower += 1
                        }else if Double(i.bloodGlucoseMg!) < GetBloodLimit.getRandomDinnerTop(){
                            
                            normal += 1
                        }else{
                            high += 1
                        }
                    }
                }
                
                
            }else{
                if perMealNum > 0{
                    // perMeal
                    for i in perMealData{
                        if i.bloodGlucoseMmol! < GetBloodLimit.getBeforeDinnerLow(){
                            
                            lower += 1
                        }else if i.bloodGlucoseMmol! < GetBloodLimit.getBeforeDinnerTop(){
                            
                            normal += 1
                        }else{
                            high += 1
                        }
                    }
                }
                
                
                if afterMealNum > 0{
                    // afterMeal
                    for i in afterMealData{
                        if i.bloodGlucoseMmol! < GetBloodLimit.getAfterDinnerLow(){
                            
                            lower += 1
                        }else if i.bloodGlucoseMmol! < GetBloodLimit.getAfterDinnerTop(){
                            
                            normal += 1
                        }else{
                            high += 1
                        }
                    }
                }
                
                
                if otherNum > 0{
                    // other
                    for i in otherData{
                        if i.bloodGlucoseMmol! < GetBloodLimit.getRandomDinnerLow(){
                            
                            lower += 1
                        }else if i.bloodGlucoseMmol! < GetBloodLimit.getRandomDinnerTop(){
                            
                            normal += 1
                        }else{
                            high += 1
                        }
                    }
                }
                
            }
        }
        
        // 初始化label，如果有数据则初始化，没有就全为0
        initLabel(lower: lower, normal: normal, high: high, total: totalNum)
    }
    // 餐前检测视图内容初始化
    func perMealInit(){
        checkViewTitle.text = "Before Meal - \(perMealNum) Tests"
        
        var lower = 0   // 低于
        var normal = 0  // 正常
        var high = 0    // 高于
        // 遍历餐前数据，根据范围得到对应的次数
        if perMealNum > 0{
            if GetUnit.getBloodUnit() == "mg/dL"{
                for i in perMealData{
                    if Double(i.bloodGlucoseMg!) < GetBloodLimit.getBeforeDinnerLow(){
                        
                        lower += 1
                    }else if Double(i.bloodGlucoseMg!) < GetBloodLimit.getBeforeDinnerTop(){
                        
                        normal += 1
                    }else{
                        high += 1
                    }
                }
            }else{
                // perMeal
                for i in perMealData{
                    if i.bloodGlucoseMmol! < GetBloodLimit.getBeforeDinnerLow(){
                        
                        lower += 1
                    }else if i.bloodGlucoseMmol! < GetBloodLimit.getBeforeDinnerTop(){
                        
                        normal += 1
                    }else{
                        high += 1
                    }
                }
                
            }
            
        }
        
        // 初始化label，如果有数据则初始化，没有就全为0
        initLabel(lower: lower, normal: normal, high: high, total: perMealNum)
    }
    // 餐后检测视图内容初始化
    func afterMealInit(){
        checkViewTitle.text = "After Meal - \(afterMealNum) Tests"

        var lower = 0   // 低于
        var normal = 0  // 正常
        var high = 0    // 高于
        // 遍历餐后数据，根据范围得到对应的次数
        if afterMealNum > 0{
            
            if GetUnit.getBloodUnit() == "mg/dL"{
                for i in afterMealData{
                    if Double(i.bloodGlucoseMg!) < GetBloodLimit.getAfterDinnerLow(){
                        lower += 1
                    }else if Double(i.bloodGlucoseMg!) < GetBloodLimit.getAfterDinnerTop(){
                            
                        normal += 1
                    }else{
                        high += 1
                    }
                }
            }else{
                for i in afterMealData{
                    if i.bloodGlucoseMmol! < GetBloodLimit.getAfterDinnerLow(){
                            
                        lower += 1
                    }else if i.bloodGlucoseMmol! < GetBloodLimit.getAfterDinnerTop(){
                            
                        normal += 1
                    }else{
                        high += 1
                    }
                }
                
            }
        }
        // 初始化label，如果有数据则初始化，没有就全为0
        initLabel(lower: lower, normal: normal, high: high, total: afterMealNum)
    }
    // 初始化label
    func initLabel(lower:Int,normal:Int,high:Int,total:Int){
        initLabelToZero()
        // 可直接得到次数，但百分比需计算
        if total > 0{
            if lower > 0{
                lowerValue.text = "\(lower)"
                lowerPercent.text = String(Int(Double(lower)/Double(total)*100)) + "%"
            }
            if normal > 0{
                normalValue.text = "\(normal)"
                normalPercent.text = String(Int(Double(normal)/Double(total)*100)) + "%"
            }
            if high > 0{
                higherNormalValue.text = "\(high)"
                higherNormalPercent.text = String(Int(Double(high)/Double(total)*100)) + "%"
            }
        }
    }
    
    // 将label全初始化为0
    func initLabelToZero(){
        lowerValue.text = "0"
        lowerPercent.text = "0%"
        normalValue.text = "0"
        normalPercent.text = "0%"
        higherNormalValue.text = "0"
        higherNormalPercent.text = "0%"
    }
}
