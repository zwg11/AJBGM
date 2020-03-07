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

class InfoViewController: UIViewController ,PickerDelegate,UITextFieldDelegate{
   
    
    //请求出现转的效果，增加用户体验
    private lazy var indicator:CustomIndicatorView = {
        let view = CustomIndicatorView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: AJScreenHeight))
        view.setupUI("")
        //view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        return view
    }()
    var num:Int = 0

    //列表数据
    public lazy var infoArray: Array = ["Name","Gender","Weight","Height","Date of Birth","Country","Phone"]
    //图标数据
    public lazy var infoIconArray:Array = ["Name","Gender","Weight","Height","Date-of-Birth","Country","Phone"]
    public lazy var infoDataArray : [String] = ["","","","","","",""]

    let tableview = UITableView()
    // 判断是否有需要更新的内容，没有则不更新,返回至上一界面
    var updateSth = false
    // 初始化列表数组
    func initInfoDataArray(){
        let userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
        infoDataArray[0] = userInfo.user_name ?? ""
        print("用户名为：",infoDataArray[0])
        //0为女
        if let gender = userInfo.gender{
            infoDataArray[1] = (gender == 0) ? "Female":"Male"
        }else{
            infoDataArray[1] = "Female"
        }
        
        if GetUnit.getWeightUnit() == "kg"{
            infoDataArray[2] = (userInfo.weight_kg != nil) ? "\(userInfo.weight_kg!)":""
        }else{
            infoDataArray[2] = (userInfo.weight_lbs != nil) ? "\(userInfo.weight_lbs!)":""
        }
        infoDataArray[3] = (userInfo.height != nil) ? "\(userInfo.height!)":""
        print("-----",userInfo.birthday)
        if userInfo.birthday == nil{
            infoDataArray[4] = ""
        }else{
            infoDataArray[4] = userInfo.birthday!.components(separatedBy: "-").joined(separator: "/")
        }
        
        infoDataArray[5] = userInfo.country ?? ""
        infoDataArray[6] = userInfo.phone_number ?? ""
        
    }
    
    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton:UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(saveUserInfo), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitle("Save", for: .normal)
        button.tintColor = UIColor.white
        button.frame = CGRect(x: 0, y: 0, width: AJScreenWidth/8, height: 44)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initInfoDataArray()
        //tableview.reloadData()

        self.title = "Personal Information"
