//
//  InfoViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  个人信息管理页

import UIKit

class InfoViewController: UIViewController ,PickerDelegate{
   
    
    
    var num:Int = 0

    //列表数据
    public lazy var infoArray: Array = ["姓    名","性    别","体    重","身    高","生    日","国    家","电    话"]
    
    public lazy var infoDataArray : NSMutableArray = ["xxx","男","45","170","2019-02-08","中国","123456"]

    let tableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Information"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        
       //tableview.register(UITableViewCell.self, forCellReuseIdentifier:"infocell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isScrollEnabled = false
      
        
        //update.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .fade)
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints{(make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(AJScreenHeight/2)
        }
    }
    @objc private func back(){
        //按返回的时候，需要将数据进行更新
       self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //当每一次视图将要出现的时候，都要重新reload一下体重，防止那边换了单位，这边的信息还没换
        self.tableview.reloadRows(at: [IndexPath(row:2,section:0)], with: .fade)
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
        
        cell?.selectionStyle = .none
        cell = UITableViewCell(style: .value1, reuseIdentifier: "infocell")
        cell!.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = infoArray[indexPath.row]

        let userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
        switch indexPath.row{
        case 0:
            cell?.detailTextLabel?.text = userInfo.user_name ?? "nothing"
        case 1:
            if userInfo.gender != nil{
                cell?.detailTextLabel?.text = (userInfo.gender == 0) ? "男":"女"
            }else{
                cell?.detailTextLabel?.text = "nothing"
            }
           
        case 2:
            if userInfo.weight_kg != nil{
                if GetUnit.getWeightUnit() == "kg"{
                    cell?.detailTextLabel?.text = "\(userInfo.weight_kg!)kg"
                }else{
                    cell?.detailTextLabel?.text = "\(userInfo.weight_lbs!)lbs"
                }

            }else{
                cell?.detailTextLabel?.text = "nothing"
            }
            
        case 3:
            cell?.detailTextLabel?.text = (userInfo.height != nil) ? "\(userInfo.height!)cm":"nothing"
        case 4:
            cell?.detailTextLabel?.text = userInfo.birthday ?? "nothing"
        case 5:
            cell?.detailTextLabel?.text = userInfo.country ?? "nothing"
        default:
            cell?.detailTextLabel?.text = userInfo.phone_number ?? "nothing"
        }
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
                inputUserName()  //用户名
                num = 0
            case 1:
                let pickerView = BHJPickerView.init(self, .gender)
                pickerView.pickerViewShow()  //性别
                num = 1
            case 2:
                inputWeight()  //体重
                num = 2
            case 3:
                inputHeight()  //身高
                num = 3
            case 4:
                let pickerView = BHJPickerView.init(self, .date)   //生日
                pickerView.pickerViewShow()
                num = 4
            case 5:
                inputNation()  //国家
                num = 5
            case 6:
                inputPhone()   //电话
                num = 6
            default:
                inputUserName()
                //let pickerView = BHJPickerView.init(self, .address)
                //pickerView.pickerViewShow()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

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
                print("用户名，什么事情，也不干")
            }else{
                self.infoDataArray[0] = UserName.text!
                print("用户名num是多少",self.num)
                
                self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
                // print("用户名：\(String(describing: UserName.text)) ")
            }
           
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //改性别
    func selectedGender(_ pickerView: BHJPickerView, _ genderStr: String) {
        let messge = genderStr
        self.infoDataArray[1] = messge
        self.tableview.reloadRows(at: [IndexPath(row:1,section:0)], with: .fade)
        print(messge)
    }
    //改体重
    func inputWeight(){
        let alertController = UIAlertController(title: "请输入体重",message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "体重"
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Sure", style: .default, handler: {
            action in
            let UserName = alertController.textFields!.first!
            if String(UserName.text!) == ""  {  //||  String(UserName.text!) == "0"
                print("体重，什么事情，也不干")
            }else{
                self.infoDataArray[2] = UserName.text!
                print("体重num是多少",self.num)
                
                self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
                // print("用户名：\(String(describing: UserName.text)) ")
            }
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //改身高
    func inputHeight(){
        let alertController = UIAlertController(title: "请输入身高",message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "身高"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Sure", style: .default, handler: {
            action in
            let UserName = alertController.textFields!.first!
            if String(UserName.text!) == ""  {  //||  String(UserName.text!) == "0"
                print("身高，什么事情，也不干")
            }else{
                self.infoDataArray[3] = UserName.text!
                print("这个num是多少",self.num)
                
                self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
                // print("用户名：\(String(describing: UserName.text)) ")
            }
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //改生日
    func selectedDate(_ pickerView: BHJPickerView, _ dateStr: Date) {
        let messge = Date().dateStringWithDate(dateStr)
        self.infoDataArray[4] = messge
        print("点击生日num是多少",self.num)
        self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
        print(messge)
    }
    
    //改国家
    func inputNation(){
        let alertController = UIAlertController(title: "请输入国家",message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "国家"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Sure", style: .default, handler: {
            action in
            let UserName = alertController.textFields!.first!
            if String(UserName.text!) == ""  {  //||  String(UserName.text!) == "0"
                print("国家，什么事情，也不干")
            }else{
                self.infoDataArray[5] = UserName.text!
                print("国家num是多少",self.num)
                self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
                // print("用户名：\(String(describing: UserName.text)) ")
            }
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //改电话
    func inputPhone(){
        let alertController = UIAlertController(title: "请输入电话",message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "电话"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Sure", style: .default, handler: {
            action in
            let UserName = alertController.textFields!.first!
            if String(UserName.text!) == ""  {  //||  String(UserName.text!) == "0"
                print("电话，什么事情，也不干")
            }else{
                self.infoDataArray[6] = UserName.text!
                print("电话num是多少",self.num)
                self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
                // print("用户名：\(String(describing: UserName.text)) ")
            }
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func selectedBlood(_ pickerView: BHJPickerView, _ bloodStr: String) {
        
    }
    
    func selectedWeight(_ pickerView: BHJPickerView, _ weightStr: String) {
        
    }
    
    func selectedPressure(_ pickerView: BHJPickerView, _ pressureStr: String) {
        
    }
    func selectedAddress(_ pickerView: BHJPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
      //选择地址
    }
    
  
}
