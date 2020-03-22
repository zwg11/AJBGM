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

        view.lineChartView.leftAxis.drawLabelsEnabled = false
        // 设置x轴坐标数
        view.lineChartView.xAxis.labelCount = 7
        // 设置x坐标轴最大值
        view.lineChartView.xAxis.axisMaximum = 7
        // z设置x坐标轴的字体大小
        view.lineChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 15)
        // 设置坐标label在顶部朝内
        view.lineChartView.xAxis.labelPosition = .topInside
        // 不绘制y轴的网格
        view.lineChartView.leftAxis.drawGridLinesEnabled = false
        
//        // 画限制线
//        let low = GetBloodLimit.getRandomDinnerLow()
//        let high = GetBloodLimit.getRandomDinnerTop()
//        view.addLimitLine(low, "\(low)", kRGBColor(249, 158, 25, 1))
//        view.addLimitLine(high, "\(high)", kRGBColor(55, 158, 247, 1))
        view.backgroundColor = UIColor.clear
 
        return view
    }()
    
    func setupUI(){
        
        self.addSubview(recentTrendView)
        // 画图
        self.recentTrendView.drawLineChart(xAxisArray: xAxisArrayToWeek(Days: 7) as NSArray,xAxisData: recentDaysData(Days: 7))
        self.recentTrendView.snp_makeConstraints{(make) in
            make.left.top.equalToSuperview()
            
            make.width.equalTo(AJScreenWidth)
            make.height.equalTo(AJScreenWidth/2)
        }
    }
    func reloadChart(){
        // 移除所有限制线
        for i in recentTrendView.lineChartView.leftAxis.limitLines{
//            print(i)
            recentTrendView.lineChartView.leftAxis.removeLimitLine(i)
        }
        
        // 得到数据中的血糖最大值
        var maxGluValue = 0.0
        if sortedByDateOfData != nil{
            for i in sortedByDateOfData!{
                if maxGluValue < i.bloodGlucoseMg!{
                    maxGluValue = i.bloodGlucoseMg!
                }
            }
        }
        // 如果maxGluValue不超过300，则y轴坐标最大值为300，否则设为maxGluValue+10
        if maxGluValue < 300{
            if GetUnit.getBloodUnit() == "mmol/L"{
                recentTrendView.lineChartView.leftAxis.axisMaximum = 16.6
            }else{
                recentTrendView.lineChartView.leftAxis.axisMaximum = 300
            }
        }else{
            if GetUnit.getBloodUnit() == "mmol/L"{
                recentTrendView.lineChartView.leftAxis.axisMaximum = UnitConversion.mgTomm(num: maxGluValue+10)
            }else{
                recentTrendView.lineChartView.leftAxis.axisMaximum = maxGluValue+10
            }
        }
        
        // 画限制线
        let low = GetBloodLimit.getEmptyStomachLow()
        let high = GetBloodLimit.getAfterDinnerTop()
        let Orange = kRGBColor(255, 165, 0, 0.3)
        let Red = kRGBColor(255, 0, 0, 0.3)
        recentTrendView.addLimitLine(low, "\(low)", Orange)
        recentTrendView.addLimitLine(high, "\(high)", Red)
    }

}
