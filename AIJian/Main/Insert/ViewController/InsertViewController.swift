//
//  InsertViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//  用户手动输入界面

import UIKit

class InsertViewController: UIViewController {

    private lazy var input:InputView = {
        let view = InputView()
        view.setupUI()
        // 由于药物栏的按钮需弹出 UIAlertController，所以要将动作在viewcontroller层中设置
        view.bodyInfo.medicineChooseButton.addTarget(self, action: #selector(chooseMedicine), for: .touchUpInside)
         //编辑药物的方法
        view.bodyInfo.medicineEditButton.addTarget(self, action: #selector(edit(sender:)), for: .touchUpInside)
        // 设置标记，识别按钮  用来的标识不同的button。默认button的初始化的tag的值为0
        view.bodyInfo.medicineEditButton.tag = 8
        
        // 由于备注栏的按钮需弹出 UIAlertController，所以要将动作在viewcontroller层中设置
        view.remark.remarkChooseButton.addTarget(self, action: #selector(chooseRemark), for: .touchUpInside)
        //编辑备注的方法
        view.remark.remarkEditButton.addTarget(self, action: #selector(edit(sender:)), for: .touchUpInside)
        // 设置标记，识别按钮
        view.remark.remarkEditButton.tag = 6
        view.leftButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)    //点击取消
        view.rightButton.addTarget(self, action: #selector(save), for: .touchUpInside) //点击保存
        return view
    }()
    
    // 选择药物按钮弹出的alert
    private var medicineChooseAlert = alertViewController()
    
    // 选择备注按钮弹出的alert
    private var remarkChooseAlert = alertViewController()

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 设置当选中的表格个数改变时，使得对应的按钮显示已选择的表格数
        //药物数
        if medicineChooseAlert.selectedNum>0{
            input.bodyInfo.medicineChooseButton.setTitle("\(medicineChooseAlert.selectedNum)个选项已选择", for: .normal)
        }else{
            input.bodyInfo.medicineChooseButton.setTitle("无", for: .normal)
        }
        //选择备注
        if remarkChooseAlert.selectedNum>0{
            input.remark.remarkChooseButton.setTitle("\(remarkChooseAlert.selectedNum)个选项已选择", for: .normal)
        }else{
            input.remark.remarkChooseButton.setTitle("无", for: .normal)
        }
    }
    
    private var isMedicineUpdate = true
    private var isRemarkUpdate = true
    
    // 设置导航栏左按钮x样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medicineChooseAlert = alertViewController(title: "请选择", message: "", preferredStyle: .alert)
        medicineChooseAlert.alertData = data["medicine"] as! [String]
        medicineChooseAlert.setupUI()
        // 添加监听器监听选中的表格的个数
        medicineChooseAlert.addObserver(self, forKeyPath: "selectedNum", options: [.new], context: nil)
        
        //******************
        remarkChooseAlert = alertViewController(title: "请选择", message: "", preferredStyle: .alert)
        remarkChooseAlert.alertData = data["remark"] as! [String]
        remarkChooseAlert.setupUI()
        // 添加监听器监听选中的表格的个数
        remarkChooseAlert.addObserver(self, forKeyPath: "selectedNum", options: [.new], context: nil)
        
        
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        // 实现点击屏幕键盘收回
        hideKeyboardWhenTappedAround()
    }

    
    // ************** 药物选择栏按钮动作 **************
    // 选择 药物 按钮被点击时的动作
    @objc func chooseMedicine(){
        print("choose medicine button clicked,appear done.")
        // 由于 药物 一定是有可选项的，所以不需判断是否有可选项
        // 判断表格是否需要更新 if开始
        // 若需更新，重新加载数据和表格
        if isMedicineUpdate{
            
            medicineChooseAlert.alertData = data["medicine"] as! [String]
            // 设置框的高度，根据单元格数量和表格上下约束计算得出
            medicineChooseAlert.view.snp.updateConstraints{(make) in
                make.height.equalTo(medicineChooseAlert.alertData.count*35+90)
            }
            // 更新单元格
            medicineChooseAlert.tabelView.reloadData()
            // 显示 警示框
            self.present(medicineChooseAlert, animated: true, completion: nil)
            // 设置更新 为false，避免下次再重新加载浪费时间
            isMedicineUpdate = false
        }// 判断表格是否需要更新 if结束
            // 若不需要更新，直接显示警示框
        else{
            // 显示 警示框
            self.present(medicineChooseAlert, animated: true, completion: nil)
        }
        
    }
    
    // ****************  备注栏按钮动作 *****************
    // 选择 备注 按钮被点击时的动作
    @objc func chooseRemark(){
        print("choose remark button clicked,appear done.")
        // 将配置文件中的数据导出
        //即判断remark中是否有数据
        if data["remark"] != nil{
            remarkChooseAlert.alertData = data["remark"] as! [String]
        }
        
        // 如果数据量大于0，显示备注事件列表
        // ****** start ******
        if remarkChooseAlert.alertData.count > 0{
            print("备注内部的数据",remarkChooseAlert.alertData.count)
            print("备注初始化的数据",self.remarkChooseAlert.boolarr)
            print("备注更新的数据",self.remarkChooseAlert.boolArray)
            // 判断表格是否需要更新 if开始
            if isRemarkUpdate{
                
                // 设置框的高度，根据单元格数量和表格上下约束计算得出
                // 直接设置 height 失败，提示 height 为 get属性
                remarkChooseAlert.view.snp.updateConstraints{(make) in
                    make.height.equalTo(remarkChooseAlert.alertData.count*35+90)
                }
                // 更新单元格
                remarkChooseAlert.tabelView.reloadData()
                // 显示 警示框
                self.present(remarkChooseAlert, animated: true, completion: nil)
                // 设置更新 为false，避免下次再重新加载浪费时间
                isRemarkUpdate = false
            }// 判断表格是否需要更新 if结束
            else{
                self.present(remarkChooseAlert, animated: true, completion: nil)
            }
            
        }// ****** end ******
            // 如果数据量小于0，提示没有可供选择的事件
        else{ //即不初始化数据
            let alert = UIAlertController(title: "提示", message: "无备注事件供选择", preferredStyle: .alert)
            let actionSure = UIAlertAction(title: "sure", style: .default, handler: nil)
            alert.addAction(actionSure)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // 选择 备注/药物 编辑 按钮被点击时的动作
    // ********* 备注/药物 编辑 按钮 *********
    @objc func edit(sender:UIButton?){
        
        let alert = UIAlertController(title: "添加备注", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = ""
            textField.keyboardType = .default
        })
        // 添加取消按钮
        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        // 添加保存按钮，将文本框中数据保存到沙盒中
        let actionSure = UIAlertAction(title: "确定", style: .destructive, handler: {(UIAlertAction)-> Void in
            
            // 文本框为空，不做任何事
            if alert.textFields![0].text == "" {
                return
            }
            // 通过gtag识别按钮，如果为 remark 的
            if sender!.tag == 6{
                
                // 使得另一个警示框的表格数据更新
                self.remarkChooseAlert.alertData.append(alert.textFields![0].text!)
                // 改变对应的选择器的内容和沙盒中对应队列的内容
                data["remark"] = self.remarkChooseAlert.alertData
                print(path!)
                // 将改变后的结果写入沙盒
                data.write(toFile: path!, atomically: true)
                print(data["remark"] ?? "no remark")
                print("点击确定，显示添加结果",self.remarkChooseAlert.alertData)
                // 将新添加的事件 添加到 表格状态数组中并值为 true
                self.remarkChooseAlert.boolarr.append(true)
                
                self.remarkChooseAlert.boolArray.append(true)
                print("初始化的arry",self.remarkChooseAlert.boolarr)
                print("被设置的arry",self.remarkChooseAlert.boolArray)
                self.remarkChooseAlert.selectedNum += 1  //新添加的默认被选择
                // 备注表格需更新
                self.isRemarkUpdate = true
            }
            // 通过gtag识别按钮，如果为 medicine 的
            if sender!.tag == 8{
                
                // 使得另一个警示框的表格数据更新
                self.medicineChooseAlert.alertData.append(alert.textFields![0].text!)
                
                // 改变对应的选择器的内容和沙盒中对应队列的内容
                data["medicine"] = self.medicineChooseAlert.alertData
                print(path!)
                // 将改变后的结果写入沙盒
                data.write(toFile: path!, atomically: true)
                print(data["medicine"] ?? "no medicine")
                print(self.medicineChooseAlert.alertData)
                // 将新添加的事件 添加到 表格状态数组中并值为 true
                self.medicineChooseAlert.boolarr.append(true)
                self.medicineChooseAlert.boolArray.append(true)
                self.medicineChooseAlert.selectedNum += 1
                // 药物表格需更新
                self.isMedicineUpdate = true
            }
            
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
        // 设置返回首页
        self.tabBarController?.selectedIndex = 0
        //self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel(){
        print("点击了取消")
        //        self.navigationController?.popViewController(animated: true)
    }
    
    //点击保存
    @objc func save(){
        let alert = CustomAlertController()
        let data = input.getData()
        let time = input.getTime()
        print("获得日期:",data)
        print("获得时间:",time)
//        let glucoseValue:Double? = (Double(input.glucose.XTTextfield.text!))!
        
        //如果血糖的单位为mg/dl,则范围为10到600
        //如果血糖的单位为mmol/l,则范围为0.6到33.3
//        if GetUnit.getBloodUnit() == "mg/dL"{
//            print("此时进入了mg/dl这个血糖单位")
//            if input.glucose.glucoseValueMG != Int(0){
//                print("不为空时的内容",input.glucose.glucoseValueMG)
//                if input.glucose.glucoseValueMG >= 10 && input.glucose.glucoseValueMG <= 600{
//                     print("成功获取血糖值")
//                }else{
//                    alert.custom(self, "Attention", "血糖的范围应该在10到600之间")
//                    return
//                }
//            }else{
//                print("为空时的内容",input.glucose.XTTextfield.text!)
//                print(input.glucose.glucoseValueMG)
//                print("类型",type(of:input.glucose.glucoseValueMG))
//                alert.custom(self, "Attention", "血糖不能为空")
//                return
//            }
//        }else{ //mmol/L 单位
//            print("此时进入了mmol/l这个血糖单位")
//            if input.glucose.glucoseValueMM != Double(0){
//                if input.glucose.XTTextfield.text! != ""{  //在保证不为空，里面进行判断
//                    if input.glucose.glucoseValueMM >= 0.6 && input.glucose.glucoseValueMM <= 33.0{
//                        print("成功获取到mmol/l单位的值",input.glucose.glucoseValueMM)
//                    }else{
//                        alert.custom(self, "Attention", "血糖的范围应该在0.6到33.3之间")
//                        return
//                    }
//                }
//            }else{//为空时
//                print("mmol/L单位为空时的内容",input.glucose.XTTextfield.text!)
//                print(input.glucose.glucoseValueMM)
//                alert.custom(self, "Attention", "血糖不能为空")
//                return
//            }
//        }
        let event = input.getEventValue()
        print("获得事件的值，并将其转为int类型的值",EvenChang.evenTonum(event))
        print("胰岛素的事件调试成功*********************")
        let eat_num = input.getPorValue()
        print("获得进餐量的值，并将其转为int类型的值",EatNumChange.eatTonum(eat_num))
        print("胰岛素的进餐量调试成功*********************")
        let insulin_type = input.getInsValue()
        print("获得胰岛素类型",insulin_type)
        print("胰岛素的类型调试成功*********************")
        var insulin_num:Double? = 0
        if input.porAndIns.insulinTextfield.text! != ""{
            if FormatMethodUtil.validateBloodNumber(number: input.porAndIns.insulinTextfield.text!) == true{
                if Double(input.porAndIns.insulinTextfield.text!)! > 100.0{
                    alert.custom(self, "Attention", "输入胰岛素的值不能超过100")
                    return
                }else{
                    insulin_num = Double(input.porAndIns.insulinTextfield.text!)!
                }
            }else{
                alert.custom(self, "Attention", "正确输入胰岛素的值")
                return
            }
        }
        print("胰岛素的量",insulin_num!)
        print("胰岛素的量调试成功*********************")
//        if input.getPorValue()
//        let even = input.getEventValue()
//        let insulin = input.getInsValue()
//        let insulint_num = input.getInsNumValue()
//        let weight = input.getWeightValue()
//        let height = input.getHeightValue()
//        let sysnum = input.getSysValue()
//        let dianum = input.getDiaValue()
//        let medicine = getMedicineArray()
//        let sport = input.getSportType()
//        let sport_time = input.getSportTime()
//        let sport_strength = input.getSportStrength()

//        print("获得血糖",type(of: input.getGlucoseValue()))
        
        
        
        let weight_kg:Double?
        let weight_lbs:Double?
        if input.bodyInfo.weightTextfield.text! != ""{  //如果不为空，才做这件事情
            if GetUnit.getWeightUnit() == "kg"{
                if FormatMethodUtil.validateWeightKgNum(number: input.bodyInfo.weightTextfield.text!) == true{
                    if Double(input.bodyInfo.weightTextfield.text!)! >= 454 && Double(input.bodyInfo.weightTextfield.text!)! <= 0 {
                        //不合法
                        alert.custom(self, "Attention", "体重有效的范围为0~454")
                        return
                    }else{
                        weight_kg = Double(input.bodyInfo.weightTextfield.text!)!
                        weight_lbs = WeightUnitChange.KgToLbs(num: weight_kg!)
                    }
                }else{
                    alert.custom(self, "Attention", "请正确输入体重值")
                    return
                }
            }else{  //单位：lbs
                if FormatMethodUtil.validateWeightKgNum(number: input.bodyInfo.weightTextfield.text!) == true{
                    if Double(input.bodyInfo.weightTextfield.text!)! >= 1000 && Double(input.bodyInfo.weightTextfield.text!)! <= 0 {
                        //不合法
                        alert.custom(self, "Attention", "体重有效的范围为0~1000")
                        return
                    }else{
                        weight_lbs = Double(input.bodyInfo.weightTextfield.text!)!
                        weight_kg = WeightUnitChange.LbsToKg(num: weight_lbs!)
                    }
                }else{
                    alert.custom(self, "Attention", "请正确输入体重值")
                    return
                }
                
            }
            
        }
        
        
        print("体重调试成功")
        
        
        //获取身高
        var height:Double? = 0
        if input.bodyInfo.heightTextfield.text! != ""{
            if FormatMethodUtil.validateHeightNum(number: input.bodyInfo.heightTextfield.text!) == true{
                if Double(input.bodyInfo.heightTextfield.text!)! >= 999.9{
                    alert.custom(self, "Attention", "身高有效范围为0.0~999.9")
                    return
                }else{
                    height = Double(input.bodyInfo.heightTextfield.text!)!
                }
            }else{
                alert.custom(self, "Attention", "请正确输入身高值")
                return
            }
        }
        print("获得身高的值:",height!)
        print("身高的值调试成功*********************")
        
      
        
        print("获得收缩压:",type(of:input.getSysValue()))
        print("获的舒张压:",type(of:input.getDiaValue()))
        var sys_press_mmHg:Double? = 0
        var sys_press_kPa:Double? = 0
        var dis_press_mmHg:Double? = 0
        var dis_press_kPa:Double? = 0
        //收缩压必须大于舒张压
        if input.bodyInfo.blood_sysPressureTextfield.text! != ""{
            if input.bodyInfo.blood_sysPressureTextfield.text! != ""{
                if FormatMethodUtil.validatePressNum(number: input.bodyInfo.blood_sysPressureTextfield.text!) == true && FormatMethodUtil.validatePasswd(passwd: input.bodyInfo.blood_diaPressureTextfield.text!) == true{//限定格式
                    if GetUnit.getPressureUnit() == "mmHg"{  //限定单位
                        if Double(input.bodyInfo.blood_sysPressureTextfield.text!)! >= 45 && Double(input.bodyInfo.blood_sysPressureTextfield.text!)! <= 300 && Double(input.bodyInfo.blood_diaPressureTextfield.text!)! >= 45 && Double(input.bodyInfo.blood_diaPressureTextfield.text!)! <= 300 && Double(input.bodyInfo.blood_sysPressureTextfield.text!)! > Double(input.bodyInfo.blood_diaPressureTextfield.text!)!{
                            sys_press_mmHg = Double(input.bodyInfo.blood_sysPressureTextfield.text!)!
                            dis_press_mmHg = Double(input.bodyInfo.blood_diaPressureTextfield.text!)!
                            sys_press_kPa = PressureUnitChange.mmHgTokPa(num: sys_press_mmHg!)
                            dis_press_kPa = PressureUnitChange.kPaTommHg(num: dis_press_mmHg!)
                            print(sys_press_mmHg as Any)
                        }else{
                            alert.custom(self, "Attention", "血压的范围在45~300之间")
                        }
                    }else{ //kPa
                        if Double(input.bodyInfo.blood_sysPressureTextfield.text!)! >= 6 && Double(input.bodyInfo.blood_sysPressureTextfield.text!)! <= 40 && Double(input.bodyInfo.blood_diaPressureTextfield.text!)! >= 6 && Double(input.bodyInfo.blood_diaPressureTextfield.text!)! <= 40 && Double(input.bodyInfo.blood_sysPressureTextfield.text!)! > Double(input.bodyInfo.blood_diaPressureTextfield.text!)!{
                            sys_press_kPa = Double(input.bodyInfo.blood_sysPressureTextfield.text!)!
                            dis_press_kPa = Double(input.bodyInfo.blood_diaPressureTextfield.text!)!
                            sys_press_mmHg = PressureUnitChange.mmHgTokPa(num: sys_press_kPa!)
                            dis_press_mmHg = PressureUnitChange.kPaTommHg(num: dis_press_kPa!)

                        }else{
                            alert.custom(self, "Attention", "血压的范围在45~300之间")
                        }
                    }
                }else{
                    alert.custom(self, "Attention", "输入的血压格式不正确")
                }
            }else{
                alert.custom(self, "Attention", "舒张压不能为空")
                return
            }
        }
        let medicine = getMedicineArray()
        var medicine_string:String = ""
        if medicine != []{
//            print("药物",medicine)
            var j:Int = 0
            for i in medicine{
                if j == 0 {
                    medicine_string = i
                }else if j <= medicine.count - 1{
                    medicine_string = medicine_string + "," + i
                }else{
                    medicine_string = medicine_string  + i
                }
                j = j + 1
            }
        }else{
            print("如何等于空的时候，值为多少",medicine)
        }
        print(medicine_string)
        
        
        
        let sport = input.getSportType()
        print("获得运动类型:",sport)
    
        var sport_time:Int? = 0
        if input.sport.timeOfDurationTextfield.text! != ""{
            if Int(input.sport.timeOfDurationTextfield.text!)! > 5 && Int(input.sport.timeOfDurationTextfield.text!)! < 360{
                sport_time = Int(input.sport.timeOfDurationTextfield.text!)!
            }else{
                print(Int(input.sport.timeOfDurationTextfield.text!)!)
                alert.custom(self, "Attention", "有效的运动持续时间范围为5~360")
                return
            }
        }
        print("获得运动持续时间:",sport_time!)
        
        let sport_strength = IntensityChange.intensityTonum(input.getSportStrength())
        print("获得运动强度转换后的值:",sport_strength)
        //let arr:[String] = medicineChooseAlert.getMedicineArray()
//        let arrtemp:[String] = ["dd","aa","dda","Asipirin"]
//        setMedicineArray(arrtemp)
//        print(getMedicineArray())
        print("点击了保存")
        
        //        self.navigationController?.popViewController(animated: true)
    }
    
    //视图将要出现的时候
    override func viewWillAppear(_ animated: Bool) {
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
    }
    //视图将要消失的时候
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.input.removeFromSuperview()
    }
 
    
    func getMedicineArray()->Array<String>{
        var arr:[String] = []
        var j:Int = 0
        for i in medicineChooseAlert.boolarr{
            if i{
                print("药物")
                print(i)
                arr.append(medicineChooseAlert.alertData[j])
            }
            j = j+1
        }
        return arr
    }
    //设置药物名称,需要传入一个String数组     数据回写
    func setMedicineArray(_ arr:Array<String>){
        let initLength:Int = medicineChooseAlert.alertData.count
        var arrtemp = arr
        let fromLength:Int = arr.count
        //如果alertData的数据元素，与传入的数据元素相等的话。则将元素对应的boolarr设置成true
        //a与b之间的交集
        for i in 0..<initLength{
            for j in 0..<fromLength{
                if medicineChooseAlert.alertData[i] == arrtemp[j]{
                    //除了原先有的不用append之外，其他的东西三个东西都需要设置
                    medicineChooseAlert.boolarr[i] = true
                    medicineChooseAlert.boolArray[i] = true
                    medicineChooseAlert.selectedNum += 1
                    arrtemp[j] = ""
//                    arrtemp.remove(at: j)//如果相等,则将对应的数剔除
                }
            }
        }
        for j in 0..<fromLength{
            if(arrtemp[j] != ""){  //不为空，说明原先没有这种药，需要重新添加，重新选取
                //先加载到内存数组中
                medicineChooseAlert.alertData.append(arrtemp[j])
                medicineChooseAlert.boolArray.append(true)
                medicineChooseAlert.boolarr.append(true)
                medicineChooseAlert.selectedNum += 1
                //后写入到文件中
                data["medicine"] = medicineChooseAlert.alertData
                data.write(toFile: path!, atomically: true)
            }
        }
    }
    
    func getAllInfo(){
        
    }
    
    
}
