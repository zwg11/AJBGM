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
    var scrollView:UIScrollView = UIScrollView()
    
    lazy var text_title_one:UILabel = {
        let text_title_one = UILabel()
        text_title_one.font = UIFont.boldSystemFont(ofSize: 18)
        text_title_one.text = "ACON Headquarter:"
        text_title_one.textColor = TextColor
        return text_title_one
    }()
    
    lazy var text_one:UILabel = {
        let text_one = UILabel()
        text_one.font = UIFont.systemFont(ofSize: 16)
        text_one.lineBreakMode = NSLineBreakMode.byCharWrapping
        text_one.numberOfLines = 0
        text_one.text = " ACON Laboratories, Inc. \n 5850 Oberlin Drive, #340, San Diego, CA 92121, USA \n Email: info@aconlabs.com \n Phone: +1-858-875-8000"
        text_one.textColor = TextColor
        return text_one
    }()
    
    lazy var text_title_two:UILabel = {
          let text_title_two = UILabel()
          text_title_two.font = UIFont.boldSystemFont(ofSize: 18)
          text_title_two.text = "ACON Asia Pacific Center:"
          text_title_two.textColor = TextColor
          return text_title_two
      }()
      
      lazy var text_two:UILabel = {
          let text_two = UILabel()
          text_two.font = UIFont.systemFont(ofSize: 16)
          text_two.lineBreakMode = NSLineBreakMode.byCharWrapping
          text_two.numberOfLines = 0
          text_two.text = " ACON Biotech (Hangzhou) Co., Ltd. \n No. 210 Zhenzhong Road, West Lake District, Hangzhou, 310030, P.R. China \n Email:marketing1@aconlabs.com.cn \n Phone: +86-571-8777-5528"
          text_two.textColor = TextColor
          return text_two
      }()
    
    
    
    
    let textView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact Us"
        self.view.backgroundColor = UIColor.clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
//        let textView = UITextView(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight))
        
//
//        let ABOUTUS_STRING = """
//                Headquartered in San Diego, USA, ACON has led the way in developing and making high quality diagnostic and medical devices more affordable to people all around the world for more than 20 years. In fact, the ACON name is well known in over 150 countries. Our state of the art manufacturing facility is ISO 13485:2016 certified,FDA registered, and has been inspected by US FDA.
//
//                ACON Diabetes Care is a part of ACON. For over 15 years, ACON Diabetes Care has been focused on providing accurate, painless, and easy to use blood glucose monitoring systems and other related test systems to people with diabetes all over the world. Our products are highly recommended by health care professionals and clinical institutes. ACON Diabetes Care is also committed to delivering health care to people for living with a healthier life.
//        """
////        textView.backgroundColor = ThemeColor
//        textView.backgroundColor = UIColor.clear
//        textView.font = UIFont.boldSystemFont(ofSize: 16)
//        textView.textColor = TextColor
//        textView.isEditable = false
//        textView.textAlignment = .left
//
//        textView.text = ABOUTUS_STRING
        
        scrollView.contentSize = CGSize(width: AJScreenWidth, height: AJScreenHeight+1)
        scrollView.showsVerticalScrollIndicator = true
        
        // 添加滚动视图
        scrollView.backgroundColor = UIColor.clear
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
      
        self.scrollView.addSubview(text_title_one)
        text_title_one.snp.remakeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(5)
        }
        
        self.scrollView.addSubview(text_one)
        text_one.snp.remakeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.top.equalTo(text_title_one.snp.bottom).offset(5)
        }
        self.scrollView.addSubview(text_title_two)
        text_title_two.snp.remakeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(text_one.snp.bottom).offset(15)
        }
        
        self.scrollView.addSubview(text_two)
        text_two.snp.remakeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(120)
            make.top.equalTo(text_title_two.snp.bottom).offset(5)
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

