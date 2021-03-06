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
    // 血糖记录
    var glucoseRecords:[glucoseDate]?

    private lazy var indicator = CustomIndicatorView()
    private lazy var indicatorForMeter = CustomIndicatorView()

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
        //navigation顶部的title
        self.navigationController?.navigationItem.leftBarButtonItem = nil
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(loginview)
       
        loginview.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.left.right.top.equalToSuperview()
        }
         hideKeyboardWhenTappedAround()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//         print("qqqqqqqqqqqqqqqq",FormatMethodUtil.validateEmail(email: "berapin.wu@aconlab.com.cn"))
//        print("qqqqqqqqqqqqqqqq",FormatMethodUtil.validateEmail(email: "berapin_.wu@_aconlab.com.cn"))
        if UserInfo.getEmail() != ""{
            loginview.userNameTextField.text! = UserInfo.getEmail()
        }else{
            
        }
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.isTranslucent = true
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    /*
     功能：点击登录按钮的动作
     */
    @objc func login(){
        
        //print("login clicked.")
        let path = PlistSetting.getFilePath(File: "User.plist")
        
        let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path)!

        //在此处获取邮箱和密码最为恰当
        let alertController = CustomAlertController()
        email = loginview.userNameTextField.text!.removeHeadAndTailSpacePro
        password = loginview.passwordTextField.text!
        if email == ""{
            alertController.custom(self,"Attention", "Email Empty")
            return
        }else if password == ""{
            alertController.custom(self,"Attention", "Password Empty")
            return
        }else if FormatMethodUtil.validateEmail(email: email!) == true{
            // ****** 弹出加载风火轮 ******
            
            // 初始化UI
            indicator.setupUI("Logining in...")
            // 设置风火轮视图在父视图中心
            // 开始转
            indicator.startIndicator()
            self.view.addSubview(indicator)
            indicator.snp.makeConstraints{(make) in
                make.edges.equalToSuperview()
            }
            
            //程序到达此处，说明其他的验证已经成功,然后对数据进行校验
            let dictString:Dictionary = [ "email":String(email!),"password":String(password!)]
            //  此处的参数需要传入一个字典类型
            AlamofireManager.request(LOGIN_API,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in

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
                           // print(responseModel.toJSONString(prettyPrint: true)!)

                            /*  此处为跳转和控制逻辑
                              */
                            if(responseModel.code == 1 ){
                              //  print("登陆成功",responseModel)
                                //print("返回的code为1，登录成功")
//                                print(responseModel.data)
                                // 将返回的用户信息写入配置文件
                                data["userId"] = responseModel.data?.userId!
                                data["token"] = responseModel.data?.token!
                                data["email"] = self.email!
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
                                // 登陆成功，请求数据
                                self.indicator.setLabelText("Login in Success，Initializing Data..")
                                self.requestData(day: 3000)
                            }else if(responseModel.code == -1){  //返回-1,表示账号被停用了
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                                alertController.custom(self,"Attention", "Your account has been disabled.Please contact oncall@acondiabetescare.com")
                            }else if(responseModel.code == -2){   // 返回-2，表示该邮箱未注册
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                                // 这里的提示信息要改一下
                                
                                alertController.custom(self,"Attention", "Email is not Registered")
                                
                            }else{
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                                
                                alertController.custom(self,"Attention", "Incorrect Email or Password")
                            }
                        }
                    }
                }else{
                    //没网
                    // 将风火轮移除，并停止转动
                    self.indicator.stopIndicator()
                    self.indicator.removeFromSuperview()
                    
                    alertController.custom(self,"Attention", "Internet Error！")
                }
            }
            //print("邮箱格式正确,登录成功")
            
            return
        }else{
            alertController.custom(self,"Attention", "Incorrect Email Format")
            //print("邮箱格式错误")
            return
        }
//       self.present(AJTabbarController(), animated: true, completion: nil)
    }
    @objc func forgetPassword(){
        //print("forgetPassword clicked.")
        
        //测试过程中，修改密码时，先跳到第二页
        self.navigationController?.pushViewController(emailCheckViewController(), animated: false)
    }
    
    //跳转到注册界面
    @objc func register(){
        //print("register clicked.")
        self.navigationController?.pushViewController(registerViewController(), animated: false)
    }

    //此处只做收回键盘的动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print(textField.text ?? "")
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }

    func hideKeyboardWhenTappedAround(){
        // 添加手势，使得点击视图键盘收回/Users/ADMIN/Desktop/swift1
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        // 视图是否接受手势，false为接受
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
 

    
    // 设置手势动作
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
}


extension loginViewController{
    
