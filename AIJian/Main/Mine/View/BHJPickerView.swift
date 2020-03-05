//
//  BHJPickerView.swift
//  BHJPickerView
//
//  Created by zzz on 2018/5/21.
//  Copyright © 2018年 baihuajun. All rights reserved.
//

import UIKit


/// pickerView类型
///
/// - address//地址:
/// - date//时间:
/// - gender//性别:
public enum BHJPickerViewStyle {
//    case address  // 地址
    case date     // 时间
    case gender   // 性别
    case blood    // 血糖单位
    case weight   // 体重单位
    case pressure // 血压单位
    case country  //国家
}

/// PickerDelegate  设置代理方法，供Controller层使用
@objc protocol PickerDelegate {
    
//    func selectedAddress(_ pickerView : BHJPickerView,_ procince : AddressModel,_ city : AddressModel,_ area : AddressModel)
    @objc optional func selectedDate(_ pickerView : BHJPickerView,_ dateStr : Date)
    @objc optional func selectedGender(_ pickerView : BHJPickerView,_ genderStr : String)
    @objc optional func selectedBlood(_ pickerView : BHJPickerView,_ bloodStr : String)
    @objc optional func selectedWeight(_ pickerView : BHJPickerView,_ weightStr : String)
    @objc optional func selectedPressure(_ pickerView : BHJPickerView,_ pressureStr : String)
    @objc optional func selectedCountry(_ pickerView : BHJPickerView,_ countryStr : String)
}


class BHJPickerView: UIView , UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    var pickerDelegate : PickerDelegate?
    //底窗属性
    private var pickerStyle: BHJPickerViewStyle?
    private let pickerH : CGFloat! = 260 * kScalHeight
    //底窗个数及类别
//    private var addressPicker : UIPickerView = UIPickerView()
    private lazy var datePicker : UIDatePicker = UIDatePicker()
    private var genderPicker : UIPickerView = UIPickerView()
    private var bloodPicker : UIPickerView = UIPickerView()
    private var weightPicker : UIPickerView = UIPickerView()
    private var pressurePicker : UIPickerView = UIPickerView()
    private var countryPicker : UIPickerView = UIPickerView()
    private var backgroundButton : UIButton = UIButton()
    //存储数据信息，用来统一存放数据
    private var dataArray : NSMutableArray = NSMutableArray()
    
    //存储性别
    private var selectedGender : String = String()
    //存储血糖
    private var selectedBlood : String = String()
    //存储体重
    private var selectedWeight : String = String()
    //存储血压
    private var selectedPressure : String = String()
    //存储国家
    private var selectedCountry: String = String()
    var  List: Int?   //设置成List.   0: 地址  时间不设置标志位   1：性别  2：血糖 3：体重  4：血压
    
    
    // MARK: - 初始化UI  传入PickerView的类型
    init(_ delegate : PickerDelegate,_ style : BHJPickerViewStyle){
        
        dataArray.removeAllObjects()
        pickerDelegate = delegate
        pickerStyle = style
        self.pickerStyle = style
        let frame = CGRect.init(x: 0, y: AJScreenHeight, width: AJScreenWidth, height: AJScreenHeight)
        super.init(frame: frame)
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight))
        // adopt dark model
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            // Fallback on earlier versions
            view.backgroundColor = kRGBColor(230, 230, 230, 1)
        }
        self.addSubview(view)
        
        // 取消按钮  字体需要黑色
        let cancelButton = UIButton.init(type: UIButton.ButtonType.custom)
        cancelButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelButton.setTitle("Cancel", for: UIControl.State.normal)
//        cancelButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: UIControl.Event.touchUpInside)
        self.addSubview(cancelButton)
        
        // 确定按钮
        let doneButton = UIButton.init(type: UIButton.ButtonType.custom)
        doneButton.frame = CGRect.init(x: AJScreenWidth - 60, y: 0, width: 60, height: 44)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        doneButton.setTitle("Done", for: UIControl.State.normal)
