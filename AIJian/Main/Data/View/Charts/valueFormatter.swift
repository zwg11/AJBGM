//
//  valueFormatter.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/30.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Charts

class VDChartAxisValueFormatter: NSObject,IAxisValueFormatter {
    
    var values:NSArray?;
    override init() {
        super.init();
    }
    init(_ values: NSArray) {
        super.init();
        self.values = values;
    }
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let startDTimeInterval = startD?.timeIntervalSince1970
        if values == nil {
            return "\(value)";
        }
//        let ii = (Int64(value)-startDTimeInterval) % (60*60*24)
//        if ii == 0{
//            
//        }
        return values?.object(at: Int(value)) as! String;
    }
}
