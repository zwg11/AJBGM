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
import SwiftDate

class ChartView: UIView ,ChartViewDelegate{

    lazy var lineChartView:LineChartView = {
        //let _lineChartView = LineChartView.init(frame: CGRect.init(x: 0, y: 20, width: 300, height: 300))
        let _lineChartView = LineChartView()
        //_lineChartView.delegate = self//
        _lineChartView.backgroundColor = UIColor.white
        _lineChartView.doubleTapToZoomEnabled = false
        _lineChartView.chartDescription?.text = ""//设置为""隐藏描述文字
        
        _lineChartView.noDataText = "暂无数据"
        _lineChartView.noDataTextColor = UIColor.gray
        _lineChartView.noDataFont = UIFont.boldSystemFont(ofSize: 20)
        // 是否显示图表左下角的图例，变false使得其不显示
        _lineChartView.legend.enabled = false
        // 是否支持拖拽
        _lineChartView.scaleXEnabled = true
        _lineChartView.scaleYEnabled = false
        // x、y轴是否支持自动缩放
        //_lineChartView.autoScaleMinMaxEnabled = false
        //_lineChartView.xAxis.axisLineWidth = 720//x轴宽度
        //_lineChartView.xAxis.labelRotationAngle = -20 //刻度文字倾斜角度
        //y轴
        _lineChartView.rightAxis.enabled = false
        let leftAxis = _lineChartView.leftAxis
        leftAxis.labelCount = 6
        leftAxis.forceLabelsEnabled = false
        leftAxis.axisLineColor = UIColor.black
        leftAxis.labelTextColor = UIColor.black
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)
        leftAxis.labelPosition = .outsideChart
        //leftAxis.gridColor = UIColor.init(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0)//网格
        leftAxis.gridColor = UIColor.lightGray
        leftAxis.gridAntialiasEnabled = false//抗锯齿
        if GetUnit.getBloodUnit() == "mg/dL"{
            
        }
        leftAxis.axisMaximum = 17//最大值
        leftAxis.axisMinimum = 0
        leftAxis.labelCount = 7//多少等分
        leftAxis.decimals = 1 //小数位
        
        //x轴
        let xAxis = _lineChartView.xAxis
        xAxis.granularityEnabled = true
        xAxis.labelTextColor = UIColor.red
        xAxis.labelFont = UIFont.systemFont(ofSize: 10.0)
        xAxis.labelPosition = .bottom
        xAxis.labelRotatedHeight = 2
        //xAxis.gridColor = UIColor.init(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0)
        xAxis.gridColor = UIColor.lightGray
        xAxis.axisLineColor = UIColor.black
        xAxis.axisMinimum = 0
        // ********该处需随需求变动************
        xAxis.axisMaximum = 7
        xAxis.labelCount = 5 // 标签个数，不一定是这个数，但会大约是,这也会影响标签的显示个数
        // 设置代理，使得代理方法实现
        _lineChartView.delegate = self
        
