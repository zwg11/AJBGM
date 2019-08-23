//
//  InsertViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController {

    private lazy var input:InputView = {
        let view = InputView()
        view.setupUI()
        // 由于药物栏的按钮需弹出 UIAlertController，所以要将动作在viewcontroller层中设置
        view.bodyInfo.medicineChooseButton.addTarget(self, action: #selector(chooseMedicine), for: .touchUpInside)
        view.bodyInfo.medicineEditButton.addTarget(self, action: #selector(edit(sender:)), for: .touchUpInside)
        // 设置标记，识别按钮
        view.bodyInfo.medicineEditButton.tag = 8
        
        // 由于备注栏的按钮需弹出 UIAlertController，所以要将动作在viewcontroller层中设置
        view.remark.remarkChooseButton.addTarget(self, action: #selector(chooseRemark), for: .touchUpInside)
        view.remark.remarkEditButton.addTarget(self, action: #selector(edit(sender:)), for: .touchUpInside)
        // 设置标记，识别按钮
        view.remark.remarkEditButton.tag = 6
        return view
    }()
    
    // 选择药物按钮弹出的alert
    private lazy var medicineChooseAlert:alertViewController = {
        let alert = alertViewController(title: "请选择", message: "", preferredStyle: .alert)
        alert.addObserver(self, forKeyPath: "selectedNum", options: [.new], context: nil)
        
        return alert
    }()
    
    // 选择备注按钮弹出的alert
    private lazy var remarkChooseAlert:alertViewController = {
        let alert = alertViewController(title: "请选择", message: "", preferredStyle: .alert)
        // 添加监听器监听选中的表格的个数
        alert.addObserver(self, forKeyPath: "selectedNum", options: [.new], context: nil)
        //alert.alertData = data["remark"] as! [String]
        return alert
    }()

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 设置当选中的表格个数改变时，使得对应的按钮显示已选择的表格书
        if medicineChooseAlert.selectedNum>0{
            input.bodyInfo.medicineChooseButton.setTitle("\(medicineChooseAlert.selectedNum)个选项已选择", for: .normal)
        }else{
            input.bodyInfo.medicineChooseButton.setTitle("无", for: .normal)
        }
        
        if remarkChooseAlert.selectedNum>0{
            input.remark.remarkChooseButton.setTitle("\(remarkChooseAlert.selectedNum)个选项已选择", for: .normal)
        }else{
            input.remark.remarkChooseButton.setTitle("无", for: .normal)
        }
    }
    
    private var isMedicineUpdate = true
    private var isRemarkUpdate = true
    
    // 设置导航栏左按钮x样式
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
        
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        self.view.addSubview(input)
        input.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
        }
        
        // 实现点击屏幕键盘收回
        hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
        // 显示导航控制器的工具栏
//        self.navigationController?.isToolbarHidden = false
//        self.navigationController?.toolbar.tintColor = UIColor.gray
        
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: AJScreenWidth/2-AJScreenWidth/20, height: 40))
        leftButton.backgroundColor = UIColor.gray
        leftButton.setTitle("取消", for: .normal)
        leftButton.setTitleColor(UIColor.white, for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        leftButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        leftButton.layer.borderColor = UIColor.white.cgColor
        leftButton.layer.borderWidth = 1
        
        let item1 = UIBarButtonItem(customView: leftButton)
        
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: AJScreenWidth/2, height: 40))
        rightButton.backgroundColor = UIColor.gray
        rightButton.setTitle("保存", for: .normal)
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        rightButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        rightButton.layer.borderColor = UIColor.white.cgColor
        rightButton.layer.borderWidth = 1
        
        let item2 = UIBarButtonItem(customView: rightButton)
        //self.toolbarItems = [item1,item2]
    }
    @objc func cancel(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func save(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // ************** 药物选择栏按钮动作 **************
    // 选择 药物 按钮被点击时的动作
    @objc func chooseMedicine(){
        print("choose medicine button clicked,appear done.")
        // 由于 药物 一定是有可选项的，所以不需判断是否有可选项
        // 判断表格是否需要更新 if开始
        // 若需更新，重新加载数据和表格
        if isMedicineUpdate{
            
            medicineChooseAlert.alertData = data["medicine"] as! [String]
            // 设置框的高度，根据单元格数量和表格上下约束计算得出
            medicineChooseAlert.view.snp.updateConstraints{(make) in
                make.height.equalTo(medicineChooseAlert.alertData.count*35+90)
            }
            // 更新单元格
            medicineChooseAlert.tabelView.reloadData()
            // 显示 警示框
            self.present(medicineChooseAlert, animated: true, completion: nil)
            // 设置更新 为false，避免下次再重新加载浪费时间
            isMedicineUpdate = false
        }// 判断表格是否需要更新 if结束
            // 若不需要更新，直接显示警示框
        else{
            // 显示 警示框
            self.present(medicineChooseAlert, animated: true, completion: nil)
        }
        
    }
    
    // ****************  备注栏按钮动作 *****************
    // 选择 备注 按钮被点击时的动作
    @objc func chooseRemark(){
        print("choose remark button clicked,appear done.")
        // 将配置文件中的数据导出
        if data["remark"] != nil{
            remarkChooseAlert.alertData = data["remark"] as! [String]
        }
        
        // 如果数据量大于0，显示备注事件列表
        // ****** start ******
        if remarkChooseAlert.alertData.count > 0{
            print(remarkChooseAlert.alertData.count)
            // 判断表格是否需要更新 if开始
            if isRemarkUpdate{
                // 设置框的高度，根据单元格数量和表格上下约束计算得出
                // 直接设置 height 失败，提示 height 为 get属性
                remarkChooseAlert.view.snp.updateConstraints{(make) in
                    make.height.equalTo(remarkChooseAlert.alertData.count*35+90)
                }
                // 更新单元格
                remarkChooseAlert.tabelView.reloadData()
                // 显示 警示框
                self.present(remarkChooseAlert, animated: true, completion: nil)
                // 设置更新 为false，避免下次再重新加载浪费时间
                isRemarkUpdate = false
            }// 判断表格是否需要更新 if结束
            else{
                self.present(remarkChooseAlert, animated: true, completion: nil)
            }
            
        }// ****** end ******
            // 如果数据量小于0，提示没有可供选择的事件
        else{
            let alert = UIAlertController(title: "提示", message: "无备注事件供选择", preferredStyle: .alert)
            let actionSure = UIAlertAction(title: "sure", style: .default, handler: nil)
            alert.addAction(actionSure)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // 选择 备注/药物 编辑 按钮被点击时的动作
    // ********* 备注/药物 编辑 按钮 *********
    @objc func edit(sender:UIButton?){
        
        let alert = UIAlertController(title: "添加备注", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = ""
            textField.keyboardType = .default
        })
        // 添加取消按钮
        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        // 添加保存按钮，将文本框中数据保存到沙盒中
        let actionSure = UIAlertAction(title: "确定", style: .destructive, handler: {(UIAlertAction)-> Void in
            
            // 文本框为空，不做任何事
            if alert.textFields![0].text == "" {
                return
            }
            // 通过gtag识别按钮，如果为 remark 的
            if sender!.tag == 6{
                
                // 使得另一个警示框的表格数据更新
                self.remarkChooseAlert.alertData.append(alert.textFields![0].text!)
                // 改变对应的选择器的内容和沙盒中对应队列的内容
                data["remark"] = self.remarkChooseAlert.alertData
                print(path!)
                // 将改变后的结果写入沙盒
                data.write(toFile: path!, atomically: true)
                print(data["remark"] ?? "no remark")
                print(self.remarkChooseAlert.alertData)
                // 将新添加的事件 添加到 表格状态数组中并值为 true
                self.remarkChooseAlert.boolarr.append(true)
                self.remarkChooseAlert.boolArray.append(true)
                self.remarkChooseAlert.selectedNum += 1
                // 备注表格需更新
                self.isRemarkUpdate = true
            }
            // 通过gtag识别按钮，如果为 medicine 的
            if sender!.tag == 8{
                // 使得另一个警示框的表格数据更新
                self.medicineChooseAlert.alertData.append(alert.textFields![0].text!)
                
                // 改变对应的选择器的内容和沙盒中对应队列的内容
                data["medicine"] = self.medicineChooseAlert.alertData
                print(path!)
                // 将改变后的结果写入沙盒
                data.write(toFile: path!, atomically: true)
                print(data["medicine"] ?? "no medicine")
                print(self.medicineChooseAlert.alertData)
                // 将新添加的事件 添加到 表格状态数组中并值为 true
                self.medicineChooseAlert.boolarr.append(true)
                self.medicineChooseAlert.boolArray.append(true)
                self.medicineChooseAlert.selectedNum += 1
                // 药物表格需更新
                self.isMedicineUpdate = true
            }
            
        })
        // 添加2个按钮到 警示框中
        alert.addAction(actionCancel)
        alert.addAction(actionSure)
        self.present(alert, animated: true, completion: nil)
    }
    // *************** 备注/药物 按钮动作结束 ****************
    
    func hideKeyboardWhenTappedAround(){
        // 添加手势，使得点击视图键盘收回
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    // 设置手势动作
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
        
    }
    
    @objc func leftButtonClick(){
        // 设置返回首页
        self.tabBarController?.selectedIndex = 0
        //self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

}
