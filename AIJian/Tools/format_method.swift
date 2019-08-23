//
//  format_method.swift
//  AIJian
//
//  Created by zzz on 2019/8/17.
//  Copyright © 2019 apple. All rights reserved.
//  功能：格式校验文件

import Foundation

public class FormatMethodUtil{
    
    static let instance = FormatMethodUtil()
    
    //验证邮箱格式
    static func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    //验证身高，（0--3位）小数点后面可以接一位
    static func validateNumber(number: String) -> Bool{
        let numberRegex = "[0-9]{0,3}\\.[0-9]{0,1}"
        let numberTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberTest.evaluate(with: number)
    }
    
    //验证密码强度校验
    static func validatePasswd(passwd:String) -> Bool{
        let passwdRegex = "[\\w]{8,16}"
        let passwdTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", passwdRegex)
        return passwdTest.evaluate(with: passwd)
    }
    //判断是否为合法的mmol\L为单位的血糖数据
    static func validateBloodNumber(number:String) -> Bool{
        //表示小数点前面两位，小数点后面一位
        let numberRegex = "[0-9]{1,2}\\.[0-9]{0,1}"
        let numberTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberTest.evaluate(with: number)
    }
    //判断是否为合法的mg/dL为单位的血糖数据
    static func validateMgdlBloodNumber(number:String) -> Bool{
        //表示三位整数
        let numberRegex = "[0-9]{0,3}"
        let numberTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberTest.evaluate(with: number)
    }
}
