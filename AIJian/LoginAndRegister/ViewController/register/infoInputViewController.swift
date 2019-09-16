//
//  infoInputViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
//  填写个人信息的控制层

import UIKit
import SnapKit
import Alamofire
import HandyJSON

class infoInputViewController: UIViewController,UITextFieldDelegate {

    //邮箱，来自上一步传过来的
    var email:String?
    //用户名
    var userName:String? = ""
    //标志位,用来设置性别的
    var flag:Bool = true
    //性别  男为1   女为0
    var gender:Int64 = 1
    //身高
    var height:Double?
    //体重
    var weightKg:Double? 
    //国家
    var country:String? = ""
    //电话
    var phoneNumber:String? = ""
    //时间
    var brithday:String? = ""
    //上个界面传过来的verfiyString
    var verifyString:String? = ""
    
    
    
    // 个人信息页界面
    private lazy var infoinputView:InfoInputView = {
        let view = InfoInputView()
        view.setupUI()
        
        // 以下代理本想单独拿出来写进函数中，但是不知为什么老是内存溢出
        //所有的textField的代理方法
        view.userNameTextField.delegate = self  //用户名
//        view.heightTextField.delegate = self    //身高
//        view.weightTextField.delegate = self    //体重
        view.nationTextField.delegate = self    //国家
        view.phoneTextField.delegate = self     //电话
        initDelegate()
        view.gender_man_button.addTarget(self, action: #selector(genderMan), for: .touchUpInside)
        view.gender_woman_button.addTarget(self, action: #selector(genderWoman), for: .touchUpInside)
        view.dateButton.addTarget(self, action: #selector(chooseDate), for: .touchUpInside)
        view.finishButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        return view
    }()
    
    // 出生日期按钮
    private lazy var picker : pickerView = {
        let view = pickerView()
        view.setupUI()
        view.sureButton.addTarget(self, action: #selector(pickViewSelected), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(pickViewDismiss), for: .touchUpInside)
        return view
    }()
    var topConstraint:Constraint?
    var bottomConstraint:Constraint?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Personal Information"
//        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.backgroundColor = ThemeColor
        self.navigationController?.navigationBar.barTintColor = ThemeColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.view.addSubview(infoinputView)
        infoinputView.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        // 时间选择器视图设置
        self.view.addSubview(picker)
        // 设置时间选择器界面约束，之后会修改此约束达到界面显现和消失的效果
        picker.snp_makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(UIScreen.main.bounds.height/3)
            if #available(iOS 11.0, *) {
                self.topConstraint = make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).constraint
            } else {
                // Fallback on earlier versions
                self.topConstraint = make.top.equalTo(bottomLayoutGuide.snp.bottom).constraint
            }
            //make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        self.view.bringSubviewToFront(picker)
        
        
    }
    func initDelegate(){
        // 设置所有的文本框的代理，使得代理方法对所有文本框有效
        
    }
   
    //点击性别男的动作
    @objc func genderMan(){
   
        infoinputView.gender_man_button.setImage(UIImage(named: "selected"), for: .normal)
        infoinputView.gender_woman_button.setImage(UIImage(named: "unselected"), for: .normal)
        gender = 1
       
        
    }
    //点击性别女的动作
    @objc func genderWoman(){
        infoinputView.gender_woman_button.setImage(UIImage(named: "selected"), for: .normal)
        infoinputView.gender_man_button.setImage(UIImage(named: "unselected"), for: .normal)
        gender = 0
    }
    
    //选择出生日期
    @objc func chooseDate(){
        print("点击了出生日期按钮")
        UIView.animate(withDuration: 0.5, animations: appear)
    }
    func appear(){
        
        // 重新布置约束
        // 时间选择器界面移到屏幕内底部，视觉效果为出现
        //shareV.pickDateView.frame.origin = CGPoint(x: 0, y: self.frame.size.height/3*2)
        print("func appear done.")
        // 删除顶部约束
        self.topConstraint?.uninstall()
        picker.snp_makeConstraints{(make) in
            
            // 添加底部约束
            if #available(iOS 11.0, *) {
                self.bottomConstraint = make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).constraint
            } else {
                // Fallback on earlier versions
                self.bottomConstraint = make.bottom.equalTo(bottomLayoutGuide.snp.top).constraint
                
            }
        }
        self.view.layoutIfNeeded()
    }
    func dismiss(){
        // 重新布置约束
        // 时间选择器界面移到屏幕外，视觉效果为消失
        //shareV.pickDateView.frame.origin = CGPoint(x: 0, y: shareV.snp.bottom)
        print("func dismiss done.")
        // 删除顶部约束
        self.bottomConstraint?.uninstall()
        picker.snp_makeConstraints{(make) in
            
            // 添加底部约束
            if #available(iOS 11.0, *) {
                self.topConstraint = make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).constraint
            } else {
                // Fallback on earlier versions
                self.topConstraint = make.top.equalTo(bottomLayoutGuide.snp.bottom).constraint
            }
        }
        // 告诉当前控制器的View要更新约束了，动态更新约束，没有这句的话更新约束就没有动画效果
        self.view.layoutIfNeeded()
    }
    
    
    // 点击取消按钮，时间选择器界面移到屏幕外，视觉效果为消失
    @objc func pickViewDismiss(){
        UIView.animate(withDuration: 0.5, animations: dismiss)
        
        //        self.pickDateView.snp.makeConstraints{(make) in
        //            make.top.equalTo(self.snp.bottom)
        //
        //        }
        print("cancel button clicked")
        
    }
    // 点击确定按钮，时间选择器界面移到屏幕外，视觉效果为消失，按钮文本显示日期
    @objc func pickViewSelected(){
        // 创建一个日期格式器
        let dateFormatter = DateFormatter()
        // 为格式器设置格式字符串,时间所属区域
        dateFormatter.dateFormat="yyyy-MM-dd"
        // 绑定一个时间选择器，并按格式返回时间
        brithday = dateFormatter.string(from: picker.datePicker.date)
        infoinputView.dateButton.setTitle(brithday, for: .normal)
        print("选择时间日期:",brithday!)
//        shareV.birthdayButton.setTitle(date, for: .normal)
        
        UIView.animate(withDuration: 0.5, animations: dismiss)
        
        print("sure button clicked")
        
    }
    
    
    
    //完成的点击方法
    @objc func finish(){
        print("点击了完成方法")
        let alertController = CustomAlertController()
        //用户名
       userName = infoinputView.userNameTextField.text!
        //性别
//        gender = infoinputView.
//        //身高
//        if infoinputView.heightTextField.text! != ""{
//             height = Double(infoinputView.heightTextField.text!)!
//        }
//        //体重
//        if infoinputView.weightTextField.text! != ""{
//             weightKg = Double(infoinputView.weightTextField.text!)!
//        }
       
        //国家
        country = infoinputView.nationTextField.text!
        //电话
        phoneNumber = infoinputView.phoneTextField.text!
        //时间
//        brithday =
        if userName == ""{
            alertController.custom(self, "Attention", "用户名不能为空")
            return
        }else if country == ""{
             alertController.custom(self, "Attention", "国家不能为空")
            return
        }else{  //经过验证之后的请求
            //设置了国家和用户名不能为空
            print(userName!)
//            print(height!)
//            print(weightKg!)
            print(country!)
            print(phoneNumber!)
//            email = "3333@qq.com"
//            verifyString = "aekcnsoirebgregnkdnwin"
            print("从前一个页面传过来的email",email!)
            print("从前一个页面传过来的data",verifyString!)
            var userData:USER = USER()
            userData.email = String(email!)
            userData.user_name = String(userName!)
            userData.gender = gender
            if weightKg != nil{
                userData.weight_kg = weightKg
            }
            userData.country = String(country!)
            if userData.phone_number != nil{
                userData.phone_number = String(phoneNumber!)
            }
            //toJSONGString的过程
//            let tempArray = [userData]
            let user = userData.toJSONString()!
            
            let dictString:Parameters = [
                "user":user,
                "verifyString":String(verifyString!)
                   ]
            print(dictString)
            Alamofire.request(FillUserInfo,method: .post,parameters: dictString).responseString{ (response) in
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
                                 self.navigationController?.popToRootViewController(animated: true)
                                alertController.custom(self,"Attention", "恭喜您，注册成功！")
                               
                            }else{
                                print(responseModel.code)
                                self.navigationController?.popToRootViewController(animated: true)
                                alertController.custom(self,"Attention", "恭喜您，注册成功！")
                                
                            }
                        } //end of letif
                    }
                }
            }//end of request
            
            
        }
        
    }  //函数结束
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
}
