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
        
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    @objc func test(){
        initChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("chartViewController appear.")
        
        initChart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 界面消失时，重新加载页面
        //lineChartView.removeFromSuperview()
        //initChart()
    }
    
    func initChart(){
        //let title = DataViewController().rangePickerButton.title(for:.normal)
        
        // 初始化 图标所需要的数据
        let array = xAxisArray(Days: daysNum!)
        let data1 = recentDaysData(Days: daysNum!)
        switch pickerSelectedRow{
            case 1:
                lineChartView.lineChartView.xAxis.axisMaximum = Double(daysNum!)
//                let array = xAxisArray(Days: daysNum!)
//                let data1 = recentDaysData(Days: daysNum!)
                lineChartView.drawLineChart(xAxisArray: array as NSArray,xAxisData: data1)
                lineChartView.addLimitLine(13, "限制线",UIColor.red)
            case 2:
                lineChartView.lineChartView.xAxis.axisMaximum = 7
                lineChartView.drawLineChart(xAxisArray: array as NSArray,xAxisData: data1)
                lineChartView.addLimitLine(13, "限制线",UIColor.red)
            case 3:
                lineChartView.lineChartView.xAxis.axisMaximum = 30
                lineChartView.drawLineChart(xAxisArray: array as NSArray,xAxisData: data1)
                lineChartView.addLimitLine(13, "限制线",UIColor.red)
            default:
                lineChartView.lineChartView.xAxis.axisMaximum = Double(daysNum!)
                lineChartView.drawLineChart(xAxisArray: xAxisArray(startDate: startD!, endDate: endD!) as NSArray,xAxisData: DateToData(startD!, endD!))
                lineChartView.addLimitLine(13, "限制线",UIColor.red)
        }
    }

    

}
