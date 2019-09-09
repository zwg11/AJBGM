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
        if GetUnit.getBloodUnit() == "mmol/L"{
            str = (data.bloodGlucoseMmol != nil) ? String(data.bloodGlucoseMmol!):"-"
        }else{
            str = (data.bloodGlucoseMg != nil) ? String(data.bloodGlucoseMg!):"-"
        }
        
        return str!
    }
    
    static func getRecentValue() -> [Any]{
        let x = DBSQLiteManager.shareManager()
        let today = DateInRegion().dateAt(.endOfDay).date
        let end = today + 1.seconds
        let start = end - 7.days
        // 取出最近7天的数据
        let data = x.selectGlucoseRecordInRange(start: start, end: end, userId: UserInfo.getUserId())
        
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
                        highestValue = Double(i.bloodGlucoseMg!)
                    }
                    // 如果当前值比最小值小，则最小值为当前值
                    if Double(i.bloodGlucoseMg!) < lowestValue{
                        lowestValue = Double(i.bloodGlucoseMg!)
                    }
                }
            }
            avgValue = avgValue/Double(checkNum)
            let x = String(format: "%.1f", avgValue)
            result.append(x)
            result.append(checkNum)
            result.append(highestValue)
            result.append(lowestValue)
            return result
        }else{
            
            result.append(avgValue)
            result.append(checkNum)
            result.append("--")
            result.append("--")
            return result
        }
    }
}
