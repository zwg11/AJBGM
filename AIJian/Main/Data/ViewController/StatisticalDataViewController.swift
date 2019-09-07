//
//  StatisticalDataViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit
import SwiftDate

class StatisticalDataViewController: UIViewController,UIScrollViewDelegate {

    var scrollView:UIScrollView?
    // 平均统计视图
    lazy var averageview:averageView = {
        let view = averageView()
        view.setupUI()
        return view
    }()
    // 总体检测结果视图
    lazy var totalview:perAndAfterMealTests = {
        let view = perAndAfterMealTests()
        // 注，先设置style，再运行 setupUI()
        view.style = .total
        view.setupUI()
        return view
    }()
    // 餐前检测结果视图
    lazy var perMeal:perAndAfterMealTests = {
        let view = perAndAfterMealTests()
        // 注，先设置style，再运行 setupUI()
        view.style = .perMeal
        view.setupUI()
        return view
    }()
    // 餐后检测结果视图
    lazy var afterMeal:perAndAfterMealTests = {
        let view = perAndAfterMealTests()
        // 注，先设置style，再运行 setupUI()
        view.style = .afterMeal
        view.setupUI()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // scrollView的高度是这样得到的：
        // 屏幕高度 - 状态栏高度 - 导航栏高度 - 标题高度
        // 导航栏 和 标题栏 高度都为 44

        scrollView = UIScrollView()
        scrollView!.contentSize = CGSize(width: self.view.frame.size.width, height: 620)
        scrollView!.alwaysBounceVertical = true
        scrollView!.showsVerticalScrollIndicator = true
        self.view.addSubview(scrollView!)
        scrollView!.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
        }
        
        // 平均值窗口初始化

        scrollView?.addSubview(averageview)
        averageview.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(190)
        }
        
        // 总体检测结果窗口初始化

        scrollView?.addSubview(totalview)
        totalview.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(averageview.snp.bottom)
            make.height.equalTo(140)
        }
      
        // 餐前检测窗口初始化
        scrollView?.addSubview(perMeal)
        perMeal.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(totalview.snp.bottom)
            make.height.equalTo(140)
        }
        
        // 餐后检测窗口初始化
        scrollView?.addSubview(afterMeal)
        afterMeal.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(perMeal.snp.bottom)
            make.height.equalTo(140)
        }
    // 设置通知，当选择日期范围改变时执行动作来更新视图内容
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue: "reloadData"), object: nil)
    }
    // 更新视图内容
    @objc func test(){
        initContent()
    }
    // 设置视图每次出现时滚动视图都回到顶部
    override func viewWillAppear(_ animated: Bool) {
        self.scrollView?.contentOffset = CGPoint(x: 0, y: 0)
        initContent()
        
        
    }


    func initContent(){

        
        let today = DateInRegion().dateAt(.endOfDay).date
        let end = today + 1.seconds
        // 监听导航栏右按钮的文本，对于不同的文本生成对应的数据
        switch pickerSelectedRow{
            
        case 1:
            let start = end - 3.days
            initDataSortedByDate(startDate: start, endDate: end, userId: userId!)
            //sortedTimeOfData()

        case 2:
            let start = end - 7.days
            initDataSortedByDate(startDate: start, endDate: end, userId: userId!)
            //sortedTimeOfData()

        case 3:
            let start = end - 30.days
            initDataSortedByDate(startDate: start, endDate: end, userId: userId!)
            //sortedTimeOfData()

        default:
            print("zidingyi ")
            
        }
        
        // 平均视图初始化
        averageview.labelUpdate()
        // 对检测视图的数据进行初步处理
        totalview.checkInit()
        // 总体检测视图初始化
        totalview.totalInit()
        // 饭前检测视图初始化
        perMeal.perMealInit()
        // 饭后s检测视图初始化
        afterMeal.afterMealInit()
    }

}
