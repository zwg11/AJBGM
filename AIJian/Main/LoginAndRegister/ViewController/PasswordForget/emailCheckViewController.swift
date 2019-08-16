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

class emailCheckViewController: UIViewController,UITextFieldDelegate {
    
    private lazy var emailCheck:emailCheckView = {
        let view = emailCheckView()
        view.emailTextField.delegate = self
        view.authCodeTextField.delegate = self
        view.nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        view.getAuthCodeButton.addTarget(self, action: #selector(getAuthCode), for: .touchUpInside)
        view.setupUI()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "邮箱验证"
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
    

    @objc func nextAction(){
        self.navigationController?.pushViewController(emailCheckSecViewController(), animated: true)
    }

    @objc func getAuthCode(){
        emailCheck.getAuthCodeButton.countDown(count: 10)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
}
