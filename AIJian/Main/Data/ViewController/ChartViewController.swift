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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(headerView)
        
        self.headerView.snp.makeConstraints{(make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(44)
            
        }
        
        self.view.addSubview(lineChartView)
        self.lineChartView.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/30)
            make.right.equalToSuperview().offset(-AJScreenWidth/30)
            
            make.top.equalTo(self.headerView.snp.bottom)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
            
        }
        
        self.view.backgroundColor = UIColor.init(red: 255/255.0, green: 251/255.0, blue: 186/255.0, alpha: 1)
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue: "reloadChart"), object: nil)
    }
    @objc func test(){
        initChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("chartViewController appear.")
        
        lineChartView.lineChartView.leftAxis.axisMaximum = GetBloodLimit.getRandomDinnerTop() * 2
        
        initChart()
    }
    
    
    func initChart(){
        
        // 初始化 图标所需要的数据
        let array = xAxisArray(Days: daysNum!)
        let data1 = recentDaysData(Days: daysNum!)
        // 画限制线，标明低于和高于的界限
        // 该界限获取自动适应单位，所以不需判断单位
        print("lowLimit:\(GetBloodLimit.getRandomDinnerLow())")
        lineChartView.addLimitLine(GetBloodLimit.getRandomDinnerLow(), "低于", UIColor.yellow)
        lineChartView.addLimitLine(GetBloodLimit.getRandomDinnerTop(), "高于", UIColor.blue)
        lineChartView.lineChartView.xAxis.axisMaximum = Double(daysNum!)
        if data1.count > 0{
            // 根据所选中的时间范围器元素决定各界面的数据如何初始化
            switch pickerSelectedRow{
            case 1,2,3:
                //lineChartView.lineChartView.xAxis.axisMaximum = Double(daysNum!)
                
                lineChartView.drawLineChart(xAxisArray: array as NSArray,xAxisData: data1)
                //lineChartView.addLimitLine(13, "限制线",UIColor.red)
                //            case 2:
                //                lineChartView.lineChartView.xAxis.axisMaximum = 7
                //                lineChartView.drawLineChart(xAxisArray: array as NSArray,xAxisData: data1)
                //                //lineChartView.addLimitLine(13, "限制线",UIColor.red)
                //            case 3:
                //                lineChartView.lineChartView.xAxis.axisMaximum = 30
                //                lineChartView.drawLineChart(xAxisArray: array as NSArray,xAxisData: data1)
            //lineChartView.addLimitLine(13, "限制线",UIColor.red)
            default:
                //lineChartView.lineChartView.xAxis.axisMaximum = Double(daysNum!)
                lineChartView.drawLineChart(xAxisArray: xAxisArray(startDate: startD!, endDate: endD!) as NSArray,xAxisData: DateToData(startD!, endD!))
                //lineChartView.addLimitLine(13, "限制线",UIColor.red)
            }
        }
        
    }

    

}