//        doneButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: UIControl.Event.touchUpInside)
        
        // adopt dark model
        if #available(iOS 13.0, *) {
            cancelButton.setTitleColor(UIColor.label, for: .normal)
            doneButton.setTitleColor(UIColor.label, for: .normal)
        } else {
            // Fallback on earlier versions
            cancelButton.setTitleColor(UIColor.black, for: .normal)
            doneButton.setTitleColor(UIColor.black, for: .normal)
        }
        self.addSubview(doneButton)
        
        //点击背景，取消
        backgroundButton = UIButton.init(type: UIButton.ButtonType.system)
        backgroundButton.frame = CGRect.init(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight)
        backgroundButton.backgroundColor = kRGBColor(0, 0, 0, 0)
        backgroundButton.addTarget(self, action: #selector(cancelButtonClick), for: UIControl.Event.touchUpInside)
        
        // here ignore the backgroundcolor of picker
        switch style {
            case .date:
                datePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                datePicker.datePickerMode = UIDatePicker.Mode.date
                datePicker.locale = Locale.init(identifier: "en_US")
                datePicker.maximumDate = Date()
                // adopt dark model
                if #available(iOS 13.0, *) {
                    datePicker.setValue(UIColor.label, forKey: "textColor")
                } else {
                    // Fallback on earlier versions
                }
//                datePicker.backgroundColor = UIColor.white
                datePicker.addTarget(self, action: #selector(BHJPickerView.dateSelected(_:)), for: UIControl.Event.valueChanged)
                datePicker.setDate(Date(), animated: true)
                self.addSubview(datePicker)
            
            case .gender:
                genderPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                genderPicker.delegate = self
                genderPicker.dataSource = self
//                genderPicker.backgroundColor = UIColor.white
                List = 0
//                isAddress = false
                self.addSubview(genderPicker)
            case .blood:   //血糖
                bloodPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                bloodPicker.delegate = self
                bloodPicker.dataSource = self
//                bloodPicker.backgroundColor = UIColor.white
                List = 1
                //              isAddress = false
                self.addSubview(bloodPicker)
            case .weight:  //体重
                weightPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                weightPicker.delegate = self
                weightPicker.dataSource = self
//                weightPicker.backgroundColor = UIColor.white
                List = 2
                //                isAddress = false
                self.addSubview(weightPicker)
            case .pressure:  //血压
                pressurePicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                pressurePicker.delegate = self
                pressurePicker.dataSource = self
//                pressurePicker.backgroundColor = UIColor.white
                List = 3
                //                isAddress = false
                self.addSubview(pressurePicker)
            case .country:  //国家
                countryPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                countryPicker.delegate = self
                countryPicker.dataSource = self
//                countryPicker.backgroundColor = UIColor.white
                List = 4
                self.addSubview(countryPicker)
        }
        
        if pickerStyle != BHJPickerViewStyle.date{
            switch List {
//                case 0:
//                    self.getAddressData()
                case 0:  //性别
                    dataArray = NSMutableArray.init(array: ["Male","Female"])
                    self.pickerView(genderPicker, didSelectRow: 0, inComponent: 0)
                case 1: //血糖
                    dataArray = NSMutableArray.init(array: ["mg/dL","mmol/L"])
                    self.pickerView(bloodPicker, didSelectRow: 0, inComponent: 0)
                case 2:  //体重
                    dataArray = NSMutableArray.init(array: ["kg","lbs"])
                    self.pickerView(weightPicker, didSelectRow: 0, inComponent: 0)
                case 3:  //血压
                    dataArray = NSMutableArray.init(array: ["mmHg","kPa"])
                    self.pickerView(pressurePicker, didSelectRow: 0, inComponent: 0)
                default:
                    dataArray = NSMutableArray.init(array: self.getCountry())
                    self.pickerView(countryPicker, didSelectRow: 0, inComponent: 0)
                }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Method
    
    /// 取消按钮点击方法
    @objc func cancelButtonClick(){
        
        self.pickerViewHidden()
    }
    
    /// 确定按钮点击方法
    @objc func doneButtonClick(){
        
//        if pickerStyle == .address {
//            pickerDelegate?.selectedAddress(self, selectedProvince, selectedCity, selectedDistrict)
//        }else
        if pickerStyle == .date{
            pickerDelegate?.selectedDate!(self, datePicker.date)
        }else if pickerStyle == .gender{
            pickerDelegate?.selectedGender!(self, selectedGender)
        }else if pickerStyle == .blood{
            pickerDelegate?.selectedBlood!(self, selectedBlood)
        }else if pickerStyle == .weight{
            pickerDelegate?.selectedWeight!(self, selectedWeight)
        }else if pickerStyle == .pressure{
            pickerDelegate?.selectedPressure!(self, selectedPressure)
        }else{
            pickerDelegate?.selectedCountry!(self, selectedCountry)
        }
        self.pickerViewHidden()
    }
    /// 时间选择
    ///
    /// - Parameter datePicker: 时间选择器
    @objc func dateSelected(_ datePicker: UIDatePicker) {
        
        
    }
    
    /// 展示pickerView
    public func pickerViewShow() {
        
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(self.backgroundButton)
        keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundButton.backgroundColor = kRGBColor(0, 0, 0, 0.3)
            self.frame.origin.y = AJScreenHeight - self.pickerH
        }) { (complete: Bool) in
            
        }
    }
    /// 隐藏pickerView
    public func pickerViewHidden() {
        
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundButton.backgroundColor = kRGBColor(0, 0, 0, 0)
            self.frame.origin.y = AJScreenHeight
        }) { (complete:Bool) in
            self.removeFromSuperview()
            self.backgroundButton.removeFromSuperview()
        }
    }
    
    // MARK: - UIPickerViewDelegate, UIPickerViewDataSource
    
    /// 返回列
    ///
    /// - Parameter pickerView: pickerView
    /// - Returns: 列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        switch List {
//            case 0:
//                return 3
//            default:
                return 1
//        }
    }
    
    /// 返回对应列的行数
    ///
    /// - Parameters:
    ///   - pickerView: pickerView
    ///   - component: 列
    /// - Returns: 行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                return dataArray.count
//        }
    }
    
    /// 返回对应行的title
    ///
    /// - Parameters:
    ///   - pickerView: pickerView
    ///   - row: 行
    ///   - component: 列
    /// - Returns: title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = ""
            title = dataArray[row] as! String
            return title
        
    }
    
    // adopt dark model
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
    
    /// 选择列、行
    ///
    /// - Parameters:
    ///   - pickerView: pickerView
    ///   - row: 行
    ///   - component: 列
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch List{
            case 0:
                selectedGender = dataArray[row] as! String
            case 1:
                selectedBlood = dataArray[row] as! String
            case 2:
                selectedWeight = dataArray[row] as! String
            case 3:
                selectedPressure = dataArray[row] as! String
            default:
                selectedCountry = dataArray[row] as! String
            }
    }
    
    func getCountry()->Array<Any>{
        let countryPath = Bundle.main.path(forResource: "CountryEn", ofType: "plist")
        let country:Array = NSMutableArray.init(contentsOfFile: countryPath!)! as Array
        return country
    }


}





