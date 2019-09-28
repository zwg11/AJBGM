//
//  VersionUViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//

/*版本更新界面*/

import UIKit
import SnapKit
import StoreKit


class VersionUViewController: UIViewController {
        
        //列表数据
        public lazy var versionDataArray: Array = ["Current Version","Feedback","Score","Version Update"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "Update"
            self.view.backgroundColor = ThemeColor
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style:.plain, target: self, action: #selector(back))
            
            
//
//            let tableview = UITableView.init(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight/15*4))
                let tableview = UITableView()
            //将CELL的标识，在此处进行设置
            tableview.backgroundColor = ThemeColor
            tableview.isScrollEnabled = false
            tableview.register(UITableViewCell.self, forCellReuseIdentifier:"versioncell")
            tableview.delegate = self
            tableview.dataSource = self
            
            self.view.addSubview(tableview)
            tableview.snp.remakeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15*4)
                make.width.equalToSuperview()
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
        }
        @objc private func back(){
            self.navigationController?.popViewController(animated: true)
        }
    
    }
extension VersionUViewController:UITableViewDelegate,UITableViewDataSource{
        
        //设置有几个分区
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        //每个分区有几行
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           print("几行",versionDataArray.count)
            return versionDataArray.count
        }
        //每一个cell，里面的内容
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print("到达版本更新页", indexPath)
            //根据注册的cell类ID值获取到载体cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "versioncell",for: indexPath)
            cell.backgroundColor = ThemeColor
            cell.textLabel?.textColor = TextColor
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = versionDataArray[(indexPath as NSIndexPath).row]
            return cell
        }
    
    
    
        //回调方法，监听点击事件
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //行
//            let row = indexPath.section
            //列
            let row = indexPath.row
            switch row {
                case 0:  //跳转到当前版本页面
                    //取出本地版本
                    let localVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
                    print(localVersion)
                    self.navigationController?.pushViewController(CurrentVersion(), animated: true)
                    print("第一行")
                case 1:  //跳转到反馈页面
                    self.navigationController?.pushViewController(SuggestionViewController(), animated: true)
                case 2:  //跳转到去评分界面
                    if #available(iOS 10.3, *) {
                        SKStoreReviewController.requestReview()
                    } else {
                        // Fallback on earlier versions
                    }
                case 3:  //跳转到版本更新
                    UpdateManager.init()
                default:  //缺省不跳
                    print("第五行")
               }
          }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AJScreenHeight/15
    }
}
