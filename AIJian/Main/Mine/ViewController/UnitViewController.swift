//
//  UnitViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class UnitViewController: UIViewController,PickerDelegate {

    var num:Int = 0
    
    public lazy var unitArray: Array = ["血糖单位","体重单位","血压单位",]
    
    public lazy var unitDataArray : Array = ["mmol/L","kg","kPa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Unit"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        
        
        let tableview:UITableView = {
            let tableView = UITableView.init(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight/15 * 3))
            return tableView
        }()
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier:"infocell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isScrollEnabled = false
        self.view.addSubview(tableview)
    }
    
    @objc private func back(){
        self.navigationController?.popViewController(animated: true)
    }
}


extension UnitViewController:UITableViewDelegate,UITableViewDataSource{
    
    //设置有几个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //每个分区有几行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unitArray.count
    }
    //每一个cell，里面的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("到达个人信息页", indexPath)
        //根据注册的cell类ID值获取到载体cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "infocell")
        
        
        //cell.focusStyle = .custom
        var style: UITableViewCell.CellStyle
        style = UITableViewCell.CellStyle.value1
        cell = UITableViewCell(style: style, reuseIdentifier: "infocell")
        
        //左边标签
        cell?.textLabel?.text = unitArray[(indexPath as NSIndexPath).row]
        
        //右边数据
        cell!.accessoryType = .disclosureIndicator
        cell?.detailTextLabel?.text = unitDataArray[(indexPath as NSIndexPath).row]
        
        return cell!
    }
    
    
    //回调方法，监听点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //行
        let row = indexPath.row
        print(row)
        switch row {
        case 0:
            let pickerView = BHJPickerView.init(self, .blood)
            pickerView.pickerViewShow()  //血糖
            num = 0
        case 1:
            let pickerView = BHJPickerView.init(self, .weight)
            pickerView.pickerViewShow()  //体重
            num = 1
        case 2:
            let pickerView = BHJPickerView.init(self, .pressure)
            pickerView.pickerViewShow()  //血压
            num = 2
        default:
            let pickerView = BHJPickerView.init(self, .pressure)
            pickerView.pickerViewShow()  //血压
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func selectedAddress(_ pickerView: BHJPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
        print("选择地址")
    }
    
    func selectedDate(_ pickerView: BHJPickerView, _ dateStr: Date) {
        print("选择日期")
    }
    
    func selectedGender(_ pickerView: BHJPickerView, _ genderStr: String) {
        print("选择性别")
    }
    func selectedBlood(_ pickerView: BHJPickerView, _ bloodStr: String) {
        print("选择血糖")
    }
    
    func selectedWeight(_ pickerView: BHJPickerView, _ weightStr: String) {
        print("选择体重")
    }
    
    func selectedPressure(_ pickerView: BHJPickerView, _ pressureStr: String) {
        print("选择血压")
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AJScreenHeight/15
    }
}



