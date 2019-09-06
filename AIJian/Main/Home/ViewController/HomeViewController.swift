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

class HomeViewController: UIViewController {
    
    // 为同步网络请求与表格UI，设置监听器
    var reload:String?{
        didSet{
            // 刷新UI
            setupUI()
        }
    }

    private lazy var theLastGlucoseView:theLastCheckView = {
        let view = theLastCheckView()
        view.setupUI()
        return view
    }()
    
    private lazy var glucoseReView:glucoseRecentView = {
        let view = glucoseRecentView()
        view.setupUI()
        return view
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化用户信息
        getUserInfo()
        // 向数据库插入用户信息
        let sqliteManager = DBSQLiteManager()
        sqliteManager.createTable()
        var user1 = USER()
        user1.user_id = userId!
        user1.token = token
        user1.email = "zzmmshang@qq.com"
        sqliteManager.addUserRecord(user1)
        
        requestData(day: 30)
        
        self.view.backgroundColor = UIColor.white
        
       
        
        // Do any additional setup after loading the view.
    }
    // 界面UI布局
    func setupUI(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.addSubview(theLastGlucoseView)
        theLastGlucoseView.snp.makeConstraints{(make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(AJScreenWidth/20*7)
        }
        
        self.view.addSubview(glucoseReView)
        glucoseReView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(theLastGlucoseView.snp.bottom)
            make.height.equalTo(AJScreenWidth/20*7)
        }
        
        // 等待数据加载后再将图表展示，否则会报错
        self.view.addSubview(recent7View)
        recent7View.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(glucoseReView.snp.bottom)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(20)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(20)
            }
        }
    }
    
    // 该函数向服务器请求数据并进行一定程度的数据处理
    // 包括对数据根据日期进行排序，之后分出日期和时间、分健康信息等
    // requestData()
    func requestData(day:Int){
        //********
        let day = day
        let usr_id = userId!
        let tk = token
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
                    if let recordInDaysResponse = JSONDeserializer<recordInDaysResponse>.deserializeFrom(json: jsonString) {
                        // 如果 返回信息说明 请求数据失败，则弹出警示框宝报错
                        if recordInDaysResponse.code != 1{
                            print(recordInDaysResponse.code)
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
                        
                        // 改变值刷新UI
                        self.reload = "reload"
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

