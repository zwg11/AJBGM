//
//  StatisticalDataViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class StatisticalDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // scrollView的高度是这样得到的：
        // 屏幕高度 - 状态栏高度 - 导航栏高度 - 标题高度
        // 导航栏 和 标题栏 高度都为 44
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight - UIApplication.shared.statusBarFrame.height - 44 * 2))
//        print(self.view.frame.height)
//        print(AJScreenHeight)
//        print((self.navigationController?.navigationBar.frame.height)!)
        
        // 平均值窗口初始化
        let average = averageView.init(frame: CGRect(x: 0, y: 0, width: AJScreenWidth, height: 190))
        scrollView.addSubview(average)
        
        // 总体检测结果窗口初始化
        let totalCheck = checkView.init(frame: CGRect(x: 0, y: 190, width: AJScreenWidth, height: 140))
        scrollView.addSubview(totalCheck)
        
        // 餐前检测窗口初始化
        let perMeal = perAndAfterMealTests.init(frame: CGRect(x: 0, y: 330, width: AJScreenWidth, height: 120))
        scrollView.addSubview(perMeal)
        
        // 餐后检测窗口初始化
        let afterMeal = perAndAfterMealTests.init(frame: CGRect(x: 0, y: 450, width: AJScreenWidth, height: 120))
        afterMeal.isPerMeal = false
        afterMeal.titleChange()
        scrollView.addSubview(afterMeal)
        
        scrollView.contentSize = CGSize(width: AJScreenWidth, height: 600)
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        self.view.addSubview(scrollView)
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

}
