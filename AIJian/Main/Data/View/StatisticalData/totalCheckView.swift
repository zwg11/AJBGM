//
//  checkViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/22.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class totalCheckView: UIView {
    // 初始化字体颜色，红 黄 绿 蓝
    let greenColor = UIColor.init(red: 97.0/255.0, green: 213.0/255.0, blue: 96.0/255.0, alpha: 1)
    let redColor = UIColor.init(red: 229.0/255.0, green: 28.0/255.0, blue: 35.0/255.0, alpha: 1)
    let yellowColor = UIColor.init(red: 229.0/255.0, green: 217.0/255.0, blue: 28.0/255.0, alpha: 1)
    let blueColor = UIColor.init(red: 139.0/255.0, green: 159.0/255.0, blue: 74.0/255.0, alpha: 1)
    
    private var title:String?
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
    lazy var checkViewTitle:UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        //label.text = String("total - 3 tests")
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    // 总体检测视图
    private lazy var totalTestView:UIView = {
       let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = borderColor.cgColor
        return view
    }()
    
    // 为方便布局，再设置两个视图，分别占据总体检测视图的一半
    // 左边视图
    private lazy var leftView:UIView = {
        let view = UIView()
        return view
    }()
    // 右边视图
    private lazy var rightView:UIView = {
        let view = UIView()
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
        
        // 整体框的布局
        self.addSubview(totalTestView)
        self.totalTestView.snp.makeConstraints{ (make) in
            make.top.equalTo(checkViewTitle.snp.bottom)
            make.height.equalTo(96)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            
        }
        // 左半部视图
        self.totalTestView.addSubview(leftView)
        leftView.snp.makeConstraints{(make) in
            make.left.bottom.top.equalToSuperview()
            make.right.equalTo(totalTestView.snp.centerX)
        }
        // 右半部视图
        self.totalTestView.addSubview(rightView)
        rightView.snp.makeConstraints{(make) in
            make.right.bottom.top.equalToSuperview()
            make.left.equalTo(totalTestView.snp.centerX)
        }
        // MARK: - Label布局约束
        // 所有Label 高30 宽totalTestView的 1/4 
        // ***************************低血糖*****************************
        self.leftView.addSubview(low)
        // 设置布局：左边界、顶部与父视图相同，右边界为父视图的中间
        self.low.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.right.equalTo(leftView.snp.centerX)
            
        }
        
        // 紧挨上面的视图的底部，长宽高都一样
        self.leftView.addSubview(lowValue)
        self.lowValue.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.top.equalTo(low.snp.bottom)
            make.height.equalTo(30)
            make.right.equalTo(low.snp.right)
            
        }
        
        // 紧挨上面的视图的底部，长宽高都一样
        self.leftView.addSubview(lowPercent)
        self.lowPercent.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.top.equalTo(lowValue.snp.bottom)
            make.height.equalTo(30)
            make.right.equalTo(low.snp.right)
            
        }
        
        // ***************************低于*****************************
        self.leftView.addSubview(lowerNormal)
        self.lowerNormal.snp.makeConstraints{ (make) in
            make.left.equalTo(low.snp.right)
            make.top.right.equalToSuperview()
            make.height.equalTo(30)
            

        }

        self.leftView.addSubview(lowerNormalValue)
        self.lowerNormalValue.snp.makeConstraints{ (make) in
            make.left.equalTo(lowerNormal.snp.left)
            make.top.equalTo(lowerNormal.snp.bottom)
            make.height.equalTo(30)
            make.right.equalToSuperview()

        }

        self.leftView.addSubview(lowerNormalPercent)
        self.lowerNormalPercent.snp.makeConstraints{ (make) in
            make.left.equalTo(lowerNormal.snp.left)
            make.top.equalTo(lowerNormalValue.snp.bottom)
            make.height.equalTo(30)
            make.right.equalToSuperview()

        }

        // ***************************正常*****************************
        self.rightView.addSubview(normal)
        self.normal.snp.makeConstraints{ (make) in

            make.left.top.equalToSuperview()
            make.height.equalTo(low.snp.height)
            make.right.equalTo(rightView.snp.centerX)

        }

        self.rightView.addSubview(normalValue)
        self.normalValue.snp.makeConstraints{ (make) in
            make.left.equalTo(normal.snp.left)
            make.top.equalTo(normal.snp.bottom)
            make.height.equalTo(low.snp.height)
            make.right.equalTo(normal.snp.right)

        }

        self.rightView.addSubview(normalPercent)
        self.normalPercent.snp.makeConstraints{ (make) in
            make.left.equalTo(normal.snp.left)
            make.top.equalTo(normalValue.snp.bottom)
            make.height.equalTo(low.snp.height)
            make.right.equalTo(normal.snp.right)

        }
//
        // ***************************高于*****************************
        self.rightView.addSubview(higherNormal)
        self.higherNormal.snp.makeConstraints{ (make) in
            make.left.equalTo(normal.snp.right)
            make.top.right.equalToSuperview()
            make.height.equalTo(low.snp.height)

        }

        self.rightView.addSubview(higherNormalValue)
        self.higherNormalValue.snp.makeConstraints{ (make) in
            make.left.equalTo(normal.snp.right)
            make.top.equalTo(higherNormal.snp.bottom)
            make.height.equalTo(low.snp.height)
            make.right.equalToSuperview()

        }
        
        self.rightView.addSubview(higherNormalPercent)
        self.higherNormalPercent.snp.makeConstraints{ (make) in
            make.left.equalTo(normal.snp.right)
            make.top.equalTo(higherNormalValue.snp.bottom)
            make.height.equalTo(low.snp.height)
            make.right.equalToSuperview()

        }
        
        // ***************************下划线******************************
        self.totalTestView.addSubview(lineView1)
        self.lineView1.snp.makeConstraints{ (make) in
            make.centerY.equalTo(lowValue.snp.bottom)
            make.height.equalTo(2)

            make.left.equalTo(low.snp.left).offset(10)
            make.right.equalTo(low.snp.right).offset(-10)
        }
        
        self.totalTestView.addSubview(lineView2)
        self.lineView2.snp.makeConstraints{ (make) in
            make.centerY.equalTo(lowerNormalValue.snp.bottom)
            make.height.equalTo(2)
  
            make.left.equalTo(lowerNormal.snp.left).offset(10)
            make.right.equalTo(lowerNormal.snp.right).offset(-10)
            
        }
        
        self.totalTestView.addSubview(lineView3)
        self.lineView3.snp.makeConstraints{ (make) in
            make.centerY.equalTo(normalValue.snp.bottom)
            make.height.equalTo(2)

            make.left.equalTo(normal.snp.left).offset(10)
            make.right.equalTo(normal.snp.right).offset(-10)
            
        }
        
        self.totalTestView.addSubview(lineView4)
        self.lineView4.snp.makeConstraints{ (make) in
            make.centerY.equalTo(higherNormalValue.snp.bottom)
            make.height.equalTo(2)
 
            make.left.equalTo(higherNormal.snp.left).offset(10)
            make.right.equalTo(higherNormal.snp.right).offset(-10)
            
        }
        
    }


}
