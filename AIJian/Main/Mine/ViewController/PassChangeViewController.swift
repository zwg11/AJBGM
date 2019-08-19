//
//  PassChangeViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  密码修改页

import UIKit

class PassChangeViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //        let font_size = 18
            self.title = "pass"
            // Do any additional setup after loading the view.
            self.view.backgroundColor = UIColor.white
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(save))
            
            /*第一行开始*/
            let email_label = UILabel(frame: CGRect())
            email_label.text = "邮      箱"
            email_label.font = UIFont.systemFont(ofSize: 18)
            //        email_label.backgroundColor = UIColor.red
            self.view.addSubview(email_label)
            email_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(AJScreenWidth/15)
                make.top.equalTo(navigationBarHeight)
            }
            
            let text_email = UILabel()
            text_email.font = UIFont.systemFont(ofSize: 16)
            text_email.text = "11147852@qq.com"
            //        text_email.allowsEditingTextAttributes = false
            //        text_email.background = UIColor.gray
            //        text_email.borderStyle = .none
            self.view.addSubview(text_email)
            text_email.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/2)
                make.left.equalTo(email_label.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(navigationBarHeight)
            }
            
            //第一条线
            let line_frame1 = UIView(frame: CGRect())
            line_frame1.backgroundColor = UIColor.black
            self.view.addSubview(line_frame1)
            line_frame1.snp.makeConstraints{ (make) in
                make.height.equalTo(0.1)
                make.width.equalTo(AJScreenWidth)
                make.left.equalTo(AJScreenWidth/15)
                make.top.equalTo(navigationBarHeight+AJScreenHeight/15+0.2)
            }
            
            
            /*第一行结束*/
            
            //第二行
            let oldPasswd_label = UILabel(frame: CGRect())
            oldPasswd_label.text = "旧 密 码"
            oldPasswd_label.font = UIFont.systemFont(ofSize: 18)
            //        oldPasswd_label.backgroundColor = UIColor.red
            self.view.addSubview(oldPasswd_label)
            oldPasswd_label.snp.makeConstraints{ (make) in
                make.left.equalTo(AJScreenWidth/15)
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/5)
                make.top.equalTo(navigationBarHeight+AJScreenHeight/15+0.3)
            }
            
            let oldPasswd_textF = UITextField()
            oldPasswd_textF.font = UIFont.systemFont(ofSize: 16)
            //        oldPasswd_textF.text = "11147852@qq.com"
            oldPasswd_textF.placeholder="请填写旧密码"
            oldPasswd_textF.allowsEditingTextAttributes = false
            //        text_email.background = UIColor.gray
            oldPasswd_textF.borderStyle = .none
            self.view.addSubview(oldPasswd_textF)
            oldPasswd_textF.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/2)
                make.left.equalTo(email_label.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(navigationBarHeight+AJScreenHeight/15+0.3)
            }
            
            //第二条线
            let line_frame2 = UIView(frame: CGRect())
            line_frame2.backgroundColor = UIColor.black
            self.view.addSubview(line_frame2)
            line_frame2.snp.makeConstraints{ (make) in
                make.height.equalTo(0.1)
                make.left.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth)
                make.top.equalTo(navigationBarHeight+AJScreenHeight/15*2+0.3)
            }
            ////        //第三行
            let newPasswd_label = UILabel(frame: CGRect())
            newPasswd_label.text = "新 密 码"
            newPasswd_label.font = UIFont.systemFont(ofSize: 18)
            //        newPasswd_label.backgroundColor = UIColor.red
            self.view.addSubview(newPasswd_label)
            newPasswd_label.snp.makeConstraints{ (make) in
                make.left.equalTo(AJScreenWidth/15)
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/5)
                make.top.equalTo(navigationBarHeight+AJScreenHeight/15*2+0.4)
            }
            
            let newPasswd_textF = UITextField()
            newPasswd_textF.font = UIFont.systemFont(ofSize: 16)
            //        oldPasswd_textF.text = "11147852@qq.com"
            newPasswd_textF.placeholder="请填写新密码"
            newPasswd_textF.allowsEditingTextAttributes = false
            //        text_email.background = UIColor.gray
            newPasswd_textF.borderStyle = .none
            self.view.addSubview(newPasswd_textF)
            newPasswd_textF.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/2)
                make.left.equalTo(email_label.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(navigationBarHeight+AJScreenHeight/15*2+0.4)
            }
            //第三条线
            let line_frame3 = UIView(frame: CGRect())
            line_frame3.backgroundColor = UIColor.black
            self.view.addSubview(line_frame3)
            line_frame3.snp.makeConstraints{ (make) in
                make.height.equalTo(0.1)
                make.left.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth)
                make.top.equalTo(navigationBarHeight+AJScreenHeight/15*3+0.3)
            }
            
            ////        //第四行
            //        let verfiedPasswd_label = UILabel(frame: CGRect())
            let verfiedPasswd_label = UILabel(frame: CGRect())
            verfiedPasswd_label.text = "确认密码"
            verfiedPasswd_label.font = UIFont.systemFont(ofSize: 18)
            //        verfiedPasswd_label.backgroundColor = UIColor.red
            self.view.addSubview(verfiedPasswd_label)
            verfiedPasswd_label.snp.makeConstraints{ (make) in
                make.left.equalTo(AJScreenWidth/15)
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/5)
                make.top.equalTo(navigationBarHeight+AJScreenHeight/15*3+0.4)
            }
            
            let verfiedPasswd_textF = UITextField()
            verfiedPasswd_textF.font = UIFont.systemFont(ofSize: 16)
            //        oldPasswd_textF.text = "11147852@qq.com"
            verfiedPasswd_textF.placeholder="请再次确认新密码"
            verfiedPasswd_textF.allowsEditingTextAttributes = false
            //        text_email.background = UIColor.gray
            verfiedPasswd_textF.borderStyle = .none
            self.view.addSubview(verfiedPasswd_textF)
            verfiedPasswd_textF.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/2)
                make.left.equalTo(email_label.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(navigationBarHeight+AJScreenHeight/15*3+0.4)
            }
            //第四条线
            let line_frame4 = UIView(frame: CGRect())
            line_frame4.backgroundColor = UIColor.black
            self.view.addSubview(line_frame4)
            line_frame4.snp.makeConstraints{ (make) in
                make.height.equalTo(0.5)
                make.left.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth)
                make.top.equalTo(navigationBarHeight+AJScreenHeight/15*4+2)
            }
            //
        }
        
        
        @objc private func back(){
            self.navigationController?.popViewController(animated: true)
        }
        @objc private func save(){
            
        }
        


}
