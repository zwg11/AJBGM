//
//  UnitViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  血糖单位设置页

import UIKit

class UnitViewController: UIViewController {

    //tableview进行reload的时候使用
//    var num:Int = 0
//
//    public lazy var unitArray: Array = ["血糖单位","体重单位","血压单位",]
    var currentGlucoseUnit:String?
    var currentWeightUnit:String?
    var currentBloodUnit:String?
    
    public lazy var unitDataArray : Array = ["","",""]
    
    let unselectedButtonColor = UIColor.init(red: 17/255.0, green: 56/255.0, blue: 86/255.0, alpha: 1)
    let unselectedTextColor = UIColor.init(red: 118/255.0, green: 131/255.0, blue: 141/255.0, alpha: 1)
    
//    let tableview:UITableView = {
//        let tableView = UITableView.init(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight/15 * 3))
//        return tableView
//    }()
    
    lazy var text_Glucose:UILabel = {
        let text_Glucose = UILabel()
        text_Glucose.font = UIFont.systemFont(ofSize: 16)
        text_Glucose.text = "Glucose Unit"
        text_Glucose.textColor = TextColor
//        text_Glucose.backgroundColor = UIColor.red
        return text_Glucose
    }()
    
    lazy var mmol_Button:UIButton = {
        let mmol_Button = UIButton(frame: CGRect())
        mmol_Button.setTitle("mmol/L", for: .normal)
        mmol_Button.contentHorizontalAlignment = .center
        mmol_Button.setTitleColor(UIColor.white, for: .normal)
        mmol_Button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        mmol_Button.layer.borderWidth = 0.5
        mmol_Button.layer.borderColor = UIColor.white.cgColor
        return mmol_Button
    }()
    
    lazy var mg_Button:UIButton = {
        let mg_Button = UIButton(frame: CGRect())
        mg_Button.setTitle("mg/dL", for: .normal)
        mg_Button.contentHorizontalAlignment = .center
        mg_Button.setTitleColor(UIColor.white, for: .normal)
        mg_Button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        mg_Button.layer.borderWidth = 0.5
        mg_Button.layer.borderColor = UIColor.white.cgColor
        return mg_Button
    }()

    
    lazy var text_Weight:UILabel = {
        let text_Weight = UILabel()
        text_Weight.font = UIFont.systemFont(ofSize: 16)
        text_Weight.text = "Weight Unit"
        text_Weight.textColor = TextColor
//        text_Weight.backgroundColor = UIColor.red
        return text_Weight
    }()
    
    lazy var kg_Button:UIButton = {
        let kg_Button = UIButton(frame: CGRect())
        kg_Button.setTitle("Kg", for: .normal)
        kg_Button.contentHorizontalAlignment = .center
        kg_Button.setTitleColor(UIColor.white, for: .normal)
        kg_Button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        kg_Button.layer.borderWidth = 0.5
        kg_Button.layer.borderColor = UIColor.white.cgColor
        return kg_Button
    }()
    
    lazy var lb_Button:UIButton = {
        let lb_Button = UIButton(frame: CGRect())
        lb_Button.setTitle("lbs", for: .normal)
        lb_Button.contentHorizontalAlignment = .center
        lb_Button.setTitleColor(UIColor.white, for: .normal)
        lb_Button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        lb_Button.layer.borderWidth = 0.5
        lb_Button.layer.borderColor = UIColor.white.cgColor
        return lb_Button
    }()
    
    
    lazy var text_BloodPress:UILabel = {
        let text_BloodPress = UILabel()
        text_BloodPress.font = UIFont.systemFont(ofSize: 16)
        text_BloodPress.text = "Blood Pressure"
        text_BloodPress.textColor = TextColor
//        text_BloodPress.backgroundColor = UIColor.red
        return text_BloodPress
    }()
    
    lazy var mmhg_Button:UIButton = {
        let kg_Button = UIButton(frame: CGRect())
        kg_Button.setTitle("mmHg", for: .normal)
        kg_Button.contentHorizontalAlignment = .center
        kg_Button.setTitleColor(UIColor.white, for: .normal)
        kg_Button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        kg_Button.layer.borderWidth = 0.5
        kg_Button.layer.borderColor = UIColor.white.cgColor
        return kg_Button
    }()
    
