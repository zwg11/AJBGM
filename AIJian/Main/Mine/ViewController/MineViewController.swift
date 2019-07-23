//
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

        let view = AJMineHeaderView(frame: CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>))
        //将tableView加入到整个视图当中
        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
    }
    
    //列表数据
    private lazy var dataSource: Array = {
        return [[["icon":"video", "title": "信息管理"],
                 ["icon":"video", "title": "清楚缓存"],
                 ["icon":"video", "title": "密码修改"],
                 ["icon":"video", "title": "血糖设置"]],
                
                [["icon":"video", "title": "视频帮助"],
                 ["icon":"video", "title": "关于我们"],
                ["icon":"video", "title": "版本更新"]]
            ]
    }()
    
    // 懒加载顶部部分视图
    private lazy var headerView:AJMineHeaderView = {
        let view = AJMineHeaderView.init(frame: CGRect(x:0, y:0, width:AJScreenWidth, height: 300))
        view.delegate = self
        return view
    }()

    //懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:AJScreenWidth, height:AJScreenHeight), style: UITableView.Style.plain)
       tableView.delegate = self
       tableView.dataSource = self
       return tableView
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//tableView Delegate
extension MineViewController : UITableViewDelegate,UITableViewDataSource{
    
    //有几个大部分
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //每个部分有几个
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 4
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    //有几个大部分
    
    
    
}

 //设置顶部部分视图的代理
extension MineViewController : AJMineHeaderViewDelegate{
    
    
    
}


