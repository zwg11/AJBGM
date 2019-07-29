//
//  StatisticalDataViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class StatisticalDataViewController: UIViewController {

    var scrollView:UIScrollView?
    var average = averageView.init(frame: CGRect(x: 0, y: 0, width: AJScreenWidth, height: 190))
    override func viewDidLoad() {
        super.viewDidLoad()

        // scrollView的高度是这样得到的：
        // 屏幕高度 - 状态栏高度 - 导航栏高度 - 标题高度
        // 导航栏 和 标题栏 高度都为 44
        //let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight - UIApplication.shared.statusBarFrame.height - 44 * 2))
        scrollView = UIScrollView()
        scrollView!.contentSize = CGSize(width: self.view.frame.size.width, height: 600)
        scrollView!.alwaysBounceVertical = true
        scrollView!.showsVerticalScrollIndicator = true
        self.view.addSubview(scrollView!)
        scrollView!.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height-108)
        }
        // 平均值窗口初始化
        // let average = averageView.init(frame: CGRect(x: 0, y: 0, width: AJScreenWidth, height: 190))
        //let average = averageView.self

        average.backgroundColor = UIColor.gray

        scrollView!.addSubview(average)
//        average.snp.makeConstraints{(make) in
//            make.left.right.equalToSuperview()
//            make.top.equalToSuperview()
//            make.height.equalTo(190)
//        }
        
        
        // 总体检测结果窗口初始化
        let totalCheck = checkView.init(frame: CGRect(x: 0, y: 190, width: AJScreenWidth, height: 140))
        scrollView!.addSubview(totalCheck)
        
        
        
        
        // 餐前检测窗口初始化
        let perMeal = perAndAfterMealTests.init(frame: CGRect(x: 0, y: 330, width: AJScreenWidth, height: 120))
        scrollView!.addSubview(perMeal)
        
        // 餐后检测窗口初始化
        let afterMeal = perAndAfterMealTests.init(frame: CGRect(x: 0, y: 450, width: AJScreenWidth, height: 120))
        afterMeal.isPerMeal = false
        afterMeal.titleChange()
        scrollView!.addSubview(afterMeal)
        
//        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 650)
//        scrollView.alwaysBounceVertical = true
//        scrollView.showsVerticalScrollIndicator = true
//        self.view.addSubview(scrollView)
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        let inter = UIApplication.shared.statusBarOrientation
        if(inter == UIInterfaceOrientation.portrait){
            print("shuping")
            
        }
        else{
            scrollView?.frame.size.height = UIScreen.main.bounds.height-108
            //average.frame.size.width = AJScreenWidth

        }
        average.frame.size.width = AJScreenWidth
    }

}
