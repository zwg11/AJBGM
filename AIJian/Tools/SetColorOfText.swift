//
//  SetColorOfText.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/20.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit

class SetColorOfLabelText{
    
    // 根据血糖值判断其属于哪个血糖范围
    // 不同血糖范围设置不同的字体颜色
    static func SetGlucoseTextColor(_ data:glucoseDate,label:UILabel){
        // 如果有血糖值
        if let value = data.bloodGlucoseMg{
            // 根据检测时间判断
            switch data.detectionTime!{
                // a餐前
            case 0:
                // 如果小于正常范围，设为红色
                if value < GetBloodLimit.getBeforeDinnerLow(){
                    label.textColor = UIColor.red
                }// 如果大于正常范围，设为y橘色
                else if value >= GetBloodLimit.getBeforeDinnerTop(){
                    label.textColor = UIColor.orange
                }// 如果在正常范围，设为绿色
                else{
                    label.textColor = UIColor.green
                }
                // 餐后
            case 1:
                // 如果小于正常范围，设为y橘色
                if value < GetBloodLimit.getAfterDinnerLow(){
                    label.textColor = UIColor.orange
                }// 如果大于正常范围，设红色
                else if value >= GetBloodLimit.getAfterDinnerTop(){
                    label.textColor = UIColor.red
                }// 如果在正常范围，设为绿色
                else{
                    label.textColor = UIColor.green
                }
                // 空腹
            case 2:
                // 如果小于正常范围，设为橘色
                if value < GetBloodLimit.getEmptyStomachLow(){
                    label.textColor = UIColor.orange
                }// 如果大于正常范围，设为红色
                else if value >= GetBloodLimit.getEmptyStomachTop(){
                    label.textColor = UIColor.red
                }// 如果在正常范围，设为绿色
                else{
                    label.textColor = UIColor.green
                }
                // 随机
            default:
                // 如果小于正常范围，设为橘色
                if value < GetBloodLimit.getRandomDinnerLow(){
                    label.textColor = UIColor.orange
                }// 如果大于正常范围，设为红色
                else if value >= GetBloodLimit.getRandomDinnerTop(){
                    label.textColor = UIColor.red
                }// 如果在正常范围，设为绿色
                else{
                    label.textColor = UIColor.green
                }
            }
            
        }
        
    }
    // func SetGlucoseTextColor() end
    
    
}
