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
    
        var emptyStomach_left_number:NSNumber?
        var emptyStomach_right_number:NSNumber?
    
        var beforeDinner_left_number:NSNumber?
        var beforeDinner_right_number:NSNumber?
    
        var afterDinner_left_number:NSNumber?
        var afterDinner_right_number:NSNumber?
    
        var randomDinner_left_number:NSNumber?
        var randomDinner_right_number:NSNumber?
    
    
       //空腹相关的全局变量
        lazy var emptyStomach_left:UITextField = {
            let emptyStomach_left = UITextField()
            emptyStomach_left.font = UIFont.systemFont(ofSize: 14)
            emptyStomach_left.allowsEditingTextAttributes = false
            emptyStomach_left.keyboardType = UIKeyboardType.decimalPad
            emptyStomach_left.borderStyle = .line
            return emptyStomach_left
        }()
    
        lazy var emptyStomach_right:UITextField = {
            let emptyStomach_right = UITextField()
            emptyStomach_right.font = UIFont.systemFont(ofSize: 14)
            emptyStomach_right.allowsEditingTextAttributes = false
            emptyStomach_right.keyboardType = UIKeyboardType.decimalPad
            emptyStomach_right.borderStyle = .line
            return emptyStomach_right
        }()

        lazy var emptyUnit_label:UILabel = {
            let emptyUnit_label = UILabel(frame: CGRect())
            emptyUnit_label.font = UIFont.systemFont(ofSize: 14)
            return emptyUnit_label
        }()
    
        //餐前相关的全局变量
        lazy var beforeDinner_left:UITextField = {
            let beforeDinner_left = UITextField()
            beforeDinner_left.font = UIFont.systemFont(ofSize: 14)
            beforeDinner_left.allowsEditingTextAttributes = false
            beforeDinner_left.keyboardType = UIKeyboardType.decimalPad
            beforeDinner_left.borderStyle = .line
            return beforeDinner_left
        }()
    
        lazy var beforeDinner_right:UITextField = {
            let beforeDinner_right = UITextField()
            beforeDinner_right.font = UIFont.systemFont(ofSize: 14)
            beforeDinner_right.allowsEditingTextAttributes = false
            beforeDinner_right.keyboardType = UIKeyboardType.decimalPad
            beforeDinner_right.borderStyle = .line
            return beforeDinner_right
        }()
    
        lazy var beforeUnit_label:UILabel = {
            let beforeUnit_label = UILabel(frame: CGRect())
            beforeUnit_label.font = UIFont.systemFont(ofSize: 14)
            return beforeUnit_label
        }()
    
        //餐后相关的全局变量
        lazy var afterDinner_left:UITextField = {
            let afterDinner_left = UITextField()
            afterDinner_left.font = UIFont.systemFont(ofSize: 14)
            afterDinner_left.allowsEditingTextAttributes = false
            afterDinner_left.keyboardType = UIKeyboardType.decimalPad
            afterDinner_left.borderStyle = .line
            return afterDinner_left
        }()
    
        lazy var afterDinner_right:UITextField = {
            let afterDinner_right = UITextField()
            afterDinner_right.font = UIFont.systemFont(ofSize: 14)
            afterDinner_right.allowsEditingTextAttributes = false
            afterDinner_right.keyboardType = UIKeyboardType.decimalPad
            afterDinner_right.borderStyle = .line
            return afterDinner_right
        }()
    
        lazy var afterUnit_label:UILabel = {
            let afterUnit_label = UILabel(frame: CGRect())
            afterUnit_label.font = UIFont.systemFont(ofSize: 14)
            return afterUnit_label
        }()

         //随机相关的全局变量
        lazy var randomDinner_left:UITextField = {
            let randomDinner_left = UITextField()
            randomDinner_left.font = UIFont.systemFont(ofSize: 14)
            randomDinner_left.allowsEditingTextAttributes = false
            randomDinner_left.keyboardType = UIKeyboardType.decimalPad
            randomDinner_left.borderStyle = .line
            return randomDinner_left
        }()
        lazy var randomDinner_right:UITextField = {
            let randomDinner_right = UITextField()
            randomDinner_right.font = UIFont.systemFont(ofSize: 14)
            randomDinner_right.allowsEditingTextAttributes = false
            randomDinner_right.keyboardType = UIKeyboardType.decimalPad
            randomDinner_right.borderStyle = .line
            return randomDinner_right
        }()
        lazy var randomUnit_label:UILabel = {
            let randomUnit_label = UILabel(frame: CGRect())
            randomUnit_label.font = UIFont.systemFont(ofSize: 14)
            self.view.addSubview(randomUnit_label)
            return randomUnit_label
        }()
    
        //保存和恢复默认设置按钮
        lazy var saveBlood:UIButton = {
            let saveBlood = UIButton(type:.system)
            saveBlood.backgroundColor = UIColor.red
            saveBlood.setTitle("保存", for:.normal)
            saveBlood.tintColor = UIColor.white
            saveBlood.layer.cornerRadius = 8
            saveBlood.layer.masksToBounds = true
            saveBlood.titleLabel?.font = UIFont.systemFont(ofSize:18)
            saveBlood.titleLabel?.textColor = UIColor.white
            return saveBlood
        }()
    
        lazy var recoverBlood:UIButton = {
            let recoverBlood = UIButton(type:.system)
            recoverBlood.backgroundColor = UIColor.red
            recoverBlood.setTitle("恢复默认设置", for:.normal)
            recoverBlood.tintColor = UIColor.white
            recoverBlood.layer.cornerRadius = 8
            recoverBlood.layer.masksToBounds = true
            recoverBlood.titleLabel?.font = UIFont.systemFont(ofSize:18)
            recoverBlood.titleLabel?.textColor = UIColor.white
            return recoverBlood
        }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "bloodsetting"
            // Do any additional setup after loading the view.
            self.view.backgroundColor = UIColor.white
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
           
            
            //空腹
            let emptyStomach_label = UILabel(frame: CGRect())
            emptyStomach_label.text = "空腹"
            emptyStomach_label.font = UIFont.systemFont(ofSize: 14)
