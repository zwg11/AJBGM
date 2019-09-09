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
}

/// PickerDelegate  设置代理方法，供Controller层使用
protocol PickerDelegate {
    
//    func selectedAddress(_ pickerView : BHJPickerView,_ procince : AddressModel,_ city : AddressModel,_ area : AddressModel)
    func selectedDate(_ pickerView : BHJPickerView,_ dateStr : Date)
    func selectedGender(_ pickerView : BHJPickerView,_ genderStr : String)
    func selectedBlood(_ pickerView : BHJPickerView,_ bloodStr : String)
    func selectedWeight(_ pickerView : BHJPickerView,_ weightStr : String)
    func selectedPressure(_ pickerView : BHJPickerView,_ pressureStr : String)
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
    
    private var backgroundButton : UIButton = UIButton()
    //存储数据信息，用来统一存放数据
    private var dataArray : NSMutableArray = NSMutableArray()
    
    //存储城市信息
//    private var cityArray : NSMutableArray = NSMutableArray()
//    //存储地区信息
//    private var districtArray : NSMutableArray = NSMutableArray()
//    private var selectedProvince : AddressModel = AddressModel()
//    private var selectedCity : AddressModel = AddressModel()
//    private var selectedDistrict : AddressModel = AddressModel()
    //存储性别
    private var selectedGender : String = String()
    //存储血糖
    private var selectedBlood : String = String()
    //存储体重
    private var selectedWeight : String = String()
    //存储血压
    private var selectedPressure : String = String()
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
        view.backgroundColor = kRGBColor(230, 230, 230, 1)
        self.addSubview(view)
        
        // 取消按钮
        let cancelButton = UIButton.init(type: UIButton.ButtonType.custom)
        cancelButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelButton.setTitle("取 消", for: UIControl.State.normal)
        cancelButton.setTitleColor(kRGBColor(18, 93, 255, 1), for: UIControl.State.normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: UIControl.Event.touchUpInside)
        self.addSubview(cancelButton)
        
        // 确定按钮
        let doneButton = UIButton.init(type: UIButton.ButtonType.custom)
        doneButton.frame = CGRect.init(x: AJScreenWidth - 60, y: 0, width: 60, height: 44)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        doneButton.setTitle("确 定", for: UIControl.State.normal)
        doneButton.setTitleColor(kRGBColor(18, 93, 255, 1), for: UIControl.State.normal)
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: UIControl.Event.touchUpInside)
        self.addSubview(doneButton)
        
        //点击背景，取消
        backgroundButton = UIButton.init(type: UIButton.ButtonType.system)
        backgroundButton.frame = CGRect.init(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight)
        backgroundButton.backgroundColor = kRGBColor(0, 0, 0, 0)
        backgroundButton.addTarget(self, action: #selector(cancelButtonClick), for: UIControl.Event.touchUpInside)
        switch style {
//            case .address:
//                addressPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
//                addressPicker.delegate = self
//                addressPicker.dataSource = self
//                addressPicker.backgroundColor = UIColor.white
////                isAddress = true
//                List = 0
//                self.addSubview(addressPicker)
//
            case .date:
                datePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                datePicker.datePickerMode = UIDatePicker.Mode.date
                datePicker.locale = Locale.init(identifier: "zh_CN")
                datePicker.backgroundColor = UIColor.white
                datePicker.addTarget(self, action: #selector(BHJPickerView.dateSelected(_:)), for: UIControl.Event.valueChanged)
                datePicker.setDate(Date(), animated: true)
                self.addSubview(datePicker)
            
            case .gender:
                genderPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                genderPicker.delegate = self
                genderPicker.dataSource = self
                genderPicker.backgroundColor = UIColor.white
                List = 0
//                isAddress = false
                self.addSubview(genderPicker)
            case .blood:   //血糖
                bloodPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                bloodPicker.delegate = self
                bloodPicker.dataSource = self
                bloodPicker.backgroundColor = UIColor.white
                List = 1
                //              isAddress = false
                self.addSubview(bloodPicker)
            case .weight:  //体重
                weightPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                weightPicker.delegate = self
                weightPicker.dataSource = self
                weightPicker.backgroundColor = UIColor.white
                List = 2
                //                isAddress = false
                self.addSubview(weightPicker)
            case .pressure:  //血压
                pressurePicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: AJScreenWidth, height: pickerH - 44))
                pressurePicker.delegate = self
                pressurePicker.dataSource = self
                pressurePicker.backgroundColor = UIColor.white
                List = 3
                //                isAddress = false
                self.addSubview(pressurePicker)
        }
        
        if pickerStyle != BHJPickerViewStyle.date{
            switch List {
//                case 0:
//                    self.getAddressData()
                case 0:  //性别
                    dataArray = NSMutableArray.init(array: ["男","女"])
                    self.pickerView(genderPicker, didSelectRow: 0, inComponent: 0)
                case 1: //血糖
                    dataArray = NSMutableArray.init(array: ["mg/dL","mmol/L"])
                    self.pickerView(bloodPicker, didSelectRow: 0, inComponent: 0)
                case 2:  //体重
                    dataArray = NSMutableArray.init(array: ["kg","lbs"])
                    self.pickerView(weightPicker, didSelectRow: 0, inComponent: 0)
                default:  //血压
                    dataArray = NSMutableArray.init(array: ["mmHg","kPa"])
                    self.pickerView(pressurePicker, didSelectRow: 0, inComponent: 0)
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
            pickerDelegate?.selectedDate(self, datePicker.date)
        }else if pickerStyle == .gender{
            pickerDelegate?.selectedGender(self, selectedGender)
        }else if pickerStyle == .blood{
            pickerDelegate?.selectedBlood(self, selectedBlood)
        }else if pickerStyle == .weight{
            pickerDelegate?.selectedWeight(self, selectedWeight)
        }else{
            pickerDelegate?.selectedPressure(self, selectedPressure)
        }
        self.pickerViewHidden()
    }
    /// 时间选择
    ///
    /// - Parameter datePicker: 时间选择器
    @objc func dateSelected(_ datePicker: UIDatePicker) {
        
        
    }
    
    /// 读取省市区数据
