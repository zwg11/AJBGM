//
//  String+extension.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/24.
//  Copyright © 2019 apple. All rights reserved.
/// *********扩展String，使其支持字符串转日期**********

import Foundation

extension String{
    // 字符串 -> 日期
    func stringToDate(dateformat:String = "yyyy-MM-dd HH:mm") -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = dateformat
        let date = formatter.date(from: self)
        return date!
    }
    

    //subscript函数可以检索数组中的值
    // 实现利用下标获取子字符串
    subscript(_ start:Int,_ end:Int) -> String{
        let start = self.index(self.startIndex, offsetBy: start)
        let end = self.index(self.startIndex, offsetBy: end)
        return String(self[start...end])
    }
    //直接按照索引方式截取制定索引的字符
    subscript(_ i:Int) -> Character{
        //读取字符
        get{
            return self[index(startIndex,offsetBy: i)]
        }
        //修改字符
        set{
            //转化为字符数组
            var arr:[Character] = Array(self)
            arr[i] = newValue
            self = String(arr)
        }
    }
    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉所有空格
     */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /*
     *去掉首尾空格 后 指定开头空格数
     */
    func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.removeHeadAndTailSpacePro
    }
    
    
}

//Character扩展
extension Character{
    //Character转ASCII整数值（定义小写整数值）
    var ascii:Int{
        get{
            return Int(self.unicodeScalars.first?.value ?? 0)
        }
    }
}


//Int转Character,ascii值（定义大写为字符值）
extension Int{
    var ASCII:Character{
        get{return Character(UnicodeScalar(self)!)}
    }
}
