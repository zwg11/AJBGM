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
        //  如果列表章节数大于0
        if section<sortedTime.count{
            return sortedTime[section].count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "DATE"
        let id1 = "DATA"
        if(tableView.isEqual(DATETableView)){
            var cell = tableView.dequeueReusableCell(withIdentifier: id)
            if(cell == nil){
                cell = UITableViewCell(style: .default, reuseIdentifier: id)
            }
            
            cell?.textLabel?.text = sortedTime[indexPath.section][indexPath.row].toFormat("HH:mm")
            return cell!
        }
        var cell1 = tableView.dequeueReusableCell(withIdentifier: id1)
        cell1?.selectionStyle = .none
        if(cell1 == nil){
            cell1 = dataTableViewCell(style: .default, reuseIdentifier: id1,secion: indexPath.section,row: indexPath.row)
        }
        
        return cell1!
    }

    // 日期tableView
    var DATETableView:UITableView = UITableView()
    // 数据tableView
    var DATATableView:UITableView = UITableView()

    // 整个页面的滚动视图
    var mainScrollView:UIScrollView = UIScrollView()
    // 只含有 数据tableView 的滚动视图
    var scroll:UIScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 如果设置其为透明可保证 其颜色与其他地方颜色相同时 视觉上一致
        //self.navigationController?.navigationBar.isTranslucent = false

        // 设置背景颜色
        mainScrollView.backgroundColor = kRGBColor(156, 181, 234, 1)
        // 设置整个视图的 滚动视图
        mainScrollView.contentSize = CGSize(width: AJScreenWidth, height: 40*3 + 44*4)
        self.view.addSubview(mainScrollView)

        mainScrollView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
            //make.height.equalTo(520)
        }
        // create a tableView
        // **********其宽度要根据计算得出，高度也是根据数据量计算得出************
        DATETableView.dataSource = self
        DATETableView.delegate = self
        DATETableView.isScrollEnabled = false
        mainScrollView.addSubview(DATETableView)
        DATETableView.snp.makeConstraints{(make) in
            make.top.left.equalToSuperview()
            
            make.height.equalTo(40*3 + 44*4)
            make.width.equalTo(80)
        }
        
        
        //let scroll = UIScrollView(frame: CGRect(x: 70, y: 10, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-100))
        scroll.contentSize = CGSize(width: 640, height: 40*3 + 44*4)
        scroll.showsHorizontalScrollIndicator = true
        scroll.indicatorStyle = .black
        scroll.bounces = false
        
        scroll.alwaysBounceHorizontal = false
        
        mainScrollView.addSubview(scroll)
        scroll.snp.makeConstraints{(make) in
            make.top.equalToSuperview()
            // 一直不理解为什么约束有时设为与滚动视图对齐就会不显示
            make.right.equalTo(self.view)
            // 滚动视图的高度要与 表格的高度 一致
            make.height.equalTo(40*3 + 44*4)
            make.left.equalTo(DATETableView.snp.right)
        }
        
        
        // create a tableView
        // **********其宽度要根据计算得出，高度也是根据数据量计算得出************
        DATATableView = UITableView(frame: CGRect(x: 0, y: 0, width: 640, height: 40*3 + 44*4), style: .grouped)
        DATATableView.dataSource = self
        DATATableView.delegate = self
        DATATableView.isScrollEnabled = false
        scroll.addSubview(DATATableView)
        
    }
    
    // MARK: - 设置导航栏头部尾部高度，注意heightFor和viewFor函数都实现才能调节高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    // 设置单元格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    // 设置表格头部视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == DATETableView{
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))

            label.backgroundColor = UIColor.blue
            label.textColor = UIColor.white
            label.textAlignment = .center
            view.addSubview(label)
            // 如果列表章节数大于0
            if section<sortedTime.count{
                label.text = sortedTime[section][0].toFormat("MM-dd")
            }
            return view
        }else{
            // 设置头部视图
            let view = DataTableViewOfHeader.init()
            return view
        }
        
    }
    // 不显示尾部视图
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    // 表格章节数依据数据里的日期，有几天有数据就是几个章节
    func numberOfSections(in tableView: UITableView) -> Int {
        if (sortedTime.count != 0) {
            print("num of section:\(sortedTime.count)")
            return sortedTime.count
        }
        else{
            print("num of section:\(sortedTime.count)")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 设置点击单元格有选中z动画，手指松开时变为未选中
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(title: "您是想选择", message: "", preferredStyle: .alert)
        let editAction = UIAlertAction(title: "编辑", style: .default, handler: nil)
        let deleteAction = UIAlertAction(title: "删除", style: .destructive, handler: nil)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    // 设置视图每次出现时滚动视图都回到顶部
    override func viewWillAppear(_ animated: Bool) {
        self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.scroll.contentOffset = CGPoint(x: 0, y: 0)
    }

}
