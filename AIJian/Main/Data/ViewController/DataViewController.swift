//
//  DataViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import DNSPageView
import SnapKit
import Alamofire
import HandyJSON


class DataViewController: UIViewController {

    // 设置导航栏左按钮x样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageViewManager:DNSPageViewManager = {
        // MARK：- 创建DNSPageStyle,设置格式
        // 标题是否能滚动、点击标题是否会伸缩、标题背景、是否显示下划线
        // 标题字体颜色、字体选中颜色、下划线颜色、下划线高
        let style = DNSPageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = false
        style.titleViewBackgroundColor = barDefaultColor
        style.isShowBottomLine = true
        style.titleFont = UIFont.systemFont(ofSize: 14)
        style.titleSelectedColor = UIColor.white
        style.titleColor = UIColor.white
        style.bottomLineColor = UIColor.white
        style.bottomLineHeight = 2
        
        // 标题内容
        let titles = ["Chart","Statistics","Datalist","Share"]
        // 设置每个标题对应的ViewController
        let viewControllers:[UIViewController] = [ChartViewController(),StatisticalDataViewController(),DataTableViewController(),SharedViewController()]
        let y = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0)
        let size = UIScreen.main.bounds.size
        for vc in viewControllers{
            self.addChild(vc)
        }
        return DNSPageViewManager(style: style, titles: titles, childViewControllers: viewControllers)
    }()
    
    private lazy var rangePickerButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(chooseDate), for: .touchUpInside)
        button.setTitle("最近7天", for: .normal)
        button.frame.size = CGSize(width: AJScreenWidth/5, height: 44)
        return button
    }()

    // 日期范围选择器
    private lazy var dateRangePicker:dateRangePickerView = {
        let view = dateRangePickerView()
        view.setupUI()
        view.cancelButton.addTarget(self, action: #selector(pickViewDismiss), for: .touchUpInside)
        view.sureButton.addTarget(self, action: #selector(pickViewSelected), for: .touchUpInside)
        return view
    }()
    
    var topConstraint:Constraint?
    var bottomConstraint:Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        // 添加导航栏右按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rangePickerButton)
        
        // 添加标题视图
        let titleview = pageViewManager.titleView
        view.addSubview(titleview)
        // 设置标题视图左右约束为对齐屏幕，顶部对齐导航栏，高度为44
        titleview.snp.makeConstraints{(make )in
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
            //make.top.equalTo((self.navigationController?.navigationBar.snp.bottom)!)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            
        }
        
        // 添加内容视图
        let contentview = pageViewManager.contentView
        view.addSubview(contentview)
        // 注：想要横竖屏时内容区域自适应屏幕，需对内容区域进行左右约束对齐父视图
        // 设置约束左右与屏幕对齐，顶部对齐标题视图，底部与屏幕底部对齐
        contentview.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            
            // 顶部与titleView对齐
            // 底部与屏幕底部对齐
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(44)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(44)
            }
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }

        }
        
        self.view.addSubview(dateRangePicker)
        dateRangePicker.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/4)
            if #available(iOS 11.0, *) {
                self.topConstraint = make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(40).constraint
            } else {
                // Fallback on earlier versions
                self.topConstraint = make.top.equalTo(bottomLayoutGuide.snp.bottom).offset(40).constraint
            }
        }

        self.view.backgroundColor = UIColor.white   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    @objc func leftButtonClick(){
        // 设置返回首页
        self.tabBarController?.selectedIndex = 0
    }
    
    // MARK: - 以下为时间范围选择器显示和消失的按钮动作
    // 选择出生日期按钮被点击时的动作
    @objc func chooseDate(){
        print("choose date button clicked,appear done.")
        UIView.animate(withDuration: 0.5, animations: appear)
    }
    
    // 点击取消按钮，时间选择器界面移到屏幕外，视觉效果为消失
    @objc func pickViewDismiss(){
        UIView.animate(withDuration: 0.5, animations: dismiss)
        
        print("cancel button clicked")
    }
    
    // 点击确定按钮，选择器界面移到屏幕外，视觉效果为消失，按钮文本显示被选项
    // 根据被选项内容执行不同的动作
    @objc func pickViewSelected(){
        UIView.animate(withDuration: 0.5, animations: dismiss)
        rangePickerButton.setTitle(dateRangePicker.selectedContent, for: .normal)
        print("sure button clicked")
    }
    
    // 选择器消失
    func dismiss(){
        // 重新布置约束
        // 时间选择器界面移到屏幕外，视觉效果为消失
        //shareV.pickDateView.frame.origin = CGPoint(x: 0, y: shareV.snp.bottom)
        print("func dismiss done.")
        // 删除顶部约束
        self.bottomConstraint?.uninstall()
        dateRangePicker.snp_makeConstraints{(make) in
            
            // 添加底部约束
            if #available(iOS 11.0, *) {
                self.topConstraint = make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(40).constraint
            } else {
                // Fallback on earlier versions
                self.topConstraint = make.top.equalTo(bottomLayoutGuide.snp.bottom).offset(40).constraint
            }
        }
        // 告诉当前控制器的View要更新约束了，动态更新约束，没有这句的话更新约束就没有动画效果
        self.view.layoutIfNeeded()
    }
    
    //选择器显示
    func appear(){
        
        // 重新布置约束
        // 时间选择器界面移到屏幕内底部，视觉效果为出现
        print("func appear done.")
        // 删除顶部约束
        self.topConstraint?.uninstall()
        dateRangePicker.snp_makeConstraints{(make) in
            
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
}

