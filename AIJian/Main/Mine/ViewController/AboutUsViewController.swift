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
    let textView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About Us"
//        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
//        let textView = UITextView(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight))
        
        
        let ABOUTUS_STRING = """
                Headquartered in San Diego, USA, ACON has led the way in developing and making high quality diagnostic and medical devices more affordable to people all around the world for more than 20 years. In fact, the ACON name is well known in over 150 countries. Our state of the art manufacturing facility is ISO 13485:2016 certified,FDA registered, and has been inspected by US FDA.
        
                ACON Diabetes Care is a part of ACON. For over 15 years, ACON Diabetes Care has been focused on providing accurate, painless, and easy to use blood glucose monitoring systems and other related test systems to people with diabetes all over the world. Our products are highly recommended by health care professionals and clinical institutes. ACON Diabetes Care is also committed to delivering health care to people for living with a healthier life.
        """
//        textView.backgroundColor = ThemeColor
        textView.backgroundColor = UIColor.clear
//        textView.font = UIFont.boldSystemFont(ofSize: 16)
        textView.textColor = TextColor
        textView.isEditable = false
        textView.textAlignment = .left
//        let paraph = NSMutableParagraphStyle()
//        paraph.lineSpacing = 10//行间距
//        paraph.paragraphSpacing = 20//段间距
//        paraph.firstLineHeadIndent = 40//首行缩进
//        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paraph, range: range0)
//        textView.attributedText = NSAttributedString(string: ABOUTUS_STRING, attributes: attributes)
//        
//        
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

