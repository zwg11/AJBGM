//
//  AJMineHeaderView.swift
//  AIJian
//
//  Created by zzz on 2019/7/22.
//  Copyright © 2019 apple. All rights reserved.
//  创建我的头部信息：包括头像和点击登录

import UIKit
import SnapKit
//添加按钮点击代理方法
protocol AJMineHeaderViewDelegate:NSObjectProtocol {
    
}

//我的页面顶部headerview
class AJMineHeaderView:UIView{
    
    //进行初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    //必要初始化器
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //设置信息代理
    weak var delegate : AJMineHeaderViewDelegate?

    
    //头像
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        //点击事件
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        imageView.addGestureRecognizer(singleTapGesture)
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "bgImage")
        //设置成圆角图形
        imageView.layer.cornerRadius = imageView.frame.size.width / 4
        imageView.layer.masksToBounds = true
      
        return imageView
    }()
    
    //未登录时，显示点击登录。登录时，显示昵称
    private lazy var userName:UILabel = {
        let label = UILabel()
        label.text="点击登录"
        //label点击事件
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(labelClick))
        label.addGestureRecognizer(singleTapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    //加载头像和昵称的方法
    func setUpUI(){
        
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(30)
            make.width.height.equalTo(80)
        }
        
        self.addSubview(self.userName)
        self.userName.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(120)
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(20)
        }
        
    }
    //图片点击事件
    @objc func imageViewClick(){
        print("点击了图片")
    }
    
    //label点击事件
    @objc func labelClick(){
        print("点击了label")
    }
}

