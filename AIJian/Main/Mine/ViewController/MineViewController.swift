
//  MineViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    
    //列表数据
    public lazy var MineArray: Array = {
        return [[["icon":"aboutUs", "title": "信息管理"],
                 ["icon":"aboutUs", "title": "单位设置"],
                 ["icon":"aboutUs", "title": "密码修改"],
                 ["icon":"aboutUs", "title": "血糖设置"]],
                
                [["icon":"aboutUs", "title": "使用说明"],
                 ["icon":"aboutUs", "title": "关于我们"],
                 ["icon":"aboutUs", "title": "版本更新"]]
        ]
    }()
    
    public lazy var clickArray: [UIViewController] = {
        return [InfoViewController(),UnitViewController(),PassChangeViewController(),BloodSetViewController(), UseDirViewController(),AboutUsViewController(),VersionUViewController()
        ]
    }()
//    private lazy var mineTableView:AJMineTableView = {
//        let view = AJMineTableView()
//        view.tableview.delegate = self
//        view.tableview.dataSource = self
//        return view
//    }()
//    private lazy var quitLogin:quitView={
//        let quitLogin = quitView()
//        quitLogin.setupUI()
//        quitLogin.quitButton.addTarget(self, action: #selector(loginOff), for: .touchUpInside)
//        return quitLogin
//    }()
    public lazy var quitButton:UIButton = {
        let quitLogin = UIButton(type:.system)
        quitLogin.backgroundColor = UIColor.red
        quitLogin.setTitle("退出登录", for:.normal)
        quitLogin.layer.cornerRadius = 8
        quitLogin.layer.masksToBounds = true
        quitLogin.titleLabel?.font = UIFont.systemFont(ofSize:18)
        quitLogin.titleLabel?.textColor = UIColor.white
        quitLogin.addTarget(self, action: #selector(loginOff), for: .touchUpInside)
        return quitLogin
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //将所有按钮添加到scrollview中，还需要修改相对布局
        
        let headview = AJMineHeaderView(frame: CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight/3))

        let tableview = AJMineTableView(frame: CGRect(x: 0, y:  AJScreenHeight/3, width: AJScreenWidth, height: AJScreenHeight/3*2))
        //将CELL的标识，在此处进行设置
        tableview.tableview.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        tableview.tableview.delegate = self
        tableview.tableview.dataSource = self
//        self.view.addSubview(tableview)
    
    
      
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: AJScreenWidth, height: AJScreenHeight-64))
        scrollView.contentSize = CGSize(width: AJScreenWidth, height: AJScreenHeight - AJScreenHeight/35)

        scrollView.showsVerticalScrollIndicator = true
        scrollView.addSubview(headview)
        scrollView.addSubview(tableview)
        scrollView.addSubview(quitButton)
        quitButton.snp.makeConstraints{ (make) in
            make.top.equalTo(AJScreenHeight-AJScreenHeight/9)
            make.centerX.equalToSuperview()
            make.height.equalTo(AJScreenHeight/15)
            make.width.equalTo(AJScreenWidth)
        }
        
        self.view.addSubview(scrollView)
        
    }

    
    
    
    @objc public func loginOff(){
        print("退出成功")
        self.navigationController?.pushViewController(loginViewController(), animated: false)
    }
   
}
extension MineViewController:UITableViewDelegate,UITableViewDataSource{
    
    //设置有几个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //每个分区有几行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 4
        }
        return 3
    }
    //每一个cell，里面的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("这是什么东东", indexPath)
        //indexPath为一个数组
        //根据注册的cell类ID值获取到载体cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.selectionStyle = .none
        //判断有几组
        let sectionArray = MineArray[indexPath.section]
        //indexpath的[section][row]
        let dict:[String:String] = sectionArray[indexPath.row]
        cell.imageView?.image = UIImage(named: dict["icon"] ?? "")
        cell.textLabel?.text = dict["title"]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    //回调方法，监听点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //行
        let row = indexPath.section
        //列
        let col = indexPath.row
        if indexPath.section == 0 {
            self.navigationController?.pushViewController(clickArray[col], animated: false)
            print(clickArray[col])
            print(col)
        }else{
            self.navigationController?.pushViewController(clickArray[col+row+3], animated: false)
            print(clickArray[col+row+3])
            print(col+row+3)
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footview = UIView()
        footview.backgroundColor = FooterViewColor
        return footview
    }
   
}