        return _lineChartView
    }()
    
    // 该函数应传值 x轴坐标 和 x轴对应label
    func drawLineChart(xAxisArray:NSArray,xAxisData:[Double]){

        // 根据日期范围生成对应的x轴的label,这里需自定义 x轴坐标显示
        lineChartView.xAxis.valueFormatter = VDChartAxisValueFormatter.init(xAxisArray)

        // 图表数据数组
        var yDataArray1 = [ChartDataEntry]()
        
        let xData = xAxisData
        //xData.sort()
        print("xdata:\(xData)")
        // 先检查是否有数据，若没有则不添加，若有则添加
        if glucoseTime.count != 0{
            for i in 0...glucoseTime.count-1 {
                let j = glucoseTime.count-1-i
                // 生成图表数据结构，根据 x的位置 和 y的位置。
                // y 的位置为 glucoseTimeAndValue 根据时间读取对应的血糖值
                // 注意坐标的 axisMinimum 和 axisMaximum 属性
                // 点的位置要相对于 这两个属性来画出
                let entry = ChartDataEntry.init(x: xData[j], y: glucoseTimeAndValue[glucoseTime[j]]!)
                // 将数据添加到图表数据数组中
                yDataArray1.append(entry)
            }
        }
        print(yDataArray1)
        let set1 = LineChartDataSet.init(entries: yDataArray1, label: "")
        // 设置线 的颜色
        set1.colors = [UIColor.black]
        // 设置 点的样式
        set1.drawCirclesEnabled = true//绘制转折点
        
        // 绘制转折点内圆
        set1.drawCircleHoleEnabled = false
        // 转折点是否显示y轴的值
        set1.drawValuesEnabled = false
        // 转折点颜色
        var colors:[UIColor] = []
        // 根据entry的y坐标的大小不同设置不同的颜色
        for i in 0..<set1.count{
            print("要画的第\(i)个点。")
            if set1[i].y > GetBloodLimit.getRandomDinnerTop(){
                colors.append(UIColor.red)
            }else if set1[i].y < GetBloodLimit.getRandomDinnerLow(){
                colors.append(UIColor.yellow)
            }else{
                colors.append(UIColor.green)
            }
        }
        set1.circleColors = colors
        // 转折点大小
        set1.circleRadius = 4
        set1.lineWidth = 2.0
        
        // 初始化折线图数据
        let data = LineChartData.init(dataSets: [set1])
        
        lineChartView.data = data
        // 设置画图动画
        lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInBack)
    }
    
    // 该函数应传值 x轴坐标和
    func drawLineChartWithoutAnimate(xAxisArray:NSArray,xAxisData:[Double]){
          
        // 根据日期范围生成对应的x轴的label,这里需自定义 x轴坐标显示
        lineChartView.xAxis.valueFormatter = VDChartAxisValueFormatter.init(xAxisArray)

        // 图表数据数组
        var yDataArray1 = [ChartDataEntry]()
        
        let xData = xAxisData
        //xData.sort()
        print("xdata:\(xData)")
        // 先检查是否有数据，若没有则不添加，若有则添加
        if glucoseTime.count != 0{
            for i in 0...glucoseTime.count-1 {
                let j = glucoseTime.count-1-i
                // 生成图表数据结构，根据 x的位置 和 y的位置。
                // y 的位置为 glucoseTimeAndValue 根据时间读取对应的血糖值
                // 注意坐标的 axisMinimum 和 axisMaximum 属性
                // 点的位置要相对于 这两个属性来画出
                let entry = ChartDataEntry.init(x: xData[j], y: glucoseTimeAndValue[glucoseTime[j]]!)
                // 将数据添加到图表数据数组中
                yDataArray1.append(entry)
            }
        }
        print(yDataArray1)
        let set1 = LineChartDataSet.init(entries: yDataArray1, label: "")
        
        set1.colors = [UIColor.blue]
        set1.drawCirclesEnabled = true//绘制转折点
        set1.circleColors = [UIColor.red]
        set1.lineWidth = 1.0
        
        // 初始化折线图数据
        let data = LineChartData.init(dataSets: [set1])
        
        lineChartView.data = data
    }
    
    
    // 限制线的添加
    func addLimitLine(_ value:Double, _ desc:String,_ color:UIColor) {
        let limitLine = ChartLimitLine.init(limit: value, label: desc)
        //线
        limitLine.lineWidth = 1
        limitLine.lineColor = color
        limitLine.lineDashLengths = [4.0,0]
        //文字
        limitLine.valueFont = UIFont.systemFont(ofSize: 10.0)
        limitLine.valueTextColor = UIColor.black
        limitLine.labelPosition = .bottomLeft
        lineChartView.leftAxis.addLimitLine(limitLine)
    }
    
    //折线上的点选中回调
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry,highlight: Highlight) {
        print("选中了一个数据")
        //显示该点的MarkerView标签
        self.showMarkerView(value: "\(entry.y)")
    }


    //显示MarkerView标签
    func showMarkerView(value:String){
        let marker = MarkerView(frame: CGRect(x: 20, y: 20, width: 80, height: 20))
        marker.chartView = self.lineChartView
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        label.text = "血糖:" + value + GetUnit.getBloodUnit()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = UIColor.gray
        label.textAlignment = .center
        marker.addSubview(label)
        self.lineChartView.marker = marker
    }
    
    func setupUI(){
        self.addSubview(lineChartView)
        self.lineChartView.snp_makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
    }

}
