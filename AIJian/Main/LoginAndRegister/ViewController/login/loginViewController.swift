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
        self.navigationController?.navigationItem.leftBarButtonItem = nil
        self.title = "登  录"
        self.view.addSubview(loginview)
        loginview.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.left.right.top.equalToSuperview()
        }
         hideKeyboardWhenTappedAround()
    }
    
    /*
     功能：点击登录按钮的动作
     */
    @objc func login(){
        print("login clicked.")
        //let path = Bundle.main.path(forResource: "User", ofType: "plist")
        let path = PlistSetting.getFilePath(File: "User.plist")
        print("path：\(path)")
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!

//        self.present(AJTabbarController(), animated: false, completion: nil)
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
        }else if FormatMethodUtil.validateEmail(email: email!) == true{
            //程序到达此处，说明其他的验证已经成功,然后对数据进行校验
            let dictString:Dictionary = [ "email":String(email!),"password":String(password!)]
//            let user = User.deserialize(from: jsonString)
            print(dictString)
            //  此处的参数需要传入一个字典类型
            Alamofire.request(LOGIN_API,method: .post,parameters: dictString).responseString{ (response) in

                if response.result.isSuccess {

                    if let jsonString = response.result.value {

                        /// json转model
                        /// 写法一：responseModel.deserialize(from: jsonString)
                        /// 写法二：用JSONDeserializer<T>
                        /*
                           利用JSONDeserializer封装成一个对象。然后再把这个对象解析为
                         */
                        if let responseModel = JSONDeserializer<loginResponse>.deserializeFrom(json: jsonString) {
                            /// model转json 为了方便在控制台查看
                            print(responseModel.toJSONString(prettyPrint: true)!)

                            /*  此处为跳转和控制逻辑
                              */
                            if(responseModel.code == 1 ){
                                print("登陆成功",responseModel)
                                print("返回的code为1，登录成功")
//                                print(responseModel.data)
                                // 将返回的用户信息写入配置文件
                                data["userId"] = responseModel.data?.userId!
                                data["token"] = responseModel.data?.token!
                                data["email"] = self.email!
//                                data.setObject(responseModel.data?.userId! as Any, forKey: "userId" as NSCopying )
//                                data.setObject(responseModel.data?.token! as Any, forKey: "token" as NSCopying )
//                                data.setObject(self.email!, forKey: "email" as NSCopying )
                                // 保存
                                data.write(toFile: path, atomically: true)

                                // ******************* 初始化数据库 *******************
                                // 创建表，包括用户信息表 和 血糖记录表
                                let sqliteManager = DBSQLiteManager()
                                sqliteManager.createTable()
                                
                                // 向数据库插入用户信息
                                var user1 = USER()
                                user1.user_id = UserInfo.getUserId()
                                user1.token = UserInfo.getToken()
                                user1.email = UserInfo.getEmail()
                                sqliteManager.addUserRecord(user1)
                                
                                self.present(AJTabbarController(), animated: false, completion: nil)
                            }else{
                                print(responseModel)
//                                  print(responseModel.data)
                                alertController.custom(self,"Attention", "邮箱或密码不正确")
                            }
                        }
                    }
                }else{
                    alertController.custom(self,"Attention", "网络连接失败，请稍后重试！")
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
        
        //测试过程中，修改密码时，先跳到第二页
        self.navigationController?.pushViewController(emailCheckViewController(), animated: true)
    }
    
    //跳转到注册界面
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4, animations: {
            self.loginview.frame.origin.y = -150
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, animations: {
            self.loginview.frame.origin.y = 0
        })
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
    
}
