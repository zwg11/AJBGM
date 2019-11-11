//
//  GetSortedData.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/28.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import SwiftDate

// 该数组存储按时间排序的 glucoseDate 结构体
var sortedByDateOfData:[glucoseDate]?

// 用于图表显示
//var glucoseValue:[Double] = []
// 该数组存储用于图表显示的时间
var glucoseTime:[Date] = []

// 该数组存储已经排好序的 key为时间，value为血糖值 的字典数组
var glucoseTimeAndValue:Dictionary<Date,Double> = [:]


// 声明2个二维数组，用于数据的表格视图
var sortedTime:[[Date]] = []
var sortedData:[[glucoseDate]] = []

// MARK: - 数据的获取与处理流程
// 1、首先获得一定时间范围的数据
// 2、分别将数据处理为（1）适用于图表展示 （2）适用于表格展示 的数组

// *********** 获得一定时间范围的数据 *************
// 该函数初始化 sortedByDateOfData 数组
func initDataSortedByDate(startDate:Date,endDate:Date,userId:Int64){
    var data:[glucoseDate]?
    // 向数据库请求数据
    let sqliteManager = DBSQLiteManager()
    data = sqliteManager.selectGlucoseRecordInRange(start: startDate, end: endDate, userId: userId)
    // 将请求的数据赋值给数组
    sortedByDateOfData = data
}

// ************ 表格展示 *************
// 存储排好序的数据时间，并将同一天的日期放在同一个数组中
// 另一个对应着时间数组存储数据
func sortedTimeOfData(){
    
    var Time:[[Date]] = []
    var Data:[[glucoseDate]] = []
    if sortedByDateOfData?.count != 0{
        for i in 0..<sortedByDateOfData!.count{
            // 开始时 二维数组为空，直接添加
            let date = sortedByDateOfData![i].createTime!.toDate()!
            if i == 0{
                Time.append([date.date])
                Data.append([sortedByDateOfData![i]])
            }else{
                // 先判断二维数组中对应的同一天有没有其他时间了
                //如果有，则在对应的数组添加该日期
                if sortedByDateOfData![i].createTime!.toDate()!.toFormat("yyyy/MM/dd") == sortedByDateOfData![i-1].createTime!.toDate()!.toFormat("yyyy/MM/dd"){
                    let index = Time.count - 1
                    Time[index].append(date.date)
                    Data[index].append(sortedByDateOfData![i])
                }
                    // 如果没有，则添加一个数组
                else{
                    Time.append([date.date])
                    Data.append([sortedByDateOfData![i]])
                }
            }
        }
    }
    // 将排好序的时间和数据赋值给准备好的数组
    sortedTime = Time
    sortedData = Data
    print(sortedData)
    print(sortedTime)
    
}


// ************* 图表展示 **************
// 为画图表，提取含有血糖值的数据，只提取时间和血糖值
func chartData(){
    
    // 该数组存储用于图表显示的时间
    var Time:[Date] = []
    // 该数组存储已经排好序的 key为时间，value为血糖值 的字典数组
    var TimeAndValue:Dictionary<Date,Double> = [:]
    // 如果有数据，那么得到适合生成图表的数组
    
    if sortedByDateOfData!.count > 0{
        for i in sortedByDateOfData!{
            //glucoseValue.append(value)
            let date11 = i.createTime!.toDate()?.date
            Time.append(date11!)
            // 判断单位设定，根据不同的单位封装不同的数据
            if GetUnit.getBloodUnit() == "mmol/L"{
                // updateValue函数在字典中有对应key时更新value，没有对应key时添加
                TimeAndValue.updateValue(i.bloodGlucoseMmol!, forKey: date11!)
            }else{
                TimeAndValue.updateValue(Double(i.bloodGlucoseMg!), forKey: date11!)
            }
        }
    }
    
    // 将处理好的数组赋值给对应数组
    glucoseTime = Time
    glucoseTimeAndValue = TimeAndValue
    print("glucoseTimeAndValue:\(glucoseTimeAndValue)")
    
}

