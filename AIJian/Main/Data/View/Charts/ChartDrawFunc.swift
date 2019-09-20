//
//  ChartDrawFunc.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/26.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import SwiftDate

// *******当为最近几天时********
// 形成x坐标轴的label
func xAxisArray(Days:Int)->[String]{
    let today = DateInRegion().dateAt(.endOfDay).date
    let end = today + 1.seconds
    let start = end - Days.days
    var x = start
    var dates:[Date] = []
    // 使得日期数组都装着每天的开始
    while x <= end {
        dates.append(x)
        x = x + 1.days
    }
    //dates.sort()
    var xAxisStrings:[String] = []
    for i in dates{
        xAxisStrings.append(i.toFormat("MM-dd"))
    }
    print(xAxisStrings)
    xAxisStrings[0] = ""
    xAxisStrings[xAxisStrings.count-1] = ""
    return xAxisStrings
}

// 对于首页图表，形成带有星期几的 x坐标轴的label
func xAxisArrayToWeek(Days:Int)->[String]{
    let today = DateInRegion().dateAt(.endOfDay).date
    let end = today + 1.seconds
    let start = end - Days.days
    var x = start
    var dates:[Date] = []
    // 使得日期数组都装着每天的开始
    while x <= end {
        dates.append(x)
        x = x + 1.days
    }
    //dates.sort()
    var xAxisStrings:[String] = []
    for i in dates{
        xAxisStrings.append("           " + i.weekdayName(.standaloneShort))
    }
    print(xAxisStrings)
    //xAxisStrings[0] = ""
    xAxisStrings[xAxisStrings.count-1] = ""
    return xAxisStrings
}

// 给定最近几天时
// 给定一个日期数组，返回响应的x轴坐标
func recentDaysData(Days:Int)->[Double]{
    let today = DateInRegion().dateAt(.endOfDay).date
    let end = today + 1.seconds
    let start = end - Days.days
    // 向数据库提取近些天的数据
    initDataSortedByDate(startDate: start, endDate: end, userId: UserInfo.getUserId())
    // 将数据处理成 图表所需的数据
    chartData()
    
    var xAxisData:[Double] = []
    let calendar = NSCalendar.current

    for i in glucoseTime{
        // 如果日期在这个时间范围内
        if i>=start && i<=end{
            // 计算 start 和 i之间的分钟差
            let res = calendar.dateComponents([.minute], from: start, to: i.date)
            print(res.minute!)
            let result1 = res.minute!
            
            // 根据分钟差计算出相对于 零点的x坐标
            xAxisData.append(Double(result1)/1440.0)
        }
    }
    return xAxisData
}


// ************自定义日期范围时*************
// 形成x坐标轴的label
func xAxisArray(startDate:Date,endDate:Date)->[String]{
//    let start = startDate.dateAt(.startOfDay)
//    let end = endDate.dateAt(.endOfDay) + 1.seconds

    var x = startDate
    var dates:[Date] = []
    // 使得日期数组都装着每天的开始
    while x <= endDate {
        dates.append(x)
        x = x + 1.days
    }
    //dates.sort()
    var xAxisStrings:[String] = []
    for i in dates{
        xAxisStrings.append(i.toFormat("MM-dd"))
    }
    print(xAxisStrings)
    xAxisStrings[0] = ""
    xAxisStrings[xAxisStrings.count-1] = ""
    return xAxisStrings
}



// 传入 坐标轴0点 表示的日期，要画的点 的日期数组，该数组必须要排好序
func DateToData(_ start:Date,_ end:Date)->[Double]{
    
    // 向数据库提取近些天的数据
    initDataSortedByDate(startDate: start, endDate: end, userId: UserInfo.getUserId())
    // 将数据处理成 图表所需的数据
    chartData()
    
    var xAxisData:[Double] = []
    let calendar = NSCalendar.current
    // 生成 x轴坐标
    for i in glucoseTime{
        // 先求出 日期数组中各个日期 与 开头日期的 分钟差
        let res = calendar.dateComponents([.minute], from: start, to: i.date)
        print(res.minute!)
        let result1 = res.minute!
        // 保留3位小数
        //var rrr = String(format: "%.3f", Double(result1)/1440.0)
        // 将分钟差转换为坐标
        xAxisData.append(Double(result1)/1440.0)
    }
    return xAxisData
    
//    var x = start
//    var dates:[Date] = []
//    // 使得日期数组都装着每天的开始
//    while x <= end {
//        dates.append(x)
//        x = x + 1.days
//    }
//    //dates.sort()
//    var xAxisStrings:[String] = []
//    for i in dates{
//        xAxisStrings.append(i.toFormat("MM-dd"))
//    }
//    print(xAxisStrings)
//    xAxisStrings[0] = ""
//    xAxisStrings[xAxisStrings.count-1] = ""
//    return xAxisStrings
}


// 输出中间的天数，以便设置x轴的长度
func xAxisCount(startDate:Date,endDate:Date)->Int{
    
    let calendar = NSCalendar.current
    
    // 求出开始日期的开始时间和结束日期后一天的开始时间
    let start = startDate.dateAt(.startOfDay)
    let end = endDate.dateAt(.endOfDay) + 1.seconds
    
    // 求出 两个日期的 天数差
    let res = calendar.dateComponents([.day], from: start, to: end)
    return res.day!
}
