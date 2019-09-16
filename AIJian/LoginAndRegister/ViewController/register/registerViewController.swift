//
//  registerViewController.swift
//  AIJian
//
//  Created by zzz on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
/**
    功能：认证邮箱注册，填入密码
    界面：有输入邮箱，验证邮箱，输入验证码。   密码。。确认密码
 ***/

import UIKit
import SnapKit
import Alamofire
import HandyJSON

class registerViewController: UIViewController,UITextFieldDelegate {

    //输入新密码
    var  password:String?
    //输入确认密码
    var  passwordSec:String?
    // 记录邮箱
    var email:String?
    // 记录邮箱验证码
    var email_code:String?
    //传给下一个页面的data,防止任何人都能重置用户信息
    var data:String?
    
    private lazy var register:registerView = {
        let view = registerView()
        view.setupUI()

        // 以下代理本想单独拿出来写进函数中，但是不知为什么老是内存溢出
//        view.userNameTextField.delegate = self
        view.emailTextField.delegate = self
        view.authCodeTextField.delegate = self
        view.passwordTextField.delegate = self
        view.passwordSecTextField.delegate = self
        initDelegate()
        view.nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        view.getAuthCodeButton.addTarget(self, action: #selector(getAuthCode), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = ThemeColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: NaviTitleColor]
        self.view.backgroundColor = ThemeColor
        self.title = "Sign Up"
        self.view.addSubview(register)
        register.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.top.left.right.equalToSuperview()
        }
        // Do any additional setup after loading the view.
    }
    
   //注册时，点击下一步
    @objc func nextAction(){
        let infoInput_next: infoInputViewController = infoInputViewController()
        print(infoInput_next)
//        let infoInput_next = infoInputViewController.self
        password = register.passwordTextField.text!
        passwordSec = register.passwordSecTextField.text!
        email_code = register.authCodeTextField.text!
        email = register.emailTextField.text!
        print(password!)
        print(passwordSec!)
        let alertController = CustomAlertController()
        
        if password == ""{
            alertController.custom(self, "Attention", "新密码不能为空")
            return
        }else if passwordSec == "" {
            alertController.custom(self, "Attention", "确认密码不能为空")
            return
        }else if password != passwordSec{
            alertController.custom(self, "Attention", "两次密码不同")
            return
        }else if email == ""{
            alertController.custom(self, "Attention", "邮箱不能为空")
            return
        }else if FormatMethodUtil.validatePasswd(passwd: password!) != true{
            alertController.custom(self, "Attention", "密码强度不够")
            return
        }else{
            let dictString:Dictionary = [ "email":String(email!),"verifyCode":String(email_code!),"password":String(password!)]
            //            let user = User.deserialize(from: jsonString)
            print(dictString)
            //  此处的参数需要传入一个字典类型
            Alamofire.request(UserRegister,method: .post,parameters: dictString).responseString{ (response) in
                
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
                                infoInput_next.email = self.email  //将数据传入下一个页面
                               infoInput_next.verifyString = responseModel.data
                               self.navigationController?.pushViewController(infoInput_next, animated: true)  //然后跳转
                            }else{
//                                infoInput_next.email = self.email
//                                infoInput_next.verifyString = "edbdkeisoaoen45673"
//                                self.navigationController?.pushViewController(infoInput_next, animated: true)
                                alertController.custom(self,"Attention", "验证码错误")
                                return 
                            }
                            
                        } //得到响应
                    }
                }else{
                    alertController.custom(self,"Attention", "网络错误")
                    return
                }
            }
        }
//
//        let nv = infoInputViewController()
//        self.navigationController?.pushViewController(infoInputViewController(), animated: true)
    }
    
    func initDelegate(){
        // 设置所有的文本框的代理，使得代理方法对所有文本框有效
       
    }
    //注册时，获取验证码
    @objc func getAuthCode(){
        let alertController = CustomAlertController()
        email = register.emailTextField.text!
        if email == ""{
            alertController.custom(self, "Attention", "邮箱不能为空")
        }else if FormatMethodUtil.validateEmail(email: email!) == true{
            print("获取验证码阶段")
            print("如果不为空的话",email!)
            let  dictString:Dictionary = [ "email":String(email!)]
            print(dictString)
            Alamofire.request(get_Code,method: .post,parameters: dictString).responseString{ (response) in
                if response.result.isSuccess {
                    if let jsonString = response.result.value {
                        if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                            /// model转json 为了方便在控制台查看
                            print(responseModel.toJSONString(prettyPrint: true)!)
                            /*  此处为跳转和控制逻辑
                             */
                            if(responseModel.code == 1 ){
                                //返回1，让其倒计时
                                self.register.getAuthCodeButton.countDown(count: 10)
                            }else{
                                alertController.custom(self,"Attention", "邮箱或密码不正确")
                            }
                        print("注册时，获取验证码阶段")
                    }
                  }//end of response.result.value
                }else{
                    alertController.custom(self, "Attention", "网络请求失败")
                }//end of response.result.isSuccess
            }//end of request
            
        }else{
            alertController.custom(self,"Attention", "邮箱格式错误")
            print("邮箱格式错误")
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        UIView.animate(withDuration: 0.2, animations: {
            self.register.frame.origin.y = -150
        })
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收起键盘
//        UIView.animate(withDuration: 0.2, animations: {
//            self.register.frame.origin.y = -150
//        })
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.4, animations: {
//            self.register.frame.origin.y = -150
//        })
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.2, animations: {
//            self.register.frame.origin.y = 0
//        })
//    }
    
}

