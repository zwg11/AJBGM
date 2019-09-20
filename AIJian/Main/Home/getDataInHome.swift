//
//  getDataInHome.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/4.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import SwiftDate

class getDataInHome{
    
   
    // 获取最近一次的血糖值
    static func getLastGlucoseValue() -> String{
        let x = DBSQLiteManager.shareManager()
        // 在数据库取出最近c一次的血糖记录
        let data = x.selectLastGlucoseRecord(UserInfo.getUserId())
        
        let str:String?
        // // 判断单位，根据相应单位取出最近一次的值
        if let value = data.bloodGlucoseMmol{
            if GetUnit.getBloodUnit() == "mmol/L"{
                str = String(value)
            }else{
                str = String(format:"%.0f",data.bloodGlucoseMg!)
            }

        }else{
            str = "-"
        }
        
        return str!
    }
    
    // 给一段时间，返回数组，分别为该段时间血糖的 平均值、检测次数、最高值、最低值
    static func getRecentValue(_ startDate:Date,_ endDate:Date) -> [Any]{
        let x = DBSQLiteManager.shareManager()
//        let today = DateInRegion().dateAt(.endOfDay).date
//        let end = today + 1.seconds
//        let start = end - 7.days
        // 取出最近7天的数据
        let data = x.selectGlucoseRecordInRange(start: startDate, end: endDate, userId: UserInfo.getUserId())
        
        var result:[Any] = []
        var avgValue = 0.0
        let checkNum = data.count
        var highestValue = 0.0
        var lowestValue = 1000.0
        // 如果有数据，则显示
        if checkNum > 0{
            if GetUnit.getBloodUnit() == "mmol/L"{
                for i in data{
                    avgValue += i.bloodGlucoseMmol!
                    // 如果当前值比最大值大，则最大值为当前值
                    if i.bloodGlucoseMmol! > highestValue{
                        highestValue = i.bloodGlucoseMmol!
                    }
                    // 如果当前值比最小值小，则最小值为当前值
                    if i.bloodGlucoseMmol! < lowestValue{
                        lowestValue = i.bloodGlucoseMmol!
                    }
                }
            }else{
                for i in data{
                    avgValue += Double(i.bloodGlucoseMg!)
                    // 如果当前值比最大值大，则最大值为当前值
                    if Double(i.bloodGlucoseMg!) > highestValue{
                        highestValue = i.bloodGlucoseMg!
                    }
                    // 如果当前值比最小值小，则最小值为当前值
                    if Double(i.bloodGlucoseMg!) < lowestValue{
                        lowestValue = i.bloodGlucoseMg!
                    }
                }
            }
            avgValue = avgValue/Double(checkNum)
            // 平均值为1位小数
            let x = String(format: "%.1f", avgValue)
            result.append(x)
            result.append(checkNum)
            // 最高值和最低值根据单位判断是否有小数
            if GetUnit.getBloodUnit() == "mmol/L"{
                result.append(highestValue)
                result.append(lowestValue)
            }else{
                result.append(String(format: "%.0f", highestValue))
                result.append(String(format: "%.0f", lowestValue))
            }
            
            return result
        }else{
            // 如果没数据，平均值、检测次数为0，最高值、最低值设为 --
            result.append(avgValue)
            result.append(checkNum)
            result.append("--")
            result.append("--")
            return result
        }
    }
}
