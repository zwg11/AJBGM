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
import SwiftDate

// 用于对数据库数据的提取和各个页面显示内容的初始化
// start 和 end 分别表示时间范围的开始时间和结束时间
var startD:Date?
var endD:Date?
//  表示该时间范围的天数
var daysNum:Int?

// 范围选择器选中的目标，作为标志位
var pickerSelectedRow = 2

class DataViewController: UIViewController {

    // 该按钮为时间范围选择器出现时的背景
    // 实现点击背景选择器消失的效果
    private lazy var backButton:UIButton = {
        let button = UIButton.init(type: .system)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(pickViewDismiss), for: .touchUpInside)
//        button.frame = CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight)
        return button
    }()
    
    
    
    
    // 设置导航栏左按钮x样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var pageViewManager:DNSPageViewManager = {
        // MARK：- 创建DNSPageStyle,设置格式
        // 标题是否能滚动、点击标题是否会伸缩、标题背景、是否显示下划线
        // 标题字体颜色、字体选中颜色、下划线颜色、下划线高
        let style = DNSPageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = false
//        style.titleViewBackgroundColor = ThemeColor
        style.titleViewBackgroundColor = UIColor.clear
        style.isShowBottomLine = true
        style.titleFont = UIFont.systemFont(ofSize: 14)
        style.titleSelectedColor = UIColor.white
        style.titleColor = UIColor.white
        style.bottomLineColor = UIColor.green
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
    
    // 导航栏有按钮，用于弹出时间范围选择器
    lazy var rangePickerButton:UIButton = {
        let button = UIButton(type:.system)
        button.addTarget(self, action: #selector(chooseDate), for: .touchUpInside)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitle("Last 7 days", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .right
        button.frame.size = CGSize(width: AJScreenWidth/3, height: 44)
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
        // 设置页面支持横屏
//        appDelegate.blockRotation = true
        self.view.backgroundColor = UIColor.clear
//        self.view.backgroundColor = UIColor.lightGray
        // 超过页面范围的子页面不显示
        self.view.clipsToBounds = true
        // 设置pickerView初始位置
        dateRangePicker.rangePicker.selectRow(1, inComponent: 0, animated: false)
        
        // 添加标题视图
        let titleview = pageViewManager.titleView
//        titleview.backgroundColor = UIColor.red
        view.addSubview(pageViewManager.titleView)
        // 设置标题视图左右约束为对齐屏幕，顶部对齐导航栏，高度为44
        pageViewManager.titleView.snp.makeConstraints{(make )in
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
//        contentview.backgroundColor = UIColor.clear
//        contentview.tintColor = UIColor.clear
        contentview.collectionView.backgroundColor = UIColor.clear
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
        
        self.navigationController!.view.addSubview(dateRangePicker)
        dateRangePicker.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/4)
            if #available(iOS 11.0, *) {
                self.topConstraint = make.top.equalTo(self.navigationController!.view.safeAreaLayoutGuide.snp.bottom).offset(40).constraint
            } else {
                // Fallback on earlier versions
                self.topConstraint = make.top.equalTo(self.navigationController!.bottomLayoutGuide.snp.bottom).offset(40).constraint
            }
        }

//        self.view.backgroundColor = UIColor.white
    }
    

//    override var shouldAutorotate: Bool{
//            return true
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return .allButUpsideDown
//    }
    
    // 页面出现，tabbar隐藏
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        self.automaticallyAdjustsScrollViewInsets = false
//        self.extendedLayoutIncludesOpaqueBars = true;
        // 隐藏 tabbar
        self.tabBarController?.tabBar.isHidden = true
