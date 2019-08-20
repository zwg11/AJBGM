//
//  BloodSetViewController.swift
//  AIJian
//
//  Created by zzz on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  血糖设置界面

import UIKit

class BloodSetViewController: UIViewController,UITextFieldDelegate {
    
       //空腹相关的全局变量
        lazy var emptyStomach_left:UITextField = {
            let emptyStomach_left = UITextField()
            emptyStomach_left.font = UIFont.systemFont(ofSize: 14)
//            emptyStomach_left.background = UIColor.red
            emptyStomach_left.allowsEditingTextAttributes = false
            emptyStomach_left.borderStyle = .line
            return emptyStomach_left
        }()
    
        lazy var emptyStomach_right:UITextField = {
            let emptyStomach_right = UITextField()
            emptyStomach_right.font = UIFont.systemFont(ofSize: 14)
            emptyStomach_right.allowsEditingTextAttributes = false
            emptyStomach_right.borderStyle = .line
            return emptyStomach_right
        }()
    
        lazy var emptyUnit_label:UILabel = {
            let emptyUnit_label = UILabel(frame: CGRect())
            emptyUnit_label.text = "mg/dl"
            emptyUnit_label.font = UIFont.systemFont(ofSize: 14)
            return emptyUnit_label
        }()
    
        //餐前相关的全局变量
        lazy var beforeDinner_left:UITextField = {
            let beforeDinner_left = UITextField()
            beforeDinner_left.font = UIFont.systemFont(ofSize: 14)
            beforeDinner_left.allowsEditingTextAttributes = false
            beforeDinner_left.borderStyle = .line
            return beforeDinner_left
        }()
    
        lazy var beforeDinner_right:UITextField = {
            let beforeDinner_right = UITextField()
            beforeDinner_right.font = UIFont.systemFont(ofSize: 14)
            beforeDinner_right.allowsEditingTextAttributes = false
            beforeDinner_right.borderStyle = .line
            return beforeDinner_right
        }()
    
        lazy var beforeUnit_label:UILabel = {
            let beforeUnit_label = UILabel(frame: CGRect())
            beforeUnit_label.text = "mg/dl"
            beforeUnit_label.font = UIFont.systemFont(ofSize: 14)
            return beforeUnit_label
        }()
    
        //餐后相关的全局变量
        lazy var afterDinner_left:UITextField = {
            let afterDinner_left = UITextField()
            afterDinner_left.font = UIFont.systemFont(ofSize: 14)
            afterDinner_left.allowsEditingTextAttributes = false
            afterDinner_left.borderStyle = .line
            return afterDinner_left
        }()
    
        lazy var afterDinner_right:UITextField = {
            let afterDinner_right = UITextField()
            afterDinner_right.font = UIFont.systemFont(ofSize: 14)
            afterDinner_right.allowsEditingTextAttributes = false
            afterDinner_right.borderStyle = .line
            return afterDinner_right
        }()
    
        lazy var afterUnit_label:UILabel = {
            let afterUnit_label = UILabel(frame: CGRect())
            afterUnit_label.text = "mg/dl"
            afterUnit_label.font = UIFont.systemFont(ofSize: 14)
            return afterUnit_label
        }()
    
         //随机相关的全局变量
        lazy var randomDinner_left:UITextField = {
            let randomDinner_left = UITextField()
            randomDinner_left.font = UIFont.systemFont(ofSize: 14)
            randomDinner_left.allowsEditingTextAttributes = false
            randomDinner_left.borderStyle = .line
            return randomDinner_left
        }()
        lazy var randomDinner_right:UITextField = {
            let randomDinner_right = UITextField()
            randomDinner_right.font = UIFont.systemFont(ofSize: 14)
            randomDinner_right.allowsEditingTextAttributes = false
            randomDinner_right.borderStyle = .line
            return randomDinner_right
        }()
        lazy var randomUnit_label:UILabel = {
            let randomUnit_label = UILabel(frame: CGRect())
            randomUnit_label.text = "mg/dl"
            randomUnit_label.font = UIFont.systemFont(ofSize: 14)
            return randomUnit_label
        }()
    
