//
//  DataViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import DNSPageView

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.white
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
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
        for vc in viewControllers{
            self.addChild(vc)
        }
        // 创建标题，设置坐标、尺寸等
        let pageView = DNSPageView(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight-navigationBarHeight), style: style, titles: titles, childViewControllers: viewControllers)
        view.addSubview(pageView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    @objc func leftButtonClick(){
        self.tabBarController?.selectedIndex = 0
        self.dismiss(animated: true, completion: nil)
    }
}
