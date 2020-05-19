//
//  gluViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/24.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SwiftDate
import Alamofire
import HandyJSON

class gluViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // 存储读取的数据中的血糖记录的时间
    var BLEglucoseDate:[String]=[]
    // 存取读取的数据中的血糖值
    var BLEglucoseValue:[Int]=[]
    // 存储读取的数据中的血糖标志位
    var BLEglucoseMark:[Int] = []
    // j仪器ID
    var meterID:String = ""
    // 最新记录
    var lastRecord = ""
    //  uuid list 保存每个血糖记录的 血糖记录ID
    var uuidList:[String] = []
    
    
    // 设置导航栏左按钮x样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    // 返回上一个页面
    @objc func leftButtonClick(){

        // 点击删除时弹出的警示框
        let alert = UIAlertController(title: "Back Without Save Data?", message: "", preferredStyle: .alert)
        // 该动作删除一条记录
        let sureAction = UIAlertAction(title: "Done", style: .default, handler: {(UIAlertAction)->Void in
            self.navigationController?.popViewController(animated: true)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(sureAction)
        self.present(alert, animated: true, completion: nil)
     }
    // 使得列表行数与数据数量一致
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BLEglucoseDate.count
    }
    // MARK:- 每个 cell 打印 血糖值 和 日期
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "glucose")
        if cell == nil{
            cell = UITableViewCell(style: .value1, reuseIdentifier: "id")
        }
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 20)
        // 根据血糖值在不同的范围设置不同的字颜色，以表示血糖的正常与否
        if GetUnit.getBloodUnit() == "mg/dL"{
            // 由于原数据为mg/dL,所以不需转换
            cell?.textLabel?.text = String(BLEglucoseValue[indexPath.row]) + GetUnit.getBloodUnit()
            if BLEglucoseValue[indexPath.row] > Int(GetBloodLimit.getRandomDinnerTop()){
                cell?.textLabel?.textColor = UIColor.red
            }else{
                if BLEglucoseValue[indexPath.row]<Int(GetBloodLimit.getRandomDinnerLow()){
//                    cell?.textLabel?.textColor = UIColor.yellow
                    cell?.textLabel?.textColor = UIColor.orange
                }
                else{
                    cell?.textLabel?.textColor = UIColor.green
                }
            }
        }else{
            // 需转换单位
            let result = UnitConversion.mgTomm(num: Double(BLEglucoseValue[indexPath.row]))
            cell?.textLabel?.text = String(result) + GetUnit.getBloodUnit()
            
            if result>GetBloodLimit.getRandomDinnerTop(){
                cell?.textLabel?.textColor = UIColor.red
            }else{
                if result<GetBloodLimit.getRandomDinnerLow(){
//                    cell?.textLabel?.textColor = UIColor.yellow
                    cell?.textLabel?.textColor = UIColor.orange
                }
                else{
                    cell?.textLabel?.textColor = UIColor.green
                }
            }
        }
        
        let mark = markToString(BLEglucoseMark[indexPath.row])
        cell?.selectionStyle = .none
        cell?.detailTextLabel?.text = mark + "   " + BLEglucoseDate[indexPath.row]
        cell?.detailTextLabel?.textColor = UIColor.white
        cell?.backgroundColor = UIColor.clear
        return cell!
    }
    
    private func markToString(_ mark:Int) -> String{
        switch mark {
        case 0:
            return "Random"
        case 1:
            return "After Meal"
        case 2:
            return "Before Meal"
        case 4:
            return "Random"
        default:
            return "Random"
        }

    }
    
    private func markToEventNum(_ mark:Int) -> Int64{
        switch mark {
        case 0:
            return 3
        case 1:
            return 1
        case 2,3:
            return 0
        case 4:
            return 3
        default:
            return 0
        }
    }
    
    
    var tableView = UITableView()
    // 该按钮实现App对血糖的记录
    private var button:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Record Result", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderColor = ThemeColor.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(BLEDataSave), for: .touchUpInside)
        return button
    }()
    // MARK:- 保存血糖数据动作
    @objc func BLEDataSave(){
        // 添加风火轮并使其旋转
        self.button.isEnabled = false
        self.navigationController?.view.addSubview(indicator)
        indicator.setLabelText("Inserting Data...")
        indicator.startIndicator()
        indicator.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        // 数据处理
        var datas:[glucoseDate] = []
        //print("bleglucosemark:",BLEglucoseMark)
        for i in 0...BLEglucoseValue.count-1{
            //print("第\(i)个数据")
            // MARK:- 第一步：先封装成一个对象
            var  insertData:glucoseDate = glucoseDate()
            insertData.userId = UserInfo.getUserId()
            // get uuid from uuidList and set recordId
//            let uuid = UUID().uuidString.components(separatedBy: "-").joined()
//            insertData.bloodGlucoseRecordId = uuidList[i]
            
            // 判断是否为控制液数据，不是则存储
            if BLEglucoseMark[i] != 12{
                // 数据初始化
                insertData.bloodGlucoseRecordId = uuidList[i]
                insertData.createTime = BLEglucoseDate[i]
                insertData.detectionTime =  markToEventNum(BLEglucoseMark[i])
                insertData.bloodGlucoseMmol = UnitConversion.mgTomm(num: Double(BLEglucoseValue[i]))
                insertData.bloodGlucoseMg = Double(BLEglucoseValue[i])
                insertData.eatNum = 2
                insertData.sportType = "None"
                insertData.inputType = 0
//                insertData.sportStrength = 1
                insertData.machineId = meterID
                // MARK:- 第二步：先封装进一个数组
                datas.append(insertData)
            }
            
        }
        //print("插入的数据量：",datas.count)
        // MARK:- 第三步：再将这个数组直接toString
        let GlucoseJsonData = datas.toJSONString()!
        //手动输入数据，请求部分
        let dictString = [ "token":UserInfo.getToken(),"userId":UserInfo.getUserId() as Any,"userBloodGlucoseRecords":GlucoseJsonData,"recentRecord":lastRecord] as [String : Any]
        // 向服务器申请插入数据请求
        AlamofireManagerForBLE.request(INSERT_RECORD,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
            if response.result.isSuccess {
                if let jsonString = response.result.value {
                    //print("进入验证过程")
                    //print(jsonString)
                    // json转model
                    // 写法一：responseModel.deserialize(from: jsonString)
                    // 写法二：用JSONDeserializer<T>
                    /*
                     利用JSONDeserializer封装成一个对象。然后再解析这个对象，此处返回的不同，需要封装成responseAModel的响应体
                     //                         */
                    if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                        /// model转json 为了方便在控制台查看
                        //print("瞧瞧输出的是什么",responseModel.toJSONString(prettyPrint: true)!)
                        /*  此处为跳转和控制逻辑
                         */
                        if(responseModel.code == 1 ){
                            //print(responseModel.code)
                            //print("插入成功")
                            // MARK:- 向数据库插入数据
                            DBSQLiteManager.manager.addGlucoseRecords(add: datas)
                            // MARK:- 记录此仪器传输的仪器类型和最近一次的血糖记录
                            // 向配置文件存储最新记录
                            // 读取配置文件，获取meterID的内容
                            let path = PlistSetting.getFilePath(File: "otherSettings.plist")
                            let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
                            let arr = data["meterID"] as! NSMutableDictionary
                            // 更新配置文件内容
                            arr[self.meterID] = self.lastRecord
                            data["meterID"] = arr
                            data.write(toFile: path, atomically: true)
                            //                            if self.UpdateMeterInfo(){
                            let x = UIAlertController(title: "", message: "Insert Success.", preferredStyle: .alert)
                            // 移除风火轮
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()

                            
                            // 警示框出现
                            self.present(x, animated: true, completion: {()->Void in
                                sleep(1)
                                x.dismiss(animated: true, completion: {
                                    // 跳转到原来的界面
                                    
                                    self.navigationController?.popToRootViewController(animated: false)
                                    // 发送通知，提示插入成功
                                    NotificationCenter.default.post(name: NSNotification.Name("InsertData"), object: self, userInfo: nil)
                                })
                            })
                            self.button.isEnabled = true
                                
//                            }
                        }else if (responseModel.code! == 2 ){
                            let x = UIAlertController(title: "", message: "Your account was logged in on another device,it will log out there!", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Done", style: .default, handler: {
                                action in
                                LoginOff.loginOff(self)
                            })
                                    //只加入确定按钮
                            x.addAction(okAction)
                            self.present(x, animated: true, completion: nil)
                          
                            self.button.isEnabled = true
                        }else if (responseModel.code! == 3){
                            let x = UIAlertController(title: "", message: "Your account has been disabled.Please contact oncall@acondiabetescare.com", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Done", style: .default, handler: {
                                        action in
                                        LoginOff.loginOff(self)
                            })
                            //只加入确定按钮
                             x.addAction(okAction)
                             self.present(x, animated: true, completion: nil)
                        }else if(responseModel.code!==4){
                            let x = UIAlertController(title: "", message: "Your account does not exist!", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Done", style: .default, handler: {
                                        action in
                                        LoginOff.loginOff(self)
                            })
                            //只加入确定按钮
                             x.addAction(okAction)
                             self.present(x, animated: true, completion: nil)
                        }
                        else{
                            //print(responseModel.code)
                            //print("插入失败")
                            // 插入失败
                            // 移除风火轮
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()
                            // 警示框出现
                            let alert = CustomAlertController()
                            alert.custom(self, "", "Insert Failed,Please Try Again Later.")
                            self.button.isEnabled = true
                        }
                    } //end of letif
                }
            }else{
                // 移除风火轮
                self.indicator.stopIndicator()
                self.indicator.removeFromSuperview()
                // 警示框出现
                //print("插入失败")
                // 插入成功
                let alert = CustomAlertController()
                alert.custom(self, "", "Internet Error,Please Try Again Later.")
                self.button.isEnabled = true
            }
        }//end of request
