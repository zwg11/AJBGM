//
//  infoInputViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/31.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class infoInputViewController: UIViewController,UITextFieldDelegate {
    
    // 记录性别是否是男性
    var isMan:Bool = true
    // 记录出生日期
    var date:String?

    // 时间选择器界面的顶部和底部约束
    var topConstraint:Constraint?
    var bottomConstraint:Constraint?
    
    private lazy var infoInput:InfoInputView = {
        let view = InfoInputView()
        view.setupUI()
        view.nameTextField.delegate = self
        view.manButton.addTarget(self, action: #selector(manSelected), for: .touchUpInside)
        view.womanButton.addTarget(self, action: #selector(womanSelected), for: .touchUpInside)
        view.birthdayButton.addTarget(self, action: #selector(chooseDate), for: .touchUpInside)
        view.registerFinishButton.addTarget(self, action: #selector(registerFinish), for: .touchUpInside)
        return view
    }()
    
    // 时间选择器界面
    private lazy var picker : pickerView = {
        let view = pickerView()
        view.setupUI()
        view.sureButton.addTarget(self, action: #selector(pickViewSelected), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(pickViewDismiss), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "填写个人信息"
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.view.addSubview(infoInput)
        infoInput.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
        }
        // 时间选择器视图设置
        self.view.addSubview(picker)
        // 设置时间选择器界面约束，之后会修改此约束达到界面显现和消失的效果
        picker.snp_makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(UIScreen.main.bounds.height/3)
            if #available(iOS 11.0, *) {
                self.topConstraint = make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).constraint
            } else {
                // Fallback on earlier versions
                self.topConstraint = make.top.equalTo(bottomLayoutGuide.snp.bottom).constraint
            }
            //make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        self.view.bringSubviewToFront(picker)
    }
    

    // 选中性别男
    @objc func manSelected(){
        infoInput.manButton.setImage(UIImage(named: "selected"), for: .normal)
        infoInput.womanButton.setImage(UIImage(named: "unselected"), for: .normal)
        isMan = true
    }
    // 选中性别女
    @objc func womanSelected(){
        infoInput.womanButton.setImage(UIImage(named: "selected"), for: .normal)
        infoInput.manButton.setImage(UIImage(named: "unselected"), for: .normal)
        isMan = false
    }
    
    // 完成注册按钮动作
    @objc func registerFinish(){
        
        // 返回到导航控制器的根视图控制器
        self.navigationController?.popToRootViewController(animated: true)
    }
    // MARK: - 以下为sharedView界面的时间选择器显示和消失的按钮动作
    // 选择出生日期按钮被点击时的动作
    @objc func chooseDate(){
        print("choose date button clicked,appear done.")
        UIView.animate(withDuration: 0.5, animations: appear)
        //appear()
    }
    
    func dismiss(){
        // 重新布置约束
        // 时间选择器界面移到屏幕外，视觉效果为消失
        //shareV.pickDateView.frame.origin = CGPoint(x: 0, y: shareV.snp.bottom)
        print("func dismiss done.")
        // 删除顶部约束
        self.bottomConstraint?.uninstall()
        picker.snp_makeConstraints{(make) in
            
            // 添加底部约束
            if #available(iOS 11.0, *) {
                self.topConstraint = make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).constraint
            } else {
                // Fallback on earlier versions
                self.topConstraint = make.top.equalTo(bottomLayoutGuide.snp.bottom).constraint
            }
        }
        // 告诉当前控制器的View要更新约束了，动态更新约束，没有这句的话更新约束就没有动画效果
        self.view.layoutIfNeeded()
    }
    func appear(){
        
        // 重新布置约束
        // 时间选择器界面移到屏幕内底部，视觉效果为出现
        //shareV.pickDateView.frame.origin = CGPoint(x: 0, y: self.frame.size.height/3*2)
        print("func appear done.")
        // 删除顶部约束
        self.topConstraint?.uninstall()
        picker.snp_makeConstraints{(make) in
            
            // 添加底部约束
            if #available(iOS 11.0, *) {
                self.bottomConstraint = make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).constraint
            } else {
                // Fallback on earlier versions
                self.bottomConstraint = make.bottom.equalTo(bottomLayoutGuide.snp.top).constraint
                
            }
        }
        self.view.layoutIfNeeded()
    }
    
    // 点击取消按钮，时间选择器界面移到屏幕外，视觉效果为消失
    @objc func pickViewDismiss(){
        UIView.animate(withDuration: 0.5, animations: dismiss)
        
        //        self.pickDateView.snp.makeConstraints{(make) in
        //            make.top.equalTo(self.snp.bottom)
        //
        //        }
        print("cancel button clicked")
        
    }
    // 点击确定按钮，时间选择器界面移到屏幕外，视觉效果为消失，按钮文本显示日期
    @objc func pickViewSelected(){
        // 创建一个日期格式器
        let dateFormatter = DateFormatter()
        // 为格式器设置格式字符串,时间所属区域
        dateFormatter.dateFormat="yyyy-MM-dd"
        // 绑定一个时间选择器，并按格式返回时间
        date = dateFormatter.string(from: picker.datePicker.date)
        infoInput.birthdayButton.setTitle(date, for: .normal)
        
        UIView.animate(withDuration: 0.5, animations: dismiss)
        //        self.pickDateView.snp.makeConstraints{(make) in
        //            make.top.equalTo(self.snp.bottom)
        //
        //        }
        print("sure button clicked")
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
}
