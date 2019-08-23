//
//  StatisticDate.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/22.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import HandyJSON
// 用户token
let token = "0596fea21bfd49cc81e9d13a4f598289"
let REQUEST_DATA_URL = "http://120.78.167.239:8080/app/bloodGlucoseRecord/queryRecord"

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

// 请求最近几天的血糖记录的请求参数
struct glucoseRecordInDays: HandyJSON{
    var day:Int?
    var userId:Int?
    var token:String?
}

// 请求响应内容
struct recordInDaysResponse: HandyJSON {
    var code:Int?
    var msg:String?
    var data:[glucoseDate]?
}

// 响应内容中的数据
struct glucoseDate: HandyJSON {
    var bloodGlucoseRecordId:Int?
    var userId:Int?
    var createTime:String?
    var detectionTime:String?
    var bloodGlucoseMmol:Double?
    var bloodGlucoseMg:Int?
    var eatType:String?
    var eatNum:Int?
    var insulinType:String?
    var insulinNum:Int?
    var height:Int?
    var weightKg:Int?
    var weightLbs:Int?
    var systolicPressureMmhg:Int?
    var systolicPressureKpa:Int?
    var diastolicPressureMnhg:Int?
    var diastolicPressureKpa:Int?
    var medicine:String?
    var sportType:String?
    var sportTime:String?
    var sportStrength:Int?
    var inputType:Int?
    var remark:String?
    var recordType:Int?
    var machineId:String?
    
}
