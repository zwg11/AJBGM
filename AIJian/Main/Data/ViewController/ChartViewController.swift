//
//  ChartViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Charts
import SwiftDate

class ChartViewController: UIViewController,ChartViewDelegate{
    
    private lazy var headerView:ChartHeaderView = {
        let view = ChartHeaderView()
        view.backgroundColor = UIColor.white
        view.setUpUI()
        return view
    }()
    
    lazy var lineChartView:ChartView = {
        let view = ChartView()
        view.lineChartView.delegate = self
        view.setupUI()
        
        //        view.lineChartView.delegate = self
        view.lineChartView.xAxis.labelCount = 4
        return view
    }()
    let indicator = CustomIndicatorView()
    private lazy var staticV:StaticView = {
        let view = StaticView()
        view.setupUI()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
            //            make.top.equalTo(self.headerView.snp.bottom)
            make.top.equalToSuperview()
            make.bottom.equalTo(staticV.snp.top)
        }
        
        //        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
        
        indicator.setupUI("",UIColor.clear)
        reloadChart()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadChart), name: NSNotification.Name(rawValue: "reloadChart"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(indicatorStart), name: NSNotification.Name(rawValue: "indicator"), object: nil)

    }
     
    override func viewWillAppear(_ animated: Bool) {
        reloadChart()
    }
    
    @objc func reloadChart(){
        indicatorStart()
        initChart()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "reloadChart"), object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "indicator"), object: nil)
        // 移除原图表
        lineChartView.removeFromSuperview()
    }
    
    @objc func indicatorStart(){
        self.view.addSubview(indicator)
        indicator.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview()
        }
        indicator.startIndicator()
        // 移除原图表
        lineChartView.removeFromSuperview()
    }
    func initChart(){


        // 异步设置图表
        DispatchQueue.global().async {
            // 设置图表的数据
            chartData()
            // 设置x轴的最大坐标值
//            self.lineChartView.lineChartView.xAxis.axisMaximum = Double(daysNum!)
            // 画限制线，标明低于和高于的界限
            // 该界限获取自动适应单位，所以不需判断单位
            //        print("lowLimit:\(GetBloodLimit.getRandomDinnerLow())")
            // 移除所有限制线
            for i in self.lineChartView.lineChartView.leftAxis.limitLines{
                self.lineChartView.lineChartView.leftAxis.removeLimitLine(i)
            }

            
            let low = GetBloodLimit.getEmptyStomachLow()
            let high = GetBloodLimit.getAfterDinnerTop()
            let Orange = kRGBColor(255, 165, 0, 0.5)
            let Red = kRGBColor(255, 0, 0, 0.5)
            self.lineChartView.addLimitLine(low, low, Orange)
            self.lineChartView.addLimitLine(high, high, Red)
            
            // 图表参数设置
            // 得到数据中的血糖最大值
            var maxGluValue = 0.0
            /*
            if glucoseTimeAndValue.count > 0{
                for i in glucoseTimeAndValue{
                    if maxGluValue < i.value{
                        maxGluValue = i.value
                    }
                }
            }*/
            maxGluValue = glucoseValue.max() ?? 0.0
            // 设置x轴的最大坐标值
            self.lineChartView.lineChartView.xAxis.axisMaximum = Double(daysNum!)
            // 如果maxGluValue不超过300，则y轴坐标最大值为300，否则设为maxGluValue+10
            if GetUnit.getBloodUnit() == "mmol/L"{
                if maxGluValue < 16.6{
                    self.lineChartView.lineChartView.leftAxis.axisMaximum = 16.6
                }else{
                    self.lineChartView.lineChartView.leftAxis.axisMaximum = maxGluValue+2
                }
                
            }else{
                if maxGluValue < 300{
                    self.lineChartView.lineChartView.leftAxis.axisMaximum = 300
                }else{
                    self.lineChartView.lineChartView.leftAxis.axisMaximum = maxGluValue+10
                }
                //                lineChartView.lineChartView.leftAxis.axisMaximum = 300
            }
            
            let list = DateToData(startD!, endD!, isGetData: false)
//            let xAxisArr = xAxisArray(startDate: startD!, endDate: endD!) as NSArray
            // 主程序中刷新图表
            DispatchQueue.main.async {
                // 图表底部视图加载
                self.staticV.initLabelText()
                // 根据所选中的时间范围器元素决定各界面的数据如何初始化
                switch pickerSelectedRow{
                case 1,2,3:
                    // 初始化 图标所需要的数据
//                    let array = xAxisArray(Days: daysNum!)
                    let data1 = recentDaysData(Days: daysNum!, isGetData: false)
//                    self.lineChartView.drawLineChart(xAxisArray: array as NSArray,xAxisData: data1)
                    self.lineChartView.drawLineChart(xAxisArray: nil,xAxisData: data1)
                    

                default:
                    self.lineChartView.drawLineChart(xAxisArray: nil,xAxisData: list)
                }

                
                self.view.addSubview(self.lineChartView)
                self.lineChartView.snp.makeConstraints{(make) in
                    make.left.equalToSuperview().offset(AJScreenWidth/30)
                    make.right.equalToSuperview().offset(-AJScreenWidth/30)

                    //            make.top.equalTo(self.headerView.snp.bottom)
                    make.top.equalToSuperview()
                    make.bottom.equalTo(self.staticV.snp.top)
                }
                self.indicator.stopIndicator()
            }
        }

    }
    
    //    折线上的点选中回调
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry,highlight: Highlight) {
        //显示该点的MarkerView标签
        self.showMarkerView(valuey: "\(entry.y)",valuex:"\(entry.x)")
    }
    
    // 背景图，点击后MarkerView消失
    private lazy var backButton:UIButton = {
        let button = UIButton.init(type: .system)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(ViewDismiss), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight)
        return button
    }()
    
    @objc func ViewDismiss()
    {
        backButton.removeFromSuperview()
        markerView.removeFromSuperview()
    }
    
    private lazy var markerView:UIView = {
        let view = UIView()
        view.addSubview(MarkTimelabel)
        view.addSubview(MarkValuelabel)
        // adopt dark model
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = UIColor.white
        }
        view.layer.cornerRadius = 5
        return view
        
    }()
    
    private lazy var MarkTimelabel:UILabel = {
        let label =  UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 30))
        if #available(iOS 13.0, *) {
            label.textColor = UIColor.label
        } else {
            // Fallback on earlier versions
            label.textColor = UIColor.black
        }
        label.font = UIFont.systemFont(ofSize: 18)
        //        label.backgroundColor = UIColor.gray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var MarkValuelabel:UILabel = {
        let label =  UILabel(frame: CGRect(x: 10, y: 40, width: 200, height: 30))
        if #available(iOS 13.0, *) {
            label.textColor = UIColor.label
        } else {
            // Fallback on earlier versions
            label.textColor = UIColor.black
        }
        
        label.font = UIFont.systemFont(ofSize: 18)
        //            label.backgroundColor = UIColor.gray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    //显示MarkerView标签
    func showMarkerView(valuey:String,valuex:String){
        let currentX = Double(valuex)! * 1440.0
        // 创建一个时间格式器
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let timezone = TimeZone(identifier: "UTC")
        dateFormatter.timeZone = timezone
        let xxxx = startD! + Int(currentX).minutes
        MarkTimelabel.text = "\(dateFormatter.string(from: xxxx))"
        
        let markValue = GetUnit.getBloodUnit()=="mmol/L" ? String(format: "%.1f", Double(valuey)!) : String(format: "%.0f", Double(valuey)!)
        MarkValuelabel.text = "\(markValue) " + GetUnit.getBloodUnit()
        //        MarkValuelabel.text = "BG Value:\(valuey)" + GetUnit.getBloodUnit()
        
        //        let marker = MarkerView()
        //        marker.chartView = self.lineChartView.lineChartView
        //        marker.addSubview(MarkTimelabel)
        //        marker.addSubview(MarkValuelabel)
        
        //        UIView.animate(withDuration: 5, animations: {
        self.navigationController?.view.addSubview(self.backButton)
        self.navigationController?.view.addSubview(self.markerView)
        self.backButton.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
            
        }
        
        self.markerView.snp.makeConstraints{(make) in
            make.center.equalToSuperview()
            make.width.equalTo(AJScreenWidth/5*3)
            make.height.equalTo(80)
        }
        //        })
        
        
        
        //        marker.addSubview(label)
        //        self.lineChartView.lineChartView.marker = marker
    }
}
