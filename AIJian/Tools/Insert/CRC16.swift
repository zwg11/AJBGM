//
//  CRC16.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/24.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

class CRC16{
    
    //static let instance = CRC16()
    
    func getCRC(arr:[Int]) -> Int{
        var CRC:Int = 0x0000ffff
        let POLYNOMIAL:Int = 0x0000a001
        
        let length = arr.count
        
        for i in 0..<length{
            CRC ^= (Int(arr[i] & 0x000000ff))
            for _ in 0..<8{
                if((CRC & 0x00000001) != 0 ){
                    CRC >>= 1
                    CRC ^= POLYNOMIAL
                }else{
                    CRC >>= 1
                }
//                print(j)
            }
        }
        return CRC
    }
    
    func string2CRC(string:String)->String{
        let a:String = string
        //此数组为存放字符串的ascii码值
        var arr:[Int]=[]
        for i in a.indices{
            //把字符串转化为ascii码，然后重新放到一个数组内部
            arr.append(a[i].ascii)
        }
        //使用方法为传入一个数组，返回一个CRC的校验码
//        print(self.getCRC(arr:arr))
        return String(self.getCRC(arr:arr))
    }
}
