//
//  StatisticalDataViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class StatisticalDataViewController: UIViewController,UIScrollViewDelegate {

    
    var scrollView:UIScrollView?
    // 平均统计视图
    lazy var averageview:averageView = {
        let view = averageView()
        view.setupUI()
        //view.backgroundColor = UIColor.yellow
        return view
    }()
    // 总体检测结果视图
    lazy var totalview:totalCheckView = {
        let view = totalCheckView()
        view.setupUI()
        //注：标题的数字后期需要用整数变量代替
        view.checkViewTitle.text = "total - 0 tests"
        //view.backgroundColor = UIColor.gray
        return view
    }()
    // 餐前检测结果视图
    lazy var perMeal:totalCheckView = {
        let view = totalCheckView()
        view.setupUI()
        //注：标题的数字后期需要用整数变量代替
        view.checkViewTitle.text = "per meal - 0 tests"
//        view.isPerMeal = true
//        view.titleChange()
        //view.backgroundColor = UIColor.blue
        return view
    }()
    // 餐后检测结果视图
    lazy var afterMeal:totalCheckView = {
        let view = totalCheckView()
        view.setupUI()
        //注：标题的数字后期需要用整数变量代替
        view.checkViewTitle.text = "after meal - 0 tests"
//        view.isPerMeal = false
//        view.titleChange()
        //view.backgroundColor = UIColor.red
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // scrollView的高度是这样得到的：
        // 屏幕高度 - 状态栏高度 - 导航栏高度 - 标题高度
        // 导航栏 和 标题栏 高度都为 44

        scrollView = UIScrollView()
        scrollView!.contentSize = CGSize(width: self.view.frame.size.width, height: 620)
        scrollView!.alwaysBounceVertical = true
        scrollView!.showsVerticalScrollIndicator = true
        self.view.addSubview(scrollView!)
        scrollView!.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
        }
        
        // 平均值窗口初始化

        scrollView?.addSubview(averageview)
        averageview.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(190)
        }
        
        // 总体检测结果窗口初始化

        scrollView?.addSubview(totalview)
        totalview.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(averageview.snp.bottom)
            make.height.equalTo(140)
        }
      
        // 餐前检测窗口初始化
        scrollView?.addSubview(perMeal)
        perMeal.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(totalview.snp.bottom)
            make.height.equalTo(140)
        }
        
        // 餐后检测窗口初始化
        scrollView?.addSubview(afterMeal)
        afterMeal.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(perMeal.snp.bottom)
            make.height.equalTo(140)
        }
        
    }
    
    // 设置视图每次出现时滚动视图都回到顶部
    override func viewWillAppear(_ animated: Bool) {
        self.scrollView?.contentOffset = CGPoint(x: 0, y: 0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
//        let inter = UIApplication.shared.statusBarOrientation
//        if(inter == UIInterfaceOrientation.portrait){
//            print("shuping")
//
//        }
//        else{
//            scrollView?.frame.size.height = UIScreen.main.bounds.height-108
//
//        }
//    }

}
