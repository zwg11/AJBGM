//
//  registerViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class registerViewController: UIViewController,UITextFieldDelegate {

    private lazy var register:registerView = {
        let view = registerView()
        view.setupUI()

        // 以下代理本想单独拿出来写进函数中，但是不知为什么老是内存溢出
        view.userNameTextField.delegate = self
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

        // 
        self.view.backgroundColor = UIColor.blue
        self.title = "注册"
        self.view.addSubview(register)
        register.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight)
            make.top.left.right.equalToSuperview()
        }
        // Do any additional setup after loading the view.
    }
    

    @objc func nextAction(){
        self.navigationController?.pushViewController(infoInputViewController(), animated: true)
    }
    
    func initDelegate(){
        // 设置所有的文本框的代理，使得代理方法对所有文本框有效
       
    }

    @objc func getAuthCode(){
        register.getAuthCodeButton.countDown(count: 10)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
}
