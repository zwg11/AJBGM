//
//  CustomActivityIndicatorView.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/10.
//  Copyright © 2019 apple. All rights reserved.
//
//  **************** 用于显示加载动画和说明内容 ****************

import UIKit
import SnapKit

class CustomIndicatorView: UIView {

    // 风火轮控件
    private lazy var Indicator:UIActivityIndicatorView = {
        // whiteLarge 37*37
        // white      22*22
        // gray       22*22
        let view = UIActivityIndicatorView(style: .whiteLarge)
        // 使得控件不转时隐藏
        view.hidesWhenStopped = true
        view.color = UIColor.red
        //view.backgroundColor = UIColor.yellow
        return view
    }()
    // 风火轮控件开始旋转
    func startIndicator(){
        Indicator.startAnimating()
    }
    // 风火轮控件停止旋转
    func stopIndicator(){
        Indicator.stopAnimating()
    }
    // 文字说明label
    private lazy var label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        return label
    }()
    // 设置label文本
    func setLabelText(_ text:String){
        label.text = text
    }
    
    // 传入label的文本内容
    func setupUI(_ text:String){
        // 设置背景为浅灰色
        self.backgroundColor = UIColor.lightGray
        // 设置透明度为0.8
        self.alpha = 0.8
        label.text = text
        self.addSubview(label)
        self.addSubview(Indicator)
        Indicator.snp.makeConstraints{(make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(40)
        }
        label.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(Indicator.snp.bottom)
            make.height.equalTo(20)
            
        }
    }
}
