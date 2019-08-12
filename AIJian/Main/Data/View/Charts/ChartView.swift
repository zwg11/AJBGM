//
//  ChartView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/30.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Charts
import SnapKit

class ChartView: UIView {

    lazy var lineChartView:LineChartView = {
        //let _lineChartView = LineChartView.init(frame: CGRect.init(x: 0, y: 20, width: 300, height: 300))
        let _lineChartView = LineChartView()
        //_lineChartView.delegate = self//
        _lineChartView.backgroundColor = UIColor.init(red: 230/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1.0)
        _lineChartView.doubleTapToZoomEnabled = false
        _lineChartView.chartDescription?.text = ""//设置为""隐藏描述文字
        
        // 是否显示图表左下角的图例，变false使得其不显示
        _lineChartView.legend.enabled = false
        
        _lineChartView.noDataText = "暂无数据"
        _lineChartView.noDataTextColor = UIColor.gray
        _lineChartView.noDataFont = UIFont.boldSystemFont(ofSize: 14)
        
        // 是否支持拖拽,使x轴可以拖拽，y轴不可以
        _lineChartView.scaleXEnabled = true
        _lineChartView.scaleYEnabled = false
        
        //y轴
        _lineChartView.rightAxis.enabled = false
        let leftAxis = _lineChartView.leftAxis
        leftAxis.labelCount = 10
        leftAxis.forceLabelsEnabled = false
        leftAxis.axisLineColor = UIColor.black
        leftAxis.labelTextColor = UIColor.black
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
        leftAxis.labelPosition = .outsideChart
        leftAxis.gridColor = UIColor.init(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0)//网格
        leftAxis.gridAntialiasEnabled = false//抗锯齿
        leftAxis.axisMaximum = 500//最大值
        leftAxis.axisMinimum = 0
        leftAxis.labelCount = 11//多少等分
        
        //x轴
        let xAxis = _lineChartView.xAxis
        xAxis.granularityEnabled = true
        xAxis.labelTextColor = UIColor.black
        xAxis.labelFont = UIFont.systemFont(ofSize: 10.0)
        xAxis.labelPosition = .bottom
        xAxis.gridColor = UIColor.init(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0)
        xAxis.axisLineColor = UIColor.black
        xAxis.labelCount = 12
        return _lineChartView
    }()

    func drawLineChart(){
        self.addLimitLine(250, "限制线")
        let xValues = ["07.21","07.22","07.23","07.24","07.25","07.26","07.27"]
        lineChartView.xAxis.valueFormatter = VDChartAxisValueFormatter.init(xValues as NSArray)
        lineChartView.leftAxis.valueFormatter = VDChartAxisValueFormatter.init()
        
        // 图表数据数组
        var yDataArray1 = [ChartDataEntry]()
        for i in 0...xValues.count-1 {
            let y = arc4random()%500
            // 生成图表数据结构
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            // 将数据添加到图表数据数组中
            yDataArray1.append(entry)
        }
        // 将数据数组添加到表中（entries），并附说明（label）
        let set1 = LineChartDataSet.init(entries: yDataArray1, label: "")

        
        set1.drawIconsEnabled = false

        
        set1.colors = [UIColor.blue]
        set1.drawCirclesEnabled = false//绘制转折点
        set1.lineWidth = 1.0
        
//        // 同样是生成图表数据并放入对应数组中
//        var yDataArray2 = [ChartDataEntry]()
//        for i in 0...xValues.count-1 {
//            let y = arc4random()%500+1
//            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
//
//            yDataArray2.append(entry)
//        }
//        // 设置折线数据、说明、颜色和宽度
//        let set2 = LineChartDataSet.init(entries: yDataArray2, label: "绿色")
//        set2.colors = [UIColor.green]
//        set2.drawCirclesEnabled = false
//        set2.lineWidth = 1.0
        
        let data = LineChartData.init(dataSets: [set1])
        
        lineChartView.data = data
        lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInBack)
    }
    
    func addLimitLine(_ value:Double, _ desc:String) {
        let limitLine = ChartLimitLine.init(limit: value, label: desc)
        //线
        limitLine.lineWidth = 1
        limitLine.lineColor = UIColor.red
        limitLine.lineDashLengths = [2.0,2.0]
        //文字
        limitLine.valueFont = UIFont.systemFont(ofSize: 10.0)
        limitLine.valueTextColor = UIColor.black
        limitLine.labelPosition = .bottomRight
        lineChartView.leftAxis.addLimitLine(limitLine)
    }
    
    func setupUI(){
        self.addSubview(lineChartView)
        self.drawLineChart()
        
        self.lineChartView.snp_makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
    }
}
