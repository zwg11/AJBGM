//
//  DataTableViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class DataTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "DATE"
        let id1 = "DATA"
        if(tableView.isEqual(headerTableView)){
            var cell = tableView.dequeueReusableCell(withIdentifier: id)
            if(cell == nil){
                cell = UITableViewCell(style: .default, reuseIdentifier: id)
            }
            cell?.textLabel?.text = "00:00"
            return cell!
        }
        var cell1 = tableView.dequeueReusableCell(withIdentifier: id1)
        if(cell1 == nil){
            cell1 = dataTableViewCell(style: .default, reuseIdentifier: id1)
        }
        //cell1?.textLabel?.text = "abcdefg"
        return cell1!
    }

    
    var headerTableView:UITableView = UITableView()
    var footTableview:UITableView = UITableView()

    var scroll:UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 如果设置其为透明可保证 其颜色与其他地方颜色相同时 视觉上一致
        //self.navigationController?.navigationBar.isTranslucent = false

        // 设置视图背景颜色
        view.backgroundColor = kRGBColor(156, 181, 234, 1)

        // create a tableView
        // **********其宽度要根据计算得出，高度也是根据数据量计算得出************
        headerTableView.dataSource = self
        headerTableView.delegate = self
        headerTableView.isScrollEnabled = false
        self.view.addSubview(headerTableView)
        headerTableView.snp.makeConstraints{(make) in
            make.top.left.equalToSuperview()
            
            make.height.equalTo(520)
            make.width.equalTo(80)
        }
        
        
        //let scroll = UIScrollView(frame: CGRect(x: 70, y: 10, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-100))
        scroll.contentSize = CGSize(width: 640, height: 520)
        scroll.showsHorizontalScrollIndicator = true
        scroll.indicatorStyle = .black
        scroll.bounces = false
        
        scroll.alwaysBounceHorizontal = false
        
        self.view.addSubview(scroll)
        scroll.snp.makeConstraints{(make) in
            make.top.right.equalToSuperview()
            // 滚动视图的高度要与 表格的高度 一致
            make.height.equalTo(520)
            make.left.equalTo(headerTableView.snp.right)
        }
        
        
        // create a tableView
        // **********其宽度要根据计算得出，高度也是根据数据量计算得出************
        footTableview = UITableView(frame: CGRect(x: 0, y: 0, width: 640, height: 520), style: .grouped)
        footTableview.dataSource = self
        footTableview.delegate = self
        footTableview.isScrollEnabled = false
        scroll.addSubview(footTableview)
        
    }
    
    // MARK: - 设置导航栏头部尾部高度，注意heightFor和viewFor函数都实现才能调节高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 设置头部视图
        if tableView == footTableview{
            let view = DataTableView.init(frame: CGRect(x: 0, y: 0, width: 640, height: 40))
            return view
        }else{
            let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
            label.text = "01-01"
            label.textColor = UIColor.black
            label.backgroundColor = kRGBColor(156, 181, 234, 1)
            label.textAlignment = .center
            view.addSubview(label)
            return view
        }
        //let view = DataTableView.init(frame: CGRect(x: 0, y: 0, width: 640, height: 40))
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    @objc func leftclick(){
        view.backgroundColor = UIColor.red
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