//        self.navigationController?.navigationBar.barTintColor = ThemeColor
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: NaviTitleColor]
        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
         tableview.separatorColor = TextGrayColor
        tableview.register(UITableViewCell.self, forCellReuseIdentifier:"infocell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isScrollEnabled = false
        tableview.backgroundColor = UIColor.clear
        
        //update.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .fade)
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints{(make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(AJScreenHeight/16*7)
        }
    }
    @objc private func leftButtonClick(){
        //按返回的时候，需要将数据进行更新
       self.navigationController?.popViewController(animated: false)
    }
    
    @objc func saveUserInfo(){

        if !updateSth{
            self.navigationController?.popViewController(animated: false)
            return
        }
        // 开始转
        indicator.startIndicator()
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        // 如果有需要更新的内容
        var updateUserInfo = USER_UPDATE()
        updateUserInfo.email = UserInfo.getEmail()
        //此处需要判断用户如果没有用户名的话，不让其保存
        if infoDataArray[0] == ""{
            let alertController = CustomAlertController()
            alertController.custom(self, "Attention", "Username Empty")
            self.indicator.stopIndicator()
            self.indicator.removeFromSuperview()
            return
        }
        updateUserInfo.userName = (infoDataArray[0] == "") ? nil:infoDataArray[0]
        updateUserInfo.gender = (infoDataArray[1] == "Male") ? 0:1
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
        updateUserInfo.birthday = (infoDataArray[4] == "") ? nil:infoDataArray[4].components(separatedBy: "/").joined(separator: "-")

        updateUserInfo.country = (infoDataArray[5] == "") ? nil:infoDataArray[5]
        updateUserInfo.phoneNumber = (infoDataArray[6] == "") ? nil:infoDataArray[6]
        
        let dictString = ["userId":UserInfo.getUserId(),"user":updateUserInfo.toJSONString()!,"token":UserInfo.getToken()] as [String : Any]
        Alamofire.request(UPDATE_USERINFO,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
            if response.result.isSuccess {
                if let jsonString = response.result.value {
                    print(jsonString)
                    // json转model
                    // 写法一：responseModel.deserialize(from: jsonString)
                    // 写法二：用JSONDeserializer<T>
                    /*
                     利用JSONDeserializer封装成一个对象。然后再解析这个对象，此处返回的不同，需要封装成responseAModel的响应体
                     //                         */
                    if let responseModel = JSONDeserializer<USERINFO_UPDATE_RESPONSE>.deserializeFrom(json: jsonString) {
                        /// model转json 为了方便在控制台查看
                        /*  此处为跳转和控制逻辑
                         */
                        self.indicator.stopIndicator()
                        self.indicator.removeFromSuperview()
                        if(responseModel.code! == 1 ){
                            // 向数据库插入数据  更新完远端，再更新本地
                            self.updateUserInfoInSqlite(updateUserInfo)
//                            let x = UIAlertController(title: "", message: "Update Success", preferredStyle: .alert)
//                            self.present(x, animated: true, completion: {()->Void in
//                                sleep(1)
//                                x.dismiss(animated: true, completion: {
//                                    // 跳转到原来的界面
//                                    self.navigationController?.popToRootViewController(animated: false)
//                                    // 发送通知，提示插入成功
////                                    NotificationCenter.default.post(name: NSNotification.Name("InsertData"), object: self, userInfo: nil)
//                                })
//                            })
                            let alert = CustomAlertController()
                            alert.custom(self, "", "Update Success")
                           
                        }else if (responseModel.code! == 2 ){
                            let alert = CustomAlertController()
                            alert.custom(self, "Attention", "Your account is already logged in at the other end!")
                           LoginOff.loginOff(self)
                            
                        }else if responseModel.code! == 3{
                            LoginOff.loginOff(self)
                            let alert = CustomAlertController()
                            alert.custom(self,"Attention", "Your account has been disabled.Please contact oncall@acondiabetescare.com")
                        }else{
                            let alert = CustomAlertController()
                            alert.custom(self, "Attention", "Update Failure")
                            print(responseModel.code!)
                        }
                    } //end of letif
                }
            }else{
                self.indicator.stopIndicator()
                self.indicator.removeFromSuperview()
                let alert = CustomAlertController()
                alert.custom(self, "Attention", "Internet Error")
            }
        }//end of request
    }
     //更新本地数据库
    func updateUserInfoInSqlite(_ UpdateUserInfo:USER_UPDATE){
        var info = USER_INFO()
        info.userId = UserInfo.getUserId()
        info.email = UserInfo.getEmail()
        info.userName = UpdateUserInfo.userName
        info.gender = UpdateUserInfo.gender
        info.height = UpdateUserInfo.height
        info.weightLbs = UpdateUserInfo.weightLbs
        info.weightKg = UpdateUserInfo.weightKg
        print(UpdateUserInfo.birthday)
        if UpdateUserInfo.birthday == "" || UpdateUserInfo.birthday == nil{
            info.birthday = ""
        }else{
             //放入数据库中的是，--，取出来的是//
            info.birthday = UpdateUserInfo.birthday!.components(separatedBy: "/").joined(separator: "-")
        }
        
        info.phoneNumber = UpdateUserInfo.phoneNumber
        info.country = UpdateUserInfo.country
        // 将更新内容放入
        DBSQLiteManager.manager.updateUserInfo(info)
        updateSth = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.isTranslucent = true
        
        self.automaticallyAdjustsScrollViewInsets = false
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
        //根据注册的cell类ID值获取到载体cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "infocell")
        cell = UITableViewCell(style: .value1, reuseIdentifier: "infocell")
        cell?.selectionStyle = .none
        cell!.accessoryType = .disclosureIndicator
        
        cell!.backgroundColor = ThemeColor
        cell?.textLabel?.textColor = TextColor
        cell!.backgroundColor = UIColor.clear
        switch indexPath.row{
            case 0:
                //此处为username
                cell?.imageView?.image = UIImage(named: infoIconArray[0])
                cell?.detailTextLabel?.text = infoDataArray[0]=="" ? "-":infoDataArray[0]
                cell?.textLabel?.text = infoArray[indexPath.row]
            case 1:
                cell?.imageView?.image = UIImage(named: infoIconArray[1])
                cell?.detailTextLabel?.text = infoDataArray[1]=="" ? "-":infoDataArray[1]
                cell?.textLabel?.text = infoArray[indexPath.row]
            case 2:
                cell?.imageView?.image = UIImage(named: infoIconArray[2])
                cell?.detailTextLabel?.text = (infoDataArray[2]=="" ? ("-"+GetUnit.getWeightUnit()):(infoDataArray[2]) + GetUnit.getWeightUnit())
                cell?.textLabel?.text = infoArray[indexPath.row]
            case 3:
                cell?.imageView?.image = UIImage(named: infoIconArray[3])
                cell?.detailTextLabel?.text = infoDataArray[3]=="" ? "-cm":(infoDataArray[3] + "cm")
                cell?.textLabel?.text = infoArray[indexPath.row]
            case 4:
                cell?.imageView?.image = UIImage(named: infoIconArray[4])
                
                cell?.detailTextLabel?.text = infoDataArray[4]=="" ? "-":infoDataArray[4]
                cell?.textLabel?.text = infoArray[indexPath.row]
            case 5:
                cell?.imageView?.image = UIImage(named: infoIconArray[5])
                cell?.detailTextLabel?.text = infoDataArray[5]=="" ? "-":infoDataArray[5]
                cell?.textLabel?.text = infoArray[indexPath.row]
            default:
                cell?.imageView?.image = UIImage(named: infoIconArray[6])
                cell?.detailTextLabel?.text = infoDataArray[6]=="" ? "-":infoDataArray[6]
                cell?.textLabel?.text = infoArray[indexPath.row]
            }
        cell?.detailTextLabel?.textColor = UIColor.white
        
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
                let pickerView = BHJPickerView.init(self, .country)   //国家
                pickerView.pickerViewShow()
                num = 5
            case 6:
                inputPhone()   //电话
                num = 6
            default:
                inputUserName()
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AJScreenHeight/16
    }
    
    //输入用户名
    @objc func inputUserName(){
        let alertController = UIAlertController(title: "Please Enter Name",message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Done", style: .default, handler: {
            action in
            let UserName = alertController.textFields!.first!
            if String(UserName.text!).removeHeadAndTailSpacePro == ""  {
             
                
            }else if String(UserName.text!).count >= 50 {//不能让用户名大于50个字符
            
            }else{
                self.infoDataArray[0] = UserName.text!.removeHeadAndTailSpacePro
                self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
                self.updateSth = true
            }
           
        })
//        okAction.setValue(UIColor.black, forKey: "_titleTextColor")
//        cancelAction.setValue(UIColor.black, forKey: "_titleTextColor")
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
        let alertController = UIAlertController(title: "Please Enter Weight",message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.keyboardType = .decimalPad
            textField.delegate = self
            textField.tag = 1
//            textField.placeholder = "体重"
           
 
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Done", style: .default, handler: {
            action in
            let UserWeight = alertController.textFields!.first!.text!
//            let DuserWeight = Double(UserWeight)
            print(UserWeight)
            if String(UserWeight) == ""  {
//            }else if DuserWeight > 453.0{
                
            }else if Double(UserWeight)! > 453{
                
            }else{
                self.infoDataArray[2] = UserWeight
                self.updateSth = true
                self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
            }
            
        })
