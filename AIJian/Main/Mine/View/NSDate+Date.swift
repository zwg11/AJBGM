//
//  NSDate+Date.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/7.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

public extension Date {
    // MARK: - 获取时间字符串
    /// 获取时间字符串
    ///
    /// - Parameter fromDate: 时间
    /// - Returns: 返回字符串
    func dateStringWithDate(_ fromDate : Date) -> String{
        
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "en_US")
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = formatter.string(from: fromDate)
        return date.components(separatedBy: " ").first!
    }
    func dateStringWithDate_format_another(_ fromDate : Date) -> String{
           
           let timeZone = TimeZone.init(identifier: "UTC")
           let formatter = DateFormatter()
           formatter.timeZone = timeZone
           formatter.locale = Locale.init(identifier: "en_US")
           formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           let date = formatter.string(from: fromDate)
           return date.components(separatedBy: " ").first!
       }
    
    /// 获取时间差
    ///
    /// - Parameter fromDate: 开始时间
    /// - Returns: 返回时间差
    func daltaFrom(_ fromDate : Date)  -> DateComponents{
        
        /// 获取当前日历
        let calendar = Calendar.current
        let components : Set<Calendar.Component> = [.year, .month,.day, .hour, .minute, .second]
        return calendar.dateComponents(components, from: self)
    }
    
    /// 是否是同一年
    ///
    /// - Returns: ture or false
    func isThisYear() -> Bool {
        let calendar = Calendar.current
        let currendarYear = calendar.component(.year, from: Date())
        let selfYear =  calendar.component(.year, from: self)
        return currendarYear == selfYear
    }
    
    /// 是否是今天的时间
    ///
    /// - Returns: Bool
    func isToday() -> Bool{
        
        let currentTime = Date().timeIntervalSince1970
        
        let selfTime = self.timeIntervalSince1970
        
        return (currentTime - selfTime) <= (24 * 60 * 60)
    }
    
    /// 是否是昨天的时间
    ///
    /// - Returns: Bool
    func isYesToday() -> Bool {
        
        let currentTime = Date().timeIntervalSince1970
        
        let selfTime = self.timeIntervalSince1970
        
        return (currentTime - selfTime) > (24 * 60 * 60)
    }
}