//        self.pageViewManager.titleView.currentIndex = 0
        // 设置页面支持横屏
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.blockRotation = true
//        let value = UIInterfaceOrientation.portrait.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
        
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        // 添加导航栏右按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rangePickerButton)
        
        // 识别 导航栏右按钮标题，做出相应值的设置
        setDaysAndRange()
        
        
    }

    // 页面消失，tabbar隐藏
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        // 设置页面不支持横屏
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.blockRotation = false
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        

    }
    @objc func leftButtonClick(){
        let orientation = UIDevice.current.orientation
        if orientation != .portrait{
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }

        // 设置返回首页
        self.tabBarController?.selectedIndex = 0
    }
    
    // MARK: - 以下为时间范围选择器显示和消失的按钮动作
    // 选择日期按钮被点击时的动作
    @objc func chooseDate(){
        print("choose range date button clicked,appear done.")

        // 添加背景按钮
        self.navigationController!.view.addSubview(backButton)
        backButton.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        self.navigationController!.view.bringSubviewToFront(dateRangePicker)
        UIView.animate(withDuration: 0.5, animations: appear)
        
    }
    
    // 该视图用来设置自定义选择日期范围的视图
    
    private lazy var customRange:customRangeView = {
        let view = customRangeView()
        view.setupUI()
        view.endbutton.addTarget(self, action: #selector(selectCustomRange), for: .touchUpInside)
        return view
    }()
    // 自定义选择日期的 设置日期按钮被选中时 的动作
    @objc func selectCustomRange(){
        
        print("select CustomRange")
        
        let customSD = customRange.startDatePicker.date
        let customED = customRange.endDatePicker.date
        
        print("开始时间：\(customRange.startDatePicker.date)")
        print("结束时间：\(customRange.endDatePicker.date)")
        let components = NSCalendar.current.dateComponents([.day], from: customSD, to: customED)
        if customRange.startDatePicker.date > customRange.endDatePicker.date{
            let alert = CustomAlertController()
            alert.custom(self, "Attention", "Start Date Needs to Come Before End Date")
        }else if components.day! > 31{
            let alert = CustomAlertController()
            alert.custom(self, "Attention", "The Time Span Shall Not Greater Than 31 Days")
        }
        else{
            // 选择日期范围视图移除
            customRange.removeFromSuperview()
            // 更新按钮标题
            rangePickerButton.setTitle(dateRangePicker.selectedContent, for: .normal)
            // 设置开始时间和结束时间
            // 开始时间
            let SD = dateManage(date: customRange.startDatePicker.date)
            startD = SD.dateAt(.startOfDay)
//            print("startD:\(startD)")
            // 结束时间
            let ED = customRange.endDatePicker.date
            endD = ED.dateAt(.endOfDay)
//            print("endD:\(endD)")
            // 设定被选中的标志位
            pickerSelectedRow = 4
            
            // 执行对日期范围选定后的数据处理
            setDaysAndRange()
            // 打印 开始时间 和 结束时间
            //print("startD:\(startD),endD:\(endD)")
        }
        
        
        
    }
    
    func dateManage(date:Date) -> Date{
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy/MM/dd"
        let res = dateformat.string(from: date)
        let x = res.toDate()?.date
        return x!
    }
    // ************ 选择器的出现和消失 ****************
    // 点击取消按钮，时间选择器界面移到屏幕外，视觉效果为消失
    @objc func pickViewDismiss(){
        backButton.removeFromSuperview()
        dismiss()
//        UIView.animate(withDuration: 0.5, animations: dismiss)
        print("cancel button clicked")
    }
    
    // 点击确定按钮，时间范围选择器界面移到屏幕外，视觉效果为消失，按钮文本显示被选项
    // 根据被选项内容执行不同的动作
    @objc func pickViewSelected(){
        backButton.removeFromSuperview()
        dismiss()
//        UIView.animate(withDuration: 0.5, animations: dismiss)
        // 如果选择了自定义，那么弹出2个时间选择器供用户选择时间范围
        if dateRangePicker.selectedContent == "Custom"{
            self.navigationController!.view.addSubview(customRange)
            customRange.snp.makeConstraints{(make)  in
                make.left.right.equalToSuperview()
//                make.bottom.equalTo(self.navigationController!.view.snp.bottom)
                if #available(iOS 11.0, *) {
                    make.bottom.equalTo(self.navigationController!.view.safeAreaLayoutGuide.snp.bottom)
                } else {
                    // Fallback on earlier versions
                    make.bottom.equalTo(self.navigationController!.bottomLayoutGuide.snp.top)
                }
                make.height.equalTo(AJScreenHeight)
            }
            self.navigationController!.view.layoutIfNeeded()
        }// 否则更新按钮标题
        else{
//            UIView.animate(withDuration: 0.5, animations: dismiss)
            // 更新按钮标题
            rangePickerButton.setTitle(dateRangePicker.selectedContent ?? "Last 7 days", for: .normal)
            
            // 监听导航栏右按钮的文本，对于不同的文本设定不同的标志位
            switch dateRangePicker.selectedContent{
                
            case "Last 3 days":
                pickerSelectedRow = 1
            case "Last 7 days":
                pickerSelectedRow = 2
            case "Last 30 days":
                pickerSelectedRow = 3
            default:
                print("error.No selelcted row in picker.")
                
            }
            // 识别 导航栏右按钮标题，做出相应值的设置
            setDaysAndRange()
        }
        
        print("sure button clicked")
    }// 根据被选项内容执行不同的动作
    
    
    // 选择器消失
    func dismiss(){
        // 重新布置约束
        // 时间选择器界面移到屏幕外，视觉效果为消失
        //shareV.pickDateView.frame.origin = CGPoint(x: 0, y: shareV.snp.bottom)
        print("func dismiss done.")
        // 删除顶部约束
        self.bottomConstraint?.uninstall()
        dateRangePicker.snp.makeConstraints{(make) in
//            self.topConstraint = make.top.equalTo(self.navigationController!.view.snp.bottom).offset(40).constraint
            // 添加底部约束
            if #available(iOS 11.0, *) {
                self.topConstraint = make.top.equalTo(self.navigationController!.view.safeAreaLayoutGuide.snp.bottom).offset(40).constraint
            } else {
                // Fallback on earlier versions
                self.topConstraint = make.top.equalTo(self.navigationController!.bottomLayoutGuide.snp.bottom).offset(40).constraint
            }
        }
        // 告诉当前控制器的View要更新约束了，动态更新约束，没有这句的话更新约束就没有动画效果
        self.navigationController!.view.layoutIfNeeded()
    }// 选择器消失
    
    
    //选择器显示
    func appear(){
        
        // 重新布置约束
        // 时间选择器界面移到屏幕内底部，视觉效果为出现
        print("func appear done.")
        // 删除顶部约束
        self.topConstraint?.uninstall()
        dateRangePicker.snp_makeConstraints{(make) in
//            self.bottomConstraint = make.bottom.equalTo(self.navigationController!.view.snp.bottom).constraint
            // 添加底部约束
            if #available(iOS 11.0, *) {
                self.bottomConstraint = make.bottom.equalTo(self.navigationController!.view.safeAreaLayoutGuide.snp.bottom).constraint
            } else {
                // Fallback on earlier versions
                self.bottomConstraint = make.bottom.equalTo(self.navigationController!.bottomLayoutGuide.snp.top).constraint
            }
        }
        self.navigationController!.view.layoutIfNeeded()
    }//选择器显示
    
    
    // 对于导航栏右按钮的标题不同，做不同的事情
    func setDaysAndRange(){
        let x = Date().dateAt(.endOfDay)
        print("x",x)
        let today = DateInRegion().dateAt(.endOfDay).date
        print("today:",today)
        
        // 监听导航栏右按钮的文本，对于不同的文本生成对应的数据
        switch pickerSelectedRow{
            
        case 1:
            endD = today + 1.seconds
            startD = endD! - 3.days
            daysNum = 3
            // 向数据库索取一定时间范围的数据，并将其按时间降序排序
            initDataSortedByDate(startDate: startD!, endDate: endD!, userId: UserInfo.getUserId())
            // 处理出为展示表格的数据
            sortedTimeOfData()
            // 处理出为展示图表的数据
            chartData()
        case 2:
            endD = today + 1.seconds
            startD = endD! - 7.days
            daysNum = 7
            initDataSortedByDate(startDate: startD!, endDate: endD!, userId: UserInfo.getUserId())
            sortedTimeOfData()
            chartData()
        case 3:
            endD = today + 1.seconds
            startD = endD! - 30.days
            daysNum = 30
            initDataSortedByDate(startDate: startD!, endDate: endD!, userId: UserInfo.getUserId())
            sortedTimeOfData()
            chartData()
        default:
            let components = Calendar.current.dateComponents([.day], from: startD!, to: endD!+1.seconds)
            daysNum = components.day
            print("daysNum:\(String(describing: daysNum))")
            initDataSortedByDate(startDate: startD!, endDate: endD!, userId: UserInfo.getUserId())
            sortedTimeOfData()
            chartData()
            
        }

        // 根据当前所在的页面刷新对应页面的数据显示
        switch self.pageViewManager.titleView.currentIndex{
        case 0:// 设置通知，通知控制器重新加载他的界面
            NotificationCenter.default.post(name: NSNotification.Name("reloadChart"), object: self, userInfo: nil)
        case 1:// 设置通知，通知控制器重新加载他的界面
            NotificationCenter.default.post(name: NSNotification.Name("reloadData"), object: self, userInfo: nil)
        case 2:// 设置通知，通知控制器重新加载他的界面
            NotificationCenter.default.post(name: NSNotification.Name("reloadTable"), object: self, userInfo: nil)
        default:// 设置通知，通知控制器重新加载他的界面
            NotificationCenter.default.post(name: NSNotification.Name("reloadView"), object: self, userInfo: nil)
            
        }
        // 设置通知，通知其他控制器重新加载他们的界面
        //NotificationCenter.default.post(name: NSNotification.Name("reload"), object: self, userInfo: nil)

    
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
}

extension DataViewController{
//    override var shouldAutorotate: Bool {
//        return true
//    }
//    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .allButUpsideDown
//    }
//    
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .portrait
//    }
}
