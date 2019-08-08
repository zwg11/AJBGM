//
//  AJMineTableView.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/1.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit



class AJMineTableView:UIView{

    
    
    lazy var tableview:UITableView={
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:AJScreenWidth, height:AJScreenHeight/3*2), style: UITableView.Style.plain)
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(tableview)
    }
    

    
}

