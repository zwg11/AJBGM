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
//
//        lazy var oldPasswd_label:UILabel = {
//            let oldPasswd_label = UILabel(frame: CGRect())
//            oldPasswd_label.text = "旧 密 码"
//            oldPasswd_label.font = UIFont.systemFont(ofSize: 18)
//            return oldPasswd_label
//        }()
    
        lazy var oldPasswd_textF:UITextField = {
            let oldPasswd_textF = UITextField()
            oldPasswd_textF.font = UIFont.systemFont(ofSize: 16)
            oldPasswd_textF.placeholder="Old Password"
//            oldPasswd_textF.keyboardType = .default
            oldPasswd_textF.isSecureTextEntry = true
            oldPasswd_textF.allowsEditingTextAttributes = false
            oldPasswd_textF.borderStyle = .none
            let imageView = UIImageView(image: UIImage(named: "email"))
            oldPasswd_textF.leftView = imageView
            oldPasswd_textF.leftViewMode = .always
            let str:NSMutableAttributedString = NSMutableAttributedString(string: "Old Password", attributes: [NSAttributedString.Key.foregroundColor:TextColor])
            oldPasswd_textF.attributedPlaceholder = str
            
//            oldPasswd_textF.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
            return oldPasswd_textF
        }()
    
        lazy var newPasswd_textF:UITextField = {
            let newPasswd_textF = UITextField()
            newPasswd_textF.font = UIFont.systemFont(ofSize: 16)
            newPasswd_textF.placeholder="New Password"
            newPasswd_textF.allowsEditingTextAttributes = false
            newPasswd_textF.isSecureTextEntry = true
            newPasswd_textF.borderStyle = .none
            let imageView = UIImageView(image: UIImage(named: "email"))
            newPasswd_textF.leftView = imageView
            newPasswd_textF.leftViewMode = .always
            let str:NSMutableAttributedString = NSMutableAttributedString(string: "New Password", attributes: [NSAttributedString.Key.foregroundColor:TextColor])
            newPasswd_textF.attributedPlaceholder = str
//            newPasswd_textF.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
            return newPasswd_textF
        }()
    
        lazy var verfiedPasswd_textF:UITextField = {
            let verfiedPasswd_textF = UITextField()
            verfiedPasswd_textF.font = UIFont.systemFont(ofSize: 16)
            verfiedPasswd_textF.placeholder="Confirm the Password"
            verfiedPasswd_textF.allowsEditingTextAttributes = false
            verfiedPasswd_textF.isSecureTextEntry = true
            verfiedPasswd_textF.borderStyle = .none
            let imageView = UIImageView(image: UIImage(named: "email"))
            verfiedPasswd_textF.leftView = imageView
            verfiedPasswd_textF.leftViewMode = .always
            let str:NSMutableAttributedString = NSMutableAttributedString(string: "Confirm the Password", attributes: [NSAttributedString.Key.foregroundColor:TextColor])
            verfiedPasswd_textF.attributedPlaceholder = str
//            verfiedPasswd_textF.setValue(TextColor, forKeyPath: "_placeholderLabel.textColor")
            return verfiedPasswd_textF
        }()
    
        lazy var saveButton:UIButton = {
            let button = UIButton()
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
            self.view.backgroundColor = ThemeColor
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
            if AJScreenHeight == 812{
                print("相等")
            }else{
                print("不相等")
            }
            print("iphone x 的高度",AJScreenHeight)
            
            
//            /*第一行开始*/
//            let email_label = UILabel(frame: CGRect())
//            email_label.text = ""
//            email_label.font = UIFont.systemFont(ofSize: 18)
//            self.view.addSubview(email_label)
//            email_label.snp.makeConstraints{ (make) in
//                make.height.equalTo(AJScreenHeight/15)
//                make.width.equalTo(AJScreenWidth/5)
//                make.left.equalTo(AJScreenWidth/15)
//                make.top.equalTo(topLayoutGuide.snp.bottom)
//            }
//            print("距离上面的高度",navigationBarHeight)
//
//            //邮箱信息布局约束
//            self.view.addSubview(text_email)
//            text_email.snp.makeConstraints{ (make) in
//                make.height.equalTo(AJScreenHeight/15)
//                make.width.equalTo(AJScreenWidth/2)
//                make.left.equalTo(email_label.snp.right).offset(AJScreenWidth/10)
//                make.top.equalTo(topLayoutGuide.snp.bottom)
//            }
//
//            //第一条线
//            let line_frame1 = UIView(frame: CGRect())
//            line_frame1.backgroundColor = UIColor.black
//            self.view.addSubview(line_frame1)
//            line_frame1.snp.makeConstraints{ (make) in
//                make.height.equalTo(0.5)
//                make.width.equalTo(AJScreenWidth)
//                make.left.equalTo(AJScreenWidth/15)
//                make.top.equalTo(text_email.snp.bottom).offset(1)
////                make.top.equalTo(navigationBarHeight+AJScreenHeight/15+0.2)
//            }
            /*第一行结束*/
//
//            //第二行
//            self.view.addSubview(oldPasswd_label)
//            oldPasswd_label.snp.makeConstraints{ (make) in
//                make.left.equalTo(AJScreenWidth/15)
//                make.height.equalTo(AJScreenHeight/15)
//                make.width.equalTo(AJScreenWidth/5)
//                make.top.equalTo(line_frame1.snp.bottom).offset(1)
//            }
            
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
//            //第三行
//            let newPasswd_label = UILabel(frame: CGRect())
//            newPasswd_label.text = "新 密 码"
//            newPasswd_label.font = UIFont.systemFont(ofSize: 18)
//            //        newPasswd_label.backgroundColor = UIColor.red
//            self.view.addSubview(newPasswd_label)
//            newPasswd_label.snp.makeConstraints{ (make) in
//                make.left.equalTo(AJScreenWidth/15)
//                make.height.equalTo(AJScreenHeight/15)
//                make.width.equalTo(AJScreenWidth/5)
//                make.top.equalTo(line_frame2.snp.bottom).offset(1)
//            }
            
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
            
            ////        //第四行
//            //        let verfiedPasswd_label = UILabel(frame: CGRect())
//            let verfiedPasswd_label = UILabel(frame: CGRect())
//            verfiedPasswd_label.text = "确认密码"
//            verfiedPasswd_label.font = UIFont.systemFont(ofSize: 18)
//            //        verfiedPasswd_label.backgroundColor = UIColor.red
//            self.view.addSubview(verfiedPasswd_label)
//            verfiedPasswd_label.snp.makeConstraints{ (make) in
//                make.left.equalTo(AJScreenWidth/15)
//                make.height.equalTo(AJScreenHeight/15)
//                make.width.equalTo(AJScreenWidth/5)
//                make.top.equalTo(line_frame3.snp.bottom).offset(1)
//            }
            
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
        
        
        @objc private func back(){
            self.navigationController?.popViewController(animated: true)
        }
        @objc private func save(){
            let alert = CustomAlertController()
            oldP = self.oldPasswd_textF.text!
            newP = self.newPasswd_textF.text!
            verfiedP = self.verfiedPasswd_textF.text!
//            email = "6666"
//            token = "666"
            
            
            if oldP == ""{
                alert.custom(self, "Attention", "旧密码不能为空")
                return
            }else if newP == ""{
                alert.custom(self, "Attention", "新密码不能为空")
                return
            }else if verfiedP == ""{
                alert.custom(self, "Attention", "确认密码不能为空")
                return
            }else if FormatMethodUtil.validatePasswd(passwd: verfiedP!) != true{
                alert.custom(self, "Attention", "新密码强度不够")
                return
            }else if newP != verfiedP{
                alert.custom(self, "Attention", "新密码和旧密码不同")
                return
            }else{
                let dictString:Dictionary = [ "oldPassword":String(oldP!),"newPassword":String(newP!),"email":String(email),"token":String(token),"userId":UserInfo.getUserId()] as [String : Any]
                print(dictString)
              //  此处的参数需要传入一个字典类型
                Alamofire.request(PASSWDRESET,method: .post,parameters: dictString).responseString{ (response) in
                    
                    if response.result.isSuccess {
                        
                        if let jsonString = response.result.value {
                            
                            if let responseModel = JSONDeserializer<responseAModel>.deserializeFrom(json: jsonString) {
                                // model转json 为了方便在控制台查看
                                print(responseModel.toJSONString(prettyPrint: true)!)
                                
                                /*  此处为跳转和控制逻辑*/
                                if(responseModel.code == 1 ){
                                    print("密码修改成功")
                                    alert.custom_cengji(self,"Attention", "密码修改成功")
                                    self.oldPasswd_textF.text! = ""
                                    self.newPasswd_textF.text! = ""
                                    self.verfiedPasswd_textF.text! = ""
                                
                                }else{
                                    alert.custom_cengji(self,"Attention", "密码修改失败")
                                    self.oldPasswd_textF.text! = ""
                                    self.newPasswd_textF.text! = ""
                                    self.verfiedPasswd_textF.text! = ""
                           
                                }
                                
                            }
                        }
                    }else{
                        alert.custom(self,"Attention", "网络异常")
                    }
                }
            }   
            print(self.oldPasswd_textF.text!)
            print(self.newPasswd_textF.text!)
            print(self.verfiedPasswd_textF.text!)
        }
        


}
