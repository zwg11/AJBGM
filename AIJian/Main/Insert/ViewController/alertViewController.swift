//
//  alertViewController.swift
//  st
//
//  Created by ADMIN on 2019/8/20.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
// 封装一个 自定义的UIAlertController类，其包含带有多选属性的表格
class alertViewController: UIAlertController,UITableViewDelegate,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self = UIAlertController.init(title: "提示\n\n\n\n", message: "", preferredStyle: .alert)
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    let tabelView = UITableView()
    var boolarr:Array<Bool> = []
    var boolArray:Array<Bool> = []
    var alertData:[String] = []
    // 该值记录被选中的单元格的个数
    @objc dynamic var selectedNum = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alertData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    // 设置单元格内容和图片
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "id")
        
        if(cell == nil){
            // 该单元格可根据单元格选中状态设置图片显示内容
            cell = UITableViewCell(style: .default, reuseIdentifier: "id")
        }
        
        if alertData.count > 0{
            cell?.textLabel?.text = alertData[indexPath.row]
            // 读取数组设置 单元格 是否被选中
            if boolarr[indexPath.row]{
                
                cell?.imageView?.image = UIImage(named: "selected")
            }else{
                
                cell?.imageView?.image = UIImage(named: "unselected")
            }
        }
      
        return cell!
    }
    
    // 设置单元格被选中时动作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        // 转变当前表格的选中状态
        boolArray[indexPath.row] = !boolArray[indexPath.row]
        if boolArray[indexPath.row]{
            selectedNum += 1
            cell?.imageView?.image = UIImage(named: "selected")
        }else{
            
            cell?.imageView?.image = UIImage(named: "unselected")
            selectedNum -= 1
        }
        // 存储当前表格的选中状态
        //boolArray[indexPath.row] = !boolArray[indexPath.row]
    }// 点击单元格函数结束
    // 设置单元格取消选中时动作
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        // 存储当前表格的选中状态
//        boolArray[indexPath.row] = false
//    }
    func setupUI(){
        // 设置单元格允许多选
        tabelView.allowsMultipleSelection = true
        // 初始化 存储表格状态的数组
        if alertData.count>0{
            for _ in 1...alertData.count{
                boolarr.append(false)
            }
        }
        
        boolArray = boolarr
        
        tabelView.delegate = self
        tabelView.dataSource = self
        // 设置tabelview不可滚动
        tabelView.isScrollEnabled = false
        tabelView.layer.borderColor = UIColor.lightGray.cgColor
        tabelView.layer.borderWidth = 1
        self.view.addSubview(tabelView)
        tabelView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .default, handler: {
            action in
            print("cancel")
            self.boolArray = self.boolarr
            print(self.boolArray)
            print(self.boolarr)
            self.tabelView.reloadData()
        })
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            print("确定")
            self.boolarr = self.boolArray
            print(self.boolArray)
            print(self.boolarr)
            
            self.tabelView.reloadData()
        })
        
        self.addAction(cancelAction)
        self.addAction(okAction)
    }
}
