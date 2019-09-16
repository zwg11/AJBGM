//
//  InfoViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  个人信息管理页

import UIKit
import Alamofire
import HandyJSON

class InfoViewController: UIViewController ,PickerDelegate{
   
    
    
    var num:Int = 0

    //列表数据
    public lazy var infoArray: Array = ["姓    名","性    别","体    重","身    高","生    日","国    家","电    话"]
    //图标数据
    public lazy var infoIconArray:Array = ["aboutUs","aboutUs","aboutUs","aboutUs","aboutUs","aboutUs","aboutUs"]
    public lazy var infoDataArray : [String] = ["","","","","","",""]

    let tableview = UITableView()
    // 判断是否有需要更新的内容，没有则不更新,返回至上一界面
    var updateSth = false
    // 初始化列表数组
    func initInfoDataArray(){
        let userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
        infoDataArray[0] = userInfo.user_name ?? ""
        if (userInfo.height != nil){
            infoDataArray[1] = (userInfo.height! == 0) ? "男":"女"
        }
        
        if GetUnit.getWeightUnit() == "kg"{
            infoDataArray[2] = (userInfo.weight_kg != nil) ? "\(userInfo.weight_kg!)":""
        }else{
            infoDataArray[2] = (userInfo.weight_lbs != nil) ? "\(userInfo.weight_lbs!)":""
        }
        infoDataArray[3] = (userInfo.height != nil) ? "\(userInfo.height!)":""
        infoDataArray[4] = userInfo.birthday ?? ""
        infoDataArray[5] = userInfo.country ?? ""
        infoDataArray[6] = userInfo.phone_number ?? ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initInfoDataArray()
        //tableview.reloadData()

        self.title = "Information"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveUserInfo))
        
       //tableview.register(UITableViewCell.self, forCellReuseIdentifier:"infocell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isScrollEnabled = false
      
        
        //update.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .fade)
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints{(make) in
            make.top.equalTo(AJScreenHeight/10)
            make.left.right.equalToSuperview()
            make.height.equalTo(AJScreenHeight/15*7)
        }
    }
    @objc private func back(){
        //按返回的时候，需要将数据进行更新
       self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveUserInfo(){

        if !updateSth{
            self.navigationController?.popViewController(animated: true)
            return
        }
        // 如果有需要更新的内容
        var updateUserInfo = USER_UPDATE()
        updateUserInfo.email = UserInfo.getEmail()
        updateUserInfo.userName = (infoDataArray[0] == "") ? nil:infoDataArray[0]
        updateUserInfo.gender = (infoDataArray[1] == "男") ? 0:1
        if infoDataArray[2] != ""{
            if GetUnit.getWeightUnit() == "kg"{
                updateUserInfo.weightKg = Double(infoDataArray[2])
                updateUserInfo.weightLbs = WeightUnitChange.KgToLbs(num: Double(infoDataArray[2])!)
            }else{
                updateUserInfo.weightLbs = Double(infoDataArray[2])
                updateUserInfo.weightKg = WeightUnitChange.LbsToKg(num: Double(infoDataArray[2])!)
            }
        }
        updateUserInfo.height = (infoDataArray[3] == "") ? nil:Double(infoDataArray[3])
        updateUserInfo.birthday = (infoDataArray[4] == "") ? nil:infoDataArray[4]

        updateUserInfo.country = (infoDataArray[5] == "") ? nil:infoDataArray[5]
        updateUserInfo.phoneNumber = (infoDataArray[6] == "") ? nil:infoDataArray[6]
        
        let dictString = ["userId":UserInfo.getUserId(),"user":updateUserInfo.toJSONString()!,"token":UserInfo.getToken()] as [String : Any]
        Alamofire.request(UPDATE_USERINFO,method: .post,parameters: dictString).responseString{ (response) in
            if response.result.isSuccess {
                if let jsonString = response.result.value {
                    print("进入验证过程")
                    print(jsonString)
                    // json转model
                    // 写法一：responseModel.deserialize(from: jsonString)
                    // 写法二：用JSONDeserializer<T>
                    /*
                     利用JSONDeserializer封装成一个对象。然后再解析这个对象，此处返回的不同，需要封装成responseAModel的响应体
                     //                         */
                    if let responseModel = JSONDeserializer<USERINFO_UPDATE_RESPONSE>.deserializeFrom(json: jsonString) {
                        /// model转json 为了方便在控制台查看
                        print("瞧瞧输出的是什么",responseModel.toJSONString(prettyPrint: true)!)
                        /*  此处为跳转和控制逻辑
                         */
                        if(responseModel.code! == 1 ){
                            print(responseModel.code!)
                            print("更新成功")
                            //print("responseModel.data：\(responseModel.data!)")
                            self.navigationController?.popViewController(animated: true)
                            // 向数据库插入数据
                            self.updateUserInfoInSqlite(updateUserInfo)
                        }else{
                            let alert = CustomAlertController()
                            alert.custom(self, "Attension", "更新用户信息失败")
                            print(responseModel.code!)
                            print("更新失败")
                            
                        }
                    } //end of letif
                }
            }else{
                let alert = CustomAlertController()
                alert.custom(self, "Attension", "更新用户信息失败")
            }
        }//end of request
    }
    
    func updateUserInfoInSqlite(_ UpdateUserInfo:USER_UPDATE){
        var info = USER_INFO()
        info.userId = UserInfo.getUserId()
        info.email = UserInfo.getEmail()
        info.userName = UpdateUserInfo.userName
        info.gender = UpdateUserInfo.gender
        info.height = UpdateUserInfo.height
        info.weightLbs = UpdateUserInfo.weightLbs
        info.weightKg = UpdateUserInfo.weightKg
        info.birthday = UpdateUserInfo.birthday
        info.phoneNumber = UpdateUserInfo.phoneNumber
        info.country = UpdateUserInfo.country
        // 将更新内容放入
        DBSQLiteManager.manager.updateUserInfo(info)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //当每一次视图将要出现的时候，都要重新reload一下体重，防止那边换了单位，这边的信息还没换
        initInfoDataArray()
        self.tableview.reloadData()
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
        cell?.imageView?.image = UIImage(named: infoIconArray[indexPath.row])
        cell?.textLabel?.text = infoArray[indexPath.row]

        //let userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
        switch indexPath.row{
        case 0:
            cell?.detailTextLabel?.text = infoDataArray[0]=="" ? "nothing":infoDataArray[0]
        case 1:
            cell?.detailTextLabel?.text = infoDataArray[1]=="" ? "nothing":infoDataArray[1]
            
           
        case 2:
            cell?.detailTextLabel?.text = (infoDataArray[2]=="" ? "nothing":(infoDataArray[2]) + GetUnit.getWeightUnit())

            
        case 3:
            cell?.detailTextLabel?.text = infoDataArray[3]=="" ? "nothing":(infoDataArray[3] + "cm")
        case 4:
            cell?.detailTextLabel?.text = infoDataArray[4]=="" ? "nothing":infoDataArray[4]
        case 5:
            cell?.detailTextLabel?.text = infoDataArray[5]=="" ? "nothing":infoDataArray[5]
        default:
            cell?.detailTextLabel?.text = infoDataArray[6]=="" ? "nothing":infoDataArray[6]
        }
        return cell!
    }
    
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
                self.updateSth = true
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
        self.updateSth = true
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
                self.updateSth = true
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
                self.updateSth = true
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
        self.updateSth = true
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
                self.updateSth = true
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
                self.updateSth = true
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
