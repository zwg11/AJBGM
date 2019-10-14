////
////  BLEViewController.swift
////  AIJian
////
////  Created by ADMIN on 2019/9/7.
////  Copyright © 2019 apple. All rights reserved.
////
//
//import UIKit
//
//
//class BLEViewController: UIViewController {
//
////    let sd = sliderView.init(frame: CGRect(x: 0, y: 100, width: AJScreenWidth*0.9, height: 5))
//    // 设置导航栏左按钮样式
//    private lazy var leftButton:UIButton = {
//        let button = UIButton.init(type: .custom)
//        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        button.setImage(UIImage(named: "back"), for: .normal)
//        //button.setTitleColor(UIColor.blue, for: .normal)
//        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
//        return button
//    }()
//    // 点击左按钮的动作
//    @objc func leftButtonClick(){
//        // 设置返回首页
//        self.tabBarController?.selectedIndex = 0
//    }
//
//    // 设置导航栏右按钮样式
//    private lazy var rightButton:UIButton = {
//        let button = UIButton.init(type: .custom)
//        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        button.setImage(UIImage(named: "edit"), for: .normal)
//        //button.setTitleColor(UIColor.blue, for: .normal)
//        button.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
//        return button
//    }()
//    // 点击右按钮的动作
//    @objc func rightButtonClick(){
//        // 设置去手动输入界面
//        let insert = InsertViewController()
//
//        self.navigationController?.pushViewController(insert, animated: true)
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        let sd = sliderView.init(frame: CGRect(x: 0, y: -100, width: AJScreenWidth*0.9, height: 2))
//        self.view.addSubview(sd)
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
//        sliderImage = viewToImage.getImageFromView(view: sd)
//        // 隐藏tabbar
//        self.tabBarController?.tabBar.isHidden = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        // 隐藏tabbar
//        self.tabBarController?.tabBar.isHidden = false
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        self.view.addSubview(sd)
//        // 添加导航栏左按钮
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
//        // 添加导航栏右按钮
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
//        // Do any additional setup after loading the view.
////        sliderImage = viewToImage.getImageFromView(view: sd)
////         设置监听器，监听是否弹出插入成功弹窗
//        NotificationCenter.default.addObserver(self, selector: #selector(InsertSuccess), name: NSNotification.Name(rawValue: "InsertData"), object: nil)
//
//    }
//
//    @objc func InsertSuccess(){
//        let x = UIAlertController(title: "", message: "Insert Success.", preferredStyle: .alert)
//        self.present(x, animated: true, completion: {()->Void in
//            sleep(1)
//            x.dismiss(animated: true, completion: nil)
//        })
//        self.tabBarController?.selectedIndex = 0
//
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension BLEViewController{
//    override var shouldAutorotate: Bool {
//        return false
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
//
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .portrait
//    }
//}