        //保存和恢复默认设置按钮
        lazy var saveBlood:UIButton = {
            let saveBlood = UIButton(type:.system)
            saveBlood.backgroundColor = UIColor.red
            saveBlood.setTitle("保存", for:.normal)
            saveBlood.tintColor = UIColor.white
            saveBlood.layer.cornerRadius = 8
            saveBlood.layer.masksToBounds = true
            saveBlood.titleLabel?.font = UIFont.systemFont(ofSize:18)
            saveBlood.titleLabel?.textColor = UIColor.white
            return saveBlood
        }()
    
        lazy var recoverBlood:UIButton = {
            let recoverBlood = UIButton(type:.system)
            recoverBlood.backgroundColor = UIColor.red
            recoverBlood.setTitle("恢复默认设置", for:.normal)
            recoverBlood.tintColor = UIColor.white
            recoverBlood.layer.cornerRadius = 8
            recoverBlood.layer.masksToBounds = true
            recoverBlood.titleLabel?.font = UIFont.systemFont(ofSize:18)
            recoverBlood.titleLabel?.textColor = UIColor.white
            return recoverBlood
        }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "bloodsetting"
            // Do any additional setup after loading the view.
            self.view.backgroundColor = UIColor.white
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
            
            //空腹
            let emptyStomach_label = UILabel(frame: CGRect())
            emptyStomach_label.text = "空腹"
            emptyStomach_label.font = UIFont.systemFont(ofSize: 14)
//            emptyStomach_label.backgroundColor = UIColor.red
            self.view.addSubview(emptyStomach_label)
            emptyStomach_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth/8)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(navigationBarHeight+AJScreenWidth/10)
            }
            
            //空腹左侧输入框
            self.view.addSubview(emptyStomach_left)
            emptyStomach_left.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
            }
            
            let emptyMark_label = UILabel(frame: CGRect())
            emptyMark_label.text = "~"
            emptyMark_label.font = UIFont.systemFont(ofSize: 14)
            //        email_label.backgroundColor = UIColor.red
            self.view.addSubview(emptyMark_label)
            emptyMark_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(emptyStomach_left.snp.right).offset(AJScreenWidth/25)
                make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
            }
            
            //空腹右侧输入框
            self.view.addSubview(emptyStomach_right)
            emptyStomach_right.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(emptyStomach_left.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
            }
            
            //空腹的单位标签
            self.view.addSubview(emptyUnit_label)
            emptyUnit_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(emptyStomach_right.snp.right).offset(10)
                make.top.equalTo(emptyStomach_label.snp.bottom).offset(1)
            }
            /* 空腹结束 */
            
            /* 餐前开始 */
            let beforeDinner_label = UILabel(frame: CGRect())
            beforeDinner_label.text = "餐前"
            beforeDinner_label.font = UIFont.systemFont(ofSize: 14)
            //        email_label.backgroundColor = UIColor.red
            self.view.addSubview(beforeDinner_label)
            beforeDinner_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(emptyStomach_left.snp.bottom).offset(5)
            }
            
            
            self.view.addSubview(beforeDinner_left)
            beforeDinner_left.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
            }
            
            let beforeMark_label = UILabel(frame: CGRect())
            beforeMark_label.text = "~"
            beforeMark_label.font = UIFont.systemFont(ofSize: 14)
            //        email_label.backgroundColor = UIColor.red
            self.view.addSubview(beforeMark_label)
            beforeMark_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(beforeDinner_left.snp.right).offset(AJScreenWidth/25)
                make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
            }
            
          
            self.view.addSubview(beforeDinner_right)
            beforeDinner_right.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(beforeDinner_left.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
            }
            
           
            self.view.addSubview(beforeUnit_label)
            beforeUnit_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(beforeDinner_right.snp.right).offset(10)
                make.top.equalTo(beforeDinner_label.snp.bottom).offset(5)
            }
            /* 餐前结束 */
            /* 餐后开始 */
            let afterDinner_label = UILabel(frame: CGRect())
            afterDinner_label.text = "餐后"
            afterDinner_label.font = UIFont.systemFont(ofSize: 14)
            self.view.addSubview(afterDinner_label)
            afterDinner_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(beforeDinner_left.snp.bottom).offset(5)
            }
            
           
            self.view.addSubview(afterDinner_left)
            afterDinner_left.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
            }
            
            let afterMark_label = UILabel(frame: CGRect())
            afterMark_label.text = "~"
            afterMark_label.font = UIFont.systemFont(ofSize: 14)
            //email_label.backgroundColor = UIColor.red
            self.view.addSubview(afterMark_label)
            afterMark_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(afterDinner_left.snp.right).offset(AJScreenWidth/25)
                make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
            }
            
           
            self.view.addSubview(afterDinner_right)
            afterDinner_right.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(afterDinner_left.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
            }
            
           
            self.view.addSubview(afterUnit_label)
            afterUnit_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(afterDinner_right.snp.right).offset(10)
                make.top.equalTo(afterDinner_label.snp.bottom).offset(5)
            }
            
            /* 餐后结束 */
            
            /* 随机开始 */
            let randomDinner_label = UILabel(frame: CGRect())
            randomDinner_label.text = "随机"
            randomDinner_label.font = UIFont.systemFont(ofSize: 14)
            self.view.addSubview(randomDinner_label)
            randomDinner_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenWidth/15)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(afterDinner_left.snp.bottom).offset(5)
            }
            
           
            self.view.addSubview(randomDinner_left)
            randomDinner_left.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(AJScreenWidth/7)
                make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
            }
            
            let randomMark_label = UILabel(frame: CGRect())
            randomMark_label.text = "~"
            randomMark_label.font = UIFont.systemFont(ofSize: 14)
            //        email_label.backgroundColor = UIColor.red
            self.view.addSubview(randomMark_label)
            randomMark_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(randomDinner_left.snp.right).offset(AJScreenWidth/25)
                make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
            }
            
           
            self.view.addSubview(randomDinner_right)
            randomDinner_right.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/20)
                make.width.equalTo(AJScreenWidth/4)
                make.left.equalTo(randomDinner_left.snp.right).offset(AJScreenWidth/10)
                make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
            }
            
            
            self.view.addSubview(randomUnit_label)
            randomUnit_label.snp.makeConstraints{ (make) in
                make.height.equalTo(AJScreenHeight/15)
                make.width.equalTo(AJScreenWidth/5)
                make.left.equalTo(randomDinner_right.snp.right).offset(10)
                make.top.equalTo(randomDinner_label.snp.bottom).offset(5)
            }
            
            /* 随机结束 */
            
            /*保存按钮*/
           
            saveBlood.addTarget(self, action: #selector(save), for: .touchUpInside)
            self.view.addSubview(saveBlood)
            saveBlood.snp.makeConstraints{(make) in
                make.height.equalTo(AJScreenWidth/10)
                make.width.equalTo(AJScreenWidth*3/5)
                make.top.equalTo(randomDinner_left.snp.bottom).offset(20)
                make.left.equalTo(AJScreenWidth/5)
            }
       
            /*恢复默认设置按钮*/
           
            recoverBlood.addTarget(self, action: #selector(recover), for: .touchUpInside)
            self.view.addSubview(recoverBlood)
            recoverBlood.snp.makeConstraints{(make) in
                make.height.equalTo(AJScreenWidth/10)
                make.width.equalTo(AJScreenWidth*3/5)
                make.top.equalTo(saveBlood.snp.bottom).offset(10)
                make.left.equalTo(AJScreenWidth/5)
            }
        }
        
        @objc private func back(){
            self.navigationController?.popViewController(animated: true)
        }
        @objc private func save(){
            
        }
        @objc private func recover(){
            
        }

}