    // 该函数向服务器请求数据并进行一定程度的数据处理
    // 包括对数据根据日期进行排序，之后分出日期和时间、分健康信息等
    // MARK: - requestData()
    func requestData(day:Int){
        //********
        let day = day
        let usr_id = UserInfo.getUserId()
        let tk = UserInfo.getToken()
        // 设置信息请求字典
        let dicStr:Dictionary = ["day":day,"userId":usr_id,"token":tk] as [String : Any]
       // print(dicStr)
        // 请求数据，请求信息如上字典
        AlamofireManager.request(REQUEST_DATA_URL,method: .post,parameters: dicStr, headers:vheader).responseString{ (response) in
            if response.result.isSuccess {
               // print("收到回复")
                if let jsonString = response.result.value {
                    
                    /// json转model
                    /// 写法一：responseModel.deserialize(from: jsonString)
                    /// 写法二：用JSONDeserializer<T>
                    /*
                     利用JSONDeserializer封装成一个对象。然后再把这个对象解析为
                     */
//                    print("jsonString:\(jsonString)")
                    if let recordInDaysResponse = JSONDeserializer<recordInDaysResponse>.deserializeFrom(json: jsonString) {
                        // 如果 返回信息说明 请求数据失败，则弹出警示框宝报错
                        if recordInDaysResponse.code != 1{
                            // 将风火轮移除，并停止转动
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()
                            // 重新将用户配置文件设为空
                            UserInfo.setToken("")
                            
                            let alert = CustomAlertController()
                            alert.custom(self, "Attention", "\(recordInDaysResponse.msg!)")
                            return
                        }
                        // 存储血糖信息，请求meter信息
                        self.glucoseRecords = recordInDaysResponse.data
                        print("开始请求meter数据")
                        self.GetMeterInfo()
                        
                        
                        
//                        // ******** 将得到的所有数据都添加到数据库 ***********
//                        let sqliteManager = DBSQLiteManager()
//                        // 创建表
//                        sqliteManager.createTable()
//                        // 如果服务器中有对应用户的数据，将数据添加到数据库
//
//                        if recordInDaysResponse.data != nil{
//                            sqliteManager.addGlucoseRecords(add: recordInDaysResponse.data!)
//
//                        }
//
//                        // 将风火轮移除，并停止转动
//                        self.indicator.stopIndicator()
//                        self.indicator.removeFromSuperview()
//
//                        // 显示tabbar
//                        let tabbar = AJTabbarController()
//                        //                                tabbar.isLogin = true
//                        tabbar.modalPresentationStyle = .fullScreen
//                        self.present(tabbar, animated: true, completion: nil)
                        // 重新加载表格内容
                        //self.homeTableView.reloadData()
                    }
                }
            }else{
                // 重新将用户配置文件设为空
                UserInfo.setToken("")
                // 将风火轮移除，并停止转动
                self.indicator.stopIndicator()
                self.indicator.removeFromSuperview()
                
                let alert = CustomAlertController()
                alert.custom(self, "Attention", "Internet Error")
              //  print("没网了")
            }
            
            
        }
        //**********
    }
    // requestData() end
    
    
    // MARK: - GetMeterInfo()
    // 获取该用户所使用过的血糖仪的记录
    func GetMeterInfo(){
        //手动输入数据，请求部分
        
        let dictString = [ "userId":UserInfo.getUserId() as Any,"token":UserInfo.getToken()] as [String : Any]
        // 向服务器申请插入数据请求
        Alamofire.request(METERID_GET,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
            if response.result.isSuccess {
                if let jsonString = response.result.value {
                   // print("进入验证过程")
//                    print(jsonString)
                    // json转model
                    // 写法一：responseModel.deserialize(from: jsonString)
                    // 写法二：用JSONDeserializer<T>
                    /*
                     利用JSONDeserializer封装成一个对象。然后再解析这个对象，此处返回的不同，需要封装成responseAModel的响应体
                     //                         */
                    if let responseModel = JSONDeserializer<METERINFO_GET_RESPONSE>.deserializeFrom(json: jsonString) {
                        /// model转json 为了方便在控制台查看
//                        print("瞧瞧输出的是什么",responseModel.toJSONString(prettyPrint: true)!)
                        /*  此处为跳转和控制逻辑
                         */
                        if(responseModel.code == 1 ){ // 如果请求到meter数据

                            // 向配置文件存储最新记录
                            // 读取配置文件，获取meterID的内容
                            let path0 = PlistSetting.getFilePath(File: "otherSettings.plist")
                            let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: path0)!
                            let arr:NSMutableDictionary = [:]
                            // 更新配置文件内容
                            if let Info = responseModel.data{
                                for i in Info{
                                    arr[i.meterId as Any] = i.recentRecord
                                }
                            }

                            data["meterID"] = arr
                            data.write(toFile: path0, atomically: true)
                            
                            // ******** 将得到的所有血糖数据都添加到数据库 ***********
                            let sqliteManager = DBSQLiteManager()
                            // 创建表
                            sqliteManager.createTable()
                            // 如果服务器中有对应用户的数据，将数据添加到数据库
                            
                            if self.glucoseRecords != nil{
                                sqliteManager.addGlucoseRecords(add: self.glucoseRecords!)
                                
                            }
                            
                            // 将风火轮移除，并停止转动
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()
                            
                            // 显示tabbar
                            let tabbar = AJTabbarController()
                            
                            tabbar.modalPresentationStyle = .fullScreen
                            self.present(tabbar, animated: true, completion: {
                                self.glucoseRecords = nil
                            })
                            
                        }else{ // 如果没请求到数据
                            // 重新将用户配置文件设为空
                            UserInfo.setToken("")
                            // 将风火轮移除，并停止转动
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()
                            
                            let alert = CustomAlertController()
                            alert.custom(self, "Attention", "\(responseModel.msg!)")
                        }
                    } //end of letif
                    else{
                        // 将风火轮移除，并停止转动
                        // 重新将用户配置文件设为空
                        UserInfo.setToken("")
                        self.indicator.stopIndicator()
                        self.indicator.removeFromSuperview()
                        
                        let alert = CustomAlertController()
                        alert.custom(self, "Attention", "Internet Error")
                    }
                }else{
                    // 将风火轮移除，并停止转动
                    // 重新将用户配置文件设为空
                    UserInfo.setToken("")
                    self.indicator.stopIndicator()
                    self.indicator.removeFromSuperview()
                    
                    let alert = CustomAlertController()
                    alert.custom(self, "Attention", "Internet Error")
                }
            }// 请求失败
            else{
                // 重新将用户配置文件设为空
                UserInfo.setToken("")
                // 将风火轮移除，并停止转动
                self.indicator.stopIndicator()
                self.indicator.removeFromSuperview()
                
                let alert = CustomAlertController()
                alert.custom(self, "Attention", "Internet Error")
            }
        }//end of request
        
    }
    

}
