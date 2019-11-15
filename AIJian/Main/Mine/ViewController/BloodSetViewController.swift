//
//  BloodSetViewController.swift
//  AIJian
//
//  Created by zzz on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  血糖设置界面
/*
 功能说明： 上限允许范围：5.0--16.6
 下限允许范围：3.3--7.8
 所有下限默认值为3.9，上限默认值为7.8
 */

import UIKit

class BloodSetViewController: UIViewController,UITextFieldDelegate {
    
    //文件与文本框过渡值的存储
    var emptyStomach_left_number:NSNumber?
    var emptyStomach_right_number:NSNumber?
    
    var beforeDinner_left_number:NSNumber?
    var beforeDinner_right_number:NSNumber?
    
    var afterDinner_left_number:NSNumber?
    var afterDinner_right_number:NSNumber?
    
    var randomDinner_left_number:NSNumber?
    var randomDinner_right_number:NSNumber?
    
    //计算单位，所使用的过度值
    var emptyStomach_left_Double:Double?
    var emptyStomach_right_Double:Double?
    
    var beforeDinner_left_Double:Double?
    var beforeDinner_right_Double:Double?
    
    var afterDinner_left_Double:Double?
    var afterDinner_right_Double:Double?
    
    var randomDinner_left_Double:Double?
    var randomDinner_right_Double:Double?
    
    let UIPAGEColor = UIColor.init(red: 128/255.0, green: 136/255.0, blue: 146/255.0, alpha: 1)
    let UITITLEColor = UIColor.init(red: 136/255.0, green: 172/255.0, blue: 207/255.0, alpha: 1)
    let AnotherColor = UIColor.init(red: 136/255.0, green: 136/255.0, blue: 136/255.0, alpha: 1)
    //空腹相关的全局变量
    lazy var emptyStomach_left:UITextField = {
        let emptyStomach_left = UITextField()
        emptyStomach_left.font = UIFont.systemFont(ofSize: 14)
        emptyStomach_left.allowsEditingTextAttributes = false
        emptyStomach_left.keyboardType = UIKeyboardType.decimalPad
        emptyStomach_left.borderStyle = .line
        emptyStomach_left.textAlignment = .center
        emptyStomach_left.textColor = TextColor
        emptyStomach_left.layer.borderColor = UIColor.white.cgColor
        emptyStomach_left.layer.borderWidth = 1
        return emptyStomach_left
    }()
    
    lazy var emptyStomach_right:UITextField = {
        let emptyStomach_right = UITextField()
        emptyStomach_right.font = UIFont.systemFont(ofSize: 14)
        emptyStomach_right.allowsEditingTextAttributes = false
        emptyStomach_right.keyboardType = UIKeyboardType.decimalPad
        emptyStomach_right.borderStyle = .line
        emptyStomach_right.textAlignment = .center
        emptyStomach_right.textColor = TextColor
        emptyStomach_right.layer.borderColor = UIColor.white.cgColor
        emptyStomach_right.layer.borderWidth = 1
        return emptyStomach_right
    }()
    
    lazy var emptyUnit_label:UILabel = {
        let emptyUnit_label = UILabel(frame: CGRect())
        emptyUnit_label.font = UIFont.systemFont(ofSize: 14)
        emptyUnit_label.textColor = TextColor
        return emptyUnit_label
    }()
    
    //餐前相关的全局变量
    lazy var beforeDinner_left:UITextField = {
        let beforeDinner_left = UITextField()
        beforeDinner_left.font = UIFont.systemFont(ofSize: 14)
        beforeDinner_left.allowsEditingTextAttributes = false
        beforeDinner_left.keyboardType = UIKeyboardType.decimalPad
        beforeDinner_left.borderStyle = .line
        beforeDinner_left.textAlignment = .center
        beforeDinner_left.textColor = TextColor
        beforeDinner_left.layer.borderColor = UIColor.white.cgColor
        beforeDinner_left.layer.borderWidth = 1
        return beforeDinner_left
    }()
    
    lazy var beforeDinner_right:UITextField = {
        let beforeDinner_right = UITextField()
        beforeDinner_right.font = UIFont.systemFont(ofSize: 14)
        beforeDinner_right.allowsEditingTextAttributes = false
        beforeDinner_right.keyboardType = UIKeyboardType.decimalPad
        beforeDinner_right.borderStyle = .line
        beforeDinner_right.textAlignment = .center
        beforeDinner_right.textColor = TextColor
        beforeDinner_right.layer.borderColor = UIColor.white.cgColor
        beforeDinner_right.layer.borderWidth = 1
        return beforeDinner_right
    }()
    
    lazy var beforeUnit_label:UILabel = {
        let beforeUnit_label = UILabel(frame: CGRect())
        beforeUnit_label.font = UIFont.systemFont(ofSize: 14)
        beforeUnit_label.textColor = TextColor
        return beforeUnit_label
    }()
    
    //餐后相关的全局变量
    lazy var afterDinner_left:UITextField = {
        let afterDinner_left = UITextField()
        afterDinner_left.font = UIFont.systemFont(ofSize: 14)
        afterDinner_left.allowsEditingTextAttributes = false
        afterDinner_left.keyboardType = UIKeyboardType.decimalPad
        afterDinner_left.borderStyle = .line
        afterDinner_left.textAlignment = .center
        afterDinner_left.textColor = TextColor
        afterDinner_left.layer.borderColor = UIColor.white.cgColor
        afterDinner_left.layer.borderWidth = 1
        return afterDinner_left
    }()
    
    lazy var afterDinner_right:UITextField = {
        let afterDinner_right = UITextField()
        afterDinner_right.font = UIFont.systemFont(ofSize: 14)
        afterDinner_right.allowsEditingTextAttributes = false
        afterDinner_right.keyboardType = UIKeyboardType.decimalPad
        afterDinner_right.borderStyle = .line
        afterDinner_right.textAlignment = .center
        afterDinner_right.textColor = TextColor
        afterDinner_right.layer.borderColor = UIColor.white.cgColor
        afterDinner_right.layer.borderWidth = 1
        return afterDinner_right
    }()
    
    lazy var afterUnit_label:UILabel = {
        let afterUnit_label = UILabel(frame: CGRect())
        afterUnit_label.font = UIFont.systemFont(ofSize: 14)
        afterUnit_label.textColor = TextColor
        return afterUnit_label
    }()
    
