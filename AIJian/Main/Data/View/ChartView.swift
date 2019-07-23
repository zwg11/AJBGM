//
//  ChartView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class ChartView: UIView {

    // title
    private lazy var textLabel:UILabel = {
       let label = UILabel()
        label.text = "Trend chart of blood sugar"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    // title image
    private lazy var titleImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "tend_pic")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints{ (make) in
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(230)
            make.centerY.equalTo(25)
            
        }
        
        self.addSubview(self.titleImageView)
        self.titleImageView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.textLabel.snp.right)
            make.height.width.equalTo(self.textLabel.snp.height)
            make.centerY.equalTo(self.textLabel.snp.centerY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
