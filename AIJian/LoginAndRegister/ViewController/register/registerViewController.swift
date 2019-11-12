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
    
    var isAgree:Bool = false
    
    //请求出现转的效果，增加用户体验
    private lazy var indicator = CustomIndicatorView()
    // 协议警示框

    
    // 协议内容
    
//    var popTextView:PopTextView = PopTextView()
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
//        self.navigationController?.navigationBar.barTintColor = ThemeColor
//        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: NaviTitleColor]
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
//        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
        self.title = "Sign Up"
        register.NoResponseProtocolLogo.addTarget(self, action: #selector(ClickIcon), for: .touchUpInside)
        register.NoResponseProtocolInfo.addTarget(self, action: #selector(ClickProtocol), for: .touchUpInside)
        self.view.addSubview(register)
        register.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.left.right.equalToSuperview()
//            make.top.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
//                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                // Fallback on earlier versions
            }
        }
        // Do any additional setup after loading the view.
    }
   
    
    @objc func ClickIcon(){
        if isAgree == false{
            register.NoResponseProtocolLogo.setImage(UIImage(named: "selected"), for: .normal)
            isAgree = true
        }else{
            register.NoResponseProtocolLogo.setImage(UIImage(named: "unselected"), for: .normal)
            isAgree = false
        }
    }

    @objc func ClickProtocol(){
        
        self.navigationController?.pushViewController(ProtocalViewController(), animated: false)
//        self.popTextView.whiteViewEndFrame = CGRect.init(x: 20, y: 100, width: AJScreenWidth - AJScreenWidth/8, height: AJScreenHeight - 300)
//        self.popTextView.addAnimate()
//        //                    self.popTextView.textStr = "message"
//        self.popTextView.oneBtn.addTarget(self, action: #selector(self.oneBtn4Click), for: UIControl.Event.touchUpInside)
//        self.popTextView.bbtn.addTarget(self, action: #selector(self.oneBtn4Click), for: .touchUpInside)
    }
    
    
   //注册时，点击下一步
    @objc func nextAction(){
        let infoInput_next: infoInputViewController = infoInputViewController()
        print(infoInput_next)
//        let infoInput_next = infoInputViewController.self
        password = register.passwordTextField.text!.removeHeadAndTailSpacePro
        passwordSec = register.passwordSecTextField.text!
        email_code = register.authCodeTextField.text!
        email = register.emailTextField.text!
        print(email_code!)
        print(email!)
        print(passwordSec!)
        let alertController = CustomAlertController()
        if email == ""{
            alertController.custom(self, "Attention", "Email Empty")
            return
        }else if password == ""{
            alertController.custom(self, "Attention", "Password Empty")
            return
        }else if passwordSec == "" {
            alertController.custom(self, "Attention", "Confirm Password Empty")
            return
        }else if password!.count > 30{  //控制密码长度
            return 
        }else if password != passwordSec{
            alertController.custom(self, "Attention", "Password Not Match")
            return
        }else if FormatMethodUtil.validatePasswd(passwd: password!) != true{
            alertController.custom(self, "Attention", "Password (at least 8 characters)")
            return
        }else if passwordSec!.count >= 254 {
            return
        }else if isAgree == false{
            alertController.custom(self, "Attention", "Please Agree the Protocol")
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
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                               infoInput_next.email = self.email  //将数据传入下一个页面
                               infoInput_next.verifyString = responseModel.data
                               self.navigationController?.pushViewController(infoInput_next, animated: false)  //然后跳转
                            }else{
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                                alertController.custom(self,"Attention", "Incorrect Code")
                                return 
                            }
                            
                        } //得到响应
                    }
                }else{
                    self.indicator.stopIndicator()
                    self.indicator.removeFromSuperview()
                    alertController.custom(self,"Attention", "Internet Error")
                    return
                }
            }
        }
    }
    
    func initDelegate(){
        // 设置所有的文本框的代理，使得代理方法对所有文本框有效
       
    }
    //注册时，获取验证码
    @objc func getAuthCode(){
        let alertController = CustomAlertController()
        email = register.emailTextField.text!
        
        if email == ""{
            alertController.custom(self, "Attention", "Email Empty")
            return
        }
        if FormatMethodUtil.validateEmail(email: email!) == true{
            //只要邮箱正确，就给发送邮件
            self.register.getAuthCodeButton.countDown(count: 90)
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
                            }else{
                                alertController.custom(self,"Attention", "Email or Password Error")
                            }
                    }
                  }//end of response.result.value
                }else{
                    alertController.custom(self, "Attention", "Internet Error")
                }//end of response.result.isSuccess
            }//end of request
            
        }else{
            alertController.custom(self,"Attention", "Incorrect Email Format")
            return
        }
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        UIView.animate(withDuration: 0.2, animations: {
//            self.register.frame.origin.y = -150
//        })
//
//        return true
//    }
//
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
//    @objc func oneBtn4Click(btn:UIButton){
//        //        self.dataMarr.replaceObject(at: 4, with: self.popTextView.textView.text)
////        self.popTextView.tapBtnAndcancelBtnClick()
////        self.popTextView.textView.text = ""
////        let indexPath: IndexPath = NSIndexPath.init(row: 4, section: 0) as IndexPath
//        self.navigationController?.pushViewController(protocolViewC(), animated: false)
//        //        tableView.reloadRows(at: [0,0], with: UITableView.RowAnimation.none)
//    }
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


extension registerViewController{
    
}
