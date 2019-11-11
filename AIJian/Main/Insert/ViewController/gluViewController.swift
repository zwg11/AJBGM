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
    
    
    // 设置导航栏左按钮x样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    // 返回上一个页面
    @objc func leftButtonClick(){

        // 点击删除时弹出的警示框
        let alert = UIAlertController(title: "Back Without Save Data?", message: "", preferredStyle: .alert)
        // 该动作删除一条记录
        let sureAction = UIAlertAction(title: "Sure", style: .default, handler: {(UIAlertAction)->Void in
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
    // 每个 cell 打印 血糖值 和 日期
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "glucose")
        if cell == nil{
            cell = UITableViewCell(style: .value1, reuseIdentifier: "id")
        }
        
        cell?.textLabel?.text = String(BLEglucoseValue[indexPath.row]) + "mg/dL"
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 20)
        // 根据血糖值在不同的范围设置不同的字颜色，以表示血糖的正常与否
        if GetUnit.getBloodUnit() == "mg/dL"{
            if BLEglucoseValue[indexPath.row] > Int(GetBloodLimit.getRandomDinnerTop()){
                cell?.textLabel?.textColor = UIColor.red
            }else{
                if BLEglucoseValue[indexPath.row]<Int(GetBloodLimit.getRandomDinnerLow()){
                    cell?.textLabel?.textColor = UIColor.orange
                }
                else{
                    cell?.textLabel?.textColor = UIColor.green
                }
            }
        }else{
            if UnitConversion.mgTomm(num: Double(BLEglucoseValue[indexPath.row]))>GetBloodLimit.getRandomDinnerTop(){
                cell?.textLabel?.textColor = UIColor.red
            }else{
                if UnitConversion.mgTomm(num: Double(BLEglucoseValue[indexPath.row]))<GetBloodLimit.getRandomDinnerLow(){
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
//        cell?.backgroundColor = ThemeColor
        cell?.backgroundColor = UIColor.clear
        return cell!
    }
    // 设置表格头部背景颜色
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = SendButtonColor
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Blood Glucose Record"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    private func markToString(_ mark:Int) -> String{
        switch mark {
        case 0:
            return "random"
        case 1:
            return "After Meal"
        case 2:
            return "Before Meal"
        case 4:
            return "random"
        default:
            return "Test"
        }

    }
    
    private func markToEventNum(_ mark:Int) -> Int64{
        switch mark {
        case 0:
            return 3
        case 1:
            return 1
        case 2:
            return 0
        case 4:
            return 3
        default:
            return 12
        }
    }
    
    
    var tableView = UITableView()
    // 该按钮实现App对血糖的记录
    private var button:UIButton = {
        let button = UIButton(type: .system)
//        button.tintColor = UIColor.white
//        button.backgroundColor = UIColor.blue
        button.setTitle("Record Result", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
        button.setSelected()
        button.addTarget(self, action: #selector(BLEDataSave), for: .touchUpInside)
        return button
    }()
    // 保存血糖数据动作
    @objc func BLEDataSave(){
        
        var datas:[glucoseDate] = []
        for i in 0...BLEglucoseValue.count-1{
            print("第\(i)个数据")
            //第一步：先封装成一个对象
            var  insertData:glucoseDate = glucoseDate()
            insertData.userId = UserInfo.getUserId()
            // 创建一个recordId
            let uuid = UUID().uuidString.components(separatedBy: "-").joined()
            insertData.bloodGlucoseRecordId = uuid
            // 判断是否为控制液数据，不是则存储
            if BLEglucoseMark[i] != 12{
                // 数据初始化
                insertData.createTime = BLEglucoseDate[i]
                insertData.detectionTime =  markToEventNum(BLEglucoseMark[i])
                insertData.bloodGlucoseMmol = UnitConversion.mgTomm(num: Double(BLEglucoseValue[i]))
                insertData.bloodGlucoseMg = Double(BLEglucoseValue[i])
                insertData.eatNum = 2
                insertData.sportType = "Nothing"
                insertData.inputType = 0
                //第二步：先封装进一个数组
                datas.append(insertData)
            }
            
        }
        
        //第三步：再将这个数组直接toString
        let GlucoseJsonData = datas.toJSONString()!
        //手动输入数据，请求部分
        let dictString = [ "token":UserInfo.getToken(),"userId":UserInfo.getUserId() as Any,"userBloodGlucoseRecords":GlucoseJsonData] as [String : Any]
        // 向服务器申请插入数据请求
        AlamofireManager.request(INSERT_RECORD,method: .post,parameters: dictString).responseString{ (response) in
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
                    if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                        /// model转json 为了方便在控制台查看
                        print("瞧瞧输出的是什么",responseModel.toJSONString(prettyPrint: true)!)
                        /*  此处为跳转和控制逻辑
                         */
                        if(responseModel.code == 1 ){
                            print(responseModel.code)
                            print("插入成功")
                            // 向数据库插入数据
                            DBSQLiteManager.manager.addGlucoseRecords(add: datas)
                            if self.UpdateMeterInfo(){
                                let x = UIAlertController(title: "", message: "Insert Success.", preferredStyle: .alert)
                                self.present(x, animated: true, completion: {()->Void in
                                    sleep(1)
                                    x.dismiss(animated: true, completion: {
                                        // 跳转到原来的界面
                                        
                                        self.navigationController?.popToRootViewController(animated: false)
                                        // 发送通知，提示插入成功
                                        NotificationCenter.default.post(name: NSNotification.Name("InsertData"), object: self, userInfo: nil)
                                    })
                                })

                                
                            }else{
                                print(responseModel.code)
                                print("插入失败")
                                // 插入成功
                                let alert = CustomAlertController()
                                alert.custom(self, "", "Insert Failed,Please Try Again Later.")
                            }
                        }else{
                            print(responseModel.code)
                            print("插入失败")
                            // 插入失败
                            let alert = CustomAlertController()
                            alert.custom(self, "", "Insert Failed,Please Try Again Later.")
                            
                        }
                    } //end of letif
                }
            }else{
                print("插入失败")
                // 插入成功
                let alert = CustomAlertController()
                alert.custom(self, "", "Insert Failed,Please Try Again Later.")
            }
        }//end of request
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.automaticallyAdjustsScrollViewInsets = false
        print(BLEglucoseMark)
        print("laseRecord:\(lastRecord)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-200)
//        tableView.backgroundColor = ThemeColor
        tableView.backgroundColor = UIColor.clear
        button.frame = CGRect(x: 0, y: UIScreen.main.bounds.maxY-44, width: UIScreen.main.bounds.width, height: 44)
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        self.view.addSubview(button)
        tableView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
//            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-44)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
        }
        button.snp.makeConstraints{(make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
    }
    
}


extension gluViewController{
    // 更新用户血糖仪使用信息
    func UpdateMeterInfo()->Bool{
        //手动输入数据，请求部分
        var isSuccess = true
        print("当前血糖仪为\(meterID),其最后插入的记录为\(lastRecord)")
        let dictString = [ "userId":UserInfo.getUserId() as Any,"token":UserInfo.getToken(),"meterId":meterID,"recentRecord":lastRecord] as [String : Any]
                // 向服务器申请插入数据请求
                Alamofire.request(METERID_SAVE,method: .post,parameters: dictString).responseString{ (response) in
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
                            if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                                /// model转json 为了方便在控制台查看
                                print("瞧瞧输出的是什么",responseModel.toJSONString(prettyPrint: true)!)
                                /*  此处为跳转和控制逻辑
                                 */
                                if(responseModel.code == 1 ){
                                    

                                    // 向配置文件存储最新记录
                                    // 读取配置文件，获取meterID的内容
//                                    UserInfo.setMeterID(self.meterID, self.lastRecord)
                                    let path = PlistSetting.getFilePath(File: "User.plist")
                                    let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
                                    let arr = data["meterID"] as! NSMutableDictionary
                                    // 更新配置文件内容
                                    arr[self.meterID] = self.lastRecord
                                    data["meterID"] = arr
                                    data.write(toFile: path, atomically: true)
                                    print(data)
                                    print("meterID更新成功")
                                    isSuccess = true
                                }else{
                                    print(responseModel.code)
                                    print("meterID插更新失败")
                                    isSuccess = false
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
//                    return isSuccess
                }//end of request
        return isSuccess
    }
}
