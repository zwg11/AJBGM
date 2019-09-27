//
//  glucoseView.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class glucoseView: UIView ,UITextFieldDelegate{

    // 记录血糖值
    var glucoseValueMM:Double = 0
    var glucoseValueMG:Double = 0
    // 设置事件值
    var eventNum:Int = 3
    //***********************血糖********************
//    // 血糖图标
//    private lazy var XTimageView:UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "iconxt")
//        return imageView
//    }()


    // 血糖label
    private lazy var XTLabel:UILabel = {
        let label = UILabel()
        label.normalLabel(text: "Blood Glucose")
        return label
    }()
    // 血糖值mmol/L小数输入文本框
     lazy var XTTextfield:UITextField = {
        let textfield = UITextField()
        textfield.norStyle(placeholder: "")
        textfield.textAlignment = .center
        textfield.addTarget(self, action: #selector(tfvalueChange), for: UIControl.Event.editingChanged)
        textfield.font = UIFont.systemFont(ofSize: 20)
        return textfield
    }()
    //当这个输入框的值改变时
    @objc func tfvalueChange(){
        if XTTextfield.text != nil{
            if GetUnit.getBloodUnit() == "mmol/L"{
                XTSlider.value = (XTTextfield.text! as NSString).floatValue
                glucoseValueMM = Double(XTSlider.value)
            }else{
                let a = (XTTextfield.text! as NSString).intValue
//                glucoseValueMG = Int(a)
                XTSlider.value = Float(a)
            }
        }
    }
    // 血糖单位label
     lazy var XTUnitLabel:UILabel = {
        let label = UILabel()
        label.text = GetUnit.getBloodUnit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    // 血糖滑块
    lazy var XTSlider:UISlider = {
        let slider = UISlider()
        slider.isContinuous = true
//        slider.minimumTrackTintColor = UIColor.blue
//        slider.maximumTrackTintColor = UIColor.white
        slider.addTarget(self, action: #selector(valueChange(_:)), for: UIControl.Event.valueChanged)
        slider.thumbTintColor = UIColor.green
        return slider
    }()
    // 血糖滑块的动作
    @objc func valueChange(_ sender:UISlider){
        if GetUnit.getBloodUnit() == "mmol/L"{
            glucoseValueMM = Double(XTSlider.value)
            // 结果保留1位小数
            XTTextfield.text = String(format:"%.1f",glucoseValueMM)
            
        }else{
            glucoseValueMG = Double(XTSlider.value)
            // 结果保留1位小数
            XTTextfield.text = String(format:"%.0f",glucoseValueMG)
        }
        //setValueAndThumbColor(value: sender.value)
    }
    
    
    func setValueAndThumbColor(value:Float){
        XTSlider.setValue(value, animated: true)
        if value <= Float(GetBloodLimit.getRandomDinnerLow()){
            XTSlider.thumbTintColor = UIColor.red
        }else if value >= Float(GetBloodLimit.getRandomDinnerTop()){
            XTSlider.thumbTintColor = UIColor.yellow
        }else{
            XTSlider.thumbTintColor = UIColor.green
        }
    }
    //**********************************事件*************************
    private lazy var BeforeButton:UIButton = {
        let button = UIButton()
        button.setTitle("Before Meal", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setDeselected()
        button.tag = 0
        button.addTarget(self, action: #selector(SelectEvent(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var AfterButton:UIButton = {
        let button = UIButton()
        
        button.setTitle("After Meal", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setDeselected()
        button.tag = 1
        button.addTarget(self, action: #selector(SelectEvent(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var FastingButton:UIButton = {
        let button = UIButton()
        button.setTitle("Fasting", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setDeselected()
        button.tag = 2
        button.addTarget(self, action: #selector(SelectEvent(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var RandomButton:UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setDeselected()
        button.tag = 3
        button.addTarget(self, action: #selector(SelectEvent(_:)), for: .touchUpInside)
        return button
    }()
//    // 事件图标
//    private lazy var eventImageView:UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "事件")
//        return imageView
//    }()
//    // 事件label
//    private lazy var eventLabel:UILabel = {
//        let label = UILabel()
//        label.normalLabel(text: "事件")
//        return label
//    }()

//    // 事件选择按钮
//    lazy var eventButton:UIButton = {
//        let button = UIButton()
//        button.NorStyle(title: "无")
//        return button
//    }()
    
    @objc func SelectEvent(_ sender:UIButton){

        let buttons = [BeforeButton,AfterButton,FastingButton,RandomButton]
        for i in buttons{
            i.setDeselected()
        }
        sender.setSelected()
        eventNum = sender.tag
    }
    
    // 初始化事件按钮的选择
    func initEvent(event:Int){
        switch event {
        case 0:
            SelectEvent(BeforeButton)
        case 1:
            SelectEvent(AfterButton)
        case 2:
            SelectEvent(FastingButton)
        default:
            SelectEvent(RandomButton)
        }
    }
    
    
    func setupUI(){
        

        
        resetGlucoseUnit()
        initEvent(event: eventNum)
//        setValueAndThumbColor(value: 0)
        // 设置视图背景颜色和边框
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.clear
        
        //***********************血糖********************
//        // 血糖图标布局设置
//        self.addSubview(XTimageView)
//        XTimageView.snp.makeConstraints{(make) in
//            make.left.top.equalToSuperview().offset(AJScreenWidth/20)
//            make.height.width.equalTo(AJScreenWidth/15)
//        }
//        let sd = sliderView.init(frame: CGRect(x: 0, y: 10, width: AJScreenWidth*0.9, height: 5))
//        //sd.frame = CGRect(x: 0, y: 10, width: AJScreenWidth*0.9, height: 5)
//        sd.loadViews()
//        self.addSubview(sd)
        

//        let image = viewToImage.getImageFromView(view: sd)

        // 将图片放入相册
        UIImageWriteToSavedPhotosAlbum(sliderImage, self, #selector(savedPhotosAlbum(_:didFinishSavingWithError:contextInfo:)), nil)

        // 血糖label布局设置
        self.addSubview(XTLabel)
        XTLabel.snp.makeConstraints{(make) in
            make.left.top.equalToSuperview().offset(AJScreenWidth/20)
            make.width.equalTo(AJScreenWidth/4)
            make.height.equalTo(AJScreenWidth/15)
        }
        
        // 血糖值输入框布局
        self.addSubview(XTTextfield)
        XTTextfield.delegate = self
        XTTextfield.snp.makeConstraints{(make) in
            make.left.equalTo(XTLabel)
            make.top.equalTo(XTLabel.snp.bottom).offset(AJScreenWidth/40)
            make.width.equalTo(AJScreenWidth/4)
            make.height.equalTo(AJScreenWidth/12)
        }
        
        // 血糖单位label布局
        self.addSubview(XTUnitLabel)
        XTUnitLabel.snp.makeConstraints{(make) in
            make.left.equalTo(XTTextfield.snp.right).offset(AJScreenWidth/40)
            make.bottom.equalTo(XTTextfield.snp.bottom)
            make.height.equalTo(XTTextfield.snp.height)
        }
        
        // 血糖值滑块布局
//        let image1 = UIImage(named: "back-1")
        self.addSubview(XTSlider)
        XTSlider.setMinimumTrackImage(sliderImage, for: .normal)
        XTSlider.setMaximumTrackImage(sliderImage, for: .normal)
//        initSliderColor()
//        XTSlider.value = value
        XTSlider.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.right.equalToSuperview().offset(-AJScreenWidth/20)
            make.top.equalTo(XTTextfield.snp.bottom).offset(AJScreenWidth/40)
            make.height.equalTo(AJScreenWidth/15)
        }
        
//        //***********************事件********************
//        // 事件图标布局
//        self.addSubview(eventImageView)
//        eventImageView.snp.makeConstraints{(make) in
//            make.left.right.height.equalTo(XTimageView)
//            make.top.equalTo(XTSlider.snp.bottom).offset(AJScreenWidth/40)
//        }
//
//        // 事件label布局
//        self.addSubview(eventLabel)
//        eventLabel.snp.makeConstraints{(make) in
//            make.left.height.equalTo(XTLabel)
//            make.bottom.equalTo(eventImageView)
//        }
//
//        // 事件按钮布局
//        self.addSubview(eventButton)
//        eventButton.snp.makeConstraints{(make) in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(eventLabel.snp.bottom).offset(AJScreenWidth/40)
//            make.width.equalTo(AJScreenWidth/5*3)
//            make.height.equalTo(AJScreenWidth/12)
//        }
        // 事件按钮布局，总共4个
        self.addSubview(BeforeButton)
        self.addSubview(AfterButton)
        self.addSubview(FastingButton)
        self.addSubview(RandomButton)
        
        BeforeButton.snp.makeConstraints{(make) in
            make.left.equalTo(XTSlider)
            make.width.equalTo(AJScreenWidth/5)
            make.height.equalTo(AJScreenWidth/15)
            make.top.equalTo(XTSlider.snp.bottom).offset(AJScreenWidth/40)
        }
        
        AfterButton.snp.makeConstraints{(make) in
            make.left.equalTo(BeforeButton.snp.right).offset(AJScreenWidth/30)
            make.width.equalTo(AJScreenWidth/5)
            make.top.bottom.equalTo(BeforeButton)
        }
        
        FastingButton.snp.makeConstraints{(make) in
            make.left.equalTo(AfterButton.snp.right).offset(AJScreenWidth/30)
            make.width.equalTo(AJScreenWidth/5)
            make.top.bottom.equalTo(BeforeButton)
        }
        
        RandomButton.snp.makeConstraints{(make) in
            make.left.equalTo(FastingButton.snp.right).offset(AJScreenWidth/30)
            make.width.equalTo(AJScreenWidth/5)
            make.top.bottom.equalTo(BeforeButton)
        }
    }
    
    //保存图片
    @objc func savedPhotosAlbum(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        
        if error != nil {
//            let alert = CustomAlertController()
//            alert.custom(self, "", "图片生成失败")
            print("savw failed")
            
        } else {
//            let alert = CustomAlertController()
//            alert.custom(self, "", "图片生成成功")
            print("savw success")
            
        }
    }
    
    // 设置键盘按 return 键弹回
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //设置单位不同显示不同键盘滑块显示不同的范围
    func resetGlucoseUnit(){
        //设置血糖单位
        if GetUnit.getBloodUnit() == "mmol/L"{
            //设置范围
            self.XTSlider.minimumValue = 0.6
            self.XTSlider.maximumValue = 16.6
            
            self.XTTextfield.keyboardType = UIKeyboardType.decimalPad
            
        }else{
            //设置范围
            self.XTSlider.minimumValue = 10
            self.XTSlider.maximumValue = 300
            self.XTTextfield.keyboardType = UIKeyboardType.numberPad
        }
    }
    
//    func initSliderColor(){
//        let first = UIColor.yellow
//        let second = UIColor.green
//        let third = UIColor.red
//        // 创建一个渐变层
//        let layer = CAGradientLayer()
//        // 设置frame
//        layer.frame = self.XTSlider.frame
//        // 设置渐变颜色
//        layer.colors = [first,second,third]
//        var location1 = 0.0
//        var location2 = 0.0
//
//        // 分段位置
//        if GetUnit.getBloodUnit() == "mmol/L"{
//            location1 = (GetBloodLimit.getRandomDinnerLow()-0.6)/16.6
//            location2 = (GetBloodLimit.getRandomDinnerTop()-0.6)/16.6
//        }else{
//            location1 = (GetBloodLimit.getRandomDinnerLow()-10.0)/300.0
//            location2 = (GetBloodLimit.getRandomDinnerTop()-10.0)/300.0
//        }
//
//        // 设置渐变层起点和终点
//        layer.startPoint = CGPoint(x: 0, y: 0.5)
//        layer.endPoint = CGPoint(x: 1, y: 0.5)
//        layer.locations = [location1,location2,1] as [NSNumber]
////        let image = imageGradient(gradientColors: [first,second,third])
////        XTSlider.setMinimumTrackImage(image, for: .normal)
//    }
    
    
//    func imageGradient(gradientColors:[UIColor], size:CGSize = CGSize(width: 10, height: 10) ) -> UIImage
//    {
//        UIGraphicsBeginImageContextWithOptions(size, true, 0)
//        let context = UIGraphicsGetCurrentContext()!
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let colors = gradientColors.map {(color: UIColor) -> AnyObject! in return color.cgColor as AnyObject! } as NSArray
//        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
//        // 第二个参数是起始位置，第三个参数是终止位置
//        context.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: size.width, y: 0), options: CGGradientDrawingOptions(rawValue: 0))
//        let image = UIImage.init(cgImage:(UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
//        UIGraphicsEndImageContext()
//        return image
//    }
    
    // ***********现在对于直接输入那么以下代码可使文本框遵循：***********
    // ***********对于单位--mg/dL 输入小于1000的整数***********
    // ***********对于单位--mmol/L 输入小于100、小数点后1位的数***********
    
    // 如果返回true 则可以输入 ； 反之输入无效
    // string 指的是指定范围的替换字符串。在键入期间，此参数通常只包含键入的单个新字符
    //但如果用户粘贴文本，则它可能包含更多字符。当用户删除一个或多个字符时，替换字符串为空。
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let testString = ".0123456789"
        // textField:当前被操作的文本框
        // range:当前将要替换掉的文本范围
        // string:要替代文本框中一定范围文本的字符串
        
        // char 是字符序列，其包含 testString 以外的字符
        // NSCharacterSet.init(charactersIn: ) 返回包含testString所有字符的字符序列
        // .inverted 将其反转，即包含 testString 以外的字符
        let char = NSCharacterSet.init(charactersIn: testString).inverted
        // 将 string 按 包含 testString 以外的字符 进行分割 components(separatedBy: ) ，再连接joined(separator: “”)
        let inputString = string.components(separatedBy: char).joined(separator: "")
        
        // 若此时字符串与原字符串一致，那么可以输入，否则不能输入
        if string == inputString{
            // 小数点前允许的最大位数
            var numFrontDot:Int = 3
            // 小数点及其之后允许的最大位数
            var numAfterDot:Int = 0
            // mg/dL 只允许输入3位整数
            // mmol/L 小数点前2位，小数点后1位
            if GetUnit.getBloodUnit() == "mmol/L"{
                numFrontDot = 2
                numAfterDot = 2
            }
            // textField中的文本为当前textField的文本，还未被替换
            let futureStr:NSMutableString = NSMutableString(string: textField.text!)
            futureStr.insert(string, at: range.location)
            // 计数小数点之前的个数
            var flag = 0
            // 计数小数点之前的内个数
            var flag1 = 0
            // 计数小数点个数
            var dotNum = 0
            // 判断是否为小数点前
            var isFrontDot = true
            
            if futureStr.length >= 1{
                // 如果第一个就是小数点，不能输入
                let char = Character(UnicodeScalar(futureStr.character(at:0))!)
                if char == "."{
                    return false
                }
                // 如果第一个为0，第二位不为小数点，不能输入
                if futureStr.length >= 2{
                    let char2 = Character(UnicodeScalar(futureStr.character(at:1))!)
                    if char2 != "." && char == "0"{
                        return false
                    }
                }
            }
            
            if !futureStr.isEqual(to: ""){
                for i in 0..<futureStr.length{
                    // 获得指定位置的字符
                    let char = Character(UnicodeScalar(futureStr.character(at:i))!)
                    // 如果是小数点
                    if char == "."{
                        // 判断之前是否有小数点
                        // 如果有，不能输入
                        isFrontDot = false
                        dotNum += 1
                        if dotNum > 1{
                            return false
                        }
                        
                    }
                    // 判断是否在小数点前，对相应变量进行操作
                    // f如果相应变量超过一定值，不允许输入
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
            
        }// 若此时字符串与原字符串不一致，不能输入
        else{
            return false
        }
    }
    
}
