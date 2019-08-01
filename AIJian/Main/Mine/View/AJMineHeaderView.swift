//
//  AJMineHeaderView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/27.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class AJMineHeaderView:UIView{
    
    //头像
    private lazy var titleImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"defaultUserImage")
        
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //点击登录
    private lazy var textLabel:UILabel = {
        let label = UILabel()
        label.text = "Click Login"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red:18.0/255.0,green: 73/255.0,blue:212/255.0,alpha: 1)
        setUpUI()
    }
    
    func setUpUI(){
        
        //头像约束
        self.addSubview(self.titleImage)
        self.titleImage.snp.makeConstraints{ (make) in
            make.left.equalTo(AJScreenWidth/7)
            make.top.equalTo((AJScreenHeight/3 - AJScreenWidth*0.2)/2 - 20)
            make.height.equalTo(AJScreenWidth*0.3)
            print("头像高度",AJScreenWidth*0.2)
            make.width.equalTo(AJScreenWidth*0.3)
        }
        
        //字体约束
        self.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints{ (make) in
            make.top.equalTo((AJScreenHeight/3 - AJScreenWidth*0.2)/2 + 20)
            make.left.equalToSuperview().offset((AJScreenWidth/7 + AJScreenWidth*0.3)+20)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
