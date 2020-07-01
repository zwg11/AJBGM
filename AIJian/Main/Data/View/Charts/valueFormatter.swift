//
//  valueFormatter.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/30.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Charts
import SwiftDate

class VDChartAxisValueFormatter: NSObject,IAxisValueFormatter {
    
    
    var values:NSArray?
    let timezone = TimeZone(identifier: "UTC")
    // 创建一个时间格式器
    let dateFormatter = DateFormatter()
    override init() {
        super.init();
    }
    init(_ values: NSArray?) {
        super.init();
        self.values = values;
    }
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if values == nil {
            
            dateFormatter.dateFormat = "MM/dd"
            
            dateFormatter.timeZone = timezone
            if(Int(value) == 0){
                return ""
            }
            if((daysNum != nil) && Int(value) == daysNum){
                return ""
            }
            
            if(startD != nil){
                let xVal = startD! + Int(value).days
                return dateFormatter.string(from: xVal)
            }
            
            return "\(value)";
        }
        return values?.object(at: Int(value)) as! String;
    }
}