    lazy var KPa_Button:UIButton = {
        let KPa_Button = UIButton(frame: CGRect())
        KPa_Button.setTitle("KPa", for: .normal)
        KPa_Button.contentHorizontalAlignment = .center
        KPa_Button.setTitleColor(UIColor.white, for: .normal)
        KPa_Button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        KPa_Button.layer.borderWidth = 0.5
        KPa_Button.layer.borderColor = UIColor.white.cgColor
        return KPa_Button
    }()
    
    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton:UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        button.setTitle("Save", for: .normal)
        button.tintColor = ThemeColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Units Setup"
        
//        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
//        tableview.register(UITableViewCell.self, forCellReuseIdentifier:"infocell")
//        tableview.delegate = self
//        tableview.dataSource = self
//        tableview.isScrollEnabled = false
//        self.view.addSubview(tableview)
//
        self.view.addSubview(text_Glucose)
        text_Glucose.snp.makeConstraints{  (make) in
            make.left.equalTo(AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/15)
            make.width.equalTo(AJScreenWidth/4)
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(AJScreenWidth/15)
        }
        mg_Button.addTarget(self, action: #selector(ClickMgButton), for: .touchUpInside)
        self.view.addSubview(mg_Button)
        mg_Button.snp.makeConstraints{  (make) in
            make.right.equalTo(-AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/20)
            make.width.equalTo(AJScreenWidth/5)
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(AJScreenWidth/15)
        }
        print("进入单位设置")
        mmol_Button.addTarget(self, action: #selector(ClickMmolButton), for: .touchUpInside)
        self.view.addSubview(mmol_Button)
        mmol_Button.snp.makeConstraints{  (make) in
            make.right.equalTo(mg_Button.snp.left).offset(-AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/20)
            make.width.equalTo(AJScreenWidth/5)
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(AJScreenWidth/15)
        }
        
        //第一条线
        let line_frame1 = UIView(frame: CGRect())
        line_frame1.backgroundColor = LineColor
        self.view.addSubview(line_frame1)
        line_frame1.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(text_Glucose.snp.bottom).offset(1)
        }
        self.view.addSubview(text_Weight)
        text_Weight.snp.makeConstraints{  (make) in
            make.left.equalTo(AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/15)
            make.width.equalTo(AJScreenWidth/4)
            make.top.equalTo(line_frame1.snp.bottom).offset(AJScreenWidth/20)
        }
        lb_Button.addTarget(self, action: #selector(ClickLbButton), for: .touchUpInside)
        self.view.addSubview(lb_Button)
        lb_Button.snp.makeConstraints{  (make) in
            make.right.equalTo(-AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/20)
            make.width.equalTo(AJScreenWidth/5)
            make.top.equalTo(line_frame1.snp.bottom).offset(AJScreenWidth/20)
        }
        kg_Button.addTarget(self, action: #selector(ClickKgButton), for: .touchUpInside)
        self.view.addSubview(kg_Button)
        kg_Button.snp.makeConstraints{  (make) in
            make.right.equalTo(lb_Button.snp.left).offset(-AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/20)
            make.width.equalTo(AJScreenWidth/5)
            make.top.equalTo(line_frame1.snp.bottom).offset(AJScreenWidth/20)
        }
        //第二条线
        let line_frame2 = UIView(frame: CGRect())
        line_frame2.backgroundColor = LineColor
        self.view.addSubview(line_frame2)
        line_frame2.snp.makeConstraints{ (make) in
            make.height.equalTo(0.5)
            make.width.equalTo(AJScreenWidth)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(text_Weight.snp.bottom).offset(1)
        }
        self.view.addSubview(text_BloodPress)
        text_BloodPress.snp.makeConstraints{  (make) in
            make.left.equalTo(AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/15)
            make.width.equalTo(AJScreenWidth/3)
            make.top.equalTo(line_frame2.snp.bottom).offset(AJScreenWidth/20)
        }
        
        KPa_Button.addTarget(self, action: #selector(ClickKpaButton), for: .touchUpInside)
        self.view.addSubview(KPa_Button)
        KPa_Button.snp.makeConstraints{  (make) in
            make.right.equalTo(-AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/20)
            make.width.equalTo(AJScreenWidth/5)
            make.top.equalTo(line_frame2.snp.bottom).offset(AJScreenWidth/20)
        }
        mmhg_Button.addTarget(self,action: #selector(ClickMmhgButton),for: .touchUpInside)
        self.view.addSubview(mmhg_Button)
        mmhg_Button.snp.makeConstraints{  (make) in
            make.right.equalTo(KPa_Button.snp.left).offset(-AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/20)
            make.width.equalTo(AJScreenWidth/5)
            make.top.equalTo(line_frame2.snp.bottom).offset(AJScreenWidth/20)
        }

        
        
    }
   
    
    //每一次视图出现，就加载
    override func viewWillAppear(_ animated: Bool) {
        //let path = Bundle.main.path(forResource: "UnitSetting", ofType: "plist")
        let path = PlistSetting.getFilePath(File: "UnitSetting.plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
//        print("dkdkdkdkdkdkd",data.description)
//        print("有几个数",data.count)
        unitDataArray[0] = data["BloodUnit"]! as! String
        unitDataArray[1] = data["WeightUnit"]! as! String
        unitDataArray[2] = data["PressureUnit"]! as! String
        currentGlucoseUnit = unitDataArray[0]
        currentWeightUnit = unitDataArray[1]
        currentBloodUnit = unitDataArray[2]
        print("BloodUnit",data["BloodUnit"]!)
        print("WeightUnit",data["WeightUnit"]!)
        print("PressureUnit",data["PressureUnit"]!)
        if unitDataArray[0] == "mmol/L"{
            mmol_Button.backgroundColor = ButtonColor
            
            mmol_Button.setTitleColor(UIColor.white, for: .normal)
            mmol_Button.layer.borderWidth = 0.5
            mmol_Button.layer.borderColor = UIColor.white.cgColor
            
            mg_Button.backgroundColor = unselectedButtonColor
            mg_Button.setTitleColor(unselectedTextColor, for: .normal)
            mg_Button.layer.borderWidth = 0.5
            mg_Button.layer.borderColor = unselectedTextColor.cgColor
        }else{
            mg_Button.backgroundColor = ButtonColor
            mg_Button.setTitleColor(UIColor.white, for: .normal)
            mg_Button.layer.borderWidth = 0.5
            mg_Button.layer.borderColor = UIColor.white.cgColor
            
            mmol_Button.backgroundColor = unselectedButtonColor
            mmol_Button.setTitleColor(unselectedTextColor, for: .normal)
            mmol_Button.layer.borderWidth = 0.5
            mmol_Button.layer.borderColor = unselectedTextColor.cgColor
        }
        if unitDataArray[1] == "Kg"{
            print("等于Kg")
        }else{
            print("不等于Kg")
        }
        
        if unitDataArray[1] == "Kg"{
            kg_Button.backgroundColor = ButtonColor
            kg_Button.setTitleColor(UIColor.white, for: .normal)
            kg_Button.layer.borderWidth = 0.5
            kg_Button.layer.borderColor = UIColor.white.cgColor
            
            lb_Button.backgroundColor = unselectedButtonColor
            lb_Button.setTitleColor(unselectedTextColor, for: .normal)
            lb_Button.layer.borderWidth = 0.5
            lb_Button.layer.borderColor = unselectedTextColor.cgColor
        }else{
            lb_Button.backgroundColor = ButtonColor
            lb_Button.setTitleColor(UIColor.white, for: .normal)
            lb_Button.layer.borderWidth = 0.5
            lb_Button.layer.borderColor = UIColor.white.cgColor
            
            kg_Button.backgroundColor = unselectedButtonColor
            kg_Button.setTitleColor(unselectedTextColor, for: .normal)
            kg_Button.layer.borderWidth = 0.5
            kg_Button.layer.borderColor = unselectedTextColor.cgColor
        }
        if unitDataArray[2] == "mmHg"{
            mmhg_Button.backgroundColor = ButtonColor
            mmhg_Button.setTitleColor(UIColor.white, for: .normal)
            mmhg_Button.layer.borderWidth = 0.5
            mmhg_Button.layer.borderColor = UIColor.white.cgColor
            
            KPa_Button.backgroundColor = unselectedButtonColor
            KPa_Button.setTitleColor(unselectedTextColor, for: .normal)
            KPa_Button.layer.borderWidth = 0.5
            KPa_Button.layer.borderColor = unselectedTextColor.cgColor
        }else{
            KPa_Button.backgroundColor = ButtonColor
            KPa_Button.setTitleColor(UIColor.white, for: .normal)
            KPa_Button.layer.borderWidth = 0.5
            KPa_Button.layer.borderColor = UIColor.white.cgColor
            
            mmhg_Button.backgroundColor = unselectedButtonColor
            mmhg_Button.setTitleColor(unselectedTextColor, for: .normal)
            mmhg_Button.layer.borderWidth = 0.5
            mmhg_Button.layer.borderColor = unselectedTextColor.cgColor
        }
        print("BloodUnit",data["BloodUnit"]!)
        print("WeightUnit",data["WeightUnit"]!)
        print("PressureUnit",data["PressureUnit"]!)
    }
    @objc private func ClickMmolButton(){
        currentGlucoseUnit = "mmol/L"
        mmol_Button.backgroundColor = ButtonColor
        mmol_Button.setTitleColor(UIColor.white, for: .normal)
        mmol_Button.layer.borderWidth = 0.5
        mmol_Button.layer.borderColor = UIColor.white.cgColor
        
        mg_Button.backgroundColor = unselectedButtonColor
        mg_Button.setTitleColor(unselectedTextColor, for: .normal)
        mg_Button.layer.borderWidth = 0.5
        mg_Button.layer.borderColor = unselectedTextColor.cgColor
    }
    
    @objc private func ClickMgButton(){
        currentGlucoseUnit = "mg/dL"
        mg_Button.backgroundColor = ButtonColor
        mg_Button.setTitleColor(UIColor.white, for: .normal)
        mg_Button.layer.borderWidth = 0.5
        mg_Button.layer.borderColor = UIColor.white.cgColor
        
        mmol_Button.backgroundColor = unselectedButtonColor
        mmol_Button.setTitleColor(unselectedTextColor, for: .normal)
        mmol_Button.layer.borderWidth = 0.5
        mmol_Button.layer.borderColor = unselectedTextColor.cgColor
    }
   
    
    @objc private func ClickKgButton(){
        currentWeightUnit = "Kg"
        kg_Button.backgroundColor = ButtonColor
        kg_Button.setTitleColor(UIColor.white, for: .normal)
        kg_Button.layer.borderWidth = 0.5
        kg_Button.layer.borderColor = UIColor.white.cgColor
        
        lb_Button.backgroundColor = unselectedButtonColor
        lb_Button.setTitleColor(unselectedTextColor, for: .normal)
        lb_Button.layer.borderWidth = 0.5
        lb_Button.layer.borderColor = unselectedTextColor.cgColor
    }
    @objc private func ClickLbButton(){
        currentWeightUnit = "lbs"
        lb_Button.backgroundColor = ButtonColor
        lb_Button.setTitleColor(UIColor.white, for: .normal)
        lb_Button.layer.borderWidth = 0.5
        lb_Button.layer.borderColor = UIColor.white.cgColor
        
        kg_Button.backgroundColor = unselectedButtonColor
        kg_Button.setTitleColor(unselectedTextColor, for: .normal)
        kg_Button.layer.borderWidth = 0.5
        kg_Button.layer.borderColor = unselectedTextColor.cgColor
    }
    
    @objc private func ClickMmhgButton(){
        currentBloodUnit = "mmHg"
        mmhg_Button.backgroundColor = ButtonColor
        mmhg_Button.setTitleColor(UIColor.white, for: .normal)
        mmhg_Button.layer.borderWidth = 0.5
        mmhg_Button.layer.borderColor = UIColor.white.cgColor
        
        KPa_Button.backgroundColor = unselectedButtonColor
        KPa_Button.setTitleColor(unselectedTextColor, for: .normal)
        KPa_Button.layer.borderWidth = 0.5
        KPa_Button.layer.borderColor = unselectedTextColor.cgColor
    }
    
    @objc private func ClickKpaButton(){
        currentBloodUnit = "KPa"
        KPa_Button.backgroundColor = ButtonColor
        KPa_Button.setTitleColor(UIColor.white, for: .normal)
        KPa_Button.layer.borderWidth = 0.5
        KPa_Button.layer.borderColor = UIColor.white.cgColor
        
        mmhg_Button.backgroundColor = unselectedButtonColor
        mmhg_Button.setTitleColor(unselectedTextColor, for: .normal)
        mmhg_Button.layer.borderWidth = 0.5
        mmhg_Button.layer.borderColor = unselectedTextColor.cgColor
    }
    
    @objc private func leftButtonClick(){
        self.navigationController?.popViewController(animated: false)
    }
    @objc private func save(){
        let path = PlistSetting.getFilePath(File: "UnitSetting.plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        //先更新plist文件里面的数据
        data.setObject(currentGlucoseUnit as Any, forKey: "BloodUnit" as NSCopying)
        data.setObject(currentWeightUnit as Any, forKey: "WeightUnit" as NSCopying)
        data.setObject(currentBloodUnit as Any, forKey: "PressureUnit" as NSCopying)
        //接着写入到文件中
        data.write(toFile: path, atomically: true)
        let alert = CustomAlertController()
        alert.custom(self, "Attention", "Save Success！")
        
    }
    
    
    
}

//
//
//extension UnitViewController:UITableViewDelegate,UITableViewDataSource{
//
//    //设置有几个分区
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    //每个分区有几行
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return unitArray.count
//    }
//    //每一个cell，里面的内容
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("到达个人信息页", indexPath)
//        //根据注册的cell类ID值获取到载体cell
//        var cell = tableView.dequeueReusableCell(withIdentifier: "infocell")
//
//
//        //cell.focusStyle = .custom
//        var style: UITableViewCell.CellStyle
//        style = UITableViewCell.CellStyle.value1
//        cell = UITableViewCell(style: style, reuseIdentifier: "infocell")
//
//        //左边标签
//        cell?.textLabel?.text = unitArray[(indexPath as NSIndexPath).row]
//
//        //右边数据
//        cell!.accessoryType = .disclosureIndicator
//        cell?.detailTextLabel?.text = unitDataArray[(indexPath as NSIndexPath).row]
//
//        return cell!
//    }
//
//
//    //回调方法，监听点击事件
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //行
//        let row = indexPath.row
//        print(row)
//        switch row {
//        case 0:
//            let pickerView = BHJPickerView.init(self, .blood)
//            pickerView.pickerViewShow()  //血糖
//            num = 0
//        case 1:
//            let pickerView = BHJPickerView.init(self, .weight)
//            pickerView.pickerViewShow()  //体重
//            num = 1
//        case 2:
//            let pickerView = BHJPickerView.init(self, .pressure)
//            pickerView.pickerViewShow()  //血压
//            num = 2
//        default:
//            let pickerView = BHJPickerView.init(self, .pressure)
//            pickerView.pickerViewShow()  //血压
//            num = 0
//        }
//        //取消选择的效果
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    func selectedAddress(_ pickerView: BHJPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
//        print("选择地址")
//    }
//
//    func selectedDate(_ pickerView: BHJPickerView, _ dateStr: Date) {
//        print("选择日期")
//    }
//
//    func selectedGender(_ pickerView: BHJPickerView, _ genderStr: String) {
//        print("选择性别")
//    }
//
//    //修改血糖单位
//    func selectedBlood(_ pickerView: BHJPickerView, _ bloodStr: String) {
//        let messge = bloodStr
//        //let path = Bundle.main.path(forResource: "UnitSetting", ofType: "plist")
//        let path = PlistSetting.getFilePath(File: "UnitSetting.plist")
//        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
//        //先更新plist文件里面的数据
//        data.setObject(messge, forKey: "BloodUnit" as NSCopying)
//        //接着写入到文件中
//        data.write(toFile: path, atomically: true)
//        //然后再更新数组的数据
//        self.unitDataArray[self.num] = messge
//        //最后重新加载更新第一行数据
//        self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
//        print("选择血糖")
//    }
//    //修改体重单位
//    func selectedWeight(_ pickerView: BHJPickerView, _ weightStr: String) {
//        let messge = weightStr
//        //let path = Bundle.main.path(forResource: "UnitSetting", ofType: "plist")
//        let path = PlistSetting.getFilePath(File: "UnitSetting.plist")
//        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
//        //先更新plist文件里面的数据
//        data.setObject(messge, forKey: "WeightUnit" as NSCopying)
//        //接着写入到文件中
//        data.write(toFile: path, atomically: true)
//        self.unitDataArray[self.num] = messge
//        //更新第一行数据
//        self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
//        print("选择体重")
//    }
//    //修改血压单位
//    func selectedPressure(_ pickerView: BHJPickerView, _ pressureStr: String) {
//        let messge = pressureStr
//        print(messge)
////        let path = Bundle.main.path(forResource: "UnitSetting", ofType: "plist")
//        let path = PlistSetting.getFilePath(File: "UnitSetting.plist")
//        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
//        //先更新plist文件里面的数据
//        data.setObject(messge, forKey: "PressureUnit" as NSCopying)
//        //接着写入到文件中
//        data.write(toFile: path, atomically: true)
//        self.unitDataArray[self.num] = messge
//        //更新第一行数据
//        print(self.num)
//        self.tableview.reloadRows(at: [IndexPath(row:self.num,section:0)], with: .fade)
//        print("选择血压")
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return AJScreenHeight/15
//    }
//}
//