//    func getAddressData() {
//
//        dataArray.removeAllObjects()
//        let path = Bundle.main.path(forResource:"city", ofType: "json")
//        let url = URL(fileURLWithPath: path!)
//        let addressData = NSData.init(contentsOf: url)
//        let addressDic = try! JSONSerialization.jsonObject(with: addressData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
//        let dic = addressDic.object(at: 0) as! NSDictionary
//        let provinceArray = dic["childs"] as! NSArray
//        for i in 0..<provinceArray.count {
//            let provinceDic = provinceArray.object(at: i) as! NSDictionary
//            let provinceM = AddressModel.init()
//            provinceM.region_name = (provinceDic["region_name"] as? String)
//            provinceM.region_id = (provinceDic["region_id"] as! String)
//            provinceM.agency_id = (provinceDic["agency_id"] as? String)
//            provinceM.parent_id = (provinceDic["parent_id"] as! String)
//            provinceM.region_type = (provinceDic["region_type"] as! String)
//            provinceM.childs = (provinceDic["childs"] as! [NSDictionary])
//            self.dataArray.add(provinceM)
//        }
//        self.pickerView(addressPicker, didSelectRow: 0, inComponent: 0)
//    }
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
        
//        switch List {
//            case 0:
//                if component == 0{
//                    return dataArray.count
//                }else if component == 1{
//                    return cityArray.count
//                }else{
//                    return districtArray.count
//                }
//            default:
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
//        switch List {
//        case 0:
//            if component == 0{
//                let provinceM = dataArray[row] as! AddressModel
//                title = provinceM.region_name ?? "未知"
//                return title
//            }else if component == 1{
//                let cityModel = cityArray[row] as! AddressModel
//                title = cityModel.region_name ?? "未知"
//                return title
//            }else{
//                let areaModel = districtArray[row] as! AddressModel
//                title = areaModel.region_name ?? "未知"
//                return title
//            }
//        default:
            title = dataArray[row] as! String
            return title
        
    }
    
    /// 选择列、行
    ///
    /// - Parameters:
    ///   - pickerView: pickerView
    ///   - row: 行
    ///   - component: 列
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch List{
//        case 0:
//            if component == 0 {
//                let provinceM = dataArray[row] as! AddressModel
//                let cityDicArray = provinceM.childs!
//                cityArray.removeAllObjects()
//                for j in 0..<cityDicArray.count {
//                    let cityDic = cityDicArray[j]
//                    let cityM = AddressModel.init()
//                    cityM.region_name = (cityDic["region_name"] as? String)
//                    cityM.region_id = (cityDic["region_id"] as! String)
//                    cityM.agency_id = (cityDic["agency_id"] as? String)
//                    cityM.parent_id = (cityDic["parent_id"] as! String)
//                    cityM.region_type = (cityDic["region_type"] as! String)
//                    cityM.childs = (cityDic["childs"] as! [NSDictionary])
//                    cityArray.add(cityM)
//                }
//                // 默认选择当前省的第一个城市对应的区县
//                self.pickerView(pickerView, didSelectRow: 0, inComponent: 1)
//                selectedProvince = provinceM
//            }else if component == 1 {
//                let cityModel = cityArray[row] as! AddressModel
//                let areaArray = cityModel.childs!
//                districtArray.removeAllObjects()
//                for j in 0..<areaArray.count {
//                    let areaDic = areaArray[j]
//                    let areaModel = AddressModel.init()
//                    areaModel.region_name = (areaDic["region_name"] as? String)
//                    areaModel.region_id = (areaDic["region_id"] as! String)
//                    areaModel.agency_id = (areaDic["agency_id"] as? String)
//                    areaModel.parent_id = (areaDic["parent_id"] as! String)
//                    areaModel.region_type = (areaDic["region_type"] as! String)
//                    districtArray.add(areaModel)
//                }
//                selectedCity = cityModel
//                self.pickerView(pickerView, didSelectRow: 0, inComponent: 2)
//            }else{
//                let areaModel = districtArray[row] as! AddressModel
//                selectedDistrict = areaModel
//            }
//            pickerView.reloadAllComponents()
        case 0:
            selectedGender = dataArray[row] as! String
        case 1:
            selectedBlood = dataArray[row] as! String
        case 2:
            selectedWeight = dataArray[row] as! String
        default:
            selectedPressure = dataArray[row] as! String
        }
    }


}





