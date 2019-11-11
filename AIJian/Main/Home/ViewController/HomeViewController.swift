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
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
        case 2:
            //var cell = tableView.dequeueReusableCell(withIdentifier: id)
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            cell.textLabel?.text = "Last 7 days"
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
                insert.EditData(date: data!)
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
        recent7View.reloadChart()
        recent7View.recentTrendView.drawLineChart(xAxisArray: xAxisArrayToWeek(Days: 7) as NSArray,xAxisData: recentDaysData(Days: 7))

        // 设置滑块的图片样式
        let sd = sliderView.init(frame: CGRect(x: 0, y: -100, width: AJScreenWidth*0.9, height: 5))
        self.view.addSubview(sd)
        sliderImage = viewToImage.getImageFromView(view: sd)
        // 隐藏tabbar
        self.tabBarController?.tabBar.isHidden = false
        
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        // 读取配置文件，获取meterID的内容
        let path = PlistSetting.getFilePath(File: "User.plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        print("配置文件内容\(data)")
        let arr = data["meterID"] as! NSMutableDictionary
        print("配置文件中的meterID内容：\(arr)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        homeTableView.removeFromSuperview()
    }
    
    var homeTableView:UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        homeTableView.delegate = self
        homeTableView.dataSource = self
        // 单元格分割线、背景为透明
        homeTableView.separatorColor = UIColor.clear
        homeTableView.backgroundColor = UIColor.clear
        homeTableView.isScrollEnabled = true
        self.view.backgroundColor = UIColor.clear
    }
}

