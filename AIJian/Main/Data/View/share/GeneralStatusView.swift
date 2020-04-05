//
//  GeneralStatusView.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/3.
//  Copyright © 2019 apple. All rights reserved.
//
// 该视图为发送按钮所需生成的图片视图
//  主体由图表和表格组成，外加一些文字说明label
//  图标和表格生成方法与 图表页 和 表格页 一致，在此不做详细注释

import UIKit

class GeneralStatusView: UIView {

    // 标题字符串
    let str = "Trend Report - Blood Glucose"

    // 姓名label
    lazy  var nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.black
        return label
    }()
    // 电话label
    lazy  var phoneLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.black
        return label
    }()
    // 标题label
    private lazy  var titleLabel:UILabel = {
        let label = initLabel(str)
        return label
    }()
    
    private lazy var StaticExcel:SharedStaticView = {
        let view  = SharedStaticView()
        view.setupUI()
        view.initViewData()
        return view
    }()
    
    func initLabel(_ text:String) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.black
        return label
    }
    // 时间范围label
    lazy  var rangeLabel:UILabel = {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy/MM/dd"
        let st = dateformat.string(from: startD!)
        let end = dateformat.string(from: endD!)
        let label = initLabel("\(st)--\(end)")
        return label
    }()
    
    private lazy var chart = ChartView()
    
    
    func setupUI(){
        chart.lineChartView.leftAxis.labelTextColor = UIColor.black
        
        self.addSubview(titleLabel)
        self.addSubview(rangeLabel)
        titleLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview()
            make.height.equalTo(45)
        }
        
        rangeLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(45)
        }
        
        self.addSubview(nameLabel)
        self.addSubview(phoneLabel)
        nameLabel.snp.makeConstraints{(make) in
            make.right.equalToSuperview().offset(-100)
            make.top.equalTo(titleLabel)
            make.height.equalTo(45)
        }
        phoneLabel.snp.makeConstraints{(make) in
            make.right.equalToSuperview().offset(-100)
            make.top.equalTo(rangeLabel)
            make.height.equalTo(45)
        }
        // 画图标
        self.addSubview(chart)
        initChart()
        chart.setupUI()
        chart.lineChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 20)
        chart.lineChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 15.0)
        chart.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(rangeLabel.snp.bottom).offset(40)
            make.height.equalTo(600)
        }
        
        self.addSubview(StaticExcel)
        StaticExcel.snp.makeConstraints{(make) in
            make.left.right.equalTo(chart)
            make.top.equalTo(chart.snp.bottom).offset(40)
            make.height.equalTo(300)
        }

        self.backgroundColor = UIColor.white
        self.frame = CGRect(x: 0, y: 2000, width: 1200, height: 1100 )
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue: "reloadView"), object: nil)
        
    }
    
    @objc func test(){
        // 可以刷新了
        initChart()
        StaticExcel.initViewData()

    }
    
    func initChart(){
        // 得到数据中的血糖最大值
         var maxGluValue = 0.0
         if glucoseTimeAndValue.count > 0{
             for i in glucoseTimeAndValue{
                 if maxGluValue < i.value{
                     maxGluValue = i.value
                 }
             }
         }
        // print("maxgluvalue:",maxGluValue)
         // 如果maxGluValue不超过300，则y轴坐标最大值为300，否则设为maxGluValue+10
         if GetUnit.getBloodUnit() == "mmol/L"{
             if maxGluValue < 16.6{
                 chart.lineChartView.leftAxis.axisMaximum = 16.6
             }else{
                 chart.lineChartView.leftAxis.axisMaximum = maxGluValue+2
             }
            chart.lineChartView.leftAxis.axisMaximum = maxGluValue+2
             
         }else{
             if maxGluValue < 300{
                 chart.lineChartView.leftAxis.axisMaximum = 300
             }else{
                 chart.lineChartView.leftAxis.axisMaximum = maxGluValue+10
             }
            chart.lineChartView.leftAxis.axisMaximum = maxGluValue+10
         }
//        if GetUnit.getBloodUnit() == "mmol/L"{
//            chart.lineChartView.leftAxis.axisMaximum = 16.6
//        }else{
//            chart.lineChartView.leftAxis.axisMaximum = 300
//        }

        // 初始化 图标所需要的数据
        let array = xAxisArray(Days: daysNum!)
        let data1 = recentDaysData(Days: daysNum!)
        // 根据所选中的时间范围器元素决定各界面的数据如何初始化
        // 画限制线，标明低于和高于的界限
        // 该界限获取自动适应单位，所以不需判断单位
        for i in chart.lineChartView.leftAxis.limitLines{
            chart.lineChartView.leftAxis.removeLimitLine(i)
        }
        let low = GetBloodLimit.getEmptyStomachLow()
        let high = GetBloodLimit.getAfterDinnerTop()
        let Orange = kRGBColor(255, 165, 0, 0.8)
        let Red = kRGBColor(255, 0, 0, 0.8)
        chart.addLimitLine(low, low, Orange)
        chart.addLimitLine(high, high, Red)
//        let Orange = kRGBColor(255, 165, 0, 0.3)
//        let Red = kRGBColor(255, 0, 0, 0.3)
//        chart.addLimitLine(GetBloodLimit.getEmptyStomachLow(), "低于", Orange)
//        chart.addLimitLine(GetBloodLimit.getAfterDinnerTop(), "高于", Red)
        chart.lineChartView.xAxis.gridColor = UIColor.lightGray
        chart.lineChartView.leftAxis.gridColor = UIColor.lightGray
        switch pickerSelectedRow{
        case 1,2,3:
            chart.lineChartView.xAxis.axisMaximum = Double(daysNum!)
            chart.drawLineChartWithoutAnimate(xAxisArray: array as NSArray,xAxisData: data1)
        default:
            chart.lineChartView.xAxis.axisMaximum = Double(daysNum!)
            chart.drawLineChartWithoutAnimate(xAxisArray: xAxisArray(startDate: startD!, endDate: endD!) as NSArray,xAxisData: DateToData(startD!, endD!))
        }
    }

}