//        okAction.setValue(UIColor.black, forKey: "_titleTextColor")
//        cancelAction.setValue(UIColor.black, forKey: "_titleTextColor")
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //改身高
    func inputHeight(){
        let alertController = UIAlertController(title: "Please Enter Height",message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.keyboardType = .decimalPad
            textField.delegate = self
            textField.tag = 0
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Done", style: .default, handler: {
            action in
            let UserName = alertController.textFields!.first!
            if String(UserName.text!) == ""  {
            }else{
                self.infoDataArray[3] = UserName.text!
                self.updateSth = true
                self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
                // print("用户名：\(String(describing: UserName.text)) ")
            }
            
        })
//        okAction.setValue(UIColor.black, forKey: "_titleTextColor")
//        cancelAction.setValue(UIColor.black, forKey: "_titleTextColor")
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //改生日
    func selectedDate(_ pickerView: BHJPickerView, _ dateStr: Date) {
        let messge = Date().dateStringWithDate(dateStr)
        self.infoDataArray[4] = messge
        self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
        print(messge)
        self.updateSth = true
    }
    
    //改国家
    func selectedCountry(_ pickerView: BHJPickerView, _ countryStr: String) {
        let message = countryStr
        self.infoDataArray[5] = message
        self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
        print(message)
        self.updateSth = true
    }
    
    //改电话
    func inputPhone(){
        let alertController = UIAlertController(title: "Please Enter Phone",message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.keyboardType = .numberPad
//            textField.placeholder = "电话"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Done", style: .default, handler: {
            action in
            let PhoneNum = alertController.textFields!.first!
            if String(PhoneNum.text!).removeHeadAndTailSpacePro == ""  {
            
            }else if String(PhoneNum.text!).count >= 16 {
                    
            }else{
                self.infoDataArray[6] = PhoneNum.text!.removeHeadAndTailSpacePro
                self.updateSth = true
                self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
            }
            
        })
