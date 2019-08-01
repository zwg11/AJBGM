//
//  perAndAfterMealTests.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/22.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class perAndAfterMealTests: UIView {


    // 由于c餐前餐后窗口布局一样，只有标题不同
    // 故设置标题变量
    // 在初始化该类时初始化该字符串实现不同的标题
    var isPerMeal:Bool = true
   // var title:String = String("per meal - 0 tests")
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
        label.text = String("per meal - 0 tests")
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    func titleChange(){
        if isPerMeal == false{
            checkViewTitle.text = String("after meal - 0 tests")
        }
        else{
            checkViewTitle.text = String("per meal - 0 tests")
        }
    }
    // 总体检测视图
    private lazy var totalTestView:UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = borderColor.cgColor
        return view
    }()
    
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
        self.addSubview(checkViewTitle)
        self.checkViewTitle.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo((AJScreenWidth-20)/2)
        }
        
        
        self.addSubview(totalTestView)
        self.totalTestView.snp.makeConstraints{ (make) in
            make.top.equalTo(checkViewTitle.snp.bottom)
            make.height.equalTo(96)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            
        }
        // MARK: - Label布局约束
        // 所有Label 高30 宽totalTestView的 1/4
        // ***************************低血糖*****************************
        self.totalTestView.addSubview(low)
        self.low.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        self.totalTestView.addSubview(lowValue)
        self.lowValue.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.top.equalTo(low.snp.bottom)
            make.height.equalTo(30)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        self.totalTestView.addSubview(lowPercent)
        self.lowPercent.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.top.equalTo(lowValue.snp.bottom)
            make.height.equalTo(30)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        // ***************************低于*****************************
        self.totalTestView.addSubview(lowerNormal)
        self.lowerNormal.snp.makeConstraints{ (make) in
            make.left.equalTo(low.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        self.totalTestView.addSubview(lowerNormalValue)
        self.lowerNormalValue.snp.makeConstraints{ (make) in
            make.left.equalTo(lowerNormal.snp.left)
            make.top.equalTo(lowerNormal.snp.bottom)
            make.height.equalTo(30)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        self.totalTestView.addSubview(lowerNormalPercent)
        self.lowerNormalPercent.snp.makeConstraints{ (make) in
            make.left.equalTo(lowerNormal.snp.left)
            make.top.equalTo(lowerNormalValue.snp.bottom)
            make.height.equalTo(30)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        // ***************************正常*****************************
        self.totalTestView.addSubview(normal)
        self.normal.snp.makeConstraints{ (make) in
            make.left.equalTo(lowerNormal.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(low.snp.height)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        self.totalTestView.addSubview(normalValue)
        self.normalValue.snp.makeConstraints{ (make) in
            make.left.equalTo(lowerNormal.snp.right)
            make.top.equalTo(normal.snp.bottom)
            make.height.equalTo(low.snp.height)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        self.totalTestView.addSubview(normalPercent)
        self.normalPercent.snp.makeConstraints{ (make) in
            make.left.equalTo(lowerNormal.snp.right)
            make.top.equalTo(normalValue.snp.bottom)
            make.height.equalTo(low.snp.height)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        //
        // ***************************高于*****************************
        self.totalTestView.addSubview(higherNormal)
        self.higherNormal.snp.makeConstraints{ (make) in
            make.left.equalTo(normal.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(low.snp.height)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        self.totalTestView.addSubview(higherNormalValue)
        self.higherNormalValue.snp.makeConstraints{ (make) in
            make.left.equalTo(normal.snp.right)
            make.top.equalTo(higherNormal.snp.bottom)
            make.height.equalTo(low.snp.height)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        self.totalTestView.addSubview(higherNormalPercent)
        self.higherNormalPercent.snp.makeConstraints{ (make) in
            make.left.equalTo(normal.snp.right)
            make.top.equalTo(higherNormalValue.snp.bottom)
            make.height.equalTo(low.snp.height)
            make.width.equalTo((AJScreenWidth-20)/4)
            
        }
        
        // ***************************下划线******************************
        self.totalTestView.addSubview(lineView1)
        self.lineView1.snp.makeConstraints{ (make) in
            make.centerX.equalTo(low.snp.centerX)
            make.centerY.equalTo(lowValue.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo((AJScreenWidth-20)/5)
            
        }
        
        self.totalTestView.addSubview(lineView2)
        self.lineView2.snp.makeConstraints{ (make) in
            make.centerX.equalTo(lowerNormal.snp.centerX)
            make.centerY.equalTo(lowerNormalValue.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo((AJScreenWidth-20)/5)
            
        }
        
        self.totalTestView.addSubview(lineView3)
        self.lineView3.snp.makeConstraints{ (make) in
            make.centerX.equalTo(normal.snp.centerX)
            make.centerY.equalTo(normalValue.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo((AJScreenWidth-20)/5)
            
        }
        
        self.totalTestView.addSubview(lineView4)
        self.lineView4.snp.makeConstraints{ (make) in
            make.centerX.equalTo(higherNormal.snp.centerX)
            make.centerY.equalTo(higherNormalValue.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo((AJScreenWidth-20)/5)
            
        }
        
    }
}
