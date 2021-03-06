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

   // private var event:NSArray = NSArray()
    
   // private var portion:NSArray = NSArray()
//    private var insulin:NSArray = NSArray()
    
    private var sport:NSArray = NSArray()
   // private var exerIntensity:NSArray = NSArray()
    

    
    // 记录不同选择器选择的内容
//    var eventStr:String?
//    var portionStr:String?
    var insulinStr:String?
    var sportStr:String?
    //var exerItensityStr:String?

    
    // 返回列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // 返回行数,根据选择器的不同设置不同的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
           
//         //事件
//        case eventPicker:
//            return event.count
//        //进餐量
//        case portionPicker:
//            return portion.count
        //胰岛素
        case insulinPicker:
            let path = PlistSetting.getFilePath(File: "inputChoose.plist")
            let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
            let insulin = data["insulin"] as! NSArray
            return insulin.count
        //运动
        case sportPicker:
            return sport.count
//        //运动强度
//        case exerIntensyPicker:
//            return exerIntensity.count
        default:
            return 0

        }
        
    }
    
    // 设置选择器的内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 根据选择器的不同设置内容
        switch pickerView {
            
//        case eventPicker:
//            return event[row] as? String
//
//        case portionPicker:
//            return portion[row] as? String
        case insulinPicker:
            let path = PlistSetting.getFilePath(File: "inputChoose.plist")
            let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
            let insulin = data["insulin"] as! NSArray
//            let array = getInsulin.getInsArray()
//            switch row {
//            case 1,2,3:
//
//                let content = insulin[row] as? String
//
//                let index1 = content?.index(content!.startIndex, offsetBy: 6)
//                let a = content?[index1!..<content!.endIndex]
//                return String(a!)
//            default:
//                return insulin[row] as? String
//            }
            return insulin[row] as? String
            
            
        case sportPicker:
            return sport[row] as? String
//        case exerIntensyPicker:
//            return exerIntensity[row] as? String

        default:
            return "error"
        }
    }
    
    // 记录下每个选择器选择的内容
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //选择器停止转动时调用
        switch pickerView {
        //事件选择器
//        case eventPicker:
//            eventStr = event[eventPicker.selectedRow(inComponent: 0)] as! String
//            print("事件选择器",eventStr)
//        //进餐量选择器
//        case portionPicker:
//            portionStr = portion[portionPicker.selectedRow(inComponent: 0)] as! String
        //胰岛素选择器
        case insulinPicker:
            let path = PlistSetting.getFilePath(File: "inputChoose.plist")
            let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
            let insulin = data["insulin"] as! NSArray
            switch row {
            case 1,2,3:
                
                let content = insulin[insulinPicker.selectedRow(inComponent: 0)] as? String
                
                let index1 = content?.index(content!.startIndex, offsetBy: 6)
                let a = content?[index1!..<content!.endIndex]
                insulinStr = String(a!)
            default:
                insulinStr = insulin[insulinPicker.selectedRow(inComponent: 0)] as? String
            }
//            insulinStr = insulin[insulinPicker.selectedRow(inComponent: 0)] as? String
        //运动选择器
        case sportPicker:
            sportStr = sport[sportPicker.selectedRow(inComponent: 0)] as? String
        //运动强度选择器（低，中，高）
//        case exerIntensyPicker:
//            exerItensityStr = exerIntensity[exerIntensyPicker.selectedRow(inComponent: 0)] as! String
        //事件选择器
        default:
            print("error in picker didSelectRow.")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        //修改字体，大小，颜色
        var pickerLabel = view as? UILabel
        if pickerLabel == nil{
            pickerLabel = UILabel()
//            pickerLabel?.font = UIFont.systemFont(ofSize: 16)
            pickerLabel?.textAlignment = .center
            if #available(iOS 13.0, *) {
                pickerLabel?.textColor = UIColor.label
            } else {
                // Fallback on earlier versions
                pickerLabel?.textColor = UIColor.black
            }
        }
        pickerLabel?.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)

        return pickerLabel!
    }
    
    // 确定按钮和取消按钮
    // 确定按钮
    lazy var sureButton:UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .right
        // adapt dark model
        if #available(iOS 13.0, *) {
            button.setTitleColor(UIColor.label, for: .normal)
        } else {
            // Fallback on earlier versions
            button.setTitleColor(UIColor.black, for: .normal)
        }
        // 设置内边界，使得按钮的字体不那么靠右
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width/20)
        // 此处修改了***************************************************
        //button.addTarget(chatViewController.self, action: #selector(pickViewSelected), for: .touchUpInside)
        return button
    }()
    // 取消按钮
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
        // adapt dark model
        if #available(iOS 13.0, *) {
            button.setTitleColor(UIColor.label, for: .normal)
        } else {
            // Fallback on earlier versions
            button.setTitleColor(UIColor.black, for: .normal)
        }
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width/20, bottom: 0, right: 0)
        return button
    }()
    
    // 创建 日期 选择器
    lazy var datePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        //datePicker.frame.size = CGSize(width: UIScreen.main.bounds.width - 20, height: 150)
        datePicker.locale = Locale(identifier: "en_US")
        datePicker.datePickerMode = .date
