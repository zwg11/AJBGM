//
//  Input1View.swift
//  st
//
//  Created by ADMIN on 2019/8/9.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class InputView: UIView,UIScrollViewDelegate {
    
    enum pickerStyle {
        case date       // 日期
        case time       // 时间
        
        case occurTime  // 事件
        
        case portions    //进餐量
        case insulin    // 胰岛素
        
        case sport      // 运动
        case exerintensity     // 运动强度
    }
    
    private var style = pickerStyle.date
    
    private var topConstraint:Constraint?
    private var bottomConstraint:Constraint?
    
    var scrollView:UIScrollView = UIScrollView()
    
    private lazy var dateAndTime:dateAndTimeView = {
        let view = dateAndTimeView()
        view.setupUI()
        view.backgroundColor = kRGBColor(255, 251, 186, 1)
        view.dateButton.addTarget(self, action: #selector(chooseDate), for: .touchUpInside)
        view.timeButton.addTarget(self, action: #selector(chooseTime), for: .touchUpInside)
        return view
    }()
    
    lazy var picker:allPickerView = {
        let view = allPickerView()
        view.setupUI()
        view.backgroundColor = UIColor.white
        view.sureButton.addTarget(self, action: #selector(pickViewSelected), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(pickViewDismiss), for: .touchUpInside)
        //view.frame = CGRect(x: 0, y: self.frame.maxY-10,width: AJScreenWidth,height: AJScreenHeight/3)
        return view
    }()
    
    private lazy var glucose:glucoseView = {
        let view = glucoseView()
        view.setupUI()
        view.eventButton.addTarget(self, action: #selector(chooseOccurTime), for: .touchUpInside)
        return view
    }()
    
    private lazy var porAndIns:portionAndInsulinView = {
        let view = portionAndInsulinView()
        view.setupUI()
        view.portionButton.addTarget(self, action: #selector(choosePortion), for: .touchUpInside)
        view.insulinButton.addTarget(self, action: #selector(chooseInsulin), for: .touchUpInside)
        return view
    }()
    
    lazy var bodyInfo:bodyInfoView = {
        let view = bodyInfoView()
        view.setupUI()
        return view
    }()
    
    private lazy var sport:sportView = {
        let view = sportView()
        view.setupUI()
        view.sportButton.addTarget(self, action: #selector(chooseSport), for: .touchUpInside)
        view.exerIntensityButton.addTarget(self, action: #selector(chooseExerIntensity), for: .touchUpInside)
        return view
    }()
    
    lazy var remark:remarkView = {
        let view = remarkView()
        view.setupUI()
        return view
    }()
    
    private lazy var backButton:UIButton = {
        let button = UIButton.init(type: .system)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        button.addTarget(self, action: #selector(pickViewDismiss), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight)
        return button
    }()
    
    func setupUI() {
        self.backgroundColor = UIColor.white
        
        // 设置滚动视图属性
        scrollView.contentSize = CGSize(width: AJScreenWidth, height: AJScreenWidth/15*41)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = UIColor.white
        
        // 添加滚动视图
        scrollView.backgroundColor = UIColor.red
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        
        // 时间选择器视图设置
        self.addSubview(picker)

        // 设置时间选择器界面约束，之后会修改此约束达到界面显现和消失的效果
        picker.snp_makeConstraints{(make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(AJScreenHeight*0.3)
            self.topConstraint = make.top.equalTo(self.snp.bottom).offset(50).constraint
        }
        
        // dateAndTime 视图设置
        self.scrollView.addSubview(dateAndTime)
        dateAndTime.snp.makeConstraints{(make) in
            make.left.right.equalTo(self)
            // 这里设置顶部位置置顶，与未设置时一样
            make.height.equalTo(AJScreenWidth/8+AJScreenWidth/40)
            // 设置初始始dateAndTime界面顶部在视图顶部
            make.top.equalToSuperview()
        }
        
        // glucose 视图布局
        self.scrollView.addSubview(glucose)
        glucose.snp.makeConstraints{(make) in
            //make.left.right.equalToSuperview()
            make.left.right.equalTo(self)
            make.top.equalTo(dateAndTime.snp.bottom)
            make.height.equalTo(AJScreenWidth/2+AJScreenWidth/20)
        }
        
        // porAndIns 视图布局
        self.scrollView.addSubview(porAndIns)
        porAndIns.snp.makeConstraints{(make) in
            //make.left.right.equalToSuperview()
            make.left.right.equalTo(self)
            make.top.equalTo(glucose.snp.bottom)
            make.height.equalTo(AJScreenWidth/2-AJScreenWidth/15+AJScreenWidth/40)
        }
        
        // bodyInfo 视图布局
        self.scrollView.addSubview(bodyInfo)
        bodyInfo.snp.makeConstraints{(make) in
            //make.left.right.equalToSuperview()
            make.left.right.equalTo(self)
            make.top.equalTo(porAndIns.snp.bottom)
            make.height.equalTo(AJScreenWidth/5*4+AJScreenWidth/20)
        }
        
        // sport 视图布局
        self.scrollView.addSubview(sport)
        sport.snp.makeConstraints{(make) in
            make.left.right.equalTo(self)
            make.top.equalTo(bodyInfo.snp.bottom)
            make.height.equalTo(AJScreenWidth/2 - AJScreenWidth/40)
        }
        
        // remark 视图布局
        self.scrollView.addSubview(remark)
        remark.snp.makeConstraints{(make) in
            make.left.right.equalTo(self)
            make.top.equalTo(sport.snp.bottom)
            make.height.equalTo(AJScreenWidth/4)
        }
        
        
        self.bringSubviewToFront(picker)
    }
    
    
    // MARK: - 以下为界面的日期和时间选择器显示和消失的按钮动作
    // 选择 日期 按钮被点击时的动作
    @objc func chooseDate(){
        print("choose date button clicked,appear done.")
        style = .date
        // 添加背景按钮
        self.addSubview(backButton)
        UIView.animate(withDuration: 0.5, animations: appear)
    }
    
    // 选择 时间 按钮被点击时的动作
    @objc func chooseTime(){
        print("choose time button clicked,appear done.")
        style = .time
        // 添加背景按钮
        self.addSubview(backButton)
        UIView.animate(withDuration: 0.5, animations: appear)
    }
    
    // 选择 事件 按钮被点击时的动作
    @objc func chooseOccurTime(){
        print("choose occurTime button clicked,appear done.")
        style = .occurTime
        // 添加背景按钮
        self.addSubview(backButton)
        UIView.animate(withDuration: 0.5, animations: appear)
    }
    
    // 选择 进餐量 按钮被点击时的动作
    @objc func choosePortion(){
        print("choose occurTime button clicked,appear done.")
        style = .portions
        // 添加背景按钮
        self.addSubview(backButton)
        UIView.animate(withDuration: 0.5, animations: appear)
    }
    
    // 选择 胰岛素 按钮被点击时的动作
    @objc func chooseInsulin(){
        print("choose occurTime button clicked,appear done.")
        style = .insulin
        // 添加背景按钮
        self.addSubview(backButton)
        UIView.animate(withDuration: 0.5, animations: appear)
    }
    
    // 选择 运动 按钮被点击时的动作
    @objc func chooseSport(){
        print("choose sport button clicked,appear done.")
        style = .sport
        // 添加背景按钮
        self.addSubview(backButton)
        UIView.animate(withDuration: 0.5, animations: appear)
    }
    
    // 选择 运动强度 按钮被点击时的动作
    @objc func chooseExerIntensity(){
        print("choose sport button clicked,appear done.")
        style = .exerintensity
        // 添加背景按钮
        self.addSubview(backButton)
        UIView.animate(withDuration: 0.5, animations: appear)
    }
    
    
    
    func dismiss(){
        // 移除背景按钮
        backButton.removeFromSuperview()
        // 移除选择器界面
//        UIView.animate(withDuration: 0.5, animations: {
//            self.picker.frame.origin = CGPoint(x: 0, y: self.frame.maxY-10)
//        }, completion: { _ in
//            //self.picker.removeFromSuperview()
//
//        })
        //self.picker.removeFromSuperview()
        // 重新布置约束
        // 时间选择器界面移到屏幕外，视觉效果为消失
        print("func dismiss done.")
        // 删除顶部约束
        self.bottomConstraint?.uninstall()
        picker.snp_makeConstraints{(make) in
            // 添加底部约束为与视图底部相同
            
            self.topConstraint = make.top.equalTo(self.snp.bottom).offset(50).constraint
            
        }
        animationPickerViewDismiss()
        // 告诉当前控制器的View要更新约束了，动态更新约束，没有这句的话更新约束就没有动画效果
        self.layoutIfNeeded()
    }
    
    func appear(){
        
        // 添加背景按钮
        //self.addSubview(backButton)
        // 添加选择器视图
//        self.addSubview(picker)
//        UIView.animate(withDuration: 0.5, animations: {
//            self.picker.frame.origin = CGPoint(x: 0, y: self.frame.maxY-self.picker.frame.height)
//        }, completion: nil)
        // 设置picker在视图最前面，避免被按钮覆盖
        self.bringSubviewToFront(picker)
        // 重新布置约束
        // 选择器界面移到屏幕内底部，视觉效果为出现
        // 选择哪个选择器就将其推到最前面
        //shareV.pickDateView.frame.origin = CGPoint(x: 0, y: self.frame.size.height/3*2)
        switch style {
            
        case .date:
            picker.bringSubviewToFront(picker.datePicker)
        case .time:
            picker.bringSubviewToFront(picker.timePicker)
            
        case .occurTime:
            picker.bringSubviewToFront(picker.eventPicker)
            
        case .portions:
            picker.bringSubviewToFront(picker.portionPicker)
            animatePickerViewAppear(button: porAndIns.portionButton)
        case .insulin:
            picker.bringSubviewToFront(picker.insulinPicker)
            animatePickerViewAppear(button: porAndIns.insulinButton)
            
        case .sport:
            picker.bringSubviewToFront(picker.sportPicker)
            animatePickerViewAppear(button: sport.sportButton)
//        case .exerintensity:
//            picker.bringSubviewToFront(picker.exerIntensyPicker)
//            animatePickerViewAppear(button: sport.exerIntensityButton)
            
        default:
            picker.bringSubviewToFront(picker.exerIntensyPicker)
            animatePickerViewAppear(button: sport.exerIntensityButton)
            
        }
        //picker.bringSubviewToFront(picker.timePicker)
        print("func appear done.")
        // 删除顶部约束
        self.topConstraint?.uninstall()
        picker.snp_makeConstraints{(make) in
            // 添加底部约束
            self.bottomConstraint = make.bottom.equalToSuperview().constraint
        }
        //animatePickerViewAppear(up: true)
        self.layoutIfNeeded()
    }
    
    // 点击取消按钮，时间选择器界面移到屏幕外，视觉效果为消失
    @objc func pickViewDismiss(){
        UIView.animate(withDuration: 0.5, animations: dismiss)
        print("cancel button clicked")
        
    }
    
    // 点击确定按钮，时间选择器界面移到屏幕外，视觉效果为消失，按钮文本显示日期
    @objc func pickViewSelected(){
        
        // 当按下确定时，重新设置按钮标题
        switch style {
        case .date:
            // 创建一个日期格式器
            let dateFormatter = DateFormatter()
            // 为格式器设置格式字符串,时间所属区域
            dateFormatter.dateFormat="yyyy-MM-dd"
            // 绑定一个时间选择器，并按格式返回时间
            let date = dateFormatter.string(from: picker.datePicker.date)
            dateAndTime.dateButton.setTitle(date, for: .normal)
            print(date)
        case .time:
            // 创建一个时间格式器
            let dateFormatter = DateFormatter()
            // 为格式器设置格式字符串,时间所属区域
            dateFormatter.dateFormat="HH:mm"
            // 绑定一个时间选择器，并按格式返回时间
            let time = dateFormatter.string(from: picker.timePicker.date)
            print(time)
            dateAndTime.timeButton.setTitle(time, for: .normal)
            
        case .occurTime:
            glucose.eventButton.setTitle(picker.eventStr, for: .normal)
            
        case .portions:
            porAndIns.portionButton.setTitle(picker.portionStr, for: .normal)
        case .insulin:
            porAndIns.insulinButton.setTitle(picker.insulinStr, for: .normal)
            
            
        case .sport:
            sport.sportButton.setTitle(picker.sportStr, for: .normal)
//        case .exerintensity:
//            sport.exerIntensityButton.setTitle(picker.exerItensityStr, for: .normal)
        default:
            sport.exerIntensityButton.setTitle(picker.exerItensityStr, for: .normal)
            
        }
        UIView.animate(withDuration: 0.5, animations: dismiss)
        print("sure button clicked")
        
    }

    var offset:CGFloat?
    func animationPickerViewDismiss(){
        if let dy = offset{
            UIView.beginAnimations("animatePickerViewDismiss", context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.5)
            self.scrollView.contentOffset = CGPoint(x: 0, y: dy)
            UIView.commitAnimations()
        }
        offset = nil
    }
    
    // 选择器弹出时的滚动视图的动画
    func animatePickerViewAppear(button:UIButton)
    {
        offset = self.scrollView.contentOffset.y
        
        print(self.scrollView.contentOffset.y)
        // button.frame.maxY 是相对于它的父视图的坐标，不是相对于滚动视图
        print(button.frame.maxY)
        let buttonY = (button.superview?.frame.minY)! + button.frame.maxY - offset!
        let pickerY = self.scrollView.frame.maxY - self.picker.frame.height
        //let movementDistance:CGFloat = -100
        let movementDuration: Double = 0.5
        
        var movement:CGFloat = buttonY - pickerY
        if movement < 0{
            movement = 0
        }
        UIView.beginAnimations("animatePickerViewAppear", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.scrollView.contentOffset = CGPoint(x: 0, y: offset! + movement)
        UIView.commitAnimations()
    }
    
    
    
}
