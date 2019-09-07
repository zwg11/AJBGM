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
    //血糖范围设置中的的验证血糖合法性函数
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
        let numberRegex = "[0-9]{1,3}\\.[0-9]{0,1}"
        let numberTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberTest.evaluate(with: number)
    }
    //以mg/dL为单位的血糖数据，也可以用整数表示
    static func validateMgdlBloodNumberOther(number:String) -> Bool{
        //表示三位整数
        let numberRegex = "[0-9]{1,3}"
        let numberTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberTest.evaluate(with: number)
    }
    //手动输入中，验证胰岛素输入量的为合法值的函数    小数点前后都是两位数
    static func validateInsulinNum(number:String) -> Bool{
        //表示前后都是两位
        let insulinRegex = "[0-9]{0,2}\\.[0-9]{0,2}"
        let insulinTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", insulinRegex)
        return insulinTest.evaluate(with: number)
    }
    
    //手动输入中，验证身高的为合法值的函数    小数点前后都是两位数
    static func validateHeightNum(number:String) -> Bool{
        //表示前后都是两位
        let heightRegex = "[0-9]{0,3}\\.[0-9]{0,2}"
        let heightTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", heightRegex)
        return heightTest.evaluate(with: number)
    }
    
    //校验体重合法值的函数   小数点前三位，小数点后一位
    static func validateWeightKgNum(number:String) -> Bool{
        //表示前后都是两位
        let heightRegex = "[0-9]{1,3}\\.[0-9]{0,2}"
        let heightTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", heightRegex)
        return heightTest.evaluate(with: number)
    }
    //校验血压合法值的函数
    static func validatePressNum(number:String) -> Bool{
        //表示前后都是两位
        let heightRegex = "[0-9]{1,3}\\.[0-9]{0,2}"
        let heightTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", heightRegex)
        return heightTest.evaluate(with: number)
    }
    //Double保留两位小数
    
    
}
