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
    private lazy var emailCheckSec:emailCheckSecondView = {
        let view = emailCheckSecondView()
        view.passwordTextField.delegate = self
        view.passwordSecTextField.delegate = self
        view.changeSureButton.addTarget(self, action: #selector(changeSure), for: .touchUpInside)
        view.setupUI()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let x = emailCheckViewController()
//        let y = x.email

        print("上一页传过来的email",email)
        
        print("上一页传过来的verifyString",verifyString)
        self.view.backgroundColor = UIColor.white
        self.title = "修改密码"
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
        // Do any additional setup after loading the view.
    }
    
    //点击确认修改按钮
    @objc func changeSure(){
        let alertController = CustomAlertController()
        password = emailCheckSec.passwordTextField.text!
        passwordSec = emailCheckSec.passwordSecTextField.text!
//        let email:String = "1115824104@qq.com"
//        print(password)
//        print(passwordSec)
        if password == ""{
             alertController.custom(self, "Attention", "新密码不能为空")
            return
        }else if passwordSec == "" {
             alertController.custom(self, "Attention", "确认密码不能为空")
            return
        }else if password != passwordSec{
             alertController.custom(self, "Attention", "两次密码不同")
            return
        }else{//经过前端验证之后，需要进行后端验证
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
                                self.navigationController?.popToRootViewController(animated: true)
                            }else{
                                //先转，后弹
                                self.navigationController?.popToRootViewController(animated: true)
                                alertController.custom(self,"Attention", "修改失败")
                                
                            }
                        } //end of letif
                    }
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
}
