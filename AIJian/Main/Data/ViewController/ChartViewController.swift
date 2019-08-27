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
    
    private lazy var lineChartView:ChartView = {
        let view = ChartView()
        view.backgroundColor = UIColor.red
        view.setupUI()
        view.lineChartView.xAxis.axisMaximum = 7
        view.drawLineChart(xAxisArray: xAxisArray(Days: 7) as NSArray,days: 7,xAxisData: recentDaysData(Days: 7))
        view.addLimitLine(13, "限制线",UIColor.red)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("chartViewController appear.")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