//        okAction.setValue(UIColor.black, forKey: "_titleTextColor")
//        cancelAction.setValue(UIColor.black, forKey: "_titleTextColor")
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}


extension InfoViewController{
    // *************** 详细用法请看glucoseView中的注释 *****************
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let testString = ".0123456789"
        let char = NSCharacterSet.init(charactersIn: testString).inverted
        
        let inputString = string.components(separatedBy: char).joined(separator: "")
        
        if string == inputString{
            var numFrontDot:Int = 2
            var numAfterDot:Int = 2
            if textField.tag == 1{  //体重
                if GetUnit.getWeightUnit() == "kg"{
                    numFrontDot = 3
                    numAfterDot = 2
                }else{
                    numFrontDot = 3
                    numAfterDot = 0
                }
            }else{   //身高
                numFrontDot = 3
                numAfterDot = 2
            }

            let futureStr:NSMutableString = NSMutableString(string: textField.text!)
            futureStr.insert(string, at: range.location)
            var flag = 0
            var flag1 = 0
            var dotNum = 0
            var isFrontDot = true
            
            if futureStr.length >= 1{
                let char = Character(UnicodeScalar(futureStr.character(at:0))!)
                if char == "."{
                    return false
                }
                if futureStr.length >= 2{
                    let char2 = Character(UnicodeScalar(futureStr.character(at:1))!)
                    if char2 != "." && char == "0"{
                        return false
                    }
                }
            }
            
            if !futureStr.isEqual(to: ""){
                for i in 0..<futureStr.length{
                    let char = Character(UnicodeScalar(futureStr.character(at:i))!)
                    if char == "."{
                        isFrontDot = false
                        dotNum += 1
                        if dotNum > 1{
                            return false
                        }
                    }
                    if isFrontDot{
                        flag += 1
                        if flag > numFrontDot{
                            return false
                        }
                    }
                    else{
                        flag1 += 1
                        if flag1 > numAfterDot{
                            return false
                        }
                    }
                }
            }
            return true
            
        }else{
            return false
        }
    }
}
