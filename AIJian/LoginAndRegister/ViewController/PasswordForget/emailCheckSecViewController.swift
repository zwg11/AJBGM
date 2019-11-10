//
//  emailCheckSecViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
 /*
    密码修改：邮箱校验的第二个界面
    功能：要求输入新密码和确认密码
 */


import UIKit
import SnapKit
import Alamofire
import HandyJSON

class emailCheckSecViewController: UIViewController,UITextFieldDelegate {
    
    //输入新密码
    var  password:String?
    //输入确认密码
    var  passwordSec:String?
    //认证字符串
    var verifyString:String?
    //修改谁的邮箱，由前一页传过来的
    var email:String?
    
    //请求出现转的效果，增加用户体验
    private lazy var indicator = CustomIndicatorView()
    
    private lazy var emailCheckSec:emailCheckSecondView = {
        let view = emailCheckSecondView()
        view.passwordTextField.delegate = self
        view.passwordSecTextField.delegate = self
        view.changeSureButton.addTarget(self, action: #selector(changeSure), for: .touchUpInside)
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
//        let x = emailCheckViewController()
//        let y = x.email

        print("上一页传过来的email",email)
        
        print("上一页传过来的verifyString",verifyString)
        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.backgroundColor = NavBarColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: NaviTitleColor]
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
         self.view.backgroundColor = UIColor.clear
        self.title = "Change Password"
//        self.navigationController?.navigationBar.tintColor = TextColor
        self.view.addSubview(emailCheckSec)
        emailCheckSec.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
        }
       hideKeyboardWhenTappedAround()
    }
    
    //点击确认修改按钮
    @objc func changeSure(){
        let alertController = CustomAlertController()
        password = emailCheckSec.passwordTextField.text!
        passwordSec = emailCheckSec.passwordSecTextField.text!
        if password == ""{
             alertController.custom(self, "Attention", "New Password Empty")
            return
        }else if passwordSec == "" {
             alertController.custom(self, "Attention", "Confirm Password Empty")
            return
        }else if password!.count >= 30{
            return
        }else if FormatMethodUtil.validatePasswd(passwd: password!) != true{
            alertController.custom(self, "Attention", "Password (at least 8 characters)")
            return
        }else if password != passwordSec{
             alertController.custom(self, "Attention", "Passwords Not Match")
            return
        }else{//经过前端验证之后，需要进行后端验证
            // 初始化UI
            indicator.setupUI("")
            // 设置风火轮视图在父视图中心
            // 开始转
            indicator.startIndicator()
            self.view.addSubview(indicator)
            indicator.snp.makeConstraints{(make) in
                make.edges.equalToSuperview()
            }
            print(email!)
            print(verifyString!)
            let dictString:Dictionary = [ "newPassword":String(password!),"email":String(email!),"verifyString":String(verifyString!)]
             print(dictString)
             Alamofire.request(RETRIEVESECOND,method: .post,parameters: dictString).responseString{ (response) in
                if response.result.isSuccess {
                    if let jsonString = response.result.value {
                        print("进入验证过程")
                        // json转model
                        // 写法一：responseModel.deserialize(from: jsonString)
                        // 写法二：用JSONDeserializer<T>
                        /*
                         利用JSONDeserializer封装成一个对象。然后再解析这个对象，此处返回的不同，需要封装成responseAModel的响应体
                         */
                        if let responseModel = JSONDeserializer<responseAModel>.deserializeFrom(json: jsonString) {
                            /// model转json 为了方便在控制台查看
                            print(responseModel.toJSONString(prettyPrint: true)!)
                            /*  此处为跳转和控制逻辑
                             */
                            if(responseModel.code == 1 ){
                                print("重置成功")
                                print("跳转到修改密码那一页")
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                                self.navigationController?.popToRootViewController(animated: false)
                                 alertController.custom_cengji(self,"Attention", "Password Reset Success")
                            }else{
                                //先转，后弹
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                                self.navigationController?.popToRootViewController(animated: false)
                                alertController.custom_cengji(self,"Attention", "Password Reset Failed")
                            }
                        } //end of letif
                    }
                }else{
                    self.indicator.stopIndicator()
                    self.indicator.removeFromSuperview()
                    alertController.custom(self,"Attention", "Internet Error！")
                }
            }//end of request
        }
        
        
          //如果修改成功，就直接跳转登录界面
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }

    
    func hideKeyboardWhenTappedAround(){
        // 添加手势，使得点击视图键盘收回/Users/ADMIN/Desktop/swift1
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    // 设置手势动作
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
}
