
//
//  UIAlertViewController_Extension.swift
//  st
//
//  Created by ADMIN on 2019/8/7.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit
extension UIAlertController{
    func tapGesAlert(){
//        let arrayView = UIApplication.shared.keyWindow?.subviews
//        if arrayView!.count > 0{
//            let backView = arrayView![1]
//            backView.isUserInteractionEnabled = true
//            let tap = UITapGestureRecognizer(target: self, action: #selector(cancelAlert))
//            backView.addGestureRecognizer(tap)
//        }
        // 获取背景视图,亲测以下两个都有效
        //let backView = self.view.superview?.subviews[0]
        let backView = self.view.superview?.subviews[1]
        // 以下操作失败
        //let backView = self.view.superview
        print(self.view ?? "no")
        // 设置手势点击背景警示框消失
        backView!.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(cancelAlert))
        backView!.addGestureRecognizer(tap)
        
    }
    @objc func cancelAlert(){
        self.dismiss(animated: true, completion: nil)
    }
}