    //随机相关的全局变量
    lazy var randomDinner_left:UITextField = {
        let randomDinner_left = UITextField()
        randomDinner_left.font = UIFont.systemFont(ofSize: 14)
        randomDinner_left.allowsEditingTextAttributes = false
        randomDinner_left.keyboardType = UIKeyboardType.decimalPad
        randomDinner_left.borderStyle = .line
        randomDinner_left.textAlignment = .center
        randomDinner_left.textColor = TextColor
        randomDinner_left.layer.borderColor = UIColor.white.cgColor
        randomDinner_left.layer.borderWidth = 1
        return randomDinner_left
    }()
    lazy var randomDinner_right:UITextField = {
        let randomDinner_right = UITextField()
        randomDinner_right.font = UIFont.systemFont(ofSize: 14)
        randomDinner_right.allowsEditingTextAttributes = false
        randomDinner_right.keyboardType = UIKeyboardType.decimalPad
        randomDinner_right.borderStyle = .line
        randomDinner_right.textAlignment = .center
        randomDinner_right.textColor = TextColor
        randomDinner_right.layer.borderColor = UIColor.white.cgColor
        randomDinner_right.layer.borderWidth = 1
        return randomDinner_right
    }()
    lazy var randomUnit_label:UILabel = {
        let randomUnit_label = UILabel(frame: CGRect())
        randomUnit_label.font = UIFont.systemFont(ofSize: 14)
        randomUnit_label.textColor = TextColor
        self.view.addSubview(randomUnit_label)
        return randomUnit_label
    }()
    
    //保存和恢复默认设置按钮
    lazy var saveBlood:UIButton = {
        let saveBlood = UIButton(type:.system)
        saveBlood.backgroundColor = ButtonColor
        saveBlood.setTitle("Save", for:.normal)
        saveBlood.tintColor = UIColor.white
        saveBlood.titleLabel?.font = UIFont.systemFont(ofSize:18)
        saveBlood.titleLabel?.textColor = UIColor.white
        return saveBlood
    }()
    
