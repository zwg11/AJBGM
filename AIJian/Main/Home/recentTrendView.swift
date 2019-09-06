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

    
    private lazy var recentTrendView:ChartView = {
        let view = ChartView()
        view.setupUI()
        // 摄者y轴最大值
        view.lineChartView.leftAxis.axisMaximum = GetBloodLimit.getRandomDinnerTop()*2
        // 设置x轴坐标数
        view.lineChartView.xAxis.labelCount = 7
        // 设置x坐标轴最大值
        view.lineChartView.xAxis.axisMaximum = 7
        // z设置x坐标轴的字体大小
        view.lineChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 15)
        // 设置坐标label在顶部朝内
        view.lineChartView.xAxis.labelPosition = .topInside
        // 画图
        view.drawLineChart(xAxisArray: xAxisArrayToWeek(Days: 7) as NSArray,xAxisData: recentDaysData(Days: 7))
        // 画限制线
        view.addLimitLine(GetBloodLimit.getRandomDinnerLow(), "低于", UIColor.yellow)
        view.addLimitLine(GetBloodLimit.getRandomDinnerTop(), "高于", UIColor.blue)
 
        return view
    }()
    
    func setupUI(){
        
        self.addSubview(recentTrendView)
        
        self.recentTrendView.snp_makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
    }

}
