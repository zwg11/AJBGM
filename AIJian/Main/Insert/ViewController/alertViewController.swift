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

        // Do any additional setup after loading the view.
    }
    
    
    let tabelView = UITableView()
    //存放初始化数据状态，即表格弹出时的选中状态
    var boolarr:Array<Bool> = []
    //存放当前数据状态，即当前表格的选中状态
    var boolArray:Array<Bool> = []
    //弹出数据列表
    var alertData:[String] = []
    // 该值记录被选中的单元格的个数,使用@dynamic修饰使其能够被观察
    @objc dynamic var selectedNum = 0
    
    //单元格的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 读取配置文件中的药物种类
        let path = PlistSetting.getFilePath(File: "inputChoose.plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        let arr = data["medicine"] as! NSArray
        return arr.count
    }
    //单元格的行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 33
    }
    
    // 设置单元格内容和图片
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 读取配置文件中的药物种类
        let path = PlistSetting.getFilePath(File: "inputChoose.plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        let arr = data["medicine"] as! NSArray
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "id")
        cell?.selectionStyle = .none
        
        if(cell == nil){
            // 该单元格可根据单元格选中状态设置图片显示内容
            cell = UITableViewCell(style: .default, reuseIdentifier: "id")
            cell?.selectionStyle = .none
        }
        
        // 表格文本内容与配置文件一致
        cell?.textLabel?.text = arr[indexPath.row] as? String
        // 读取数组设置 单元格 是否被选中  每次弹出的时候，都是去检测boolarr这个数组。
        if boolarr[indexPath.row]{
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            cell?.imageView?.image = UIImage(named: "selected")
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
            cell?.imageView?.image = UIImage(named: "unselected")
        }
        
        cell?.backgroundColor = UIColor.clear
        return cell!
    }
    
    // 设置单元格被选中时动作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.image = UIImage(named: "selected")
        // 设置该行状态为选中
        boolArray[indexPath.row] = true
        
        selectedNum += 1
//        tableView.deselectRow(at: indexPath, animated: true)
//        // 转变当前表格的选中状态
//
//        boolArray[indexPath.row] = !boolArray[indexPath.row]
//        if boolArray[indexPath.row]{
//            selectedNum += 1
//            cell?.imageView?.image = UIImage(named: "selected")
//        }else{
//
//            cell?.imageView?.image = UIImage(named: "unselected")
//            selectedNum -= 1
//        }

    }// 点击单元格函数结束
    
    // 取消选中某一行
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.image = UIImage(named: "unselected")
        
        // 设置该行状态为未选中
        boolArray[indexPath.row] = false

        selectedNum -= 1
    }

    func setupUI(){
        // 设置单元格允许多选
        tabelView.allowsMultipleSelection = true
        tabelView.backgroundColor = UIColor.clear
        // 读取配置文件中的药物种类
        let path = PlistSetting.getFilePath(File: "inputChoose.plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        let arr = data["medicine"] as! NSArray
        
        // 初始化 存储表格状态的数组,保持数组大小与药物种类一致
        for i in 0...arr.count-1{
            print(i)
            boolarr.append(false)
        }
        boolArray = boolarr
        
        tabelView.delegate = self
        tabelView.dataSource = self
        // 设置tabelview不可滚动
        tabelView.isScrollEnabled = true
        tabelView.bounces = false
        tabelView.layer.borderColor = UIColor.lightGray.cgColor
        tabelView.layer.borderWidth = 1
        self.view.addSubview(tabelView)
        tabelView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .default, handler: {
            action in
            print("Cancel")
            //如果取消的话，需要将原先保留下来的状态数组boolarr。替换成用户选择了的数组
            self.boolArray = self.boolarr
            print("定义中，点击了取消之后的更新数据",self.boolArray)
            print("定义中，点击了取消之后的初始化数据",self.boolarr)
            self.tabelView.reloadData()
            var sum = 0
            //判断用户选择了几个项目，然后显示已经选择了几个项目
            for i in self.boolarr{
                if i{
                    sum += 1
                }

            }
            self.selectedNum = sum
        })
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            print("确定")
            //如果取消的话，需要将用户选择了的数组。替换成原先保留下来的状态数组boolarr
            self.boolarr = self.boolArray
            print("定义中，点击了确定之后的更新数据",self.boolArray)
            print("定义中，点击了确定之后的初始化数据",self.boolarr)

//            self.tabelView.reloadData()
            
        })
        cancelAction.setValue(UIColor.black, forKey: "_titleTextColor")
        okAction.setValue(UIColor.black, forKey: "_titleTextColor")
        
        self.addAction(cancelAction)
        self.addAction(okAction)
    }
    
}
