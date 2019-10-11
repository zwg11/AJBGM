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
            cell.textLabel?.text = "Latest BG"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            // 在数据库取出最近一次的血糖记录
            let x = DBSQLiteManager.shareManager()
            let data = x.selectLastGlucoseRecord(UserInfo.getUserId())

            // 显示时间
            if let time = data.createTime{
                cell.detailTextLabel?.text = time.toDate()?.date.toFormat("yyyy-MM-dd HH:mm")
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
        if indexPath.row == 1{
            
            let x = DBSQLiteManager.shareManager()
            // 在数据库取出最近一次的血糖记录
            let data = x.selectLastGlucoseRecord(UserInfo.getUserId())
            // 初始化insert界面
            let insert = InsertViewController()
            insert.EditData(date: data)
            self.navigationController?.pushViewController(insert, animated: true)
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

        //重新判断加载视图
        //input.reloadInputViews()
//        self.view.addSubview(homeTableView)
//        homeTableView.snp.makeConstraints{(make) in
//            make.left.right.equalToSuperview()
//            if #available(iOS 11.0, *) {
//                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
//            } else {
//                // Fallback on earlier versions
//                make.top.equalTo(topLayoutGuide.snp.bottom)
//                make.bottom.equalTo(bottomLayoutGuide.snp.top)
//            }
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        homeTableView.removeFromSuperview()
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
        // 设置监听器，监听是否弹出插入成功r弹窗
            NotificationCenter.default.addObserver(self, selector: #selector(InsertSuccess), name: NSNotification.Name(rawValue: "InsertData"), object: nil)

    }

    @objc func InsertSuccess(){
        let x = UIAlertController(title: "", message: "Insert Success.", preferredStyle: .alert)
        self.present(x, animated: true, completion: {()->Void in
            sleep(1)
            x.dismiss(animated: true, completion: nil)
        })
        
    }
 
}


extension HomeViewController{
//    override var shouldAutorotate: Bool {
//        return false
//    }
//    
//    
//    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
//    
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .portrait
//    }
  
}
