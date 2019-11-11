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
    let id = "reusedId"
    
    let userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
    var country:String?
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
        
      
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            emailCommponent.imageView.image = UIImage(named: "email")
            emailCommponent.textField.delegate = self
            emailCommponent.textField.isEnabled = false
            emailCommponent.setupUI(title: "")
            emailCommponent.textField.text = UserInfo.getEmail()
            emailCommponent.textField.textColor = TextColor
            cell.contentView.addSubview(emailCommponent)
            cell.textLabel?.textColor = TextColor
//            cell.backgroundColor = ThemeColor
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            telephoneCommponent.imageView.image = UIImage(named: "Phone")
            telephoneCommponent.textField.delegate = self
            telephoneCommponent.textField.isEnabled = false
            telephoneCommponent.setupUI(title: "")
            telephoneCommponent.textField.textColor = TextColor
            if (userInfo.phone_number != nil){ //不等于空
                telephoneCommponent.textField.text = userInfo.phone_number
            }else{
                telephoneCommponent.textField.text = "--"
            }
            telephoneCommponent.textField.textColor = TextColor
            cell.contentView.addSubview(telephoneCommponent)
            cell.selectionStyle = .none
            cell.textLabel?.textColor = TextColor
//            cell.backgroundColor = ThemeColor
            cell.backgroundColor = UIColor.clear
            return cell
        case 2:
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            nationCp.imageView.image = UIImage(named: "Country")
            nationCp.setupUI(title: userInfo.country ?? "--")
//            nationCp.nationButton.addTarget(self, action:#selector(selectNation) , for: .touchUpInside)
            cell.contentView.addSubview(nationCp)
            cell.selectionStyle = .none
            cell.textLabel?.textColor = TextColor
//            cell.backgroundColor = ThemeColor
            cell.backgroundColor = UIColor.clear
            return cell
        default:
            let cell = UITableViewCell(style: .default, reuseIdentifier: id)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    let sugTableView:UITableView = UITableView()
    let content_field = HZTextView()
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
        
        self.title = "Help"
//        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        content_field.placeholder = "Please Enter Your Comments"
//        content_field.backgroundColor = ThemeColor
        content_field.backgroundColor = UIColor.clear
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

        sugTableView.delegate = self
        sugTableView.dataSource = self
//        sugTableView.backgroundColor = ThemeColor
        sugTableView.backgroundColor = UIColor.clear
        sugTableView.isScrollEnabled = false
        sugTableView.separatorColor = UIColor.white
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
        let pickerView = BHJPickerView.init(self, .country)
        pickerView.pickerViewShow()
    }
    func selectedCountry(_ pickerView: BHJPickerView, _ countryStr: String) {
//        infoinputView.nationButton.setTitle(countryStr, for: .normal)
        nationCp.nationButton.setTitle(countryStr, for:.normal)
        country = countryStr
    }
    
    @objc private func leftButtonClick(){
        self.navigationController?.popViewController(animated: false)
    }
    @objc private func save(){
        print(content_field.text!)
         let alert = CustomAlertController()
        
        if content_field.text!.removeHeadAndTailSpacePro == ""{
            alert.custom(self, "Attention", "Feedback Empty！")
            return
        }
        
//        if  telephoneCommponent.textField.text! == ""{
//            alert.custom(self, "Attention", "Phone Empty！")
//            return
//        }
//        if  telephoneCommponent.textField.text!.count == 255{
//            alert.custom(self, "Attention", "Phone Error！")
//            return
//        }
        print(content_field.text!.count)
        if content_field.text!.count >= 300{
            alert.custom(self, "Attention", "Words should be less than 300！")
            return
        }
        
        //网络请求
        let dictString:Dictionary = [ "email":String(emailCommponent.textField.text!),"phoneNumber":String(telephoneCommponent.textField.text!),"country":String(country ?? "--"),"feedback":String(content_field.text!.removeHeadAndTailSpacePro),"token":UserInfo.getToken(),"userId":UserInfo.getUserId()] as [String : Any]
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
                            alert.custom_cengji(self,"Attention", "Submitted.Thanks for your feedback！")
                            self.content_field.text! = ""
                            self.emailCommponent.textField.text! = UserInfo.getEmail()
                            self.telephoneCommponent.textField.text! = ""
                        }else{
                            alert.custom_cengji(self,"Attention", "Sorry.Feedback Failure！")
                            self.navigationController?.popViewController(animated: false)
                        }
                    }
                }
            }else{
                alert.custom(self,"Attention", "Internet Error")
            }
    }
}
    //收回键盘
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

