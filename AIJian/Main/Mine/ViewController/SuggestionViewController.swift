//
//  SuggestionViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/14.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "Suggestion"
            // Do any additional setup after loading the view.
            self.view.backgroundColor = UIColor.white
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
            //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(save))
            
            let suggestion_label = UILabel(frame: CGRect())
            suggestion_label.text = "问题与意见"
            suggestion_label.font = UIFont.systemFont(ofSize: 18)
            //        email_label.backgroundColor = UIColor.red
            self.view.addSubview(suggestion_label)
            suggestion_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/2)
                make.left.equalTo(AJScreenWidth/15)
                make.top.equalTo(navigationBarHeight+5)
            }
            
            let content_field = UITextView()
            content_field.backgroundColor = UIColor.white
            content_field.font = UIFont.boldSystemFont(ofSize: 16)
            content_field.textColor = UIColor.black
            content_field.isEditable = true
            content_field.textAlignment = .left
            content_field.layer.borderColor = UIColor(red: 60/255, green: 40/255, blue: 129/255, alpha: 1).cgColor
            content_field.layer.borderWidth = 0.5
            self.view.addSubview(content_field)
            content_field.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/5)
                make.width.equalTo(AJScreenWidth+1)
                make.top.equalTo(suggestion_label.snp.bottom).offset(5)
            }
            
            /*提交按钮*/
            let submit_button = UIButton(type:.system)
            submit_button.backgroundColor = UIColor.red
            submit_button.setTitle("保  存", for:.normal)
            submit_button.tintColor = UIColor.white
            submit_button.layer.cornerRadius = 8
            submit_button.layer.masksToBounds = true
            submit_button.titleLabel?.font = UIFont.systemFont(ofSize:18)
            submit_button.titleLabel?.textColor = UIColor.white
            submit_button.addTarget(self, action: #selector(save), for: .touchUpInside)
            self.view.addSubview(submit_button)
            submit_button.snp.makeConstraints{(make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth*2/5)
                make.top.equalTo(content_field.snp.bottom).offset(10)
                make.left.equalTo(AJScreenWidth*3/10)
            }
            
            
        }
        
        @objc private func back(){
            self.navigationController?.popViewController(animated: true)
        }
        @objc private func save(){
            
        }
        
    }
