//
//  loginViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/30.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit
import HandyJSON
import Alamofire

class loginViewController: UIViewController,UITextFieldDelegate {
    
    // 记录邮箱
    var email:String?
    // 记录密码
    var password:String?


    private lazy var loginview:loginView = {
        //从这里去寻找登录的视图
        let view = loginView()
        view.setupUI()
        view.userNameTextField.delegate = self
        view.passwordTextField.delegate = self
        view.loginwordButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.forgetPasswordButton.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
        view.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.barTintColor = UIColor.blue
        //navigation顶部的title
        self.title = "登  录"
        self.view.addSubview(loginview)
        loginview.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.left.right.top.equalToSuperview()
        }
    }
    
    /*
     功能：点击登录的动作
     
     */
    @objc func login(){
        print("login clicked.")
        //在此处获取邮箱和密码最为恰当
        let alertController = CustomAlertController()
        email = loginview.userNameTextField.text!
        password = loginview.passwordTextField.text!
        print("邮箱为",email!)
        print("密码为",password!)
        if email == ""{
            alertController.custom(self,"Attention", "邮箱不能为空")
            print("邮箱不能为空")
            return
        }else if password == ""{
            alertController.custom(self,"Attention", "密码不能为空")
            print("密码不能为空")
            return
        }else if validateEmail(email: email!) == true{
            //程序到达此处，说明其他的验证已经成功
//            let jsonString = "{\"email\":\(String(email!)),\"password\":\(String(password!)) }"
            let dictString:Dictionary = [ "email":String(email!),"password":String(password!)]
//            let user = User.deserialize(from: jsonString)
            print(dictString)
            //  此处的参数需要传入一个字典类型
            Alamofire.request(Login_api,method: .post,parameters: dictString).responseString{ (response) in
                
                if response.result.isSuccess {
                    
                    if let jsonString = response.result.value {
                        
                        /// json转model
                        /// 写法一：responseModel.deserialize(from: jsonString)
                        /// 写法二：用JSONDeserializer<T>
                        /*
                           利用JSONDeserializer封装成一个对象。然后再把这个对象解析为
                         */
                        if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                            /// model转json 为了方便在控制台查看
                            print(responseModel.toJSONString(prettyPrint: true)!)
                            
                            /*  此处为跳转和控制逻辑
                              */
                            if(responseModel.code == 1 ){
                                print("登录成功")
                                self.present(AJTabbarController(), animated: false, completion: nil)
                            }else{
                                alertController.custom(self,"Attention", "邮箱或密码不正确")
                            }
                            print(responseModel.code)
                            print(responseModel.msg)
                            print(responseModel.data)
                        }
                    }
                }
            }
            print("邮箱格式正确,登录成功")
            return
        }else{
            alertController.custom(self,"Attention", "邮箱格式错误")
            print("邮箱格式错误")
            return
        }
//       self.present(AJTabbarController(), animated: true, completion: nil)
    }
    @objc func forgetPassword(){
        print("forgetPassword clicked.")
        self.navigationController?.pushViewController(emailCheckViewController(), animated: true)
    }
    @objc func register(){
        print("register clicked.")
        self.navigationController?.pushViewController(registerViewController(), animated: true)
    }

//    func textFieldDidEndEditing(_ textField: UITextField) {
//        // 判断是哪个文本框，将内容赋值给对应的字符串
//        if textField == loginview.userNameTextField{
//            email = textField.text
//            print("邮箱为",email!)
//        }
//        if textField == loginview.passwordTextField{
//            print("跳到密码页")
//            password = textField.text
//            print("密码为",password!)
//        }
//        // 收起键盘
//        textField.resignFirstResponder()
////        return true
//    }
//
//
//
    //此处只做收回键盘的动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "")
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
    //验证邮箱格式
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
}
