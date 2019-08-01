//
//  loginViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/30.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class loginViewController: UIViewController,UITextFieldDelegate {
    
    // 记录i姓名
    var name:String?
    // 记录密码
    var password:String?


    private lazy var loginview:loginView = {
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
        self.title = "登录"
        self.view.addSubview(loginview)
        loginview.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.left.right.top.equalToSuperview()
        }

        // Do any additional setup after loading the view.
    }
    

    @objc func login(){
        print("login clicked.")
        self.present(AJTabbarController(), animated: true, completion: nil)
    }
    @objc func forgetPassword(){
        print("forgetPassword clicked.")
        self.navigationController?.pushViewController(emailCheckViewController(), animated: true)
    }
    @objc func register(){
        print("register clicked.")
        self.navigationController?.pushViewController(registerViewController(), animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "")
        
        // 判断是哪个文本框，将内容赋值给对应的字符串
        if textField == loginview.userNameTextField{
            name = textField.text
        }
        else if textField == loginview.passwordTextField{
            password = textField.text
        }
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
}
