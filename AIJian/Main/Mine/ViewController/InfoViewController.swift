//
//  InfoViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController ,PickerDelegate{
    
    var num:Int = 0

    //列表数据
    public lazy var infoArray: Array = ["用户名","性    别","体    重","身    高","邮    箱","生    日"]
    
    public lazy var infoDataArray : NSMutableArray = ["xxx","男","45","170","6662@.com","2019-02-08"]
    
    //var update:UITableViewCell??
    
    let tableview:UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight/15*7))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Information"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        
        
       
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier:"infocell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isScrollEnabled = false
      
        
        //update.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .fade)
        self.view.addSubview(tableview)
    }
    @objc private func back(){
       self.navigationController?.popViewController(animated: true)
    }
    
}
extension InfoViewController:UITableViewDelegate,UITableViewDataSource{
    
    //设置有几个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //每个分区有几行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count
    }
    //每一个cell，里面的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("到达个人信息页", indexPath)
        print("section",indexPath.section)
        print("row",indexPath.row)
        //根据注册的cell类ID值获取到载体cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "infocell")
        
        var style: UITableViewCell.CellStyle

        style = UITableViewCell.CellStyle.value1

        
        cell = UITableViewCell(style: style, reuseIdentifier: "infocell")
        
        cell!.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = infoArray[(indexPath as NSIndexPath).row]

        
        //放真实数据,右边value
        if(indexPath.row == 0){
            cell?.detailTextLabel?.text = infoDataArray[(indexPath as NSIndexPath).row] as? String
        }else if(indexPath.row == 3){
            cell?.detailTextLabel?.text = "45kg"
            print(infoDataArray[(indexPath as NSIndexPath).row] )
        }else if(indexPath.row == 4){
            cell?.detailTextLabel?.text = infoDataArray[(indexPath as NSIndexPath).row] as? String
//            print(infoDataArray[(indexPath as NSIndexPath).row] + weightUnit)
        }else{
            cell?.detailTextLabel?.text = infoDataArray[(indexPath as NSIndexPath).row] as? String
        }
//         cell.selectionStyle = .default
        return cell!
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    //回调方法，监听点击事件
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //行
        let row = indexPath.row
        print(row)
        switch row {
            case 0:
                inputUserName()
                num = 0
            case 1:
                let pickerView = BHJPickerView.init(self, .gender)
                pickerView.pickerViewShow()
                num = 1
            case 5:
                let pickerView = BHJPickerView.init(self, .date)
                pickerView.pickerViewShow()
                num = 5
            
            default:
                inputUserName()
                //let pickerView = BHJPickerView.init(self, .address)
                //pickerView.pickerViewShow()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footview = UIView()
//        foot
//    view.backgroundColor = FooterViewColor
//        return footview
////    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AJScreenHeight/15
    }
    //输入用户名
    @objc func inputUserName(){
        let alertController = UIAlertController(title: "请输入用户名",message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "用户名"
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            let UserName = alertController.textFields!.first!
            if String(UserName.text!) == ""  {  //||  String(UserName.text!) == "0"
                print("什么事情，也不干")
            }else{
                self.infoDataArray[0] = UserName.text!
                print("这个num是多少",self.num)
                
                self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
                // print("用户名：\(String(describing: UserName.text)) ")
            }
           
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func selectedAddress(_ pickerView: BHJPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
      //选择地址
    }
    //改时间
    func selectedDate(_ pickerView: BHJPickerView, _ dateStr: Date) {
        let messge = Date().dateStringWithDate(dateStr)
        print("这个num是多少",self.num)
        
        self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
        self.infoDataArray[5] = messge
        print(messge)
    }
    //改性别
    func selectedGender(_ pickerView: BHJPickerView, _ genderStr: String) {
        let messge = genderStr
        self.infoDataArray[2] = messge
        print(messge)
    }
}
