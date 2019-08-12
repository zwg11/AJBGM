//
//  pickerView.swift
//  st
//
//  Created by ADMIN on 2019/8/7.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit





class allPickerView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    // 使用以下步骤获取plist文件的数据
//    let path = Bundle.main.path(forResource: "inputChoose", ofType: "plist")
//    let data:NSDictionary = NSDictionary.init(contentsOfFile: path!)!
//
//    var sport:NSArray = NSArray()
//    sport = data["sport"] as! NSArray
//
//    print(sport[0])
    
    // 记录不同的选择器的内容的数组
    private var event:NSArray = NSArray()
    
    private var portion:NSArray = NSArray()
    private var insulin:NSArray = NSArray()
    
    private var medicine:NSArray = NSArray()
    
    private var sport:NSArray = NSArray()
    private var exerIntensity:NSArray = NSArray()
    
    private var remark:NSArray = NSArray()
    
    // 记录不同选择器选择的内容
    var eventStr:String = String()
    var portionStr:String = String()
    var insulinStr:String = String()
    var medicineStr:String = String()
    var sportStr:String = String()
    var exerItensityStr:String = String()
    var remarkStr:String = String()
    
    // 返回列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // 返回行数,根据选择器的不同设置不同的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {

        case eventPicker:
            return event.count

        case portionPicker:
            return portion.count
        case insulinPicker:
            return insulin.count
            
        case medicinePicker:
            return medicine.count

        case sportPicker:
            return sport.count
        case exerIntensyPicker:
            return exerIntensity.count
        default:
            return remark.count
        }
        
    }
    
    // 设置选择器的内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 根据选择器的不同设置内容
        switch pickerView {
            
        case eventPicker:
            return event[row] as? String
            
        case portionPicker:
            return portion[row] as? String
        case insulinPicker:
            return insulin[row] as? String
            
        case medicinePicker:
            return medicine[row] as? String
            
        case sportPicker:
            return sport[row] as? String
        case exerIntensyPicker:
            return exerIntensity[row] as? String
        default:
            return remark[row] as? String
        }
    }
    
    // 记录下每个选择器选择的内容
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 选择器停止转动时调用
        switch pickerView {
            
        case eventPicker:
            eventStr = event[eventPicker.selectedRow(inComponent: 0)] as! String
            
        case portionPicker:
            portionStr = sport[sportPicker.selectedRow(inComponent: 0)] as! String
        case insulinPicker:
            insulinStr = insulin[insulinPicker.selectedRow(inComponent: 0)] as! String
            
        case medicinePicker:
            medicineStr = medicine[medicinePicker.selectedRow(inComponent: 0)] as! String
            
        case sportPicker:
            sportStr = sport[sportPicker.selectedRow(inComponent: 0)] as! String
        case exerIntensyPicker:
            exerItensityStr = exerIntensity[exerIntensyPicker.selectedRow(inComponent: 0)] as! String
        default:
            remarkStr = remark[remarkPicker.selectedRow(inComponent: 0)] as! String
        }
    }

    // 确定按钮和取消按钮
    // 确定按钮
    lazy var sureButton:UIButton = {
        let button = UIButton()
        button.setTitle("ok", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.contentHorizontalAlignment = .right
        // 设置内边界，使得按钮的字体不那么靠右
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width/20)
        // 此处修改了***************************************************
        //button.addTarget(chatViewController.self, action: #selector(pickViewSelected), for: .touchUpInside)
        return button
    }()
    // 取消按钮
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("cancel", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width/20, bottom: 0, right: 0)       
        return button
    }()
    
    // 创建 日期 选择器
    lazy var datePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        //datePicker.frame.size = CGSize(width: UIScreen.main.bounds.width - 20, height: 150)
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor.white
        datePicker.maximumDate = Date()
        datePicker.layer.borderColor = UIColor.gray.cgColor
        datePicker.layer.borderWidth = 1
        return datePicker
        
    }()
    
    // 创建 时间 选择器
    lazy var timePicker:UIDatePicker = {
        let timePicker = UIDatePicker()

        timePicker.calendar = Calendar.current
        timePicker.locale = Locale(identifier: "en_GB")
        timePicker.timeZone = .current
        timePicker.datePickerMode = .time
        timePicker.backgroundColor = UIColor.white
        timePicker.layer.borderColor = UIColor.gray.cgColor
        timePicker.layer.borderWidth = 1
        return timePicker
        
    }()
    
    // 创建 事件 选择器
    lazy var eventPicker:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        initPickerView(pickerView: pickerView)
        return pickerView
    }()
    
    // 创建 进餐量 选择器
    lazy var portionPicker:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        initPickerView(pickerView: pickerView)
        return pickerView
    }()
    
    // 创建 胰岛素 选择器
    lazy var insulinPicker:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        initPickerView(pickerView: pickerView)
        return pickerView
    }()
    
    // 创建 药物 选择器
    lazy var medicinePicker:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        initPickerView(pickerView: pickerView)
        return pickerView
    }()
    
    // 创建 运动 选择器
    lazy var sportPicker:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        initPickerView(pickerView: pickerView)
        return pickerView
    }()
    
    // 创建 运动强度 选择器
    lazy var exerIntensyPicker:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        initPickerView(pickerView: pickerView)
        return pickerView
    }()
    
    // 创建 备注 选择器
    lazy var remarkPicker:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        initPickerView(pickerView: pickerView)
        return pickerView
    }()

    // 设置选择器统一外观
    func initPickerView(pickerView:UIPickerView){
        // 背景颜色为白色，一定要设置，因为默认为透明
        pickerView.backgroundColor = UIColor.white
        // 设置边界颜色和宽度
        pickerView.layer.borderColor = UIColor.gray.cgColor
        pickerView.layer.borderWidth = 1
    }
    
    func setupUI(){
        
        // 读取配置文件，获取不同选择器的内容
        let path = Bundle.main.path(forResource: "inputChoose", ofType: "plist")
        let data:NSDictionary = NSDictionary.init(contentsOfFile: path!)!
        event = data["event"] as! NSArray
        
        portion = data["portion"] as! NSArray
        insulin = data["insulin"] as! NSArray
        
        medicine = data["medicine"] as! NSArray
        
        sport = data["sport"] as! NSArray
        exerIntensity = data["exerIntensity"] as! NSArray
        
        remark = data["remark"] as! NSArray
        
        
        // 设置视图背景、边框
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        // 取消 按钮布局
        self.addSubview(cancelButton)
        self.cancelButton.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width/3)
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/15)
        }
        // 确定 按钮布局
        self.addSubview(sureButton)
        self.sureButton.snp.makeConstraints{(make) in
            make.right.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width/3)
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/15)
    
        }
        // 日期 选择器布局
        self.addSubview(datePicker)
        self.datePicker.snp.makeConstraints{(make) in
            make.right.left.bottom.equalToSuperview()

            make.top.equalTo(sureButton.snp.bottom)
            //make.height.equalTo(self.frame.size.height/3 - UIScreen.main.bounds.height/15)
        }

        // 时间 选择器布局
        self.addSubview(timePicker)
        self.timePicker.snp.makeConstraints{(make) in
//            make.right.left.bottom.equalToSuperview()
//
//            make.top.equalTo(sureButton.snp.bottom)
            make.edges.equalTo(datePicker)
            //make.height.equalTo(self.frame.size.height/3 - UIScreen.main.bounds.height/15)
        }
        
        // 事件 选择器布局
        self.addSubview(eventPicker)
        self.eventPicker.snp.makeConstraints{(make) in
            make.edges.equalTo(datePicker)
        }
        
        // 进餐量 选择器布局
        self.addSubview(portionPicker)
        self.portionPicker.snp.makeConstraints{(make) in
            make.edges.equalTo(datePicker)
        }
        
        // 胰岛素 选择器布局
        self.addSubview(insulinPicker)
        self.insulinPicker.snp.makeConstraints{(make) in
            make.edges.equalTo(datePicker)
        }
        
        // 药物 选择器布局
        self.addSubview(medicinePicker)
        self.medicinePicker.snp.makeConstraints{(make) in
            make.edges.equalTo(datePicker)
        }
        
        // 运动 选择器布局
        self.addSubview(sportPicker)
        self.sportPicker.snp.makeConstraints{(make) in
            make.edges.equalTo(datePicker)
        }
        
        // 运动强度 选择器布局
        self.addSubview(exerIntensyPicker)
        self.exerIntensyPicker.snp.makeConstraints{(make) in
            make.edges.equalTo(datePicker)
        }
        
        // 备注 选择器布局
        self.addSubview(remarkPicker)
        self.remarkPicker.snp.makeConstraints{(make) in
            make.edges.equalTo(datePicker)
        }
        
    }
    
    

    

}