//        datePicker.backgroundColor = UIColor.white
        datePicker.maximumDate = Date()
        datePicker.date = Date()
        datePicker.layer.borderColor = UIColor.gray.cgColor
        datePicker.layer.borderWidth = 1
        // adapt dark model
        if #available(iOS 13.0, *) {
            datePicker.setValue(UIColor.label, forKey: "textColor")
            datePicker.backgroundColor = UIColor.systemBackground
        } else {
            // Fallback on earlier versions
            datePicker.backgroundColor = UIColor.white
            
        }
        return datePicker
        
    }()
    
    // 创建 时间 选择器
    
    lazy var timePicker:UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.calendar = Calendar.current
        timePicker.locale = Locale(identifier: "en_GB")
//        timePicker.locale = NSLocale.system
        
        timePicker.datePickerMode = .time
        timePicker.date = Date()
//        timePicker.backgroundColor = UIColor.white
        timePicker.layer.borderColor = UIColor.gray.cgColor
        timePicker.layer.borderWidth = 1
        // adapt dark model
        if #available(iOS 13.0, *) {
            timePicker.setValue(UIColor.label, forKey: "textColor")
            timePicker.backgroundColor = UIColor.systemBackground
        } else {
            // Fallback on earlier versions
            timePicker.backgroundColor = UIColor.white
        }
        return timePicker
        
    }()
    
    // 创建 胰岛素 选择器
    lazy var insulinPicker:UIPickerView = {
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
    
//    // 创建 运动强度 选择器
//    lazy var exerIntensyPicker:UIPickerView = {
//        let pickerView = UIPickerView()
//        pickerView.dataSource = self
//        pickerView.delegate = self
//        initPickerView(pickerView: pickerView)
//        return pickerView
//    }()
    
    
    // 设置选择器统一外观
    func initPickerView(pickerView:UIPickerView){
        // 背景颜色为白色，一定要设置，因为默认为透明
        if #available(iOS 13.0, *) {
            pickerView.backgroundColor = UIColor.systemBackground
        } else {
            // Fallback on earlier versions
            pickerView.backgroundColor = UIColor.white
        }
        
        // 设置边界颜色和宽度
        pickerView.layer.borderColor = UIColor.gray.cgColor
        pickerView.layer.borderWidth = 1
    }
    
    func setupUI(){

        // 读取配置文件，获取不同选择器的内容
        //let path = Bundle.main.path(forResource: "inputChoose", ofType: "plist")
        let path = PlistSetting.getFilePath(File: "inputChoose.plist")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!
        
//        // 设置选择器的内容
//        event = data["event"] as! NSArray
//
//        portion = data["portion"] as! NSArray
        
        
        sport = data["sport"] as! NSArray
//        exerIntensity = data["exerIntensity"] as! NSArray
        

        
        
        // 设置视图背景、边框 ,adapt dark model       
        if #available(iOS 13.0, *) {
            self.backgroundColor = UIColor.systemBackground
        } else {
            // Fallback on earlier versions
            self.backgroundColor = UIColor.white
        }
        
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
        
//        // 事件 选择器布局
//        self.addSubview(eventPicker)
//        self.eventPicker.snp.makeConstraints{(make) in
//            make.edges.equalTo(datePicker)
//        }
//
//        // 进餐量 选择器布局
//        self.addSubview(portionPicker)
//        self.portionPicker.snp.makeConstraints{(make) in
//            make.edges.equalTo(datePicker)
//        }
        
        // 胰岛素 选择器布局
        self.addSubview(insulinPicker)
        self.insulinPicker.snp.makeConstraints{(make) in
            make.edges.equalTo(datePicker)
        }
        
        // 运动 选择器布局
        self.addSubview(sportPicker)
        self.sportPicker.snp.makeConstraints{(make) in
            make.edges.equalTo(datePicker)
        }
        
//        // 运动强度 选择器布局
//        self.addSubview(exerIntensyPicker)
//        self.exerIntensyPicker.snp.makeConstraints{(make) in
//            make.edges.equalTo(datePicker)
//        }
        
    }
    
    
    
    
    
}
