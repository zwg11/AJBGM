
//  MineViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headview = AJMineHeaderView(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight/3))
        self.view.addSubview(headview)
    }
    
    //列表数据
    private lazy var dataSource: Array = {
        return [[["icon":"aboutUs", "title": "信息管理"],
                 ["icon":"aboutUs", "title": "单位设置"],
                 ["icon":"aboutUs", "title": "密码修改"],
                 ["icon":"aboutUs", "title": "血糖设置"]],
                
                [["icon":"aboutUs", "title": "使用说明"],
                 ["icon":"aboutUs", "title": "关于我们"],
                 ["icon":"aboutUs", "title": "版本更新"]]
        ]
    }()
}
