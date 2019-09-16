//
//  homeView.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/1.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Charts

class recentTrendView: UIView {

    
    lazy var recentTrendView:ChartView = {
        let view = ChartView()
        view.setupUI()
        // 摄者y轴最大值
        view.lineChartView.leftAxis.axisMaximum = GetBloodLimit.getRandomDinnerTop()*2
        view.lineChartView.leftAxis.drawLabelsEnabled = false
        // 设置x轴坐标数
        view.lineChartView.xAxis.labelCount = 7
        // 设置x坐标轴最大值
        view.lineChartView.xAxis.axisMaximum = 7
        // z设置x坐标轴的字体大小
        view.lineChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 15)
        // 设置坐标label在顶部朝内
        view.lineChartView.xAxis.labelPosition = .topInside
        
        // 画限制线
        let low = GetBloodLimit.getRandomDinnerLow()
        let high = GetBloodLimit.getRandomDinnerTop()
        view.addLimitLine(low, "\(low)", kRGBColor(249, 158, 25, 1))
        view.addLimitLine(high, "\(high)", kRGBColor(55, 158, 247, 1))
        view.backgroundColor = UIColor.clear
 
        return view
    }()
    
    func setupUI(){
        
        self.addSubview(recentTrendView)
        // 画图
        self.recentTrendView.drawLineChart(xAxisArray: xAxisArrayToWeek(Days: 7) as NSArray,xAxisData: recentDaysData(Days: 7))
        self.recentTrendView.snp_makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
    }

}
