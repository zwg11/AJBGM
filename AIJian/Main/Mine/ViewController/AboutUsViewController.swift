//
//  AboutUsViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  关于我们

import UIKit

class AboutUsViewController: UIViewController {
    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AboutUs"
//        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
//        let textView = UITextView(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight))
        let textView = UITextView()
//        textView.backgroundColor = ThemeColor
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        textView.textColor = TextColor
        textView.isEditable = false
        textView.textAlignment = .left
        textView.text = ABOUTUS_STRING
        self.view.addSubview(textView)
        textView.snp.remakeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
        }
        
    }
    
    @objc private func leftButtonClick(){
        self.navigationController?.popViewController(animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
