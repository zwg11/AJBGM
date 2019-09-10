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

    
    private lazy var picker : pickerView = {
        let view = pickerView()
        view.setupUI()
        view.sureButton.addTarget(self, action: #selector(pickViewSelected), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(pickViewDismiss), for: .touchUpInside)
        return view
    }()
    
//    private lazy var shareV:SharedView = {
//        let view = SharedView()
//        view.setupUI()
//        view.nameTextField.delegate = self
//        view.birthdayButton.addTarget(self, action: #selector(chooseDate), for: .touchUpInside)
//        return view
//    }()
    
    private lazy var shareV:SharedView = {
        let view = SharedView()
        view.setupUI()
//        view.emailTextField.delegate = self
        view.nameTextField.delegate = self
        view.birthdayButton.addTarget(self, action: #selector(chooseDate), for: .touchUpInside)

        view.sendButton.addTarget(self, action: #selector(sendImage), for: .touchUpInside)
        return view
    }()
    private lazy var general:GeneralStatusView = {
       let view = GeneralStatusView()
        view.setupUI()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.addSubview(general)
    }
    
    @objc func sendImage(){
        // 将shareV视图生成为图片
        
        // 将视图生成文件
        let image = viewToImage.getImageFromView(view: general)
        // 将图片放入相册
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.savedPhotosAlbum(_:didFinishSavingWithError:contextInfo:)), nil)
        // 要分享的内容封装成数组
        let activityItems = [image]
        // 创建
        let toVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(toVC, animated: true, completion: nil)
    }
    
    //保存图片
    @objc func savedPhotosAlbum(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        
        if error != nil {
            let alert = CustomAlertController()
            alert.custom(self, "", "图片生成失败")
            print("savw failed")
            
        } else {
            let alert = CustomAlertController()
            alert.custom(self, "", "图片生成成功")
            print("savw success")
            
        }
    }
    

    var topConstraint:Constraint?
    var bottomConstraint:Constraint?

    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        dismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true
        //general.setupUI()
        
        let sharedScrollView = UIScrollView()
        // 设置内容高度为屏幕的3/2,显示滚动条，d能上下滚动，背景为白色
        sharedScrollView.contentSize = CGSize(width: AJScreenWidth, height: AJScreenWidth)
        sharedScrollView.alwaysBounceVertical = true
        sharedScrollView.showsVerticalScrollIndicator = true
        sharedScrollView.backgroundColor = UIColor.white
        self.view.addSubview(sharedScrollView)
        sharedScrollView.snp.makeConstraints{(make) in
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
        
        
        
        // sharedView 视图设置
        sharedScrollView.addSubview(shareV)
        
        shareV.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            //            make.height.equalTo(self.view.frame.size.height/2)
            // 这里设置顶部位置置顶，与未设置时一样
            //make.left.right.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
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
                self.topConstraint = make.top.equalTo(bottomLayoutGuide.snp.top).constraint
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
                self.topConstraint = make.top.equalTo(bottomLayoutGuide.snp.top).constraint
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

        print("sure button clicked")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "")
        
        // 将内容赋值给对应的字符串
        name = textField.text

        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
}
