//
//  LoadView.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/24.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class LoadView: UIView {

    // 设置加载图片
    lazy var imageView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "jiazai")!
        // 将其置于视图中心
        view.center = self.center
        view.sizeToFit()
        return view
    }()
    // 设置加载文字说明
    lazy var loadInfoLabel:UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = UIColor.red
        label.backgroundColor = UIColor.clear
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupUI(){
        imageView.frame.size = CGSize(width: 44, height: 44)
        //imageView.rotate360Degree()
        // 该标签置于 ‘加载’图片的正下方
        loadInfoLabel.frame = CGRect(x: 0, y: self.center.y + 50, width: UIScreen.main.bounds.width, height: 40)
        self.addSubview(imageView)
        self.addSubview(loadInfoLabel)
        
    }


}
