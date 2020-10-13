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
        view.emailTextField.tag = 0
        view.emailTextField.delegate = self
        view.authCodeTextField.tag = 1
        view.authCodeTextField.delegate = self
        view.passwordTextField.tag = 2
        view.passwordTextField.delegate = self
        view.passwordSecTextField.tag = 3
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
//    let alertProctoController = UIAlertController(title: "Attention",message: "",
//                                            preferredStyle: .alert)
//
//    func getNSAtributedString(str:String){
//        let myMutableString = NSMutableAttributedString(string:str)
//        let range2 = NSMakeRange(2, 2)
//        myMutableString.addAttribute, range: <#T##NSRange#>)
//    }
        

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
        
//        var labela = UILabel.init()
//        let stringa = "Hello world"
//        labela.attributedText = getNSAtributedString(str: stringa)
//
        
        
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
            register.NoResponseProtocolLogo.setImage(UIImage(named: "selected-1"), for: .normal)
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
       // print(infoInput_next)
//        let infoInput_next = infoInputViewController.self
        password = register.passwordTextField.text!.removeHeadAndTailSpacePro
        passwordSec = register.passwordSecTextField.text!
        email_code = register.authCodeTextField.text!
        email = register.emailTextField.text!
       // print(email_code!)
        //print(email!)
       // print(passwordSec!)
        let alertController = CustomAlertController()
        if email == ""{
            alertController.custom(self, "Attention", "No Email Address")
            return
        }else if FormatMethodUtil.validateEmail(email: email!) != true{
            alertController.custom(self,"Attention", "Incorrect Email Format")
            return
        }else if password == ""{
            alertController.custom(self, "Attention", "No Password")
            return
        }else if passwordSec == "" {
            alertController.custom(self, "Attention", "No Confirm Password")
            return
        }else if password!.count >= 20{
            alertController.custom(self, "Attention", "Incorrect Confirm Password Format.The password length should be 6 or 20 digits.")
            return
        }else if password!.count < 6 {
            alertController.custom(self, "Attention", "Incorrect Confirm Password Format.The password length should be 6 or 20 digits.")
            return
        }else if password != passwordSec{
            alertController.custom(self, "Attention", "Password Not Match")
            return
        }else if isAgree == false{
            alertController.custom(self, "Attention", "Agree Registration Protocol and Submit the Information")
            return
//            let text = "Agree Registration Protocol and Submit the Information"
//            let textRange = NSMakeRange(6, 22)
//            let attributedText = NSMutableAttributedString(string:text)
//            attributedText.addAttribute(NSAttributedString.Key.underlineStyle,value: NSUnderlineStyle.single.rawValue, range: textRange)
//
//            let lab = UILabel()
//
//            let width1 = UIScreen.main.bounds.width
//            lab.numberOfLines = 0
//            lab.lineBreakMode = .byWordWrapping
//
//            lab.attributedText = attributedText
//            lab.textAlignment = .center
//
//            lab.sizeToFit()
//            let alertController = UIAlertController(title: "Attention",message: "\n\n",
//            preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "Done", style: .default, handler: {
//                    action in
//            })
//            alertController.view.addSubview(lab)
//            lab.snp.makeConstraints{(make) in
//                make.width.equalTo(width1-80)
//                make.top.equalToSuperview().offset(20)
//                make.centerX.equalToSuperview()
//                make.height.equalTo(100)
//            }
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//
//            return
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
           // print(dictString)
            //  此处的参数需要传入一个字典类型
            Alamofire.request(UserRegister,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
                
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
                           // print(responseModel.toJSONString(prettyPrint: true)!)
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()
                            /*  此处为跳转和控制逻辑
                             */
                            print(responseModel)
                            if(responseModel.code == 1 ){
                               infoInput_next.email = self.email  //将数据传入下一个页面
                               infoInput_next.verifyString = responseModel.data
                               self.navigationController?.pushViewController(infoInput_next, animated: false)  //然后跳转
                            }else if(responseModel.code == 0){
                                alertController.custom(self, "Attention", responseModel.msg)
                                return
                            }else{
                                alertController.custom(self,"Attention","Sign Up Failure")
                                return 
                            }
//                            }else if(responseModel.msg! == "Incorrect Code"){
//                                print(responseModel)
//                                alertController.custom(self,"Attention", "Incorrect Code")
//                                return
//                            }else{
//                                alertController.custom(self,"Attention", "Sign Up Failure")
//                                return
//                            }
                            
                        } //得到响应
                    }
                }else{
                    self.indicator.stopIndicator()
                    self.indicator.removeFromSuperview()
                    alertController.custom(self,"Attention", "Failed!Internet Error")
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
            alertController.custom(self, "Attention", "No Email Address")
            return
        }
        if FormatMethodUtil.validateEmail(email: email!) == true{
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
            self.register.getAuthCodeButton.setButtonDisable()
            let  dictString:Dictionary = [ "email":String(email!)]
         //   print(dictString)
            Alamofire.request(get_Code,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
                if response.result.isSuccess {
                    if let jsonString = response.result.value {
                        if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                            /// model转json 为了方便在控制台查看
                            //print(responseModel.toJSONString(prettyPrint: true)!)
                            /*  此处为跳转和控制逻辑
                             */
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()
                            if(responseModel.code == 1 ){
                                //返回1，让其倒计时
                                self.register.getAuthCodeButton.countDown(count: 90)
                            }else if(responseModel.code == -1 ){
                                alertController.custom(self,"Attention", "The email has been registered")
                                self.register.getAuthCodeButton.setButtonEnable()
                            }else if responseModel.code == 3{
                                alertController.custom(self,"Attention", "Your account is disabled. Please contact info@aconlabs.com")
                            }else{
                                alertController.custom(self,"Attention", "Failed")
                                self.register.getAuthCodeButton.setButtonEnable()
                            }
                    }
                  }//end of response.result.value
                }else{
                    self.indicator.stopIndicator()
                    self.indicator.removeFromSuperview()
                    alertController.custom(self, "Attention", "Failed!Internet Error")
                }//end of response.result.isSuccess
            }//end of request
            
        }else{//此处不需要添加移除操作
            alertController.custom(self,"Attention", "Incorrect Email Format")
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       //如果tag == 1，则为密码输入框
       if textField.tag == 2 || textField.tag == 3{
           let limitation = 20
           let futureStr:NSMutableString = NSMutableString(string: textField.text!)
           futureStr.insert(string, at: range.location)
           if futureStr.length > limitation {
               return false
           }
           return true
       }
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
