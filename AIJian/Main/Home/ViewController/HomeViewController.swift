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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData(day: 7)
        
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
        let userId = 6
        let dicStr:Dictionary = ["day":day,"userId":userId,"token":token] as [String : Any]
        print(dicStr)
        // 请求数据，请求信息如上c字典
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
                        // 数据按 创建时间降序 排列，将结果赋值给一个数组
                        sortedByDateOfData = recordInDaysResponse.data?.sorted(by: {(data1,data2) -> Bool in
                            return data1.createTime!.toDate()!.date > data2.createTime!.toDate()!.date
                        })
//                        for x in sortedByDateOfData!{
//                            print("********sortedByDateOfData*********")
//                            print(x.createTime)
//                        }

                        // 将排好序的数据进行处理，得到我们想要的数组，用于表格显示
                        sortedTimeOfData()
                        
                        // 为画图表，提取含有血糖值的数据，只提取时间和血糖值
                        for i in recordInDaysResponse.data!{
                            
                            // 只有在有血糖数据时才导入
                            if let value = i.bloodGlucoseMmol{
                                //glucoseValue.append(value)
                                let date11 = i.createTime!.toDate()?.date
                                glucoseTime.append(date11!)
                                glucoseTimeAndValue.updateValue(value, forKey: date11!)
                                
                            }
                        }
                        // 改变值刷新UI
                        self.reload = "reload"
                    }
//                    print("**********glucoseValue**********")
//                    print(glucoseValue)
//                    print("**********glucoseTime**********")
//                    print(glucoseTime)
//                    print("**********glucoseTimeAndValue**********")
//                    print(glucoseTimeAndValue)
                } 
            }
        }
        //**********
    }
    // requestData() end

}