//            emptyStomach_label.backgroundColor = UIColor.red
            self.view.addSubview(emptyStomach_label)
            emptyStomach_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth/8)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(navigationBarHeight+AJScreenWidth/10)
            }
            
            //空腹左侧输入框
            emptyStomach_left.delegate = self
            self.view.addSubview(emptyStomach_left)
            emptyStomach_left.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
            }
            
            let emptyMark_label = UILabel(frame: CGRect())
            emptyMark_label.text = "~"
            emptyMark_label.font = UIFont.systemFont(ofSize: 14)
            //        email_label.backgroundColor = UIColor.red
            self.view.addSubview(emptyMark_label)
            emptyMark_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(emptyStomach_left.snp.right).offset(AJScreenWidth/25)
                make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
            }
            
            //空腹右侧输入框
            self.view.addSubview(emptyStomach_right)
            emptyStomach_right.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(emptyStomach_left.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
            }
            
            //空腹的单位标签
       
            self.view.addSubview(emptyUnit_label)
            emptyUnit_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(emptyStomach_right.snp.right).offset(10)
                make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
            }
            /* 空腹结束 */
            
            /* 餐前开始 */
            let beforeDinner_label = UILabel(frame: CGRect())
            beforeDinner_label.text = "餐前"
            beforeDinner_label.font = UIFont.systemFont(ofSize: 14)
            //        email_label.backgroundColor = UIColor.red
            self.view.addSubview(beforeDinner_label)
            beforeDinner_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(emptyStomach_left.snp.bottom).offset(5)
            }
            
            
            self.view.addSubview(beforeDinner_left)
            beforeDinner_left.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
            }
            
            let beforeMark_label = UILabel(frame: CGRect())
            beforeMark_label.text = "~"
            beforeMark_label.font = UIFont.systemFont(ofSize: 14)
            //        email_label.backgroundColor = UIColor.red
            self.view.addSubview(beforeMark_label)
            beforeMark_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(beforeDinner_left.snp.right).offset(AJScreenWidth/25)
                make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
            }
            
          
            self.view.addSubview(beforeDinner_right)
            beforeDinner_right.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(beforeDinner_left.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
            }
            

            self.view.addSubview(beforeUnit_label)
            beforeUnit_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(beforeDinner_right.snp.right).offset(10)
                make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
            }
            /* 餐前结束 */
            /* 餐后开始 */
            let afterDinner_label = UILabel(frame: CGRect())
            afterDinner_label.text = "餐后"
            afterDinner_label.font = UIFont.systemFont(ofSize: 14)
            self.view.addSubview(afterDinner_label)
            afterDinner_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(beforeDinner_left.snp.bottom).offset(5)
            }
            
           
            self.view.addSubview(afterDinner_left)
            afterDinner_left.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
            }
            
            let afterMark_label = UILabel(frame: CGRect())
            afterMark_label.text = "~"
            afterMark_label.font = UIFont.systemFont(ofSize: 14)
            //email_label.backgroundColor = UIColor.red
            self.view.addSubview(afterMark_label)
            afterMark_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(afterDinner_left.snp.right).offset(AJScreenWidth/25)
                make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
            }
            
           
            self.view.addSubview(afterDinner_right)
            afterDinner_right.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(afterDinner_left.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
            }
            
    
            self.view.addSubview(afterUnit_label)
            afterUnit_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(afterDinner_right.snp.right).offset(10)
                make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
            }
            
            /* 餐后结束 */
            
            /* 随机开始 */
            let randomDinner_label = UILabel(frame: CGRect())
            randomDinner_label.text = "随机"
            randomDinner_label.font = UIFont.systemFont(ofSize: 14)
            self.view.addSubview(randomDinner_label)
            randomDinner_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(afterDinner_left.snp.bottom).offset(5)
            }
            
           
            self.view.addSubview(randomDinner_left)
            randomDinner_left.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
            }
            
            let randomMark_label = UILabel(frame: CGRect())
            randomMark_label.text = "~"
            randomMark_label.font = UIFont.systemFont(ofSize: 14)
            //        email_label.backgroundColor = UIColor.red
            self.view.addSubview(randomMark_label)
            randomMark_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(randomDinner_left.snp.right).offset(AJScreenWidth/25)
                make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
            }
            
           
            self.view.addSubview(randomDinner_right)
            randomDinner_right.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(randomDinner_left.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
            }
            
           
            randomUnit_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
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
                make.width.equalTo(AJScreenWidth*3/5)
                make.top.equalTo(randomDinner_left.snp.bottom).offset(20)
                make.left.equalTo(AJScreenWidth/5)
            }
       
            /*恢复默认设置按钮*/
           
            recoverBlood.addTarget(self, action: #selector(recover), for: .touchUpInside)
            self.view.addSubview(recoverBlood)
            recoverBlood.snp.makeConstraints{(make) in
                make.height.equalTo(AJScreenWidth/10)
                make.width.equalTo(AJScreenWidth*3/5)
                make.top.equalTo(saveBlood.snp.bottom).offset(10)
                make.left.equalTo(AJScreenWidth/5)
            }
        }
    
        override func viewWillAppear(_ animated: Bool) {
            
            //这个是加载用户血糖单位设置信息
            let unit_path = Bundle.main.path(forResource: "UnitSetting", ofType: "plist")
            let unit_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: unit_path!)!
            
            let unit = unit_data["BloodUnit"]! as! String
            print(unit)
            emptyUnit_label.text = unit
            beforeUnit_label.text = unit
            afterUnit_label.text = unit
            randomUnit_label.text = unit
            /*单位设置结束*/
            
            emptyStomach_left.text = ""
            emptyStomach_right.text = ""
            
            beforeDinner_left.text = ""
            beforeDinner_right.text = ""
            
            afterDinner_left.text = ""
            afterDinner_right.text = ""
            
            randomDinner_left.text = ""
            randomDinner_right.text = ""
            
            /*血糖显示*/
            let user_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
            let user_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: user_path!)!
            
            
            /* 设置显示过程 */
            let a = (user_data["emptyStomachLowLimit"] as? NSNumber)?.stringValue
            let b = (user_data["emptyStomachHighLimit"] as? NSNumber)?.stringValue
            print(a!)
            emptyStomach_left.placeholder  = a!
            emptyStomach_right.placeholder = b!
            
            let c = (user_data["beforeDinnerLowLimit"] as? NSNumber)?.stringValue
            let d = (user_data["beforeDinnerHighLimit"] as? NSNumber)?.stringValue
            beforeDinner_left.placeholder  = c!
            beforeDinner_right.placeholder = d!
            
            let e = (user_data["afterDinnerLowLimit"] as? NSNumber)?.stringValue
            let f = (user_data["afterDinnerHighLimit"] as? NSNumber)?.stringValue
            afterDinner_left.placeholder  = e!
            afterDinner_right.placeholder = f!
            
            let g = (user_data["randomDinnerLowLimit"] as? NSNumber)?.stringValue
            let h = (user_data["randomDinnerHighLimit"] as? NSNumber)?.stringValue
            randomDinner_left.placeholder  = g!
            randomDinner_right.placeholder = h!
        }
    
    
        @objc private func back(){
            self.navigationController?.popViewController(animated: true)
        }
    
        /**/
    
        @objc private func save(){
            let alert = CustomAlertController()
            let save_path = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
            let save_data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: save_path!)!
            //思路：先获取原来文件中的数值，这样就可以不管它有没有改，都可以直接覆盖。
            
            emptyStomach_left_number  = save_data["emptyStomachLowLimit"]  as? NSNumber