//        self.button.isEnabled = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.automaticallyAdjustsScrollViewInsets = false
        //print(BLEglucoseMark)
        //print("laseRecord:\(lastRecord)")
//        let array:Array<String> = lastRecord.components(separatedBy: " ")
        // 将字符串拆成 每个字符串只包含一个字符 的 字符串数组
        //let data = array[0].components(separatedBy: "")
        //print("处理后的最后记录\(array)")
        
        // set uuid list
//        for i in 0...BLEglucoseValue.count-1{
//            //print("第\(i)个数据")
//            // MARK:- 第一步：先封装成一个对象
//            var  insertData:glucoseDate = glucoseDate()
//            insertData.userId = UserInfo.getUserId()
//            // 创建一个recordId
//            let uuid = UUID().uuidString.components(separatedBy: "-").joined()
//            uuidList.append(uuid)
//        }
    }
    
    private lazy var indicator:CustomIndicatorView = {
       let view = CustomIndicatorView()
        view.setupUI("")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        // 头部标签
        let tableHeadLabel = UILabel()
        tableHeadLabel.backgroundColor = UIColor.clear
        tableHeadLabel.textColor = UIColor.white
        tableHeadLabel.textAlignment = .left
        tableHeadLabel.text = "    BG Data"
        tableHeadLabel.font = UIFont.boldSystemFont(ofSize: 16)
//        tableHeadLabel.layer.borderColor = ThemeColor.cgColor
//        tableHeadLabel.layer.borderWidth = 1
        self.view.addSubview(tableHeadLabel)
        tableHeadLabel.snp.makeConstraints{(make) in
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(44)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                //                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
                //                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                // Fallback on earlier versions
            }
            
        }
        // 添加导航栏标题
        self.title = "Data"
        tableView.delegate = self
        tableView.dataSource = self

