//
//  AJStartView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/30.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class AJStartView: UIView {


    // MARK: - 设置初始化界面
    init(imageName image:String,timer seconds:Int){
        // 启动页覆盖屏幕
        let frame = CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight)
        super.init(frame: frame)
        // 设置背景为蓝色
        self.backgroundColor = UIColor.blue
        // 添加启动页面图，位置为中心
        let startImageview = UIImageView(image: UIImage(named: image))
        startImageview.center = self.center
        
        self.addSubview(startImageview)
        // 设置动画，逐渐消失，动画结束后该页面从父页面移除
        UIView.animate(withDuration: TimeInterval(seconds), animations: {
            self.alpha = 0.5
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }){
            (finish) in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