    lazy var recoverBlood:UIButton = {
        let recoverBlood = UIButton(type:.system)
        recoverBlood.backgroundColor = ThemeColor
        recoverBlood.setTitle("Default Settings", for:.normal)
        recoverBlood.tintColor = UIColor.init(red: 28/255.0, green: 97/255.0, blue: 157/255.0, alpha: 0)
        recoverBlood.titleLabel?.font = UIFont.systemFont(ofSize:18)
        recoverBlood.titleLabel?.textColor = UIColor.white
        recoverBlood.layer.borderWidth = 0.5
        recoverBlood.layer.borderColor = UIColor.init(red: 28/255.0, green: 97/255.0, blue: 157/255.0, alpha: 1).cgColor
        return recoverBlood
    }()
   
    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }() /*****************************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置点击屏幕键盘弹回
        hideKeyboardWhenTappedAround()
        self.view.backgroundColor = UIColor.clear
        self.title = "Targets Setting"
        // Do any additional setup after loading the view.
//        self.view.backgroundColor = ThemeColor
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let information = UILabel(frame: CGRect())
        information.text = "BG Targets"
        information.textAlignment = .center
        information.textColor = TextColor
        information.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(information)
        information.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/15)
            make.width.equalTo(AJScreenWidth)
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(1)
        }
        
        
        //空腹
        let emptyStomach_label = UILabel(frame: CGRect())
        emptyStomach_label.text = "Fasting"
        emptyStomach_label.font = UIFont.systemFont(ofSize: 14)
        emptyStomach_label.textColor = UITITLEColor
        //            emptyStomach_label.backgroundColor = UIColor.red
        self.view.addSubview(emptyStomach_label)
        emptyStomach_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/6)
            make.left.equalTo(AJScreenWidth/5)
            make.top.equalTo(information.snp.bottom).offset(AJScreenWidth/12)
        }
        
        //空腹左侧输入框
        emptyStomach_left.delegate = self
        self.view.addSubview(emptyStomach_left)
        emptyStomach_left.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/6)
            make.left.equalTo(AJScreenWidth/5)
            make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
        }
        
        let emptyMark_label = UILabel(frame: CGRect())
        emptyMark_label.text = "---"
        emptyMark_label.textColor = UIColor.white
        emptyMark_label.font = UIFont.systemFont(ofSize: 14)
        emptyMark_label.textAlignment = .center
        self.view.addSubview(emptyMark_label)
        emptyMark_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/8)
            make.left.equalTo(emptyStomach_left.snp.right).offset(AJScreenWidth/25)
            make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
        }
        
        //空腹右侧输入框
        emptyStomach_right.delegate = self
        self.view.addSubview(emptyStomach_right)
        emptyStomach_right.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/6)
            make.left.equalTo(emptyMark_label.snp.right).offset(AJScreenWidth/25)
            make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
        }
        
        //空腹的单位标签
        
        self.view.addSubview(emptyUnit_label)
        emptyUnit_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/5)
            make.left.equalTo(emptyStomach_right.snp.right).offset(10)
            make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
        }
        /* 空腹结束 */
        
        /* 餐前开始 */
        let beforeDinner_label = UILabel(frame: CGRect())
        beforeDinner_label.text = "Before Meal"
        beforeDinner_label.textColor = UITITLEColor
        beforeDinner_label.font = UIFont.systemFont(ofSize: 14)
        //        email_label.backgroundColor = UIColor.red
        self.view.addSubview(beforeDinner_label)
        beforeDinner_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/4)
            make.left.equalTo(AJScreenWidth/5)
            make.top.equalTo(emptyStomach_left.snp.bottom).offset(5)
        }
        
        beforeDinner_left.delegate = self
        self.view.addSubview(beforeDinner_left)
        beforeDinner_left.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/6)
            make.left.equalTo(AJScreenWidth/5)
            make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
        }
        
        let beforeMark_label = UILabel(frame: CGRect())
        beforeMark_label.text = "---"
        beforeMark_label.textColor = UIColor.white
        beforeMark_label.font = UIFont.systemFont(ofSize: 14)
        //        email_label.backgroundColor = UIColor.red
        beforeMark_label.textAlignment = .center
        self.view.addSubview(beforeMark_label)
        beforeMark_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/8)
            make.left.equalTo(beforeDinner_left.snp.right).offset(AJScreenWidth/25)
            make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
        }
        
        beforeDinner_right.delegate = self
        self.view.addSubview(beforeDinner_right)
        beforeDinner_right.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/6)
            make.left.equalTo(beforeMark_label.snp.right).offset(AJScreenWidth/25)
            make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
        }
        
        
        self.view.addSubview(beforeUnit_label)
        beforeUnit_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/5)
            make.left.equalTo(beforeDinner_right.snp.right).offset(10)
            make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
        }
        /* 餐前结束 */
        /* 餐后开始 */
        let afterDinner_label = UILabel(frame: CGRect())
        afterDinner_label.text = "After Meal"
        afterDinner_label.textColor = UITITLEColor
        afterDinner_label.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(afterDinner_label)
        afterDinner_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/4)
            make.left.equalTo(AJScreenWidth/5)
            make.top.equalTo(beforeDinner_left.snp.bottom).offset(5)
        }
        
        afterDinner_left.delegate = self
        self.view.addSubview(afterDinner_left)
        afterDinner_left.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/6)
            make.left.equalTo(AJScreenWidth/5)
            make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
        }
        
        let afterMark_label = UILabel(frame: CGRect())
        afterMark_label.text = "---"
        afterMark_label.textColor = UIColor.white
        afterMark_label.font = UIFont.systemFont(ofSize: 14)
        afterMark_label.textAlignment = .center
        //email_label.backgroundColor = UIColor.red
        self.view.addSubview(afterMark_label)
        afterMark_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/8)
            make.left.equalTo(afterDinner_left.snp.right).offset(AJScreenWidth/25)
            make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
        }
        
        afterDinner_right.delegate = self
        self.view.addSubview(afterDinner_right)
        afterDinner_right.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/6)
            make.left.equalTo(afterMark_label.snp.right).offset(AJScreenWidth/25)
            make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
        }
        
        
        self.view.addSubview(afterUnit_label)
        afterUnit_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/5)
            make.left.equalTo(afterDinner_right.snp.right).offset(10)
            make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
        }
        
        /* 餐后结束 */
        
        /* 随机开始 */
        let randomDinner_label = UILabel(frame: CGRect())
        randomDinner_label.text = "Random"
        randomDinner_label.textColor = UITITLEColor
        randomDinner_label.font = UIFont.systemFont(ofSize: 14)
        randomUnit_label.textColor = TextColor
        self.view.addSubview(randomDinner_label)
        randomDinner_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenWidth/15)
            make.width.equalTo(AJScreenWidth/4)
            make.left.equalTo(AJScreenWidth/5)
            make.top.equalTo(afterDinner_left.snp.bottom).offset(5)
        }
        
        randomDinner_left.delegate = self
        self.view.addSubview(randomDinner_left)
        randomDinner_left.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/6)
            make.left.equalTo(AJScreenWidth/5)
            make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
        }
        
        let randomMark_label = UILabel(frame: CGRect())
        randomMark_label.text = "---"
        randomMark_label.textColor = UIColor.white
        randomMark_label.font = UIFont.systemFont(ofSize: 14)
        randomMark_label.textAlignment = .center
        //        email_label.backgroundColor = UIColor.red
        self.view.addSubview(randomMark_label)
        randomMark_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/8)
            make.left.equalTo(randomDinner_left.snp.right).offset(AJScreenWidth/25)
            make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
        }
        
        emptyStomach_right.delegate = self
        self.view.addSubview(randomDinner_right)
        randomDinner_right.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/6)
            make.left.equalTo(randomMark_label.snp.right).offset(AJScreenWidth/25)
            make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
        }
        
        
        randomUnit_label.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/25)
            make.width.equalTo(AJScreenWidth/5)
            make.left.equalTo(randomDinner_right.snp.right).offset(10)
            make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
        }
        
        /* 随机结束 */
        
        /*保存按钮*/
        
        saveBlood.addTarget(self, action: #selector(save), for: .touchUpInside)
        self.view.addSubview(saveBlood)
        saveBlood.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenWidth/10)
            //                make.width.equalTo(AJScreenWidth*3/5)
            make.top.equalTo(randomDinner_left.snp.bottom).offset(AJScreenWidth/5)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
        }
        
        /*恢复默认设置按钮*/
        
        recoverBlood.addTarget(self, action: #selector(recover), for: .touchUpInside)
        self.view.addSubview(recoverBlood)
        recoverBlood.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenWidth/10)
            //                make.width.equalTo(AJScreenWidth*3/5)
            make.top.equalTo(saveBlood.snp.bottom).offset(AJScreenWidth/10)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
        }
    }
    //视图将要出现时，调用这个方法
    override func viewWillAppear(_ animated: Bool) {
        
        //这个是加载用户血糖单位设置信息
        //let unit_path = Bundle.main.path(forResource: "UnitSetting", ofType: "plist")
        let unit_path = PlistSetting.getFilePath(File: "UnitSetting.plist")
        let unit_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_path)!
        let unit = unit_data["BloodUnit"]! as! String
        print(unit)
        //设置用户的显示单位
        setLabelUnit(unit: unit)
        //清空用户的输入
        clearEmpty()
        
        /*血糖显示*/
        //加载mmol/l单位数值文件
        let user_path = PlistSetting.getFilePath(File: "userBloodSetting.plist")
        let user_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: user_path)!
        //加载mg/dl单位数值文件
        let user_mgdl_path = PlistSetting.getFilePath(File: "userBloodSettingMgdl.plist")
        let user_mgdl_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: user_mgdl_path)!
        //这些数据都是小单位的数据mmol\L  带一位小数点
        let a_Double:Double = Double(((user_data["emptyStomachLowLimit"] as? NSNumber)?.stringValue)!)!
        let b_Double:Double = Double(((user_data["emptyStomachHighLimit"] as? NSNumber)?.stringValue)!)!
        let c_Double:Double = Double(((user_data["beforeDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let d_Double:Double = Double(((user_data["beforeDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        let e_Double:Double = Double(((user_data["afterDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let f_Double:Double = Double(((user_data["afterDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        let g_Double:Double = Double(((user_data["randomDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let h_Double:Double = Double(((user_data["randomDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
      
        //大单位数据mg/dl    三位整数
        let amg_Double:Int = Int(((user_mgdl_data["emptyStomachLowLimit"] as? NSNumber)?.stringValue)!)!
        let bmg_Double:Int = Int(((user_mgdl_data["emptyStomachHighLimit"] as? NSNumber)?.stringValue)!)!
        let cmg_Double:Int = Int(((user_mgdl_data["beforeDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let dmg_Double:Int = Int(((user_mgdl_data["beforeDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        let emg_Double:Int = Int(((user_mgdl_data["afterDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let fmg_Double:Int = Int(((user_mgdl_data["afterDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        let gmg_Double:Int = Int(((user_mgdl_data["randomDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let hmg_Double:Int = Int(((user_mgdl_data["randomDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        
        //  /* 设置显示过程,显示用户设置的值 */
        //根据 unit加载到的单位，来显示值
        if unit == "mmol/L"{
            showPlaceholder(String(a_Double),String(b_Double),String(c_Double),String(d_Double),String(e_Double),String(f_Double),String(g_Double),String(h_Double))
        }else{
            //当单位为mg/dL
            showPlaceholder(String(amg_Double),String(bmg_Double),String(cmg_Double),String(dmg_Double),String(emg_Double),String(fmg_Double),String(gmg_Double),String(hmg_Double))
        }
    }
    
    //返回的时候，将框框再重新设回白色
    @objc private func leftButtonClick(){
        setBoundWhite()
        self.navigationController?.popViewController(animated: false)
    }
    
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

    
    /*
     用户按下保存键
     */
    
    @objc private func save(){
        let alert = CustomAlertController()
        //读取用户单位设置文件。
        let unit_path = PlistSetting.getFilePath(File: "UnitSetting.plist")
        let unit_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_path)!
        let unit_String = unit_data["BloodUnit"]! as! String
        //加载mmol/l
        let save_path = PlistSetting.getFilePath(File: "userBloodSetting.plist")
        let save_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_path)!
        
        //加载mg/dl
        let save_mgdl_path = PlistSetting.getFilePath(File: "userBloodSettingMgdl.plist")
        let save_mgdl_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_mgdl_path)!
        
        //思路：先判断是什么单位，然后从对应的文件中，去获取到对应的数据显示。
        if unit_String == "mmol/L"{
            emptyStomach_left_number  = save_data["emptyStomachLowLimit"]  as? NSNumber
            emptyStomach_right_number = save_data["emptyStomachHighLimit"] as? NSNumber
            beforeDinner_left_number  = save_data["beforeDinnerLowLimit"] as? NSNumber
            beforeDinner_right_number = save_data["beforeDinnerHighLimit"] as? NSNumber
            afterDinner_left_number   = save_data["afterDinnerLowLimit"] as? NSNumber
            afterDinner_right_number  = save_data["afterDinnerHighLimit"] as? NSNumber
            randomDinner_left_number  = save_data["randomDinnerLowLimit"] as? NSNumber
            randomDinner_right_number = save_data["randomDinnerHighLimit"] as? NSNumber
        }else{
            emptyStomach_left_number  = save_mgdl_data["emptyStomachLowLimit"]  as? NSNumber
            emptyStomach_right_number = save_mgdl_data["emptyStomachHighLimit"] as? NSNumber
            beforeDinner_left_number  = save_mgdl_data["beforeDinnerLowLimit"] as? NSNumber
            beforeDinner_right_number = save_mgdl_data["beforeDinnerHighLimit"] as? NSNumber
            afterDinner_left_number   = save_mgdl_data["afterDinnerLowLimit"] as? NSNumber
            afterDinner_right_number  = save_mgdl_data["afterDinnerHighLimit"] as? NSNumber
            randomDinner_left_number  = save_mgdl_data["randomDinnerLowLimit"] as? NSNumber
            randomDinner_right_number = save_mgdl_data["randomDinnerHighLimit"] as? NSNumber
        }

        //校验用户输入的正确性,a,b等都是个过度值，所有命名较为随意
        /*
         注：在获取用户输入的过程中，还需要判断用户是否输入：分为只输入一部分，或者全部输入。
         所以在这之前需要做个判空操作
         
         不论是什么单位的文件，在写入一个文件中，另一个文件也需要写入。
         */
        
        //mmol\L的输入限制
        if unit_String == "mmol/L"{
            //空腹
            //获得用户缺省值的下限
            var a:Double = Double(((save_data["emptyStomachLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("空腹下限值",a)
            if self.emptyStomach_left.text! != ""{
                //判断是否为非法输入
//                if FormatMethodUtil.validateBloodNumber(number: self.emptyStomach_left.text!) == true{
                    a = Double(self.emptyStomach_left.text!)!
                    if a <= 7.8 && a >= 3.3{
                        print("用户的输入",a)
                        emptyStomach_left_number = a as NSNumber
                        save_data.setObject(emptyStomach_left_number as Any, forKey: "emptyStomachLowLimit" as NSCopying)
                        //还需要将值转化一份，存入到mg/dl的文件中
                        let another = UnitConversion.mmTomg(num: emptyStomach_left_number as! Double)
                        save_mgdl_data.setObject(another as Any, forKey: "emptyStomachLowLimit" as NSCopying)
                        print(type(of: self.emptyStomach_left_number))
                    }else{
                        emptyStomach_left.layer.borderColor = UIColor.red.cgColor
                        emptyStomach_left.layer.borderWidth = 1
                    }
            }else{
                //用户啥也没输入
                print("空腹下限啥事也没干")
            }
            
            var b:Double = Double(((save_data["emptyStomachHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("空腹上限值",b)
            if self.emptyStomach_right.text! != ""{
                    b = Double(self.emptyStomach_right.text!)!
                    if b <= 16.6 && b >= 5.0 && b > a{  //注：上限的值必须大于下限
                        emptyStomach_right_number = b as NSNumber
                        save_data.setObject(emptyStomach_right_number as Any, forKey: "emptyStomachHighLimit" as NSCopying)
                        //还需要将值转化一份，存入到mg/dl的文件中
                        let another = UnitConversion.mmTomg(num: emptyStomach_right_number as! Double)
                        save_mgdl_data.setObject(another as Any, forKey: "emptyStomachHighLimit" as NSCopying)
                    }else{
                        emptyStomach_right.layer.borderColor = UIColor.red.cgColor
                        emptyStomach_right.layer.borderWidth = 1
                    }
            }else{
                print("空腹上限啥事也没干")
            }
            //餐前
            var c:Double = Double(((save_data["beforeDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐前下限值",c)
            if self.beforeDinner_left.text! != ""{
                //判断是否为非法输入
                    c = Double(self.beforeDinner_left.text!)!
                    if c <= 7.8 && c >= 3.3{
                        print("用户的输入",c)
                        beforeDinner_left_number = c as NSNumber
                        save_data.setObject(beforeDinner_left_number as Any, forKey: "beforeDinnerLowLimit" as NSCopying)
                        //还需要将值转化一份，存入到mg/dl的文件中
                        let another = UnitConversion.mmTomg(num: beforeDinner_left_number as! Double)
                        save_mgdl_data.setObject(another as Any, forKey: "beforeDinnerLowLimit" as NSCopying)
                        print(type(of: beforeDinner_left_number))
                    }else{
                        beforeDinner_left.layer.borderColor = UIColor.red.cgColor
                        beforeDinner_left.layer.borderWidth = 1
                    }
            }else{
                print("餐前下限啥事也没干")
            }
            
            var d:Double = Double(((save_data["beforeDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐前上限值",d)
            if self.beforeDinner_right.text! != ""{
                //判断是否为非法输入
                    d = Double(self.beforeDinner_right.text!)!
                    if d <= 16.6 && d >= 5.0 && d > c{
                        print("用户的输入",d)
                        beforeDinner_right_number = d as NSNumber
                        save_data.setObject(beforeDinner_right_number as Any, forKey: "beforeDinnerHighLimit" as NSCopying)
                        //还需要将值转化一份，存入到mg/dl的文件中
                        let another = UnitConversion.mmTomg(num: beforeDinner_right_number as! Double)
                        save_mgdl_data.setObject(another as Any, forKey: "beforeDinnerHighLimit" as NSCopying)
                        print(type(of: beforeDinner_right_number))
                    }else{
                        beforeDinner_right.layer.borderColor = UIColor.red.cgColor
                        beforeDinner_right.layer.borderWidth = 1
                    }
            }else{
                print("餐前上限啥事也没干")
            }
            
            //餐后
            var e:Double = Double(((save_data["afterDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐后下限值",e)
            if self.afterDinner_left.text! != ""{
                //判断是否为非法输入
                    e = Double(self.afterDinner_left.text!)!
                    if e <= 7.8 && e >= 3.3{
                        print("用户的输入",e)
                        afterDinner_left_number = e as NSNumber
                        save_data.setObject(afterDinner_left_number as Any, forKey: "afterDinnerLowLimit" as NSCopying)
                        //还需要将值转化一份，存入到mg/dl的文件中
                        let another = UnitConversion.mmTomg(num: afterDinner_left_number as! Double)
                        save_mgdl_data.setObject(another as Any, forKey: "afterDinnerLowLimit" as NSCopying)
                        print(type(of: afterDinner_left_number))
                    }else{
                        afterDinner_left.layer.borderColor = UIColor.red.cgColor
                        afterDinner_left.layer.borderWidth = 1
                    }
            }else{
                print("餐后下限啥事也没干")
            }
            
            var f:Double = Double(((save_data["afterDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐后上限值",f)
            if self.afterDinner_right.text! != ""{
                //判断是否为非法输入
                    f = Double(self.afterDinner_right.text!)!
                    if f <= 16.6 && f >= 5.0 && f > e{
                        print("用户的输入",f)
                        afterDinner_right_number = f as NSNumber
                        save_data.setObject(afterDinner_right_number as Any, forKey: "afterDinnerHighLimit" as NSCopying)
                        //还需要将值转化一份，存入到mg/dl的文件中
                        let another = UnitConversion.mmTomg(num: afterDinner_right_number as! Double)
                        save_mgdl_data.setObject(another as Any, forKey: "afterDinnerHighLimit" as NSCopying)
                        print(type(of: afterDinner_right_number))
                    }else{
                        afterDinner_right.layer.borderColor = UIColor.red.cgColor
                        afterDinner_right.layer.borderWidth = 1
                    }
            }else{
                print("餐后上限啥事也没干")
            }
            //随机
            var g:Double = Double(((save_data["randomDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("随机下限值",g)
            if self.randomDinner_left.text! != ""{
                //判断是否为非法输入
                    g = Double(self.randomDinner_left.text!)!
                    if g <= 7.8 && g >= 3.3{
                        print("用户的输入",g)
                        randomDinner_left_number = g as NSNumber
                        save_data.setObject(randomDinner_left_number as Any, forKey: "randomDinnerLowLimit" as NSCopying)
                        //还需要将值转化一份，存入到mg/dl的文件中
                        let another = UnitConversion.mmTomg(num: randomDinner_left_number as! Double)
                        save_mgdl_data.setObject(another as Any, forKey: "randomDinnerLowLimit" as NSCopying)
                        print(type(of: randomDinner_left_number))
                    }else{
                        randomDinner_left.layer.borderColor = UIColor.red.cgColor
                        randomDinner_left.layer.borderWidth = 1
                    }
            }else{
                print("随机下限啥事也没干")
            }
            
            
            var h:Double = Double(((save_data["randomDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("随机上限值",h)
            if self.randomDinner_right.text! != ""{
                //判断是否为非法输入
                    h = Double(self.randomDinner_right.text!)!
                    if h <= 16.6 && h >= 5.0 && h > g{
                        print("用户的输入",h)
                        randomDinner_right_number = h as NSNumber
                        save_data.setObject(randomDinner_right_number as Any, forKey: "randomDinnerHighLimit" as NSCopying)
                        //还需要将值转化一份，存入到mg/dl的文件中
                        let another = UnitConversion.mmTomg(num: randomDinner_right_number as! Double)
                        save_mgdl_data.setObject(another as Any, forKey: "randomDinnerHighLimit" as NSCopying)
                        print(type(of: randomDinner_right_number))
                    }else{
                        randomDinner_right.layer.borderColor = UIColor.red.cgColor
                        randomDinner_right.layer.borderWidth = 1
                    }
            }else{
                print("随机上限啥事也没干")
            }
            
            //第二步，保存写入userBloodSetting.plist文件中
            save_data.write(toFile: save_path, atomically: true)
            save_mgdl_data.write(toFile: save_mgdl_path, atomically: true)
            //第三步，重新从文件中取数据，修改显示uitextField的placeholder的属性
            /* 设置显示过程 */
            let a_Double:Double = Double(((save_data["emptyStomachLowLimit"] as? NSNumber)?.stringValue)!)!
            let b_Double:Double = Double(((save_data["emptyStomachHighLimit"] as? NSNumber)?.stringValue)!)!
            let c_Double:Double = Double(((save_data["beforeDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
            let d_Double:Double = Double(((save_data["beforeDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
            let e_Double:Double = Double(((save_data["afterDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
            let f_Double:Double = Double(((save_data["afterDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
            let g_Double:Double = Double(((save_data["randomDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
            let h_Double:Double = Double(((save_data["randomDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
            showPlaceholder(String(a_Double),String(b_Double),String(c_Double),String(d_Double),String(e_Double),String(f_Double),String(g_Double),String(h_Double))
            clearEmpty()
            
            
            
        }else{  //此单位为mg/dL
            //空腹
            //获得用户缺省值的下限
            var a:Double = Double(((save_data["emptyStomachLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("mg空腹下限值",a)
            if self.emptyStomach_left.text! != ""{
                //判断是否为非法输入
                    a = Double(self.emptyStomach_left.text!)!
                    if a <= 140 && a >= 60{
                        print("用户的输入",a)
                        //把得到mg/dL单位的数据转化为mmol/L单位的数据，然后存入到文件中
                        save_mgdl_data.setObject(a as NSNumber as Any, forKey: "emptyStomachLowLimit" as NSCopying)
                        a = UnitConversion.mgTomm(num: a)
                        emptyStomach_left_number = a as NSNumber
                        save_data.setObject(emptyStomach_left_number as Any, forKey: "emptyStomachLowLimit" as NSCopying)
                    }else{
                        emptyStomach_left.layer.borderColor = UIColor.red.cgColor
                        emptyStomach_left.layer.borderWidth = 1
                    }
            }else{
                print("空腹下限啥事也没干")
            }
            
            var b:Double = Double(((save_data["emptyStomachHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("mg空腹上限值",b)
            if self.emptyStomach_right.text! != ""{
                    b = Double(self.emptyStomach_right.text!)!
                    if b <= 300 && b >= 90 && b > a{  //注：上限的值必须大于下限
                        save_mgdl_data.setObject(b as NSNumber as Any, forKey: "emptyStomachHighLimit" as NSCopying)
                        b = UnitConversion.mgTomm(num: b)
                        emptyStomach_right_number = b as NSNumber
                        save_data.setObject(emptyStomach_right_number as Any, forKey: "emptyStomachHighLimit" as NSCopying)
                    }else{
                        emptyStomach_right.layer.borderColor = UIColor.red.cgColor
                        emptyStomach_right.layer.borderWidth = 1
                        alert.custom(self, "Attention", "空腹血糖上限限范围为90--300")
                    }
            }else{
                print("mg空腹上限啥事也没干")
            }
            //餐前
            var c:Double = Double(((save_data["beforeDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐前下限值",c)
            if self.beforeDinner_left.text! != ""{
                //判断是否为非法输入
                    c = Double(self.beforeDinner_left.text!)!
                    if c <= 140 && c >= 60{
                        print("用户的输入",c)
                        save_mgdl_data.setObject(c as NSNumber as Any, forKey: "beforeDinnerLowLimit" as NSCopying)
                        c = UnitConversion.mgTomm(num: c)
                        beforeDinner_left_number = c as NSNumber
                        save_data.setObject(beforeDinner_left_number as Any, forKey: "beforeDinnerLowLimit" as NSCopying)
                        print(type(of: beforeDinner_left_number))
                    }else{
                        beforeDinner_left.layer.borderColor = UIColor.red.cgColor
                        beforeDinner_left.layer.borderWidth = 1
                    }
            }else{
                print("餐前下限啥事也没干")
            }
            
            var d:Double = Double(((save_data["beforeDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐前上限值",d)
            if self.beforeDinner_right.text! != ""{
                //判断是否为非法输入
//                if FormatMethodUtil.validateMgdlBloodNumber(number: self.beforeDinner_right.text!) == true{
                    d = Double(self.beforeDinner_right.text!)!
                    if d <= 300 && d >= 90 && d > c{
                        print("用户的输入",d)
                        save_mgdl_data.setObject(d  as NSNumber as Any, forKey: "beforeDinnerHighLimit" as NSCopying)
                        d = UnitConversion.mgTomm(num: d)
                        beforeDinner_right_number = d as NSNumber
                        save_data.setObject(beforeDinner_right_number as Any, forKey: "beforeDinnerHighLimit" as NSCopying)
                        print(type(of: beforeDinner_right_number))
                    }else{
                        beforeDinner_right.layer.borderColor = UIColor.red.cgColor
                        beforeDinner_right.layer.borderWidth = 1
                }
            }else{
                print("餐前上限啥事也没干")
            }
            
            //餐后
            var e:Double = Double(((save_data["afterDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐后下限值",e)
            if self.afterDinner_left.text! != ""{
                //判断是否为非法输入
                    e = Double(self.afterDinner_left.text!)!
                    if e <= 140 && e >= 60{
                        print("用户的输入",e)
                        save_mgdl_data.setObject(e as NSNumber as Any, forKey: "afterDinnerLowLimit" as NSCopying)
                        e = UnitConversion.mgTomm(num: e)
                        afterDinner_left_number = e as NSNumber
                        save_data.setObject(afterDinner_left_number as Any, forKey: "afterDinnerLowLimit" as NSCopying)
                        print(type(of: afterDinner_left_number))
                    }else{
                        afterDinner_left.layer.borderColor = UIColor.red.cgColor
                        afterDinner_left.layer.borderWidth = 1
                    }
            }else{
                print("餐后下限啥事也没干")
            }
            
            var f:Double = Double(((save_data["afterDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐后上限值",f)
            if self.afterDinner_right.text! != ""{
                //判断是否为非法输入
                    f = Double(self.afterDinner_right.text!)!
                    if f <= 300 && f >= 90 && f > e{
                        print("用户的输入",f)
                        save_mgdl_data.setObject(f as NSNumber as Any, forKey: "afterDinnerHighLimit" as NSCopying)
                        f = UnitConversion.mgTomm(num: f)
                        afterDinner_right_number = f as NSNumber
                        save_data.setObject(afterDinner_right_number as Any, forKey: "afterDinnerHighLimit" as NSCopying)
                        print(type(of: afterDinner_right_number))
                    }else{
                        afterDinner_right.layer.borderColor = UIColor.red.cgColor
                        afterDinner_right.layer.borderWidth = 1
                    }
            }else{
                print("餐后上限啥事也没干")
            }
            //随机
            var g:Double = Double(((save_data["randomDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("随机下限值",g)
            if self.randomDinner_left.text! != ""{
                //判断是否为非法输入
                    g = Double(self.randomDinner_left.text!)!
                    if g <= 140 && g >= 60{
                        print("用户的输入",g)
                        save_mgdl_data.setObject(g as NSNumber as Any, forKey: "randomDinnerLowLimit" as NSCopying)
                        g = UnitConversion.mgTomm(num: g)
                        randomDinner_left_number = g as NSNumber
                        save_data.setObject(randomDinner_left_number as Any, forKey: "randomDinnerLowLimit" as NSCopying)
                        print(type(of: randomDinner_left_number))
                    }else{
                        randomDinner_left.layer.borderColor = UIColor.red.cgColor
                        randomDinner_left.layer.borderWidth = 1
                    }
            }else{
                print("随机下限啥事也没干")
            }
            
            
            var h:Double = Double(((save_data["randomDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("随机上限值",h)
            if self.randomDinner_right.text! != ""{
                //判断是否为非法输入
                    h = Double(self.randomDinner_right.text!)!
                    if h <= 300 && h >= 90 && h > g{
                        print("用户的输入",h)
                        save_mgdl_data.setObject(h as NSNumber as Any, forKey: "randomDinnerHighLimit" as NSCopying)
                        h = UnitConversion.mgTomm(num: h)
                        randomDinner_right_number = h as NSNumber
                        save_data.setObject(randomDinner_right_number as Any, forKey: "randomDinnerHighLimit" as NSCopying)
                        print(type(of: randomDinner_right_number))
                    }else{
                        randomDinner_right.layer.borderColor = UIColor.red.cgColor
                        randomDinner_right.layer.borderWidth = 1
                    }
            }else{
                print("随机上限啥事也没干")
            }
            
            
            //结果写入文件中,两个单位的都要存
            save_data.write(toFile: save_path, atomically: true)
            save_mgdl_data.write(toFile: save_mgdl_path, atomically: true)
            //取出来的为，mg/dL类型的数据
            let a_Int:Int = Int(((save_mgdl_data["emptyStomachLowLimit"] as? NSNumber)?.stringValue)!)!
            let b_Int:Int = Int(((save_mgdl_data["emptyStomachHighLimit"] as? NSNumber)?.stringValue)!)!
            let c_Int:Int = Int(((save_mgdl_data["beforeDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
            let d_Int:Int = Int(((save_mgdl_data["beforeDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
            let e_Int:Int = Int(((save_mgdl_data["afterDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
            let f_Int:Int = Int(((save_mgdl_data["afterDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
            let g_Int:Int = Int(((save_mgdl_data["randomDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
            let h_Int:Int = Int(((save_mgdl_data["randomDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
            
            showPlaceholder(String(a_Int),String(b_Int),String(c_Int),String(d_Int),String(e_Int),String(f_Int),String(g_Int),String(h_Int))
            clearEmpty()
        } //end of mg/dl
    }
    
    //恢复默认设置的按钮
    /*
     做法：设置成两个plist文件，每次按下恢复按钮，就会把默认文件defalutBloodSetting的信息，覆盖到userBloodSetting的文件中。
     每次修改都是对userBloodSetting的文件中。
     */
    
    @objc private func recover(){
        setBoundWhite()
        /*加载缺省的上下限设置文件信息   mmol/l文件
           是加载用户设置血糖上下限信息 */
        let path_default = Bundle.main.path(forResource: "defaultBloodSetting", ofType: "plist")
        let data_default:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path_default!)!
        let path_user = PlistSetting.getFilePath(File: "userBloodSetting.plist")
        let data_user:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path_user)!
        
        /*加载缺省的上下限设置文件信息   mg/dl文件
         是加载用户设置血糖上下限信息 */
        let path_mgdl_default = Bundle.main.path(forResource: "defaultBloodSettingMgdl", ofType: "plist")
        let data_mgdl_default:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path_mgdl_default!)!
        let path_mgdl_user = PlistSetting.getFilePath(File: "userBloodSettingMgdl.plist")
        let data_mgdl_user:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path_mgdl_user)!
        //读取单位
        let unit_path = PlistSetting.getFilePath(File: "UnitSetting.plist")
        let unit_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_path)!
        let unit = unit_data["BloodUnit"]! as! String
        
        //mmol/l覆盖过程
        //空腹覆盖过程
        data_user["emptyStomachLowLimit"]  = data_default["emptyStomachLowLimit"]
        data_user["emptyStomachHighLimit"] = data_default["emptyStomachHighLimit"]
        //餐前覆盖过程
        data_user["beforeDinnerLowLimit"]  = data_default["beforeDinnerLowLimit"]
        data_user["beforeDinnerHighLimit"] = data_default["beforeDinnerHighLimit"]
        //餐后覆盖过程
        data_user["afterDinnerLowLimit"]  = data_default["afterDinnerLowLimit"]
        data_user["afterDinnerHighLimit"] = data_default["afterDinnerHighLimit"]
        //随机覆盖过程
        data_user["randomDinnerLowLimit"]  = data_default["randomDinnerLowLimit"]
        data_user["randomDinnerHighLimit"] = data_default["randomDinnerHighLimit"]
        data_user.write(toFile: path_user, atomically: true)
        
        //mg/dl覆盖过程
        //空腹覆盖过程
        data_mgdl_user["emptyStomachLowLimit"]  = data_mgdl_default["emptyStomachLowLimit"]
        data_mgdl_user["emptyStomachHighLimit"] = data_mgdl_default["emptyStomachHighLimit"]
        //餐前覆盖过程
        data_mgdl_user["beforeDinnerLowLimit"]  = data_mgdl_default["beforeDinnerLowLimit"]
        data_mgdl_user["beforeDinnerHighLimit"] = data_mgdl_default["beforeDinnerHighLimit"]
        //餐后覆盖过程
        data_mgdl_user["afterDinnerLowLimit"]  = data_mgdl_default["afterDinnerLowLimit"]
        data_mgdl_user["afterDinnerHighLimit"] = data_mgdl_default["afterDinnerHighLimit"]
        //随机覆盖过程
        data_mgdl_user["randomDinnerLowLimit"]  = data_mgdl_default["randomDinnerLowLimit"]
        data_mgdl_user["randomDinnerHighLimit"] = data_mgdl_default["randomDinnerHighLimit"]
        data_mgdl_user.write(toFile: path_mgdl_user, atomically: true)
        
        let a_Double:Double = Double(((data_user["emptyStomachLowLimit"] as? NSNumber)?.stringValue)!)!
        let b_Double:Double = Double(((data_user["emptyStomachHighLimit"] as? NSNumber)?.stringValue)!)!
        let c_Double:Double = Double(((data_user["beforeDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let d_Double:Double = Double(((data_user["beforeDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        let e_Double:Double = Double(((data_user["afterDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let f_Double:Double = Double(((data_user["afterDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        let g_Double:Double = Double(((data_user["randomDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let h_Double:Double = Double(((data_user["randomDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        
        //大单位数据mg/dl
        let amg_Double:Int = Int(((data_mgdl_user["emptyStomachLowLimit"] as? NSNumber)?.stringValue)!)!
        let bmg_Double:Int = Int(((data_mgdl_user["emptyStomachHighLimit"] as? NSNumber)?.stringValue)!)!
        let cmg_Double:Int = Int(((data_mgdl_user["beforeDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let dmg_Double:Int = Int(((data_mgdl_user["beforeDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        let emg_Double:Int = Int(((data_mgdl_user["afterDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let fmg_Double:Int = Int(((data_mgdl_user["afterDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        let gmg_Double:Int = Int(((data_mgdl_user["randomDinnerLowLimit"] as? NSNumber)?.stringValue)!)!
        let hmg_Double:Int = Int(((data_mgdl_user["randomDinnerHighLimit"] as? NSNumber)?.stringValue)!)!
        
        if unit == "mmol/L"{
            showPlaceholder(String(a_Double),String(b_Double),String(c_Double),String(d_Double),String(e_Double),String(f_Double),String(g_Double),String(h_Double))
        }else{
            //当单位为mg/dL
            showPlaceholder(String(amg_Double),String(bmg_Double),String(cmg_Double),String(dmg_Double),String(emg_Double),String(fmg_Double),String(gmg_Double),String(hmg_Double))
        }
       
    }
    //函数功能：清空用户在文本框中的输入
    func clearEmpty(){
        emptyStomach_left.text  = ""
        emptyStomach_right.text = ""
        beforeDinner_left.text  = ""
        beforeDinner_right.text = ""
        afterDinner_left.text   = ""
        afterDinner_right.text  = ""
        randomDinner_left.text  = ""
        randomDinner_right.text = ""
    }
    //函数功能：设置Label的单位
    func setLabelUnit(unit:String){
        emptyUnit_label.text  = unit
        beforeUnit_label.text = unit
        afterUnit_label.text  = unit
        randomUnit_label.text = unit
    }
    //函数功能：无单位限制。传入多少显示多少。只显示在框中，与单位无关。设置text的placeholder显示,函数参数可匿名
    func showPlaceholder(_ a:String,_ b:String,_ c:String,_ d:String,_ e:String,_ f:String,_ g:String,_ h:String){
        let a1:NSMutableAttributedString = NSMutableAttributedString(string: a, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        emptyStomach_left.attributedPlaceholder  = a1
        let b1:NSMutableAttributedString = NSMutableAttributedString(string: b, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        emptyStomach_right.attributedPlaceholder  = b1
        let c1:NSMutableAttributedString = NSMutableAttributedString(string: c, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        beforeDinner_left.attributedPlaceholder  = c1
        let d1:NSMutableAttributedString = NSMutableAttributedString(string: d, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        beforeDinner_right.attributedPlaceholder  = d1
        let e1:NSMutableAttributedString = NSMutableAttributedString(string: e, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        afterDinner_left.attributedPlaceholder  = e1
        let f1:NSMutableAttributedString = NSMutableAttributedString(string: f, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        afterDinner_right.attributedPlaceholder  = f1
        let g1:NSMutableAttributedString = NSMutableAttributedString(string: g, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        randomDinner_left.attributedPlaceholder  = g1
        let h1:NSMutableAttributedString = NSMutableAttributedString(string: h, attributes: [NSAttributedString.Key.foregroundColor:TextColor])
        randomDinner_right.attributedPlaceholder  = h1
    }
    //当text开始被编辑时，就直接将颜色改回来
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setBoundWhite()
        return true
    }
    
    // 限制输入框的非法输入。详细用法请看 glucoseView.swift   已经限制输入框非法输入
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let testString = ".0123456789"
        let char = NSCharacterSet.init(charactersIn: testString).inverted

        let inputString = string.components(separatedBy: char).joined(separator: "")

        if string == inputString{
            //  mg/dl   60--140   90--300
        
            var numFrontDot:Int = 3
            var numAfterDot:Int = 0
            
            // mmol/L   3.0-5.8  5.0--16.6  算上小数点
            if GetUnit.getBloodUnit() == "mmol/L"{
                numFrontDot = 2
                numAfterDot = 2
            }
            let futureStr:NSMutableString = NSMutableString(string: textField.text!)
            futureStr.insert(string, at: range.location)
            var flag = 0
            var flag1 = 0
            var dotNum = 0
            var isFrontDot = true
            
            if futureStr.length >= 1{
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
                    let char = Character(UnicodeScalar(futureStr.character(at:i))!)
                    if char == "."{
                        isFrontDot = false
                        dotNum += 1
                        if dotNum > 1{
                            return false
                        }
                    }

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
        }
        else{
            return false
        }
    }
    //重新将框设为白框
    func setBoundWhite(){
        emptyStomach_left.layer.borderColor = UIColor.white.cgColor
        emptyStomach_left.layer.borderWidth = 1
        
        emptyStomach_right.layer.borderColor = UIColor.white.cgColor
        emptyStomach_right.layer.borderWidth = 1
        
        beforeDinner_left.layer.borderColor = UIColor.white.cgColor
        beforeDinner_left.layer.borderWidth = 1
        
        beforeDinner_right.layer.borderColor = UIColor.white.cgColor
        beforeDinner_right.layer.borderWidth = 1
        
        afterDinner_left.layer.borderColor = UIColor.white.cgColor
        afterDinner_left.layer.borderWidth = 1
        
        afterDinner_right.layer.borderColor = UIColor.white.cgColor
        afterDinner_right.layer.borderWidth = 1
        
        randomDinner_left.layer.borderColor = UIColor.white.cgColor
        randomDinner_left.layer.borderWidth = 1
        
        randomDinner_right.layer.borderColor = UIColor.white.cgColor
        randomDinner_right.layer.borderWidth = 1
    }
    
    
    
}
