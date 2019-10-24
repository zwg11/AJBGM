//
//  TimerForLoad.swift
//  AIJian
//
//  Created by Zwg on 2019/10/22.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit

class TimerForLoad{
    var second = 10
    var timer : Timer?

    // 2.开始计时
    func startTimer() {

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updataSecond), userInfo: nil, repeats: true)
        //调用fire()会立即启动计时器
        timer!.fire()
     }

     // 3.定时操作
     @objc func updataSecond() {
         if second>1 {
            //.........
            second -= 1
         }else {
            stopTimer()
         }
     }

    // 4.停止计时
    func stopTimer() {
        if timer != nil {
            timer!.invalidate() //销毁timer
            timer = nil
         }
     }
}
