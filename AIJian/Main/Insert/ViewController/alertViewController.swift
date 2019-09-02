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
        
        //setupUI()
        // Do any additional setup after loading the view.
    }
    let tabelView = UITableView()
    //存放初始化数据状态，即表格弹出时的选中状态
    var boolarr:Array<Bool> = []
    //存放当前数据状态，即当前表格的选中状态
    var boolArray:Array<Bool> = []
    //弹出数据列表
    var alertData:[String] = []
    // 该值记录被选中的单元格的个数
    @objc dynamic var selectedNum = 0
    
    //单元格的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alertData.count
    }
    //单元格的行高
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
            // 读取数组设置 单元格 是否被选中  每次弹出的时候，都是去检测boolarr这个数组。
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
            print("定义中，内部数据的个数",alertData.count)
            for i in 1...alertData.count{
                print(i)
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
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            print("确定")
            //如果取消的话，需要将用户选择了的数组。替换成原先保留下来的状态数组boolarr
            self.boolarr = self.boolArray
            print("定义中，点击了确定之后的更新数据",self.boolArray)
            print("定义中，点击了确定之后的初始化数据",self.boolarr)
            
            self.tabelView.reloadData()
        })
        
        self.addAction(cancelAction)
        self.addAction(okAction)
    }
//    //获得药物名称
//    func getMedicineArray()->Array<String>{
//        var arr:[String] = []
//        var j:Int = 0
//        for i in self.boolarr{
//            if i{
//               print("药物")
//               print(i)
//               arr.append(alertData[j])
//            }
//            j = j+1
//        }
//        return arr
//    }
//    //设置药物名称,需要传入一个String数组     数据回写
//    func setMedicineArray(_ arr:Array<String>){
//        let initLength:Int = alertData.count
//        let fromLength:Int = arr.count
//        //如果alertData的数据元素，与传入的数据元素相等的话。则将元素对应的boolarr设置成true
//            for i in 0..<initLength{
//                for j in 0..<fromLength{
//                    if alertData[i] == arr[j]{
//                        boolarr[i] = true
//                    }
//                }
//            }
//    }
    
}
