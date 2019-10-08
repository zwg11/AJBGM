//
//  ChartViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {
    
    private lazy var headerView:ChartHeaderView = {
        let view = ChartHeaderView()
        view.backgroundColor = UIColor.white
        view.setUpUI()
        return view
    }()
    
    lazy var lineChartView:ChartView = {
        let view = ChartView()
        view.setupUI()

        view.lineChartView.xAxis.labelCount = 4
        return view
    }()
    
    private lazy var staticV:StaticView = {
        let view = StaticView()
        view.setupUI()
        view.initLabelText()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(headerView)
        
        self.headerView.snp.makeConstraints{(make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(44)
            
        }
        
        self.view.addSubview(staticV)
        staticV.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(AJScreenWidth/6)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
        }
        
        self.view.addSubview(lineChartView)
        self.lineChartView.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/30)
            make.right.equalToSuperview().offset(-AJScreenWidth/30)
            
            make.top.equalTo(self.headerView.snp.bottom)
            make.bottom.equalTo(staticV.snp.top)
        }
        
        self.view.backgroundColor = ThemeColor
        // Do any additional setup after loading the view.
        // 监听所选时间范围的变化
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue: "reloadChart"), object: nil)
    }
    
    @objc func test(){
        initChart()
        staticV.initLabelText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("chartViewController appear.")
        
        lineChartView.lineChartView.leftAxis.axisMaximum = GetBloodLimit.getRandomDinnerTop() * 2
        
        initChart()
        staticV.initLabelText()
    }
        
    func initChart(){
        
        // 初始化 图标所需要的数据
        let array = xAxisArray(Days: daysNum!)
        let data1 = recentDaysData(Days: daysNum!)
        // 画限制线，标明低于和高于的界限
        // 该界限获取自动适应单位，所以不需判断单位
        print("lowLimit:\(GetBloodLimit.getRandomDinnerLow())")
        // 移除所有限制线
        for i in lineChartView.lineChartView.leftAxis.limitLines{
            lineChartView.lineChartView.leftAxis.removeLimitLine(i)
        }
        
        let low = GetBloodLimit.getRandomDinnerLow()
        let high = GetBloodLimit.getRandomDinnerTop()
        lineChartView.addLimitLine(low, "\(low)", UIColor.orange)
        lineChartView.addLimitLine(high, "\(high)", UIColor.red)
        // 设置x轴的最大坐标值
        lineChartView.lineChartView.xAxis.axisMaximum = Double(daysNum!)
        // 根据所选中的时间范围器元素决定各界面的数据如何初始化
        switch pickerSelectedRow{
        case 1,2,3:
            lineChartView.drawLineChart(xAxisArray: array as NSArray,xAxisData: data1)
        default:
            lineChartView.drawLineChart(xAxisArray: xAxisArray(startDate: startD!, endDate: endD!) as NSArray,xAxisData: DateToData(startD!, endD!))
        }
    }
}
