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
        if values == nil {
            return "\(value)";
        }
        return values?.object(at: Int(value)) as! String;
    }
}
