//
//  InsertViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//  用户手动输入界面

import UIKit
import Alamofire
import HandyJSON

class InsertViewController: UIViewController {

    lazy var input:InputView = {
        let view = InputView()
        view.setupUI()
        // 由于药物栏的按钮需弹出 UIAlertController，所以要将动作在viewcontroller层中设置
        view.bodyInfo.medicineChooseButton.addTarget(self, action: #selector(chooseMedicine), for: .touchUpInside)
         //编辑药物的方法
        view.bodyInfo.medicineEditButton.addTarget(self, action: #selector(edit(sender:)), for: .touchUpInside)

//        view.leftButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)    //点击取消
//        view.rightButton.addTarget(self, action: #selector(save), for: .touchUpInside) //点击保存
        return view
    }()
    private lazy var sdView = sliderView.init(frame: CGRect(x: 0, y: 0, width: AJScreenWidth*0.9, height: 2))
    // 该页面是编辑还是输入
    var isInsert: Bool = true
    
    // 选择药物按钮弹出的alert
    private var medicineChooseAlert:alertViewController = {
        // 读取配置文件
        //        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        

        let VC = alertViewController(title: "Please Select", message: "", preferredStyle: .alert)

        //        medicineChooseAlert.alertData = data["medicine"] as! [String]
        //        viewController.setupUI()
        
        // 避免懒加载导致数据未初始化就被使用
        VC.setupUI()
        return VC
    }()
    
//{
//        var viewController = alertViewController()
//
//        return viewController
//    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 设置当选中的表格个数改变时，使得对应的按钮显示已选择的表格数
        //药物数已被设置为可观察
        if medicineChooseAlert.selectedNum>0{
            input.bodyInfo.medicineChooseButton.setTitle("\(medicineChooseAlert.selectedNum) Item selected", for: .normal)
        }else{
            input.bodyInfo.medicineChooseButton.setTitle("Nothing", for: .normal)
        }

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
    
    // 设置导航栏右按钮样式
    private lazy var rightButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setTitle("Save", for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    
    // 获取配置文件路径
    //private let path = Bundle.main.path(forResource: "inputChoose", ofType: "plist")
    private let path = PlistSetting.getFilePath(File: "inputChoose.plist")
   // let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path!)!
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ThemeColor
        self.title = "Add Data"
        

        
        // 添加监听器监听选中的表格的个数
        medicineChooseAlert.addObserver(self, forKeyPath: "selectedNum", options: [.new], context: nil)
        
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        // 添加导航栏右按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        // 实现点击屏幕键盘收回
        hideKeyboardWhenTappedAround()
        // 设置监听器，监听是否需要编辑胰岛素条目
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue: "chooseInsulin"), object: nil)
        // 设置监听器，监听是否要重新加载胰岛素选择器条目
        NotificationCenter.default.addObserver(self, selector: #selector(reloadPicker), name: NSNotification.Name(rawValue: "reload"), object: nil)

    }
    
    @objc func test(){
        self.navigationController?.pushViewController(InsulinViewController(), animated: true)
    }
    
    @objc func reloadPicker(){
        input.picker.insulinPicker.reloadComponent(0)
    }

    
    // ************** 药物选择栏按钮动作 **************
    // 选择 药物 按钮被点击时的动作
    @objc func chooseMedicine(){
        print("choose medicine button clicked,appear done.")
        // 读取配置文件
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        let arr = data["medicine"] as! NSArray
        // 由于 药物 一定是有可选项的，所以不需判断是否有可选项
        // 若需更新，重新加载数据和表格
    
//        medicineChooseAlert.alertData = data["medicine"] as! [String]
        // 设置框的高度，根据单元格数量和表格上下约束计算得出
        medicineChooseAlert.view.snp.updateConstraints{(make) in
            make.height.equalTo(arr.count*35+90)
        }
        // 更新单元格
        medicineChooseAlert.tabelView.reloadData()
        // 显示 警示框
        self.present(medicineChooseAlert, animated: true, completion: nil)
   
    }
    
    
    // 选择 药物 编辑 按钮被点击时的动作
    // ********* 药物 编辑 按钮 *********
    @objc func edit(sender:UIButton?){
        
        let alert = UIAlertController(title: "Add Medication", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = ""
            textField.keyboardType = .default
        })
        // 添加取消按钮
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // 添加保存按钮，将文本框中数据保存到沙盒中
        let actionSure = UIAlertAction(title: "Sure", style: .destructive, handler: {(UIAlertAction)-> Void in
            // 读取配置文件
            let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: self.path)!
            var arr = data["medicine"] as! [String]
            // 文本框为空，不做任何事
            if alert.textFields![0].text == "" {
                return
            }else{
                arr.append(alert.textFields![0].text!)
            }

//            // 使得警示框的表格数据更新
//            self.medicineChooseAlert.alertData.append(alert.textFields![0].text!)
            
            // 改变对应的选择器的内容和沙盒中对应队列的内容
            data["medicine"] = arr
            print(self.path)
            // 将改变后的结果写入沙盒
            data.write(toFile: self.path, atomically: true)
            print(data["medicine"] ?? "no medicine")
//            print(self.medicineChooseAlert.alertData)
//             将新添加的事件 添加到 表格状态数组中并值为 true
            self.medicineChooseAlert.boolarr.append(true)
            self.medicineChooseAlert.boolArray.append(true)
            self.medicineChooseAlert.selectedNum += 1
   
        })
        // 添加2个按钮到 警示框中
        alert.addAction(actionCancel)
        alert.addAction(actionSure)
        self.present(alert, animated: true, completion: nil)
    }
    // *************** 备注/药物 按钮动作结束 ****************
    
    func hideKeyboardWhenTappedAround(){
        // 添加手势，使得点击视图键盘收回
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    // 设置手势动作
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
        
    }
    
    @objc func leftButtonClick(){
        // 设置返回原页面
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancel(){
        print("点击了取消")
        self.navigationController?.popViewController(animated: true)
    }
    
    // 血糖记录ID，用于更新数据
    var recordId:String?
    
    //MARK: - 点击保存
    @objc func save(){
        // 风火轮启动
        let indicator = CustomIndicatorView()
        indicator.setupUI("")
        self.view.addSubview(indicator)
        indicator.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        indicator.startIndicator()
        
        let alert = CustomAlertController()
        // 记录需要警告的内容
        var Message:String = ""
        let date = input.getDate()
        let time = input.getTime()
        print("获得日期:",date)
        print("获得时间:",time)
        // ********* 记录时间 *********
        let createTime = date + " " + time
        print("存入到数据库的时间",createTime)
        
        // ********* 记录血糖 *********
        var bloodGlucoseValueMmol:Double?
        var bloodGlucoseValueMg:Double?
//        如果血糖的单位为mg/dl,则范围为10到600
//        如果血糖的单位为mmol/l,则范围为0.6到33.3
        if GetUnit.getBloodUnit() == "mg/dL"{
            print("此时进入了mg/dl这个血糖单位")
            if input.glucose.XTTextfield.text! != ""{   //先判断空
                if Double(input.glucose.XTTextfield.text!)! >= 10 && Double(input.glucose.XTTextfield.text!)! <= 600{
                    bloodGlucoseValueMg = Double(input.glucose.XTTextfield.text!)!
                    bloodGlucoseValueMmol = UnitConversion.mgTomm(num: bloodGlucoseValueMg!)
                    print("血糖mg值",bloodGlucoseValueMg as Any)
                    print("血糖mmol值",bloodGlucoseValueMmol as Any)
                }else{
                    Message += "\nGlucose Range:10~600"
//                    alert.custom(self, "Attention", "血糖的范围为10~600")
                }
            }
            else{
                Message += "\nEmpty Glucose Data"
//                alert.custom(self, "Attention", "血糖不能为空")
//                return
            }
        }else{ //mmol/L 单位
            print("此时进入了mmol/l这个血糖单位")
            if input.glucose.XTTextfield.text! != ""{   //先判断空
                if Double(input.glucose.XTTextfield.text!)! >= 0.6 && Double(input.glucose.XTTextfield.text!)! <= 33.3{
                    bloodGlucoseValueMmol = Double(input.glucose.XTTextfield.text!)!
                    bloodGlucoseValueMg = UnitConversion.mmTomgDouble(num: bloodGlucoseValueMmol!)
                    print("血糖mg值",bloodGlucoseValueMg as Any)
                    print("血糖mmol值",bloodGlucoseValueMmol as Any)
                }else{
                    Message += "\nGlucose Range:0.6~33.3"
//                    alert.custom(self, "Attention", "血糖的范围为0.6~33.3")
                }
            
            }else{
                Message += "\nEmpty Glucose Data"
//                alert.custom(self, "Attention", "血糖不能为空")
//                return
            }
        }
        
        // **************** 检测时间段，非空 **************
        let event = input.getEventValue()
        print("胰岛素的事件调试成功*********************")
        // **************** 进餐量，非空 *****************
        let eat_num = input.getPorValue()
        print("胰岛素的进餐量调试成功*********************")
        // **************** 胰岛素类型，非空 ******************
        let insulin_type = input.getInsValue()
        print("获得胰岛素类型",insulin_type)
        print("胰岛素的类型调试成功*********************")
        // ****************** 胰岛素使用量 ******************
        let insulin_num:Double? = input.getInsNumValue()
        if insulin_num != nil{
            if insulin_type == "Nothing"{
                Message += "\nEmpty Insulin Type"
            }else if insulin_num! > 100.0{
                Message += "\nInsulin Range:100"
            }
        }
        print("胰岛素的量",insulin_num ?? "no")
        print("胰岛素的量调试成功*********************")
       
        // ******************** 体重 ********************
        var weight_kg:Double?
        var weight_lbs:Double?
        if GetUnit.getWeightUnit() == "Kg"{
            // 体重不为空
            weight_kg = input.getWeightValue()
            if weight_kg != nil{
                if weight_kg! >= 454.0{
                    Message += "\nWeight Range:0~454"
                }else{
                    weight_lbs = WeightUnitChange.KgToLbs(num: weight_kg!)
                }
            }
        }else{
            weight_lbs = input.getWeightValue()
            // 体重不为空
            if weight_lbs != nil{
                weight_kg = WeightUnitChange.KgToLbs(num: weight_lbs!)
            }
        }
        
        print("体重调试成功")
        
        
//        //获取身高
//        var height:Double?
//        if input.bodyInfo.heightTextfield.text! != ""{
//            if FormatMethodUtil.validateHeightNum(number: input.bodyInfo.heightTextfield.text!) == true{
//                if Double(input.bodyInfo.heightTextfield.text!)! >= 999.9{
//                    alert.custom(self, "Attention", "身高有效范围为0.0~999.9")
//                    return
//                }else{
//                    height = Double(input.bodyInfo.heightTextfield.text!)!
//                }
//            }else{
//                alert.custom(self, "Attention", "请正确输入身高值")
//                return
//            }
//        }
//        print("获得身高的值:",height ?? 0)
//        print("身高的值调试成功*********************")
        
      
        // ***************** 血压 *******************
        print("获得收缩压:",type(of:input.getSysValue()))
        print("获的舒张压:",type(of:input.getDiaValue()))
        var sys_press_mmHg:Double?
        var sys_press_kPa:Double?
        var dis_press_mmHg:Double?
        var dis_press_kPa:Double?
        // 单位为 mmHg
        if GetUnit.getPressureUnit() == "mmHg"{
            sys_press_mmHg = input.getSysValue()
            dis_press_mmHg = input.getDiaValue()
            // 如果不都为空
            if sys_press_mmHg != nil || dis_press_mmHg != nil{
                // 如果都不为空
                if sys_press_mmHg != nil && dis_press_mmHg != nil{
                    if sys_press_mmHg! < 45 || sys_press_mmHg! > 300
                        || dis_press_mmHg! < 45 || dis_press_mmHg! > 300{
                        Message += "\nBlood Pressure Range is:45~300"
                    }else if dis_press_mmHg! >= sys_press_mmHg!{  //收缩压必须大于舒张压
                        Message += "\nDBP Should be Greater than SBP "
                    }else{
                        sys_press_kPa = PressureUnitChange.mmHgTokPa(num: sys_press_mmHg!)
                        dis_press_kPa = PressureUnitChange.mmHgTokPa(num: dis_press_mmHg!)
                    }
                }else{
                    Message += "\nDBP or SBP Empty"
                }
            }
            
        }// 单位为 kPa
        else{
            sys_press_kPa = input.getSysValue()
            dis_press_kPa = input.getDiaValue()
            if sys_press_kPa != nil || dis_press_kPa != nil{
                if sys_press_kPa != nil && dis_press_kPa != nil{
                    if sys_press_kPa! < 6 || sys_press_kPa! > 40
                        || dis_press_kPa! < 6 || dis_press_kPa! > 40{
                        Message += "\nBlood Pressure range:6-40"
                    }else if dis_press_kPa! > sys_press_kPa!{
                        Message += "\nDBP Should be Greater than SBP"
                    }else{
                        sys_press_mmHg = PressureUnitChange.kPaTommHg(num: sys_press_kPa!)
                        dis_press_mmHg = PressureUnitChange.kPaTommHg(num: dis_press_kPa!)
                    }
                }else{
                    Message += "\nDBP or SBP Empty"
                }
            }
        }
        
        // ************** 药物 ***************
        let medicine = getMedicineArray()
        var medicine_string:String = ""
        // 如果有药物
        if medicine.count > 0{
            // 窑炉数为1
            if medicine.count == 1{
                medicine_string = medicine[0]
            }// 药物数大于1
            else{
                
                for i in 0..<medicine.count-1{
                    medicine_string += medicine[i] + ","
                }
                medicine_string += medicine.last!
            }
        }
        
//        if medicine != []{
////            print("药物",medicine)
//            var j:Int = 1
//            for i in medicine{
//                if j == 1 {
//                    medicine_string = i
//                }else if j <= medicine.count - 1{
//                    medicine_string = medicine_string + "," + i
//                }else{
//                    medicine_string = medicine_string  + i
//                }
//                j = j + 1
//            }
//        }
        print(medicine_string)
        
        
        // **************** 运动类型 **************
        let sport = input.getSportType()
        print("获得运动类型:",sport)
        // **************** 运动时间 **************
        let sport_time:Int64? = input.getSportTime()

        // y*************** 运动强度 ****************
        var sport_strength:Int64? = input.getSportStrength()
        
        // 有运动时间无运动类型报错
        // 运动时间不在正常范围报错
        if sport == "Nothing"{
            sport_strength = nil
            if sport_time != nil{
                Message += "\nSelect Exercise Based on Time and Strength"
                
            }
        }else if let time = sport_time{
            if time < 5 && time > 360{
                print(time)
                Message += "\n Effective Duration of Exercise:5~360"
            }
        }
        
        print("获得运动持续时间:",sport_time ?? "no sport time")

        // 如果警示信息不为空，说明需要警示
        if Message != ""{
            // 风火轮停止，并移除
            indicator.stopIndicator()
            indicator.removeFromSuperview()
            alert.custom(self, "Attention", Message)
            return
        }
        
        //第一步：先封装成一个对象
        var  insertData:glucoseDate = glucoseDate()
        insertData.userId = UserInfo.getUserId()
        // 如果为添加数据，创建一个recordId
        if isInsert{
            let uuid = UUID().uuidString.components(separatedBy: "-").joined()
            insertData.bloodGlucoseRecordId = uuid
        }// 否则用从b上一页传过来的recordId
        else{
            insertData.bloodGlucoseRecordId = recordId!
        }
        
        insertData.createTime = createTime
        insertData.detectionTime =  Int64(event)
        insertData.bloodGlucoseMmol = bloodGlucoseValueMmol!
        insertData.bloodGlucoseMg = bloodGlucoseValueMg!
        insertData.eatNum = Int64(eat_num)
        insertData.insulinType = (insulin_type == "Nothing") ? nil:insulin_type
        insertData.insulinNum = insulin_num
        insertData.weightKg = weight_kg
        insertData.weightLbs = weight_lbs
        insertData.systolicPressureMmhg = sys_press_mmHg
        insertData.systolicPressureKpa = sys_press_kPa
        insertData.diastolicPressureMmhg = dis_press_mmHg
        insertData.diastolicPressureKpa = dis_press_kPa
        insertData.medicine = (medicine_string == "") ? nil:medicine_string
        insertData.sportType = (sport == "Nothing") ? nil:sport
        insertData.sportTime = sport_time
        insertData.sportStrength = sport_strength
        insertData.inputType = 1
        insertData.remark = input.getRemark()
     
        print("insertdata:\(insertData)")
        //第二步:再封装成一个数组
        let tempArray = [insertData]
        //第三步：再将这个数组直接toString
        let GlucoseJsonData = tempArray.toJSONString()!
        //手动输入数据，请求部分
        let dictString = [ "token":UserInfo.getToken(),"userId":UserInfo.getUserId() as Any,"userBloodGlucoseRecords":GlucoseJsonData] as [String : Any]
        print(dictString)
        // 判断是修改数据还是插入数据
        // 插入和修改的网络请求是不一样的
        if isInsert{
            // 向服务器申请插入数据请求
            Alamofire.request(INSERT_RECORD,method: .post,parameters: dictString).responseString{ (response) in
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
                                DBSQLiteManager.manager.addGlucoseRecords(add: tempArray)
                                // 风火轮启动
                                indicator.stopIndicator()
                                indicator.removeFromSuperview()
//                                alert.custom(self, "", "Insert Success.")
//                                let x = UIAlertController(title: "", message: "Insert Success.", preferredStyle: .alert)
//
//                                self.present(x, animated: true, completion: nil)
//                                sleep(2)
//                                x.dismiss(animated: true, completion: nil)
                                // 跳转到原来的界面
                                self.navigationController?.popToRootViewController(animated: false)
//                                self.tabBarController?.selectedIndex = 0
                                // 发送通知，提示插入成功
                                NotificationCenter.default.post(name: NSNotification.Name("Data Input Failure"), object: self, userInfo: nil)
                                
                            }else{
                                print(responseModel.code)
                                print("插入失败")
                                // 风火轮停止
                                indicator.stopIndicator()
                                indicator.removeFromSuperview()
                                alert.custom(self, "", "Data Update Failure.")
                                
                            }
                        } //end of letif
                    }
                }
            }//end of request
        }else{
            let dic = ["userId":UserInfo.getUserId(),"token":UserInfo.getToken(),"userBloodGlucoseRecord":insertData.toJSONString()!] as [String : Any]
            print("dic:\(dic)")
            // 向服务器申请更新数据请求
            Alamofire.request(UPDATE_RECORD,method: .post,parameters: dic as Parameters).responseString{ (response) in
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
                                print("更新成功")
                                // 向数据库更新数据
                                DBSQLiteManager.manager.updateGlucoseRecord(data: insertData)
                                // 更新所展示的数据
                                initDataSortedByDate(startDate: startD!, endDate: endD!, userId: UserInfo.getUserId())
                                sortedTimeOfData()
                                chartData()
                                // 风火轮停止
                                indicator.stopIndicator()
                                indicator.removeFromSuperview()
                                
//                                let x = UIAlertController(title: "", message: "Update Success.", preferredStyle: .alert)
//                                self.present(x, animated: true, completion: nil)
//                                sleep(2)
//                                x.dismiss(animated: true, completion: nil)
                                // 跳转到原来的界面

//                                self.presentedViewController!.present(x, animated: true, completion: nil)
                                self.navigationController?.popViewController(animated: true)
                                NotificationCenter.default.post(name: NSNotification.Name("Data Update success"), object: self, userInfo: nil)
//                                sleep(2)
//                                x.dismiss(animated: true, completion: nil)
                            }else{
                                print(responseModel.code)
                                print("更新失败")
                                // 风火轮停止
                                indicator.stopIndicator()
                                indicator.removeFromSuperview()
                                // 弹窗提示
                                let alert = CustomAlertController()

                                alert.custom(self, "Attention", "Data Update Failure")

                                
                            }
                        } //end of letif
                    }
                }
            }//end of request
        }
        

        print("点击了保存")
        
    }
    
    //视图将要出现的时候
    override func viewWillAppear(_ animated: Bool) {
        // 每次进入界面滚动视图都是在最顶部
        self.input.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        // 隐藏tabbar
        self.tabBarController?.tabBar.isHidden = true
        //重新判断加载视图
        //input.reloadInputViews()
        self.view.addSubview(input)
        input.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
        }
        //重新设置单位
       input.resetUnit()
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    //视图将要消失的时候
    override func viewWillDisappear(_ animated: Bool) {
        // tabbar不隐藏
        self.tabBarController?.tabBar.isHidden = false
        self.input.removeFromSuperview()
    }
 
    
    func getMedicineArray()->[String]{
        var arr:[String] = []
        var j:Int = 0
        let path = PlistSetting.getFilePath(File: "inputChoose.plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        let arr1 = data["medicine"] as! NSArray
        for i in medicineChooseAlert.boolarr{
            if i{
                print("药物")
                print(i)
                arr.append(arr1[j] as! String)
            }
            j = j+1
        }
        return arr
    }
    //设置药物名称,需要传入一个String数组     数据回写    xxx,xxxx,xxx    
    func setMedicineArray(_ arr:Array<String>){
        
        // 读取配置文件
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        var medicine = data["medicine"] as! [String]
        
        var arrtemp = arr
        let fromLength:Int = arr.count
        //如果配置文件中的数据元素，与传入的数据元素相等的话。则将元素对应的boolarr设置成true
        //a与b之间的交集
        if fromLength > 0{
            // 设置按钮标题
            input.bodyInfo.medicineChooseButton.setTitle("\(fromLength)Selected", for: .normal)
            
            for i in 0..<medicine.count{
                
                for j in 0..<fromLength{
                    if medicine[i] == arrtemp[j]{
                        //除了原先有的不用append之外，其他的东西三个东西都需要设置
                        medicineChooseAlert.boolarr[i] = true
                        medicineChooseAlert.boolArray[i] = true
                        medicineChooseAlert.selectedNum += 1
                        arrtemp[j] = ""
//                        arrtemp.remove(at: j)//如果相等,则将对应的数剔除
                    }
                }
            }
        }
        
        for j in 0..<fromLength{
            if(arrtemp[j] != ""){  //不为空，说明原先没有这种药，需要重新添加，重新选取
                //先加载到内存数组中
                medicine.append(arrtemp[j])
                medicineChooseAlert.boolArray.append(true)
                medicineChooseAlert.boolarr.append(true)
                medicineChooseAlert.selectedNum += 1
                
            }
        }
        
        // 写入到文件中
        data["medicine"] = medicine
        data.write(toFile: path, atomically: true)
    }
}