//            let aa = (save_data["emptyStomachLowLimit"]  as? NSNumber)?.stringValue
            emptyStomach_right_number = save_data["emptyStomachHighLimit"] as? NSNumber
            
            beforeDinner_left_number  = save_data["beforeDinnerLowLimit"] as? NSNumber
            beforeDinner_right_number = save_data["beforeDinnerHighLimit"] as? NSNumber
            
            afterDinner_left_number   = save_data["afterDinnerLowLimit"] as? NSNumber
            afterDinner_right_number  = save_data["afterDinnerHighLimit"] as? NSNumber
            
            randomDinner_left_number  = save_data["randomDinnerLowLimit"] as? NSNumber
            randomDinner_right_number = save_data["randomDinnerHighLimit"] as? NSNumber
            
//            print("节点")
//            print(aa!)
//            print(type(of:Double(aa!)!))
//            print(emptyStomach_right_number!)
//            print(beforeDinner_left_number!)
//            print(beforeDinner_right_number!)
//            print(afterDinner_left_number!)
//            print(afterDinner_right_number!)
//            print(randomDinner_left_number!)
//            print(randomDinner_right_number!)
            
            //校验用户输入的正确性,a,b等都是个过度值，所有命名较为随意
            /*
                注：在获取用户输入的过程中，还需要判断用户是否输入：分为只输入一部分，或者全部输入。
                    所以在这之前需要做个判空操作
             */
            //空腹
            //获得用户缺省值的下限
            var a:Double = Double(((save_data["emptyStomachLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("空腹下限值",a)
            if self.emptyStomach_left.text! != ""{
                //判断是否为非法输入
                if FormatMethodUtil.validateBloodNumber(number: self.emptyStomach_left.text!) == true{
                    a = Double(self.emptyStomach_left.text!)!
                    if a <= 7.8 && a >= 3.3{
                        print("用户的输入",a)
                        emptyStomach_left_number = a as NSNumber
                        save_data.setObject(emptyStomach_left_number as Any, forKey: "emptyStomachLowLimit" as NSCopying)
                        save_data.write(toFile: save_path!, atomically: true)
                        alert.custom(self, "Attention", "保存成功")
                        print(type(of: emptyStomach_left_number))
                    }else{
                        alert.custom(self, "Attention", "空腹血糖下限范围为3.3~7.8")
                    }
                }else{
                    alert.custom(self, "Attention", "非法输入")
                }
            }else{
                print("空腹下限啥事也没干")
            }
            
            var b:Double = Double(((save_data["emptyStomachHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("空腹上限值",b)
            if self.emptyStomach_right.text! != ""{
                if FormatMethodUtil.validateBloodNumber(number: self.emptyStomach_right.text!) == true{
                        b = Double(self.emptyStomach_right.text!)!
                        if b <= 16.6 && b >= 5.0 && b > a{  //注：上限的值必须大于下限
                            emptyStomach_right_number = b as NSNumber
                            save_data.setObject(emptyStomach_right_number as Any, forKey: "emptyStomachHighLimit" as NSCopying)
                        }else{
                            alert.custom(self, "Attention", "空腹血糖上限限范围为5.0~16.6")
                        }
                }else{
                    alert.custom(self, "Attention", "非法输入")
                }
            }else{
                print("空腹上限啥事也没干")
            }
            //餐前
            var c:Double = Double(((save_data["beforeDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐前下限值",c)
            if self.beforeDinner_left.text! != ""{
                //判断是否为非法输入
                if FormatMethodUtil.validateBloodNumber(number: self.beforeDinner_left.text!) == true{
                    c = Double(self.beforeDinner_left.text!)!
                    if c <= 7.8 && c >= 3.3{
                        print("用户的输入",c)
                        beforeDinner_left_number = c as NSNumber
                        save_data.setObject(beforeDinner_left_number as Any, forKey: "beforeDinnerLowLimit" as NSCopying)
                        print(type(of: beforeDinner_left_number))
                    }else{
                        alert.custom(self, "Attention", "餐前血糖下限范围为3.3~7.8")
                    }
                }else{
                    alert.custom(self, "Attention", "非法输入")
                }
            }else{
                print("餐前下限啥事也没干")
            }
            
            var d:Double = Double(((save_data["beforeDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐前上限值",d)
            if self.beforeDinner_right.text! != ""{
                //判断是否为非法输入
                if FormatMethodUtil.validateBloodNumber(number: self.beforeDinner_right.text!) == true{
                    d = Double(self.beforeDinner_right.text!)!
                    if d <= 16.6 && d >= 5.0 && d > c{
                        print("用户的输入",d)
                        beforeDinner_right_number = d as NSNumber
                        save_data.setObject(beforeDinner_right_number as Any, forKey: "beforeDinnerHighLimit" as NSCopying)
                        print(type(of: beforeDinner_right_number))
                    }else{
                        alert.custom(self, "Attention", "餐前血糖上限限范围为5.0~16.6")
                    }
                }else{
                    alert.custom(self, "Attention", "非法输入")
                }
            }else{
                print("餐前上限啥事也没干")
            }
           
            //餐后
            var e:Double = Double(((save_data["afterDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐后下限值",e)
            if self.afterDinner_left.text! != ""{
                //判断是否为非法输入
                if FormatMethodUtil.validateBloodNumber(number: self.afterDinner_left.text!) == true{
                    e = Double(self.afterDinner_left.text!)!
                    if e <= 7.8 && e >= 3.3{
                        print("用户的输入",e)
                        afterDinner_left_number = e as NSNumber
                        save_data.setObject(afterDinner_left_number as Any, forKey: "afterDinnerLowLimit" as NSCopying)
                        print(type(of: afterDinner_left_number))
                    }else{
                        alert.custom(self, "Attention", "餐后血糖下限范围为3.3~7.8")
                    }
                }else{
                    alert.custom(self, "Attention", "非法输入")
                }
            }else{
                print("餐后下限啥事也没干")
            }
            
            var f:Double = Double(((save_data["afterDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("餐后上限值",f)
            if self.afterDinner_right.text! != ""{
                //判断是否为非法输入
                if FormatMethodUtil.validateBloodNumber(number: self.afterDinner_right.text!) == true{
                    f = Double(self.afterDinner_right.text!)!
                    if f <= 16.6 && f >= 5.0 && f > e{
                        print("用户的输入",f)
                        afterDinner_right_number = f as NSNumber
                        save_data.setObject(afterDinner_right_number as Any, forKey: "afterDinnerHighLimit" as NSCopying)
                        print(type(of: afterDinner_right_number))
                    }else{
                        alert.custom(self, "Attention", "餐后血糖上限限范围为5.0~16.6")
                    }
                }else{
                    alert.custom(self, "Attention", "非法输入")
                }
            }else{
                print("餐后上限啥事也没干")
            }
            //随机
            var g:Double = Double(((save_data["randomDinnerLowLimit"]  as? NSNumber)?.stringValue)!)!
            print("随机下限值",g)
            if self.randomDinner_left.text! != ""{
                //判断是否为非法输入
                if FormatMethodUtil.validateBloodNumber(number: self.randomDinner_left.text!) == true{
                    g = Double(self.randomDinner_left.text!)!
                    if g <= 7.8 && g >= 3.3{
                        print("用户的输入",g)
                        randomDinner_left_number = g as NSNumber
                        save_data.setObject(randomDinner_left_number as Any, forKey: "randomDinnerLowLimit" as NSCopying)
                        print(type(of: randomDinner_left_number))
                    }else{
                        alert.custom(self, "Attention", "随机血糖下限范围为3.3~7.8")
                    }
                }else{
                    alert.custom(self, "Attention", "非法输入")
                }
            }else{
                print("随机下限啥事也没干")
            }
            
            
            var h:Double = Double(((save_data["randomDinnerHighLimit"]  as? NSNumber)?.stringValue)!)!
            print("随机上限值",h)
            if self.randomDinner_right.text! != ""{
                //判断是否为非法输入
                if FormatMethodUtil.validateBloodNumber(number: self.randomDinner_right.text!) == true{
                    h = Double(self.randomDinner_right.text!)!
                    if h <= 16.6 && h >= 5.0 && h > g{
                        print("用户的输入",h)
                        randomDinner_right_number = h as NSNumber
                        save_data.setObject(randomDinner_right_number as Any, forKey: "randomDinnerHighLimit" as NSCopying)
                        print(type(of: randomDinner_right_number))
                    }else{
                        alert.custom(self, "Attention", "随机血糖上限限范围为5.0~16.6")
                    }
                }else{
                    alert.custom(self, "Attention", "非法输入")
                }
            }else{
                print("随机上限啥事也没干")
            }
            
           //第二步，保存写入userBloodSetting.plist文件中
            save_data.write(toFile: save_path!, atomically: true)
            //第三步，修改显示uitextField的placeholder的属性
            /* 设置显示过程 */
            let aa = (save_data["emptyStomachLowLimit"] as? NSNumber)?.stringValue
            let bb = (save_data["emptyStomachHighLimit"] as? NSNumber)?.stringValue
            print(aa!)
            emptyStomach_left.placeholder  = aa!
            emptyStomach_right.placeholder = bb!
            
            let cc = (save_data["beforeDinnerLowLimit"] as? NSNumber)?.stringValue
            let dd = (save_data["beforeDinnerHighLimit"] as? NSNumber)?.stringValue
            beforeDinner_left.placeholder  = cc!
            beforeDinner_right.placeholder = dd!
            
            let ee = (save_data["afterDinnerLowLimit"] as? NSNumber)?.stringValue
            let ff = (save_data["afterDinnerHighLimit"] as? NSNumber)?.stringValue
            afterDinner_left.placeholder  = ee!
            afterDinner_right.placeholder = ff!
            
            let gg = (save_data["randomDinnerLowLimit"] as? NSNumber)?.stringValue
            let hh = (save_data["randomDinnerHighLimit"] as? NSNumber)?.stringValue
            randomDinner_left.placeholder  = gg!
            randomDinner_right.placeholder = hh!
            
        }
    
        //恢复默认设置的按钮
        /*
            做法：设置成两个plist文件，每次按下恢复按钮，就会把默认文件defalutBloodSetting的信息，覆盖到userBloodSetting的文件中。
                每次修改都是对userBloodSetting的文件中。
        */
    
    
        @objc private func recover(){
            //这个是加载缺省的上下限设置文件信息
            let path_default = Bundle.main.path(forResource: "defaultBloodSetting", ofType: "plist")
            let data_default:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path_default!)!
            //这个是加载用户设置血糖上下限信息
            let path_user = Bundle.main.path(forResource: "userBloodSetting", ofType: "plist")
            let data_user:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path_user!)!
            
            
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

            data_user.write(toFile: path_user!, atomically: true)
            
            /* 设置显示过程 */
            let a = (data_user["emptyStomachLowLimit"] as? NSNumber)?.stringValue
            let b = (data_user["emptyStomachHighLimit"] as? NSNumber)?.stringValue
            print(a!)
            emptyStomach_left.placeholder  = a!
            emptyStomach_right.placeholder = b!

            let c = (data_user["beforeDinnerLowLimit"] as? NSNumber)?.stringValue
            let d = (data_user["beforeDinnerHighLimit"] as? NSNumber)?.stringValue
            beforeDinner_left.placeholder  = c!
            beforeDinner_right.placeholder = d!

            let e = (data_user["afterDinnerLowLimit"] as? NSNumber)?.stringValue
            let f = (data_user["afterDinnerHighLimit"] as? NSNumber)?.stringValue
            afterDinner_left.placeholder  = e!
            afterDinner_right.placeholder = f!

            let g = (data_user["randomDinnerLowLimit"] as? NSNumber)?.stringValue
            let h = (data_user["randomDinnerHighLimit"] as? NSNumber)?.stringValue
            randomDinner_left.placeholder  = g!
            randomDinner_right.placeholder = h!
        }

}
