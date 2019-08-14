//
//  UIImageView+Extension.swift
//  st
//
//  Created by ADMIN on 2019/8/7.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    // 360度旋转照片
    func rotate360Degree(){
        let rotationAnimation = CABasicAnimation(keyPath: "transform")
        // 从0度开始
        rotationAnimation.fromValue = 0
        // 旋转到360度
        rotationAnimation.toValue = Double.pi * 2
        // 旋转周期
        rotationAnimation.duration = 1
        // 旋转次数
        rotationAnimation.repeatCount = 100
        // 旋转累加角度
        rotationAnimation.isCumulative = true
        // 设置为z轴旋转
        rotationAnimation.valueFunction = CAValueFunction(name: .rotateZ)
        // 执行动画，并给动画z设置唯一标识符
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    // 停止旋转
    func stopRotate(){
        // 删除对应的动画
        layer.removeAnimation(forKey: "rotationAnimation")
    }
}
