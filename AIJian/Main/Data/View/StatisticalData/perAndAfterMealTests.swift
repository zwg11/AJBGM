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
    let redColor = UIColor.init(red: 229.0/255.0, green: 28.0/255.0, blue: 35.0/255.0, alpha: 1)
    let yellowColor = UIColor.init(red: 229.0/255.0, green: 217.0/255.0, blue: 28.0/255.0, alpha: 1)
    let blueColor = UIColor.init(red: 139.0/255.0, green: 159.0/255.0, blue: 74.0/255.0, alpha: 1)


    
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
    
    // 为方便布局，再创建两个辅助视图，将检测视图一分为二
    private lazy var view1:UIView = UIView()
    private lazy var view2:UIView = UIView()
    
    //***********低血糖*************
    private lazy var low:UILabel = {
        let label = initLabel(setTextColor: redColor, setText: "低血糖")
        return label
    }()
    
    private lazy var lowValue:UILabel = {
        let label = initLabel(setTextColor: redColor, setText: "0")
        return label
    }()
    
    private lazy var lowPercent:UILabel = {
        let label = initLabel(setTextColor: redColor, setText: "0%")
        return label
    }()
    
    //***********低于正常值*************
    private lazy var lowerNormal:UILabel = {
        let label = initLabel(setTextColor: yellowColor, setText: "低于")
        return label
    }()
    
    private lazy var lowerNormalValue:UILabel = {
        let label = initLabel(setTextColor: yellowColor, setText: "0")
        return label
    }()
    
    private lazy var lowerNormalPercent:UILabel = {
        let label = initLabel(setTextColor: yellowColor, setText: "0%")
        return label
    }()
    
    //***********正常*************
    private lazy var normal:UILabel = {
        let label = initLabel(setTextColor: greenColor, setText: "正常")
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
        let label = initLabel(setTextColor: blueColor, setText: "高于")
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
    
    
    
    // MARK: - 设置所有部件的布局约束
    func setupUI(){
        // 设置标题显示内容，根据style的不同显示不同的标题
        switch style {
        case .total:
            checkViewTitle.text = String("Total - 0 tests")
        case .perMeal:
            checkViewTitle.text = String("PerMeal - 0 tests")
        default:
            checkViewTitle.text = String("AfterMeal - 0 tests")
        }
        
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
        
        // 设置 辅助视图 布局
        testView.addSubview(view1)
        testView.addSubview(view2)
        view1.snp.makeConstraints{(make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(testView.snp.centerX)
        }
        view2.snp.makeConstraints{(make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(testView.snp.centerX)
        }
        
        // MARK: - Label布局约束
        // 所有Label 高30 宽testView的 1/4
        // ***************************低血糖*****************************
        self.testView.addSubview(low)
        self.low.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.right.equalTo(view1.snp.centerX)
            
        }
        
        self.testView.addSubview(lowValue)
        self.lowValue.snp.makeConstraints{ (make) in
            make.left.right.equalTo(low)
            make.top.equalTo(low.snp.bottom)
            make.height.equalTo(30)
            
        }
        
        self.testView.addSubview(lowPercent)
        self.lowPercent.snp.makeConstraints{ (make) in
            make.left.right.equalTo(low)
            make.top.equalTo(lowValue.snp.bottom)
            make.height.equalTo(30)
            
        }
        
        // ***************************低于*****************************
        self.testView.addSubview(lowerNormal)
        self.lowerNormal.snp.makeConstraints{ (make) in
            make.left.equalTo(low.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.right.equalTo(view1.snp.right)
            
        }
        
        self.testView.addSubview(lowerNormalValue)
        self.lowerNormalValue.snp.makeConstraints{ (make) in
            make.left.right.equalTo(lowerNormal)
            make.top.equalTo(lowerNormal.snp.bottom)
            make.height.equalTo(30)
            
        }
        
        self.testView.addSubview(lowerNormalPercent)
        self.lowerNormalPercent.snp.makeConstraints{ (make) in
            make.left.right.equalTo(lowerNormal)
            make.top.equalTo(lowerNormalValue.snp.bottom)
            make.height.equalTo(30)
            
        }
        
        // ***************************正常*****************************
        self.testView.addSubview(normal)
        self.normal.snp.makeConstraints{ (make) in
            make.left.equalTo(lowerNormal.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(low.snp.height)
            make.right.equalTo(view2.snp.centerX)
            
        }
        
        self.testView.addSubview(normalValue)
        self.normalValue.snp.makeConstraints{ (make) in
            make.left.right.equalTo(normal)
            make.top.equalTo(normal.snp.bottom)
            make.height.equalTo(low.snp.height)
            
        }
        
        self.testView.addSubview(normalPercent)
        self.normalPercent.snp.makeConstraints{ (make) in
            make.left.right.equalTo(normal)
            make.top.equalTo(normalValue.snp.bottom)
            make.height.equalTo(low.snp.height)
            
        }
        
        // ***************************高于*****************************
        self.testView.addSubview(higherNormal)
        self.higherNormal.snp.makeConstraints{ (make) in
            make.left.equalTo(normal.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(low.snp.height)
            make.right.equalToSuperview()
            
        }
        
        self.testView.addSubview(higherNormalValue)
        self.higherNormalValue.snp.makeConstraints{ (make) in
            make.left.right.equalTo(higherNormal)
            make.top.equalTo(higherNormal.snp.bottom)
            make.height.equalTo(low.snp.height)
            
        }
        
        self.testView.addSubview(higherNormalPercent)
        self.higherNormalPercent.snp.makeConstraints{ (make) in
            make.left.right.equalTo(higherNormal)
            make.top.equalTo(higherNormalValue.snp.bottom)
            make.height.equalTo(low.snp.height)

            
        }
        
        // ***************************下划线******************************
        self.testView.addSubview(lineView1)
        self.lineView1.snp.makeConstraints{ (make) in
            make.left.equalTo(low).offset(AJScreenWidth/40)
            make.right.equalTo(low).offset(-AJScreenWidth/40)
            make.centerY.equalTo(lowValue.snp.bottom)
            make.height.equalTo(2)
        }
        
        self.testView.addSubview(lineView2)
        self.lineView2.snp.makeConstraints{ (make) in
            make.left.equalTo(lowerNormal).offset(AJScreenWidth/40)
            make.right.equalTo(lowerNormal).offset(-AJScreenWidth/40)
            make.centerY.equalTo(lowerNormalValue.snp.bottom)
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
        
    }
}
