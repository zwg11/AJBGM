//
//  AboutUsViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  关于我们

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AboutUs"
        self.view.backgroundColor = ThemeColor
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        
//        let textView = UITextView(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight))
        let textView = UITextView()
        textView.backgroundColor = ThemeColor
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
    
    @objc private func back(){
        self.navigationController?.popViewController(animated: true)
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
