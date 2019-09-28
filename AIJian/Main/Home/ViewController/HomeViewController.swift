//
//  HomeViewController.swift
//  AIJianma
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import SwiftDate

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return AJScreenWidth/3
        case 3,5:
            return AJScreenWidth/2
//        case 5:
//            return 150
        default:
            return AJScreenWidth/10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "reusedId"
        //let id1 = "reuse"
        //var cell = tableView.dequeueReusableCell(withIdentifier: id)
        
        switch indexPath.row {
        case 0:
            
            
            let cell = UITableViewCell(style: .value1, reuseIdentifier: id)
            cell.selectionStyle = .none
            cell.textLabel?.text = "最近一次"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            // 在数据库取出最近一次的血糖记录
            let x = DBSQLiteManager.shareManager()
            let data = x.selectLastGlucoseRecord(UserInfo.getUserId())

            // 显示时间
            if let date = data.createTime{
                cell.detailTextLabel?.text = date
            }
            
            return cell
        case 1:
            //var cell = tableView.dequeueReusableCell(withIdentifier: id)
            
            let cell = LastResultTableViewCell(style: .value1, reuseIdentifier: id)
            cell.selectionStyle = .none

            cell.backgroundColor = UIColor.clear
            return cell
        case 2:
            //var cell = tableView.dequeueReusableCell(withIdentifier: id)
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            cell.textLabel?.text = "最近7天"
            cell.textLabel?.textColor = UIColor.white
            cell.backgroundColor = UIColor.clear
            return cell
        case 3:
            
            let cell = recentTableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
        case 4:
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            cell.textLabel?.text = "血糖趋势"
            cell.textLabel?.textColor = UIColor.white
            cell.backgroundColor = UIColor.clear
            return cell
        default:
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            cell.contentView.addSubview(recent7View)
            recent7View.snp.makeConstraints{(make) in
                make.edges.equalToSuperview()
            }
            cell.backgroundColor = UIColor.clear
            return cell
        }
        
    }

    
    private lazy var recent7View:recentTrendView = {
        let view = recentTrendView()
        // 分割线颜色设为白色
        homeTableView.separatorColor = UIColor.white
        view.setupUI()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        

//        // 初始化用户信息
//        getUserInfo()
//        // 向数据库插入用户信息
//        let sqliteManager = DBSQLiteManager()
//        sqliteManager.createTable()
//        var user1 = USER()
//        user1.user_id = userId!
//        user1.token = token
//        user1.email = "zzmmshang@qq.com"
//        sqliteManager.addUserRecord(user1)
        homeTableView.reloadData()
        print("这个东西到底是什么东西",SHIFT!)
        // 图表重新画
        recent7View.reloadChart()
        recent7View.recentTrendView.drawLineChart(xAxisArray: xAxisArrayToWeek(Days: 7) as NSArray,xAxisData: recentDaysData(Days: 7))

    }
    
    var homeTableView:UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true

        
        self.view.addSubview(homeTableView)
        homeTableView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                // Fallback on earlier versions
            }
        }
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.backgroundColor = UIColor.clear
        homeTableView.isScrollEnabled = true
        
        self.view.backgroundColor = ThemeColor


        
        
        // Do any additional setup after loading the view.
    }
 
}

