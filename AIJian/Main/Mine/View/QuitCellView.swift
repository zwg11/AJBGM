//
//  QuitCellView.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/12.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class QuitCellView:UITableViewCell{
    
    
     lazy var quitButton:UIButton = {
        let quitLogin = UIButton(type: .system)
        quitLogin.backgroundColor = ButtonColor
        quitLogin.tintColor = UIColor.white
        quitLogin.setTitleColor(UIColor.white, for: .normal)
        quitLogin.setTitle("Sign Out", for:.normal)
        quitLogin.titleLabel?.font = UIFont.systemFont(ofSize:18)
        return quitLogin
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(self.quitButton)
        self.quitButton.snp.makeConstraints{ (make) in
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/15)
            make.top.equalTo(10)
        }
    }
    
}
