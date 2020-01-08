//
//  UIButton+Extension.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit
extension UIButton{
    // 按钮一般风格设置
    // 字体内容及其颜色 边框设置
    func NorStyle(title string:String){
        self.setTitle(string, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
        self.backgroundColor = SendButtonColor
    }
    
    // 设置按钮的统一风格
    func setNormalStyle(_ title:String,_ tag:Int){
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 3, right: 0)
        self.setDeselected()
        self.tag = tag
    }
    
    // 用于手动输入页面，按钮被选中时的样式
    func setSelected(){
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = SendButtonColor
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        
    }
    
    // 用于手动输入页面，按钮未被选中时的样式
    func setDeselected(){
        self.setTitleColor(UIColor.gray, for: .normal)
        self.backgroundColor = kRGBColor(8, 52, 84, 1)
        self.layer.borderWidth = 0
    }
   
    func setButtonDisable(){
        isEnabled = false
    }
    
    func setButtonEnable(){
        isEnabled = true
    }
    
    
    func countDown(count: Int){
        // 倒计时开始,禁止点击事件
        isEnabled = false
        
        // 保存当前的背景颜色
        let defaultColor = self.backgroundColor
        // 设置倒计时,按钮背景颜色
        backgroundColor = kRGBColor(17, 56, 86, 1)
        
        var remainingCount: Int = count {
            willSet {
                setTitle("(\(newValue)s)", for: .normal)
                
                if newValue <= 0 {
                    setTitle("Resend", for: .normal)
                }
            }
        }
        
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                // 每秒计时一次
                remainingCount -= 1
                // 时间到了取消时间源
                if remainingCount <= 0 {
                    self.backgroundColor = defaultColor
                    self.isEnabled = true
                    codeTimer.cancel()
                }
            }
        })
        // 启动时间源
        codeTimer.resume()
    }
}
