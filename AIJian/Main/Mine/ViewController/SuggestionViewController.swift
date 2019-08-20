//
//  SuggestionViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/14.
//  Copyright © 2019 apple. All rights reserved.
//  意见反馈页

import UIKit
import Alamofire
import HandyJSON

class SuggestionViewController: UIViewController, UITextViewDelegate{
    
        //存放文本的变量
        var textArea:String? = nil
        lazy var content_field:UITextView = {
            let content_field = UITextView()
            content_field.backgroundColor = UIColor.white
            content_field.font = UIFont.boldSystemFont(ofSize: 16)
            content_field.textColor = UIColor.black
            content_field.isEditable = true
            content_field.textAlignment = .left
           
            content_field.layer.borderColor = UIColor(red: 60/255, green: 40/255, blue: 129/255, alpha: 1).cgColor
            content_field.layer.borderWidth = 0.5
            return content_field
        }()
 
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "Suggestion"
            // Do any additional setup after loading the view.
            self.view.backgroundColor = UIColor.white
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
            
            
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
            
        
            content_field.delegate = self
            self.view.addSubview(content_field)
            content_field.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/5)
                make.width.equalTo(AJScreenWidth+1)
                make.top.equalTo(suggestion_label.snp.bottom).offset(5)
            }
            
            /*提交按钮*/
            let submit_button = UIButton(type:.system)
            submit_button.backgroundColor = UIColor.red
            submit_button.setTitle("提  交", for:.normal)
            submit_button.tintColor = UIColor.white
            submit_button.layer.cornerRadius = 8
            submit_button.layer.masksToBounds = true
            submit_button.titleLabel?.font = UIFont.systemFont(ofSize:18)
            submit_button.titleLabel?.textColor = UIColor.white
            self.view.addSubview(submit_button)
            submit_button.snp.makeConstraints{(make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth*2/5)
                make.top.equalTo(content_field.snp.bottom).offset(10)
                make.left.equalTo(AJScreenWidth*3/10)
            }
            submit_button.addTarget(self, action: #selector(submit), for: .touchUpInside)
            
        }
        
        @objc private func back(){
            self.navigationController?.popViewController(animated: true)
        }
        @objc private func submit(){
            let userId:String = "1"
            let token:String = "0101"
            textArea = self.content_field.text!
            let alert = CustomAlertController()
            if textArea == ""{
                alert.custom(self, "Attention","内容不能为空")
            }else{
                let dictString:Dictionary = [ "userId":String(userId),"feedback":String(textArea!),"token":String(token)]
                ////            let user = User.deserialize(from: jsonString)
                print(dictString)
                //            //  此处的参数需要传入一个字典类型
                Alamofire.request(UserFeedback,method: .post,parameters: dictString).responseString{ (response) in
                
                    if response.result.isSuccess {
                
                        if let jsonString = response.result.value {
  
                            if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                                // model转json 为了方便在控制台查看
                                print(responseModel.toJSONString(prettyPrint: true)!)
                
                                /*  此处为跳转和控制逻辑*/
                                if(responseModel.code == 1 ){
                                    print("登录成功")
                                    alert.custom(self,"Attention", "感谢您的反馈")
                                    self.navigationController?.popViewController(animated: true)
                                }else{
                                    alert.custom(self,"Attention", "数据传输错误")
                                }
                
                            }
                        }
                    }
                }
            }
           
           
        }
   
    }
