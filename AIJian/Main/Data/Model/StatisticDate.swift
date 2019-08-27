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
// 用户token
let token = "0596fea21bfd49cc81e9d13a4f598289"
let REQUEST_DATA_URL = "http://120.78.167.239:8080/app/bloodGlucoseRecord/queryRecord"
// 数据
var glucoseValue:[Double] = []
var glucoseTime:[Date] = []
// 该数组存储已经排好序的 key为时间，value为血糖值 的字典数组
var glucoseTimeAndValue:Dictionary<Date,Double> = [:]
// 该数组s存储按时间排序的 glucoseDate 结构体
var sortedByDateOfData:[glucoseDate]?

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

// 声明2个二维数组，用于数据的表格视图
// 存储排好序的数据时间，并将同一天的日期放在同一个数组中
// 另一个对应着时间数组存储数据
var sortedTime:[[Date]] = []
var sortedData:[[glucoseDate]] = []

func sortedTimeOfData(){
    for i in 0..<sortedByDateOfData!.count{
        print("*****\(i)*********")
        // 开始时 二维数组为空，直接添加
        let date = sortedByDateOfData![i].createTime!.toDate()!
        if i == 0{
            sortedTime.append([date.date])
            sortedData.append([sortedByDateOfData![i]])
        }else{
            // 先判断二维数组中对应的同一天有没有其他时间了
            //如果有，则在对应的数组添加该日期
            if sortedByDateOfData![i].createTime!.toDate()!.toFormat("yyyy-MM-dd") == sortedByDateOfData![i-1].createTime!.toDate()!.toFormat("yyyy-MM-dd"){
                let index = sortedTime.count - 1
                sortedTime[index].append(date.date)
                sortedData[index].append(sortedByDateOfData![i])
            }
                // 如果没有，则添加一个数组
            else{
                sortedTime.append([date.date])
                sortedData.append([sortedByDateOfData![i]])
            }
        }
    }
}
