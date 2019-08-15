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

class emailCheckSecViewController: UIViewController,UITextFieldDelegate {

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
    

    @objc func changeSure(){
        self.navigationController?.popToViewController(loginViewController(), animated: true)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
}