extension InsertViewController{
    // MARK: - 当从表格视图转来时
    // 将单元格的内容传入手动输入界面
    func EditData(date:glucoseDate){
        let x = date
//        let y = sortedTime[section][row]
        // 设置时间选择器的位置
        
        // 手动输入标志位设置
        self.isInsert = false
        // 血糖记录ID
        self.recordId = x.bloodGlucoseRecordId!
        // 时间
        self.input.setDate((x.createTime?.toDate()?.date.toFormat("yyyy-MM-dd"))!)
        self.input.setTime((x.createTime?.toDate()?.date.toFormat("HH:mm"))!)
        // 血糖量
        if let value = x.bloodGlucoseMmol{
            if GetUnit.getBloodUnit() == "mmol/L"{
                // 设置文本框文本
                self.input.setGlucoseValue("\(value)")
                // 设置滑块位置
                //                self.input.glucose.XTSlider.setValue(Float(value), animated: false)
                self.input.glucose.setValueAndThumbColor(value: Float(value))
                //                self.input.glucose.value = Float(value)
            }else{
                // 设置文本框文本
                self.input.setGlucoseValue(String(format: "%.0f", x.bloodGlucoseMg!))
                // 设置滑块位置
//                self.input.glucose.XTSlider.setValue(Float(x.bloodGlucoseMg!), animated: false)
//                self.input.glucose.tfvalueChange()
//                self.input.glucose.XTSlider.value = Float(x.bloodGlucoseMg!)
//                self.input.setSlider(Float(x.bloodGlucoseMg!))
                //                self.input.glucose.value = Float(x.bloodGlucoseMg!)
//                self.input.glucose.setValueAndThumbColor(value: Float(value))
            }
            
        }
        // 当数据未从血糖仪传来的数据，血糖文本框不可编辑
        if x.inputType == 0{

            self.input.glucose.XTTextfield.isUserInteractionEnabled = false
            self.input.glucose.XTSlider.isUserInteractionEnabled = false
        }
        
        
        // 检测时间段，非空
        self.input.setEventValue(Int(x.detectionTime!))
        // 进餐量，非空
        self.input.setPorValue(Int(x.eatNum!))
        // 胰岛素量
        if let insNum = x.insulinNum{
            self.input.setInsNumValue("\(insNum)")
        }
        
        // 胰岛素类型
        self.input.setInsValue(x.insulinType ?? "Nothing")
        
        // 体重
        if let weight = x.weightKg{
            if GetUnit.getWeightUnit() == "kg"{
                self.input.setWeightValue("\(weight)")
            }else{
                self.input.setWeightValue(String(format: "%.0f", x.weightLbs!))
            }
        }
//        else{
//            self.input.setWeightValue("")
//        }
        
        //        // 身高
        //        if let height = x.height{
        //            self.input.setHeightValue("\(height)")
        //        }
        
        // 血压
        if let sysValue = x.systolicPressureKpa{
            if GetUnit.getPressureUnit() == "mmHg"{
                self.input.setSysValue(String(format: "%.0f", x.systolicPressureMmhg!))
                self.input.setDiaValue(String(format: "%.0f", x.diastolicPressureMmhg!))
            }else{
                self.input.setSysValue("\(sysValue)")
                self.input.setDiaValue("\(x.diastolicPressureKpa!)")
            }
        }else{
            self.input.setSysValue("")
            self.input.setDiaValue("")
        }
        //******************************** 有bug，未设置被选中的项
        // 药物
        if let medicine = x.medicine{
            let medicineArr = medicine.components(separatedBy: ",")
            self.setMedicineArray(medicineArr as Array)
        }
        
        // 运动
        self.input.setSportType(x.sportType ?? "Nothing")
        
        // 运动时间
        if let sportTime = x.sportTime{
            self.input.setSportTime("\(sportTime)")
        }else{
            self.input.setSportTime("")
        }
        // 运动强度
        self.input.setSportStrength(x.sportStrength ?? 1)
        // 备注
        self.input.setRemark(text: x.remark ?? "")
        
    }
    
//    override var shouldAutorotate: Bool {
//        return false
//    }
//    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
//    
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .portrait
//    }

}


