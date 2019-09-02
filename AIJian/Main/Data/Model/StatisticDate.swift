//
//  StatisticDate.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/22.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import HandyJSON
import SwiftDate



struct Average {
    var BloodSugar:Float = 0
    var BloodSugarStandardDeviation:Float = 0
    var BloodSugarMin:Float = 0
    var BloodSugarMax:Float = 0
    var testNumPerDay:Float = 0
    
}
struct global {
    var testNum:Int = 0
    var lowBloodSugar:Int = 0
    var lowBloodSugarPersentage:Float = 0
    var lowerNormal:Int = 0
    var lowerNormalPercentage:Float = 0
    var normal:Int = 0
    var normalPercentage:Float = 0
    var higherNormal:Int = 0
    var highterNormalPercentage:Float = 0
}
struct preMeal {
    var testNum:Int = 0
    var lowBloodSugar:Int = 0
    var lowBloodSugarPersentage:Float = 0
    var lowerNormal:Int = 0
    var lowerNormalPercentage:Float = 0
    var normal:Int = 0
    var normalPercentage:Float = 0
    var higherNormal:Int = 0
    var highterNormalPercentage:Float = 0
}
struct afterMeal {
    var testNum:Int = 0
    var lowBloodSugar:Int = 0
    var lowBloodSugarPersentage:Float = 0
    var lowerNormal:Int = 0
    var lowerNormalPercentage:Float = 0
    var normal:Int = 0
    var normalPercentage:Float = 0
    var higherNormal:Int = 0
    var highterNormalPercentage:Float = 0
}



