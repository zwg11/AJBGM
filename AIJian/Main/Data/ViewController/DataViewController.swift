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
        //button.setTitleColor(UIColor.blue, for: .normal)
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
        let titles = ["chart","statistical data","table","shared"]
        // 设置每个标题对应的ViewController
        let viewControllers:[UIViewController] = [ChartViewController(),StatisticalDataViewController(),DataTableViewController(),SharedViewController()]
        let y = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0)
        let size = UIScreen.main.bounds.size
        for vc in viewControllers{
            self.addChild(vc)
        }
        return DNSPageViewManager(style: style, titles: titles, childViewControllers: viewControllers)
    }()
    
    var glucoseValue:[Double] = []
    var glucoseTime:[Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        //********
        let day = 15
        let userId = 6
        let dicStr:Dictionary = ["day":day,"userId":userId,"token":token] as [String : Any]
        print(dicStr)
        // 请求数据，请求信息如上c字典
        Alamofire.request(REQUEST_DATA_URL,method: .post,parameters: dicStr).responseString{ (response) in
            if response.result.isSuccess {
                print("收到回复")
                if let jsonString = response.result.value {
                    
                    /// json转model
                    /// 写法一：responseModel.deserialize(from: jsonString)
                    /// 写法二：用JSONDeserializer<T>
                    /*
                     利用JSONDeserializer封装成一个对象。然后再把这个对象解析为
                     */
                    if let recordInDaysResponse = JSONDeserializer<recordInDaysResponse>.deserializeFrom(json: jsonString) {
                        //输出得到的数据
                        print(recordInDaysResponse)
                        print(recordInDaysResponse.msg ?? "nothing")
                        print(recordInDaysResponse.data ?? "none")
                        for i in recordInDaysResponse.data!{
                            if let value = i.bloodGlucoseMmol{
                                self.glucoseValue.append(value)
                                
                            }
                        }
                       
                    }
                    print("********************")
                    print(self.glucoseValue)
                }
            }
        }
        
        //**********
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
            //make.height.equalToSuperview()


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
        //self.dismiss(animated: true, completion: nil)
    }
    
    // 以下原来是用来解决转屏时的约束问题，现在不需要了
    
//    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
//
//        //*****************************************
//        // 转屏时的动画太丑了，想个办法美化下
//        UIView.animate(withDuration: 0, animations: changeSizeAndOrigin)
//        pageViewManager.titleView.frame.size.width = UIScreen.main.bounds.width
//        if #available(iOS 11.0, *) {
//            pageViewManager.titleView.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.minY
//        } else {
//            // Fallback on earlier versions
//            pageViewManager.titleView.frame.origin.y = 44
//        }
//        //let inter = UIApplication.shared.statusBarOrientation
////        if(inter == UIInterfaceOrientation.portrait){
////            print("shuping")
////        }
////        else{
////            pageViewManager.titleView.frame.size.width = UIScreen.main.bounds.width
////        }
//    }
//    @objc func changeSizeAndOrigin(){
//        pageViewManager.titleView.frame.size.width = UIScreen.main.bounds.width
//        if #available(iOS 11.0, *) {
//            pageViewManager.titleView.frame.origin.y = self.view.safeAreaLayoutGuide.layoutFrame.minY
//        } else {
//            // Fallback on earlier versions
//            pageViewManager.titleView.frame.origin.y = 44
//        }
//    }
}
