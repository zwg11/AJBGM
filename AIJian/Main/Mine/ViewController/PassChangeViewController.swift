//
//  PassChangeViewController.swift
//  AIJian
//
//  Created by zzz on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  密码修改页:包括页面构造和逻辑后台交互

import UIKit
import Alamofire
import HandyJSON


class PassChangeViewController: UIViewController,UITextFieldDelegate {
    
    //请求出现转的效果，增加用户体验
    private lazy var indicator:CustomIndicatorView = {
        let view = CustomIndicatorView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: AJScreenHeight))
        view.setupUI("")
        //view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        return view
    }()
    
        var email:String = ""
        var oldP:String?
        var newP:String?
        var verfiedP:String?
        var token:String = ""
    
        lazy var text_email:UILabel = {
            let text_email = UILabel()
            text_email.font = UIFont.systemFont(ofSize: 16)
//            text_email.text = email
            text_email.backgroundColor = UIColor.red
            return text_email
        }()
    
        lazy var oldPasswd_textF:UITextField = {
            let oldPasswd_textF = UITextField()
            oldPasswd_textF.font = UIFont.systemFont(ofSize: 16)
            oldPasswd_textF.placeholder="Old Password"
            oldPasswd_textF.isSecureTextEntry = true
            oldPasswd_textF.allowsEditingTextAttributes = false
            oldPasswd_textF.textColor = TextColor
            oldPasswd_textF.borderStyle = .none
            let imageView = UIImageView(image: UIImage(named: "mima"))
            oldPasswd_textF.leftView = imageView
            oldPasswd_textF.leftViewMode = .always
            let str:NSMutableAttributedString = NSMutableAttributedString(string: "Old Password", attributes: [NSAttributedString.Key.foregroundColor:TextColor])
            oldPasswd_textF.attributedPlaceholder = str
            return oldPasswd_textF
        }()
    
        lazy var newPasswd_textF:UITextField = {
            let newPasswd_textF = UITextField()
            newPasswd_textF.font = UIFont.systemFont(ofSize: 16)
            newPasswd_textF.placeholder="New Password"
            newPasswd_textF.allowsEditingTextAttributes = false
            newPasswd_textF.isSecureTextEntry = true
            newPasswd_textF.borderStyle = .none
            newPasswd_textF.textColor = TextColor
            let imageView = UIImageView(image: UIImage(named: "mima"))
            newPasswd_textF.leftView = imageView
            newPasswd_textF.leftViewMode = .always
            let str:NSMutableAttributedString = NSMutableAttributedString(string: "New Password", attributes: [NSAttributedString.Key.foregroundColor:TextColor])
            newPasswd_textF.attributedPlaceholder = str
            return newPasswd_textF
        }()
    
        lazy var verfiedPasswd_textF:UITextField = {
            let verfiedPasswd_textF = UITextField()
            verfiedPasswd_textF.font = UIFont.systemFont(ofSize: 16)
            verfiedPasswd_textF.placeholder="Confirm the Password"
            verfiedPasswd_textF.allowsEditingTextAttributes = false
            verfiedPasswd_textF.isSecureTextEntry = true
            verfiedPasswd_textF.borderStyle = .none
            verfiedPasswd_textF.textColor = TextColor
            let imageView = UIImageView(image: UIImage(named: "mima"))
            verfiedPasswd_textF.leftView = imageView
            verfiedPasswd_textF.leftViewMode = .always
            let str:NSMutableAttributedString = NSMutableAttributedString(string: "Confirm the Password", attributes: [NSAttributedString.Key.foregroundColor:TextColor])
            verfiedPasswd_textF.attributedPlaceholder = str
            return verfiedPasswd_textF
        }()
    
    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    
        lazy var saveButton:UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Save", for: .normal)
            button.backgroundColor = ButtonColor
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            return button
        }()
    
        //视图消失，就是退出这个密码修改页面的时候。避免每次进入的时候都要删除原来的字符串。
        override func viewDidDisappear(_ animated: Bool) {
           self.oldPasswd_textF.text! = ""
           self.newPasswd_textF.text! = ""
           self.verfiedPasswd_textF.text! = ""
        }
         //当视图出现了，直接从文件中获取email和token信息
        override func viewWillAppear(_ animated: Bool) {
            email = UserInfo.getEmail()
            token = UserInfo.getToken()
            text_email.text = email
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Change Password"
//            self.view.backgroundColor = ThemeColor
            self.view.backgroundColor = UIColor.clear
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
            //旧密码内容
            oldPasswd_textF.delegate = self
            self.view.addSubview(oldPasswd_textF)
            oldPasswd_textF.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/2)
                make.left.equalTo(AJScreenWidth/15)
                make.right.equalTo(-AJScreenWidth/15)
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(50)
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
                make.top.equalTo(oldPasswd_textF.snp.bottom).offset(1)
            }
            
            //新密码内容
            newPasswd_textF.delegate = self
            self.view.addSubview(newPasswd_textF)
            newPasswd_textF.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/2)
                make.left.equalTo(AJScreenWidth/15)
                make.right.equalTo(-AJScreenWidth/15)
                make.top.equalTo(line_frame2.snp.bottom).offset(AJScreenWidth/11)
            }
            //第三条线
            let line_frame3 = UIView(frame: CGRect())
            line_frame3.backgroundColor = LineColor
            self.view.addSubview(line_frame3)
            line_frame3.snp.makeConstraints{ (make) in
                make.height.equalTo(0.5)
                make.width.equalTo(AJScreenWidth)
                make.left.equalTo(AJScreenWidth/15)
                make.right.equalTo(-AJScreenWidth/15)
                make.top.equalTo(newPasswd_textF.snp.bottom).offset(1)
            }

            
            //确认密码
            verfiedPasswd_textF.delegate = self
            self.view.addSubview(verfiedPasswd_textF)
            verfiedPasswd_textF.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/2)
                make.left.equalTo(AJScreenWidth/15)
                make.right.equalTo(-AJScreenWidth/15)
                make.top.equalTo(line_frame3.snp.bottom).offset(AJScreenWidth/11)
            }
            //第四条线
            let line_frame4 = UIView(frame: CGRect())
            line_frame4.backgroundColor = LineColor
            self.view.addSubview(line_frame4)
            line_frame4.snp.makeConstraints{ (make) in
                make.height.equalTo(0.5)
                make.width.equalTo(AJScreenWidth)
                make.left.equalTo(AJScreenWidth/15)
                make.right.equalTo(-AJScreenWidth/15)
                make.top.equalTo(verfiedPasswd_textF.snp.bottom).offset(1)
            }
            
            saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
            self.view.addSubview(saveButton)
            saveButton.snp.makeConstraints{ (make) in
                make.left.equalToSuperview().offset(AJScreenWidth/15)
                make.right.equalToSuperview().offset(-AJScreenWidth/15)
                make.height.equalTo(AJScreenHeight/15)
                make.top.equalTo(line_frame4.snp.bottom).offset(AJScreenHeight*3/15)
            }
            
            
            
        }
        
        
        @objc private func leftButtonClick(){
            self.navigationController?.popViewController(animated: false)
        }
        @objc private func save(){
            let alert = CustomAlertController()
            oldP = self.oldPasswd_textF.text!
            newP = self.newPasswd_textF.text!
            verfiedP = self.verfiedPasswd_textF.text!
//            email = "6666"
//            token = "666"
            
            
            if oldP == ""{
                alert.custom(self, "Attention", "Original Password Empty")
                return
            }else if newP == ""{
                alert.custom(self, "Attention", "New Password Empty")
                return
            }else if verfiedP == ""{
                alert.custom(self, "Attention", "Confirm Password Empty")
                return
            }else if verfiedP!.count >= 30 {
                //不能让密码大于30个字符
                return 
            }else if oldP == newP {  //让旧密码和新密码不能一样
                alert.custom(self, "Attention", "New Password Matches Old")
                return
            }else if FormatMethodUtil.validatePasswd(passwd: verfiedP!) != true{
                alert.custom(self, "Attention", "Incorrect Password Format.The password format is a combination of at least two of numbers,letters,and special characters.")
                return
            }else if newP != verfiedP{
                alert.custom(self, "Attention", "Passwords Not Match")
                return
            }else{
                indicator.startIndicator()
                self.view.addSubview(indicator)
                self.view.bringSubviewToFront(indicator)
                let dictString:Dictionary = [ "oldPassword":String(oldP!),"newPassword":String(newP!),"email":String(email),"token":String(token),"userId":UserInfo.getUserId()] as [String : Any]
                //print(dictString)
              //  此处的参数需要传入一个字典类型
                Alamofire.request(PASSWDRESET,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
                    
                    if response.result.isSuccess {
                        
                        if let jsonString = response.result.value {
                            
                            if let responseModel = JSONDeserializer<responseAModel>.deserializeFrom(json: jsonString) {
                                // model转json 为了方便在控制台查看
                                //print(responseModel.toJSONString(prettyPrint: true)!)
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                                /*  此处为跳转和控制逻辑*/
                                if(responseModel.code == 1 ){
                                    alert.custom_cengji(self,"", "Password Reset Success")
                                    self.oldPasswd_textF.text! = ""
                                    self.newPasswd_textF.text! = ""
                                    self.verfiedPasswd_textF.text! = ""
                                    self.navigationController?.popToRootViewController(animated: false)
                                }else if (responseModel.code! == 2 ){
                                    let x = UIAlertController(title: "", message: "Your account was logged in on another device,it will log out there!", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "Done", style: .default, handler: {
                                          action in
                                            LoginOff.loginOff(self)
                                     })
                                     //只加入确定按钮
                                    x.addAction(okAction)
                                    self.present(x, animated: true, completion: nil)
                                }else if (responseModel.code! == 3){
                                    let x = UIAlertController(title: "", message: "Your account has been disabled.Please contact oncall@acondiabetescare.com", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "Done", style: .default, handler: {
                                             action in
                                            LoginOff.loginOff(self)
                                     })
                                     //只加入确定按钮
                                    x.addAction(okAction)
                                     self.present(x, animated: true, completion: nil)
                                }else if (responseModel.code! == 4){
                                    let x = UIAlertController(title: "", message: "Your account does not exist", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "Done", style: .default, handler: {
                                          action in
                                           LoginOff.loginOff(self)
                                     })
                                      //只加入确定按钮
                                    x.addAction(okAction)
                                    self.present(x, animated: true, completion: nil)
                                }else{
                                    alert.custom_cengji(self,"Attention", "Password Reset Failure")
                                    self.oldPasswd_textF.text! = ""
                                    self.newPasswd_textF.text! = ""
                                    self.verfiedPasswd_textF.text! = ""
                                    self.navigationController?.popToRootViewController(animated: false)
                                }
                                
                            }
                        }
                    }else{
                        self.indicator.stopIndicator()
                        self.indicator.removeFromSuperview()
                        alert.custom(self,"Attention", "Internet Error")
                    }
                }
            }   
        }
        


}
