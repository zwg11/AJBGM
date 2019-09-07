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
            return 150
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
            // 在数据库取出最近c一次的血糖记录
            let x = DBSQLiteManager.shareManager()
            let data = x.selectLastGlucoseRecord(userId!)
//            let dateformat = DateFormatter()
//            dateformat.dateFormat = "yyyy-MM-dd HH-mm"
            if let date = data.createTime{
                cell.detailTextLabel?.text = data.createTime!
            }
            
            return cell
        case 1:
            //var cell = tableView.dequeueReusableCell(withIdentifier: id)
            
            let cell = LastResultTableViewCell(style: .value1, reuseIdentifier: id)
            cell.selectionStyle = .none

            return cell
        case 2:
            //var cell = tableView.dequeueReusableCell(withIdentifier: id)
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            cell.textLabel?.text = "最近7天"
            
            return cell
        case 3:
            //var cell = tableView.dequeueReusableCell(withIdentifier: id)
            
            let cell = recentTableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            //cell?.textLabel?.text = "最近7天"
            cell.backgroundColor = UIColor.yellow
            return cell
        case 4:
            //var cell = tableView.dequeueReusableCell(withIdentifier: id)
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            //cell.imageView?.image = UIImage(named: "tend_pic")
            cell.textLabel?.text = "血糖趋势"
            
            return cell
        default:
            //var cell = tableView.dequeueReusableCell(withIdentifier: id)
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            cell.contentView.addSubview(recent7View)
            recent7View.snp.makeConstraints{(make) in
                make.edges.equalToSuperview()
            }
            return cell
        }
        
    }

    
    private lazy var recent7View:recentTrendView = {
        let view = recentTrendView()
        
        view.setupUI()
        
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
        print("这个东西到底是什么东西",SHIFT!)

    }
    
    var homeTableView:UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.frame = CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        self.view.addSubview(homeTableView)
        // 初始化用户信息
        getUserInfo()
        // 向数据库插入用户信息
        let sqliteManager = DBSQLiteManager()
        sqliteManager.createTable()
        var user1 = USER()
        user1.user_id = userId!
        user1.token = token!
        user1.email = "zzmmshang@qq.com"
        sqliteManager.addUserRecord(user1)
        
        requestData(day: 3)
        
        self.view.backgroundColor = UIColor.white
        
        
        
        // Do any additional setup after loading the view.
    }

    
    // 该函数向服务器请求数据并进行一定程度的数据处理
    // 包括对数据根据日期进行排序，之后分出日期和时间、分健康信息等
    // requestData()
    func requestData(day:Int){
        //********
        let day = day
        let usr_id = userId!
        let tk = token!
        // 设置信息请求字典
        let dicStr:Dictionary = ["day":day,"userId":usr_id,"token":tk] as [String : Any]
        print(dicStr)
        // 请求数据，请求信息如上字典
        Alamofire.request(REQUEST_DATA_URL,method: .post,parameters: dicStr).responseString{ (response) in
            if response.result.isSuccess {
                print("收到回复")
                if let jsonString = response.result.value {
                    
                    /// json转model
                    /// 写法一：responseModel.deserialize(from: jsonString)
                    /// 写法二：用JSONDeserializer<T>
                    /*
                     利用JSONDeserializer封装成一个对象。然后再把这个对象解析为
                     */
                    print("jsonString:\(jsonString)")
                    if let recordInDaysResponse = JSONDeserializer<recordInDaysResponse>.deserializeFrom(json: jsonString) {
                        // 如果 返回信息说明 请求数据失败，则弹出警示框宝报错
                        if recordInDaysResponse.code != 1{
                            let alert = CustomAlertController()
                            alert.custom(self, "警告", "\(recordInDaysResponse.msg!)")
                            return
                        }
                        
                        // ******** 将得到的所有数据都添加到数据库 ***********
                        let sqliteManager = DBSQLiteManager()
                        // 创建表
                        sqliteManager.createTable()
                        // 如果服务器中有对应用户的数据，将数据添加到数据库
                        if recordInDaysResponse.data != nil{
                            sqliteManager.addGlucoseRecords(add: recordInDaysResponse.data!)
                            
                        }
                        // 重新加载表格内容
                        self.homeTableView.reloadData()
                    }
                } 
            }else{
                print("没网了")
            }
            
            
        }
        //**********
    }
    // requestData() end

}