//        tableView.backgroundColor = ThemeColor
        tableView.backgroundColor = UIColor.clear
//        button.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY-44, width: UIScreen.main.bounds.width, height: 44)
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        self.view.addSubview(button)
        button.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(tableHeadLabel.snp.bottom)
            make.bottom.equalTo(button.snp.top)
//            if #available(iOS 11.0, *) {
//                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//            } else {
//                // Fallback on earlier versions
//                make.top.equalTo(topLayoutGuide.snp.bottom)
//            }
        }
        
        // 页面刚出现时弹出，让用户直接确认是否保存数据
        let alert_save = UIAlertController(title: "", message: "Save Results?", preferredStyle: .alert)
        // 保存数据动作
        let save_action = UIAlertAction(title: "Save", style: .default) { (UIAlertAction) in
            self.BLEDataSave()
//            self.navigationController?.popViewController(animated: true)
        }
        // 取消数据动作
        let cancel_action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert_save.addAction(save_action)
        alert_save.addAction(cancel_action)
        self.present(alert_save, animated: true, completion: nil)
        
        
    }
    
}


extension gluViewController{
    // MARK:- 更新用户血糖仪使用信息
    func UpdateMeterInfo()->Bool{
        //手动输入数据，请求部分
        var isSuccess = true
        //print("当前血糖仪为\(meterID),其最后插入的记录为\(lastRecord)")
        let dictString = [ "userId":UserInfo.getUserId() as Any,"token":UserInfo.getToken(),"meterId":meterID,"recentRecord":lastRecord] as [String : Any]
                // 向服务器申请插入数据请求
                Alamofire.request(METERID_SAVE,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
                    if response.result.isSuccess {
                        if let jsonString = response.result.value {
                            //print("进入验证过程")
                            //print(jsonString)
                            // json转model
                            // 写法一：responseModel.deserialize(from: jsonString)
                            // 写法二：用JSONDeserializer<T>
                            /*
                             利用JSONDeserializer封装成一个对象。然后再解析这个对象，此处返回的不同，需要封装成responseAModel的响应体
                             //                         */
                            if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                                /// model转json 为了方便在控制台查看
                                //print("瞧瞧输出的是什么",responseModel.toJSONString(prettyPrint: true)!)
                                /*  此处为跳转和控制逻辑
                                 */
                                if(responseModel.code == 1 ){
                                    

                                    // 向配置文件存储最新记录
                                    // 读取配置文件，获取meterID的内容
//                                    UserInfo.setMeterID(self.meterID, self.lastRecord)
                                    let path = PlistSetting.getFilePath(File: "otherSettings.plist")
                                    let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
                                    let arr = data["meterID"] as! NSMutableDictionary
                                    // 更新配置文件内容
                                    arr[self.meterID] = self.lastRecord
                                    data["meterID"] = arr
                                    data.write(toFile: path, atomically: true)
                                    //print(data)
                                    //print("meterID更新成功")
                                    isSuccess = true
                                    
                                }else if (responseModel.code! == 2 ){
                                    LoginOff.loginOff(self)
                                    
                                    let alert = CustomAlertController()
                                    alert.custom(self, "", "Your account was logged in on another device,it will log out there!")
                                }else if (responseModel.code! == 3){
                                    LoginOff.loginOff(self)
                                    let alert = CustomAlertController()
                                    alert.custom(self,"Attention", "Your account has been disabled.Please contact oncall@acondiabetescare.com")
                                }else if(responseModel.code!==4){
                                    LoginOff.loginOff(self)
                                    let alert = CustomAlertController()
                                    alert.custom(self,"Attention", "Your account does not exist")
                                }else{
                                    //print(responseModel.code)
                                    print("meterID插更新失败")
//                                    return false
                                }
                            } //end of letif
                            else{
                                isSuccess = false
                            }
                        }else{
                            isSuccess = false
                        }
                    }// 请求失败
                    else{
                        isSuccess = false
                    }
                }//end of request
        return isSuccess
    }
}
