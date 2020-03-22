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
    
    
    private lazy var indicator:CustomIndicatorView = {
        let view = CustomIndicatorView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: AJScreenHeight))
        view.setupUI("")
        //view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        return view
    }()
    
    var email:String?
    var phone:String?
    let id = "reusedId"
    
    var userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
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
        //自动调整滚动视图和表格视图的偏移量
        self.automaticallyAdjustsScrollViewInsets = false
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
         sugTableView.separatorColor = TextGrayColor
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
     override func viewWillAppear(_ animated: Bool) {
        userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
        if (userInfo.phone_number != nil){ //不等于空
            telephoneCommponent.textField.text = userInfo.phone_number
         }else{
            telephoneCommponent.textField.text = "--"
        }
        sugTableView.reloadRows(at: [IndexPath(row:1,section:0)],with:.fade)
        nationCp.setupUI(title: userInfo.country ?? "--")
        country = userInfo.country
        sugTableView.reloadRows(at: [IndexPath(row:2,section:0)],with:.fade)
    }
    @objc func selectNation(){
        let pickerView = BHJPickerView.init(self, .country)
        pickerView.pickerViewShow()
    }
    func selectedCountry(_ pickerView: BHJPickerView, _ countryStr: String) {
        nationCp.nationButton.setTitle(countryStr, for:.normal)
        country = countryStr
    }
    
    @objc private func leftButtonClick(){
        self.navigationController?.popViewController(animated: false)
    }
    @objc private func save(){
        //print(content_field.text!)
         let alert = CustomAlertController()
        
        if content_field.text!.removeHeadAndTailSpacePro == ""{
            alert.custom(self, "Attention", "Feedback Empty！")
            return
        }
        
        //print(content_field.text!.count)
        if content_field.text!.count >= 300{
            alert.custom(self, "Attention", "Words should be less than 300！")
            return
        }
        indicator.startIndicator()
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        //网络请求
        let dictString:Dictionary = [ "email":String(emailCommponent.textField.text!),"phoneNumber":String(telephoneCommponent.textField.text!),"country":String(country ?? "--"),"feedback":String(content_field.text!.removeHeadAndTailSpacePro),"token":UserInfo.getToken(),"userId":UserInfo.getUserId()] as [String : Any]
        //print(dictString)
        //  此处的参数需要传入一个字典类型
        Alamofire.request(FEEDBACK,method: .post,parameters: dictString, headers:vheader).responseString{ (response) in
            
            if response.result.isSuccess {
                
                if let jsonString = response.result.value {
                    
                    if let responseModel = JSONDeserializer<responseModel>.deserializeFrom(json: jsonString) {
                        // model转json 为了方便在控制台查看
                        //print(responseModel.toJSONString(prettyPrint: true)!)
                        self.indicator.stopIndicator()
                        self.indicator.removeFromSuperview()
                        /*  此处为跳转和控制逻辑*/
                        if(responseModel.code == 1 ){
//                            let x = UIAlertController(title: "", message: "Submitted.Thanks for your feedback！", preferredStyle: .alert)
//                            self.present(x, animated: true, completion: {()->Void in
//                                sleep(1)
//                                x.dismiss(animated: true, completion: {
//                                    // 跳转到原来的界面
//                                    self.navigationController?.popToRootViewController(animated: false)
//                                    // 发送通知，提示插入成功
//                                    //                                    NotificationCenter.default.post(name: NSNotification.Name("InsertData"), object: self, userInfo: nil)
//                                })
//                            })
                            alert.custom_cengji(self,"", "Submitted.Thanks for your feedback！")
                            self.content_field.text! = ""
                            self.emailCommponent.textField.text! = UserInfo.getEmail()
                            self.telephoneCommponent.textField.text! = ""
                        }else if (responseModel.code! == 2 ){
                            LoginOff.loginOff(self)
                            
                            let alert = CustomAlertController()
                            alert.custom(self, "Attention", "Your account is already logged in at the other end!")
                        }else if (responseModel.code! == 3){
                            LoginOff.loginOff(self)
                            let alert = CustomAlertController()
                            alert.custom(self,"Attention", "Your account has been disabled.Please contact oncall@acondiabetescare.com")
                        }else{
                            alert.custom_cengji(self,"Attention", "Sorry.Feedback Failure！")
                            self.navigationController?.popViewController(animated: false)
                        }
                    }
                }
            }else{
                self.indicator.stopIndicator()
                self.indicator.removeFromSuperview()
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

