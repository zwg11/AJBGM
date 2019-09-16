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



    private lazy var indicator = CustomIndicatorView()

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
        self.navigationController?.navigationBar.backgroundColor = ThemeColor
//        self.title = "登  录"
        self.view.addSubview(loginview)
        loginview.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.left.right.top.equalToSuperview()
        }
         hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
            // ****** 弹出加载风火轮 ******
            
            // 初始化UI
            indicator.setupUI("正在登录")
            // 设置风火轮视图在父视图中心
            // 开始转
            indicator.startIndicator()
            self.view.addSubview(indicator)
            indicator.snp.makeConstraints{(make) in
                make.edges.equalToSuperview()
            }
//            indicator.center = self.view.center
//            indicator.frame.size = CGSize(width: 40, height: 60)
            
            
            
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
                                // 登陆成功，请求数据
                                self.indicator.setLabelText("登录成功，正在初始化数据")
                                self.requestData(day: 30)

 
                            }else{
                                print(responseModel)
                                  print(responseModel.data)
                                // 将风火轮移除，并停止转动
                                self.indicator.stopIndicator()
                                self.indicator.removeFromSuperview()
                                
                                alertController.custom(self,"Attention", "邮箱或密码不正确")
                            }
                        }
                    }
                }else{
                    // 将风火轮移除，并停止转动
                    self.indicator.stopIndicator()
                    self.indicator.removeFromSuperview()
                    
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
        self.navigationController?.pushViewController(emailCheckSecViewController(), animated: true)
    }
    
    //跳转到注册界面
    @objc func register(){
        print("register clicked.")
        self.navigationController?.pushViewController(infoInputViewController(), animated: true)
    }

    //此处只做收回键盘的动作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "")
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
    // requestData()
    func requestData(day:Int){
        //********
        let day = day
        let usr_id = UserInfo.getUserId()
        let tk = UserInfo.getToken()
        // 设置信息请求字典
        let dicStr:Dictionary = ["day":day,"userId":usr_id,"token":tk] as [String : Any]
        print(dicStr)
        // 请求数据，请求信息如上字典
        Alamofire.request(REQUEST_DATA_URL,method: .post,parameters: dicStr).responseString{ (response) in
            if response.result.isSuccess {
                print("收到回复")
                if let jsonString = response.result.value {
                    
                    /// json转model
                    /// 写法一：responseModel.deserialize(from: jsonString)
                    /// 写法二：用JSONDeserializer<T>
                    /*
                     利用JSONDeserializer封装成一个对象。然后再把这个对象解析为
                     */
                    print("jsonString:\(jsonString)")
                    if let recordInDaysResponse = JSONDeserializer<recordInDaysResponse>.deserializeFrom(json: jsonString) {
                        // 如果 返回信息说明 请求数据失败，则弹出警示框宝报错
                        if recordInDaysResponse.code != 1{
                            // 将风火轮移除，并停止转动
                            self.indicator.stopIndicator()
                            self.indicator.removeFromSuperview()
                            
                            let alert = CustomAlertController()
                            alert.custom(self, "警告", "\(recordInDaysResponse.msg!)")
                            return
                        }
                        
                        // ******** 将得到的所有数据都添加到数据库 ***********
                        let sqliteManager = DBSQLiteManager()
                        // 创建表
                        sqliteManager.createTable()
                        // 如果服务器中有对应用户的数据，将数据添加到数据库
                        if recordInDaysResponse.data != nil{
                            sqliteManager.addGlucoseRecords(add: recordInDaysResponse.data!)
                            
                        }
                        
                        // 将风火轮移除，并停止转动
                        self.indicator.stopIndicator()
                        self.indicator.removeFromSuperview()
                        
                        // 显示tabbar
                        let tabbar = AJTabbarController()
                        //                                tabbar.isLogin = true
                        self.present(tabbar, animated: false, completion: nil)
                        // 重新加载表格内容
                        //self.homeTableView.reloadData()
                    }
                }
            }else{
                // 将风火轮移除，并停止转动
                self.indicator.stopIndicator()
                self.indicator.removeFromSuperview()
                
                let alert = CustomAlertController()
                alert.custom(self, "警告", "网络异常，请稍后重试")
                print("没网了")
            }
            
            
        }
        //**********
    }
    // requestData() end

}
