//
//  SharedViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class SharedViewController: UIViewController,UITextFieldDelegate {

    // 记录日期
    var date:String?
    // 记录i姓名
    var name:String?
    // 记录邮箱
    var email:String?
    
    private lazy var picker : pickerView = {
        let view = pickerView()
        view.setupUI()
        view.sureButton.addTarget(self, action: #selector(pickViewSelected), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(pickViewDismiss), for: .touchUpInside)
        return view
    }()
    
    private lazy var shareV:SharedView = {
        let view = SharedView()
        view.setupUI()
        view.emailTextField.delegate = self
        view.nameTextField.delegate = self
        view.birthdayButton.addTarget(self, action: #selector(chooseDate), for: .touchUpInside)
        return view
    }()
    var topConstraint:Constraint?
    var bottomConstraint:Constraint?
//    lazy var shareScrollView:UIScrollView = {
//        let view = UIScrollView()
//        view.contentSize = CGSize(width: 300, height: self.view.frame.size.height*2)
//        view.alwaysBounceVertical = true
//        view.showsVerticalScrollIndicator = true
//        view.backgroundColor = UIColor.yellow
//        return view
//    }()
    
    //    override func loadView() {
    //        let myview = UIScrollView()
    //        //myview.setupUI()
    //        myview.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2)
    //        view = myview
    //    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let uview = UIScrollView()
        uview.contentSize = CGSize(width: AJScreenWidth, height: AJScreenWidth*3/2)
        uview.alwaysBounceVertical = true
        uview.showsVerticalScrollIndicator = true
        uview.backgroundColor = UIColor.yellow
        self.view.addSubview(uview)
        uview.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            //*********************************
            // 可使底部与tabbar自动对齐
            // 注：不同版本对于顶部底部对齐不同，
            //iOS11推出了safeAreaLayoutGuide，而iOS11之前使用bottomLayoutGuide和topLayoutGuide
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
            //**********************************
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            
        }
        //        share.setupUI()
        //        uview.addSubview(share)
        //        // 这样设置约束是可以的，能够自适应，但为什么？***************************
        //          //此处也未设置view的高度Y和顶部位置，但默认顶部置顶，不知为什么
        // ***********************如果没有设置高度，那么该视图的按钮、文本框等都不能点击******************
        //        share.snp.makeConstraints{(make) in
        //            make.left.equalTo(self.view.snp.left)
        //            make.right.equalTo(self.view.snp.right)
        ////            make.height.equalTo(self.view.frame.size.height/2)
        ////            make.top.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.minX)
        //
        //        }
        
        
        
        // sharedView 视图设置
        uview.addSubview(shareV)
        
        shareV.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            //            make.height.equalTo(self.view.frame.size.height/2)
            // 这里设置顶部位置置顶，与未设置时一样
            //make.left.right.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.minY)
            } else {
                // Fallback on earlier versions
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
        // Do any additional setup after loading the view.

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
        shareV.birthdayButton.setTitle(date, for: .normal)
        
        UIView.animate(withDuration: 0.5, animations: dismiss)
        //        self.pickDateView.snp.makeConstraints{(make) in
        //            make.top.equalTo(self.snp.bottom)
        //
        //        }
        print("sure button clicked")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "")
        
        // 判断是哪个文本框，将内容赋值给对应的字符串
        if textField == shareV.nameTextField{
            name = textField.text
        }
        else if textField == shareV.emailTextField{
            email = textField.text
        }
        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
}
