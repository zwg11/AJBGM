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
        default:
            return AJScreenWidth/10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "reusedId"
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: id)
            cell.selectionStyle = .none
            cell.textLabel?.text = "Latest BG"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            // 在数据库取出最近一次的血糖记录
            let x = DBSQLiteManager.shareManager()
            let data = x.selectLastGlucoseRecord(UserInfo.getUserId())

            // 显示时间
            if let time = data?.createTime{
                cell.detailTextLabel?.text = time.toDate()?.date.toFormat("yyyy/MM/dd HH:mm")
            }
            
            return cell
        case 1:
            //var cell = tableView.dequeueReusableCell(withIdentifier: id)
            
            let cell = LastResultTableViewCell(style: .value1, reuseIdentifier: id)
            // 在数据库取出最近一次的血糖记录
            let x = DBSQLiteManager.shareManager()
            let data = x.selectLastGlucoseRecord(UserInfo.getUserId())
            if data != nil{
                SetColorOfLabelText.SetGlucoseTextColor(data!, label: cell.glucoseValueLabel)
            }
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
        case 2:
            //var cell = tableView.dequeueReusableCell(withIdentifier: id)
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            cell.textLabel?.text = "Last 7 Days"
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
            cell.textLabel?.text = "Trend"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == 1{
            
            let x = DBSQLiteManager.shareManager()
            // 在数据库取出最近一次的血糖记录
            let data = x.selectLastGlucoseRecord(UserInfo.getUserId())
            // 如果data不为空
            if data != nil{
                // 初始化insert界面
                let insert = InsertViewController()
                insert.isHome = true
                insert.EditData(data: data!)
                self.navigationController?.pushViewController(insert, animated: false)
            }else{
//                let alert = CustomAlertController()
//                alert.custom(self, "Attension", "No Data.")
            }
            
        }
    }
    
    

    
    private lazy var recent7View:recentTrendView = {
        let view = recentTrendView()
        view.setupUI()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        // 设置导航栏为透明
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        // 设置滚动视图和表格视图不自动调整位移量
        self.automaticallyAdjustsScrollViewInsets = false
        homeTableView.reloadData()
        // 图表重新画
        
        recent7View.recentTrendView.drawLineChart(xAxisArray: xAxisArrayToWeek(Days: 7) as NSArray,xAxisData: recentDaysData(Days: 7, isGetData: true))
        recent7View.reloadChart()
        // 设置滑块的图片样式
        let sd = sliderView.init(frame: CGRect(x: 0, y: -100, width: AJScreenWidth*0.9, height: 5))
        self.view.addSubview(sd)
        sliderImage = viewToImage.getImageFromView(view: sd)
        // 隐藏tabbar
        self.tabBarController?.tabBar.isHidden = false
        
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

//        // 读取配置文件，获取meterID的内容
//        let path = PlistSetting.getFilePath(File: "User.plist")
//        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
//        //print("配置文件内容\(data)")
//        let arr = data["meterID"] as! NSMutableDictionary
//        //print("配置文件中的meterID内容：\(arr)")
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        homeTableView.removeFromSuperview()
    }
    
    var homeTableView:UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        // 单元格分割线、背景为透明
        homeTableView.separatorColor = UIColor.clear
        homeTableView.backgroundColor = UIColor.clear
        homeTableView.isScrollEnabled = true
        
        self.view.backgroundColor = UIColor.clear
        
        self.view.addSubview(homeTableView)
        homeTableView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                // Fallback on earlier versions
            }

        }
        // 检查token的有效性
        isTokenEffective()
        // 检查App是否更新 me
       // isUpdateApp()
        
    }
}

extension HomeViewController{
    // 检查token的有效性
    func isTokenEffective(){
        //此处分为两种情况：一种是判断token过没过期。第二种是没有网络怎么办
        let dictString:Dictionary = [ "userId":UserInfo.getUserId() ,"token":UserInfo.getToken()] as [String : Any]
        // alamofire begin
        AlamofireManager.request(CHECK_TOKEN,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
            if response.result.isSuccess {
                if let jsonString = response.result.value {
                    if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                        //print(responseModel.toJSONString(prettyPrint: true)!)
                        if(responseModel.code == 1 ){  //token没过期
                            //没过期，允许使用，跳转到tabBar这个地方
                            //print("你的token还能用")
//                            self.window?.rootViewController = tabBarController
                        }else if(responseModel.code == 4 ){ // 该用户不存在了
                            // 跳转到登录界面
                            let viewController = loginViewController()
                            let loginNv = loginNavigationController(rootViewController: viewController)
                            loginNv.modalPresentationStyle = .fullScreen
                            let alertToLigin = UIAlertController(title: "Attention", message: "Your account does not exist", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Done", style: .default, handler:{
                                action in
                                // 跳转到登录界面
                                self.present(loginNv, animated: true, completion: nil)
                                // 清空token和userid和email
                                UserInfo.setToken("")
                                UserInfo.setUserId(0)
                                UserInfo.setEmail("")
                            })
                            alertToLigin.addAction(okAction)
                            self.present(alertToLigin, animated: true, completion: nil)
                        }
                        else{  //token过期了,不让用
                            //过期了，需要清空app文件中的token
                            // 跳转到登录界面 
                            let viewController = loginViewController()
                            let loginNv = loginNavigationController(rootViewController: viewController)
                            loginNv.modalPresentationStyle = .fullScreen
                            let alertToLigin = UIAlertController(title: "Attention", message: "Your login information has expired.", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Done", style: .default, handler:{
                                action in
                                // 跳转到登录界面
                                self.present(loginNv, animated: true, completion: nil)
                                // 清空token
                                UserInfo.setToken("")
                            })
                            alertToLigin.addAction(okAction)
                            self.present(alertToLigin, animated: true, completion: nil)
                        }
                    }
                }
            }else{  //没网的时候
                //print("网络链接失败")
                // 跳转到登录界面
                let alertToLigin = UIAlertController(title: "Attention", message: "The Internet Doesn't Work,Data Change is Not Allowed.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Done", style: .default, handler:{
                    action in
//                    // 跳转到登录界面
//                    self.present(loginNv, animated: true, completion: nil)
//                    // 清空token
//                    UserInfo.setToken("")
                })
                alertToLigin.addAction(okAction)
                self.present(alertToLigin, animated: true, completion: nil)
                //具体的提示，homeViewController   自己会做
            }
        }
        // alamofire end
    }
    
    
    
}
