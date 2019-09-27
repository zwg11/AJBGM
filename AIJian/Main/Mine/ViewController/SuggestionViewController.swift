//
//  SuggestionViewController.swift
//  time
//
//  Created by ADMIN on 2019/8/12.
//  Copyright © 2019 xiaozuo. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON


class SuggestionViewController: UIViewController,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PickerDelegate {
    
    var email:String?
    var phone:String?
    var country:String = "China"
    let id = "reusedId"
    
    let emailCommponent = sugComponent()
    let telephoneCommponent = sugComponent()
    let nationCp = nationComponent()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AJScreenHeight/15
    }
    //放对应的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("获得tableview的内容")
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            emailCommponent.textField.delegate = self
            emailCommponent.textField.isEnabled = false
            emailCommponent.setupUI(title: "")
            emailCommponent.textField.text = UserInfo.getEmail()
            emailCommponent.textField.textColor = TextColor
            cell.contentView.addSubview(emailCommponent)
            cell.textLabel?.textColor = TextColor
            cell.backgroundColor = ThemeColor
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            telephoneCommponent.textField.delegate = self
            telephoneCommponent.textField.textColor = TextColor
            telephoneCommponent.setupUI(title: "Please Enter Your Phone Number")
            cell.contentView.addSubview(telephoneCommponent)
            cell.selectionStyle = .none
            cell.textLabel?.textColor = TextColor
            cell.backgroundColor = ThemeColor
            return cell
        case 2:
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            nationCp.setupUI(title: "China")
            nationCp.nationButton.addTarget(self, action:#selector(selectNation) , for: .touchUpInside)
//            nationComponent.textField.delegate = self
//            nationComponent.setupUI(title: "请输入国家")
            cell.contentView.addSubview(nationCp)
            cell.selectionStyle = .none
            cell.textLabel?.textColor = TextColor
            cell.backgroundColor = ThemeColor
            return cell
        default:
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    let sugTableView:UITableView = UITableView()
    let content_field = HZTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Suggestion"
        self.view.backgroundColor = ThemeColor
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        print("到达意见反馈页。。。。。。。。。。。。")
        
        content_field.placeholder = "Please Enter Your Comments"
        content_field.backgroundColor = ThemeColor
        content_field.font = UIFont.boldSystemFont(ofSize: 16)
        content_field.textColor = TextColor
        content_field.isEditable = true
        content_field.textAlignment = .left
        content_field.layer.borderColor = UIColor(red: 141/255, green: 177/255, blue: 213/255, alpha: 1).cgColor
        content_field.layer.borderWidth = 0.5
        self.view.addSubview(content_field)
        content_field.snp.makeConstraints{ (make) in
            make.height.equalTo(AJScreenHeight/3)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(10)
        }
        
        
//        sugTableView.frame = CGRect(x:0, y:navigationBarHeight+AJScreenHeight/5+5,width: AJScreenWidth,height: AJScreenHeight/5)
        sugTableView.delegate = self
        sugTableView.dataSource = self
        sugTableView.backgroundColor = ThemeColor
        sugTableView.isScrollEnabled = false
        self.view.addSubview(sugTableView)
        sugTableView.snp.makeConstraints{  (make) in
            make.top.equalTo(content_field.snp.bottom).offset(5)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.height.equalTo(AJScreenHeight/5+10)
        }
        
        /*提交按钮*/
        let submit_button = UIButton(type:.system)
        submit_button.backgroundColor = ButtonColor
        submit_button.setTitle("Submit", for:.normal)
        submit_button.tintColor = UIColor.white
        submit_button.titleLabel?.font = UIFont.systemFont(ofSize:18)
        submit_button.titleLabel?.textColor = UIColor.white
        submit_button.setTitleColor(UIColor.white, for: .normal)
        submit_button.addTarget(self, action: #selector(save), for: .touchUpInside)
        self.view.addSubview(submit_button)
        submit_button.snp.makeConstraints{(make) in
            make.height.equalTo(AJScreenHeight/15)
            make.left.equalTo(AJScreenWidth/15)
            make.right.equalTo(-AJScreenWidth/15)
            make.top.equalTo(sugTableView.snp.bottom).offset(AJScreenHeight/7)
        }
        
        
    }
    
    @objc func selectNation(){
        print("选择国家")
        let pickerView = BHJPickerView.init(self, .country)
        pickerView.pickerViewShow()
    }
    func selectedCountry(_ pickerView: BHJPickerView, _ countryStr: String) {
//        infoinputView.nationButton.setTitle(countryStr, for: .normal)
        nationCp.nationButton.setTitle(countryStr, for:.normal)
        country = countryStr
    }
    
    @objc private func back(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func save(){
        print(content_field.text!)
         let alert = CustomAlertController()
        
        if content_field.text! == ""{
            print("内容不能为空！")
            alert.custom(self, "Attention", "内容不能为空！")
            return
        }
        print(content_field.text!.count)
        if content_field.text!.count >= 300{
            print("输入的字数不能超过300！")
            alert.custom(self, "Attention", "输入的字数不能超过300！")
            return
        }
//        if emailCommponent.textField.text! == ""{
//            print("为了方便我们联系您，邮箱不能为空！")
//            alert.custom(self, "Attention", "内容不能为空！")
//            return
//        }
        
        //网络请求
        let dictString:Dictionary = [ "email":String(emailCommponent.textField.text!),"phoneNumber":String(telephoneCommponent.textField.text!),"country":String(country),"feedback":String(content_field.text!),"token":UserInfo.getToken(),"userId":UserInfo.getUserId()] as [String : Any]
        print(dictString)
        //  此处的参数需要传入一个字典类型
        Alamofire.request(FEEDBACK,method: .post,parameters: dictString).responseString{ (response) in
            
            if response.result.isSuccess {
                
                if let jsonString = response.result.value {
                    
                    if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                        // model转json 为了方便在控制台查看
                        print(responseModel.toJSONString(prettyPrint: true)!)
                        
                        /*  此处为跳转和控制逻辑*/
                        if(responseModel.code == 1 ){
                            print("密码修改成功")
                            alert.custom(self,"Attention", "反馈成功，感谢您的反馈！")
                            self.content_field.text! = ""
                            self.emailCommponent.textField.text! = ""
                            self.telephoneCommponent.textField.text! = ""
//                            self.nationComponent.textField.text! = ""
                            self.navigationController?.popViewController(animated: true)
                        }else{
                            alert.custom(self,"Attention", "反馈失败！")
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }else{
                alert.custom(self,"Attention", "网络异常")
            }
    }
}
    //收回键盘
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

