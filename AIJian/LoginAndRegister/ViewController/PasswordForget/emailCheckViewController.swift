//
//  emailCheckViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
/*
   密码修改：邮箱校验的第一个界面
    功能：输入邮箱，获取验证码
 */

import UIKit
import SnapKit
import Alamofire
import HandyJSON

class emailCheckViewController: UIViewController,UITextFieldDelegate {
    
    // 记录邮箱
    var email:String?
    // 记录邮箱验证码
    var email_code:String?
    
    //请求出现转的效果，增加用户体验
    private lazy var indicator = CustomIndicatorView()
    
    
    private lazy var emailCheck:emailCheckView = {
        let view = emailCheckView()
        view.emailTextField.delegate = self
        view.authCodeTextField.delegate = self
        view.nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        view.getAuthCodeButton.addTarget(self, action: #selector(getAuthCode), for: .touchUpInside)
        view.setupUI()
        return view
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
    @objc private func leftButtonClick(){
        self.navigationController?.popViewController(animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: NaviTitleColor]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
//        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
        self.title = "Email Verification"
       // print("到达邮箱验证界面")
        self.view.addSubview(emailCheck)
        emailCheck.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    //点击下一页
    @objc func nextAction(){
        let secViewController:emailCheckSecViewController = emailCheckSecViewController()
        email = emailCheck.emailTextField.text!
        email_code = emailCheck.authCodeTextField.text!
        let alertController = CustomAlertController()
        //获得email和验证码
        //邮箱不能为空
        if email == ""{
            alertController.custom(self, "Attention", "Email Empty")
            return
        }else{
            // 初始化UI
            indicator.setupUI("")
            // 设置风火轮视图在父视图中心
            // 开始转
            indicator.startIndicator()
            self.view.addSubview(indicator)
            indicator.snp.makeConstraints{(make) in
                make.edges.equalToSuperview()
            }
            
            let dictString:Dictionary = [ "email":String(email!),"verifyCode":String(email_code!)]
           // print(dictString)
            //找回密码第一步
            Alamofire.request(RETRIEVEFIRST,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
                if response.result.isSuccess {
                    if let jsonString = response.result.value {
                        //print("进入验证过程")
                        // json转model
                        // 写法一：responseModel.deserialize(from: jsonString)
                        // 写法二：用JSONDeserializer<T>
                        /*
                         利用JSONDeserializer封装成一个对象。然后再解析这个对象
                         */
                        if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                            /// model转json 为了方便在控制台查看
                          //  print(responseModel.toJSONString(prettyPrint: true)!)
                            /*  此处为跳转和控制逻辑
                             */
                            if(responseModel.code == 1 ){
                               // print("邮箱验证成功")
                                //print("跳转到修改密码那一页")
                                // 请求成功，将风火轮移除，并停止转动
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                                secViewController.email = self.email
                                secViewController.verifyString = responseModel.data
                                self.navigationController?.pushViewController(secViewController, animated: false)
                            }else{
                                // // 请求失败，将风火轮移除，并停止转动
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                                alertController.custom(self,"Attention", "Code Error!")
                                return
                            }
                        } //end of letif
                    }
                }else{
                    //没网
                    // 将风火轮移除，并停止转动
                    self.indicator.stopIndicator()
                    self.indicator.removeFromSuperview()
                    
                    alertController.custom(self,"Attention", "Internet Error！")
                }
            }//end of request
        }

    }  //end of nextAction
    
    //点击获取验证码
    @objc func getAuthCode(){
       // print("点击获取验证码")
        let alertController = CustomAlertController()
        email = emailCheck.emailTextField.text!.removeHeadAndTailSpacePro
       // print(email!)
        /*
         需要判断邮箱不为空才能获取验证码
         */
        if email == ""{
            alertController.custom(self, "Attention", "Email Empty")
            return
        }else if FormatMethodUtil.validateEmail(email: email!) == true{
            // 初始化UI
            indicator.setupUI("")
            // 设置风火轮视图在父视图中心
            // 开始转
            indicator.startIndicator()
            self.view.addSubview(indicator)
            indicator.snp.makeConstraints{(make) in
                make.edges.equalToSuperview()
            }
            //只要邮箱正确，就给发送邮件
            emailCheck.getAuthCodeButton.setButtonDisable()
            let  dictString:Dictionary = [ "email":String(email!)]
            //print(dictString)
            Alamofire.request(get_Code_forget,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
                if response.result.isSuccess {
                    if let jsonString = response.result.value {
                        if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                            /// model转json 为了方便在控制台查看
                            //print(responseModel.toJSONString(prettyPrint: true)!)
                            /*  此处为跳转和控制逻辑
                             */
                            // 请求成功，将风火轮移除，并停止转动
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()
                            if(responseModel.code == 1 ){
                                //返回1，让其倒计时
//                                self.emailCheck.getAuthCodeButton.setButtonEnable()
                                self.emailCheck.getAuthCodeButton.countDown(count: 90)
                            }else if responseModel.code == -1{
                                alertController.custom(self,"Attention", "Email is not Registered")
                                self.emailCheck.getAuthCodeButton.setButtonEnable()
                            }else if responseModel.code == 0{
                                alertController.custom(self,"Attention", "Send Error")
                                self.emailCheck.getAuthCodeButton.setButtonEnable()
//                                self.emailCheck.getAuthCodeButton.setTitle("Resend", for: .normal)
//                                self.emailCheck.getAuthCodeButton.countDown(count: 0)
                            }else if responseModel.code == 3{
                                 alertController.custom(self,"Attention", "Your account has been disabled.Please contact oncall@acondiabetescare.com")
                            }
                          //  print("注册时，获取验证码阶段")
                        }
                    }//end of response.result.value
                }else{
                    self.indicator.stopIndicator()
                    self.indicator.removeFromSuperview()
                    alertController.custom(self, "Attention", "Internet Error")
                }//end of response.result.isSuccess
            }//end of request
           
        }else{
            alertController.custom(self, "Attention", "Incorrect Email Format")
            return 
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
}
