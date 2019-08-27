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

    // title
    private lazy var textLabel:UILabel = {
        let label = UILabel()
        label.text = "血糖趋势图"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    // title image
    private lazy var titleImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tend_pic")
        return imageView
    }()
    
    private lazy var recentTrendView:ChartView = {
        let view = ChartView()
        view.setupUI()
        // 设置x轴坐标数
        view.lineChartView.xAxis.labelCount = 7
        // 设置坐标轴最大值
        view.lineChartView.xAxis.axisMaximum = 7
        view.lineChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 15)
        // 设置坐标label在顶部朝内
        view.lineChartView.xAxis.labelPosition = .topInside
        view.drawLineChart(xAxisArray: xAxisArrayToWeek(Days: 7) as NSArray,days: 7,xAxisData: recentDaysData(Days: 7))
        view.addLimitLine(13, "限制线",UIColor.red)
 
        return view
    }()
    
    func setupUI(){
        self.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.height.equalTo(40)
            make.top.equalTo(AJScreenWidth/40)
            
        }
        
        self.addSubview(self.titleImageView)
        self.titleImageView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.textLabel.snp.right).offset(AJScreenWidth/40)
            make.height.width.equalTo(AJScreenWidth/15)
            //make.width.equalTo(textLabel.snp.height)
            make.centerY.equalTo(self.textLabel.snp.centerY)
        }
        
        self.addSubview(recentTrendView)
        //self.drawLineChart()
        
        self.recentTrendView.snp_makeConstraints{(make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(textLabel.snp.bottom)
        }
    }

}
