//
//  AJMineHeaderView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/27.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class AJMineHeaderView:UITableViewCell{
    
    //头像
     lazy var titleImage:UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named:"headImage")
        imageView.layer.cornerRadius = (AJScreenWidth*0.3)/2   //将圆角设置成半径
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.green
        return imageView
    }()
    
    //点击登录,label无法直接添加addtarger
    lazy var textButton:UIButton = {
        let button = UIButton()
        button.setTitle("", for: .init())
//        button.backgroundColor = UIColor.init(red:18.0/255.0,green: 73/255.0,blue:212/255.0,alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize:20)
        button.titleLabel?.textColor = MineNameTextColor
        return button
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.backgroundColor = UIColor.init(red:18.0/255.0,green: 73/255.0,blue:212/255.0,alpha: 1)
        setupUI()
    }
//    override init(frame: CGRect) {
////        super.init(frame: frame)
//        self.backgroundColor = UIColor.init(red:18.0/255.0,green: 73/255.0,blue:212/255.0,alpha: 1)
//        setUpUI()
//    }
    
    func setupUI(){
        
        self.backgroundColor = UIColor.white
        //头像约束
        self.addSubview(self.titleImage)
        self.titleImage.snp.makeConstraints{ (make) in
            make.left.equalTo(AJScreenWidth*0.35)
            make.right.equalTo(-AJScreenWidth*0.35)
            
            make.height.equalTo(AJScreenWidth*0.3)
            make.width.equalTo(AJScreenWidth*0.3)
            make.top.equalTo(10)
        }
        
        //字体约束
        self.addSubview(self.textButton)
        self.textButton.snp.makeConstraints{ (make) in
            make.top.equalTo(titleImage.snp.bottom).offset(2)
            make.left.equalTo(AJScreenWidth*0.3)
            make.right.equalTo(-AJScreenWidth*0.3)
            
            make.height.equalTo(20)
            make.width.equalTo(AJScreenWidth*0.4)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension UIImageView{
    
    
}
