//
//  modelViewController.swift
//  On_Call
//
//  Created by ADMIN on 2020/1/26.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class modelViewController: UIViewController {

    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    // 点击左按钮的动作
    @objc func leftButtonClick(){
        // 设置返回首页
        self.tabBarController?.selectedIndex = 0
    }
    
    private lazy var bleButton:UIButton = {
        let button = UIButton()
        let bleImage = UIImage.init(named: "蓝牙图标")
        let backImage = UIImage.init(named: "按钮 nor")
        button.addTarget(self, action: #selector(ble), for: .touchUpInside)
        button.inputModelStyle(background: backImage!, image: bleImage!, title: "Bluetooth", offset: 70)
        return button
    }()
    
    private lazy var inputButton:UIButton = {
        let button = UIButton()
        let bleImage = UIImage.init(named: "手动输入图标")
        let backImage = UIImage.init(named: "按钮 nor")
        button.addTarget(self, action: #selector(input), for: .touchUpInside)
   
        button.inputModelStyle(background: backImage!, image: bleImage!, title: "Manually", offset: 70)
    
       return button
    }()
    
    @objc func ble(){
        let vc = BLEViewController()
        vc.title = "Bluetooth"
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func input(){
        let vc = InsertViewController()
        vc.title = "Add"
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private lazy var bleImageView:UIImageView = {
        let bleImage = UIImage.init(named: "蓝牙图标")
        let view = UIImageView.init(image: bleImage)
        view.backgroundColor = UIColor.clear
        
        return view
    }()
    
    private lazy var editImageView:UIImageView = {
        let image = UIImage.init(named: "手动输入图标")
        let view = UIImageView.init(image: image)
        view.backgroundColor = UIColor.clear
        
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "Input Model"
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        // 按钮布局
        self.view.addSubview(bleButton)
        self.view.addSubview(inputButton)
        self.view.addSubview(bleImageView)
        self.view.addSubview(editImageView)
        bleButton.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(50)
            }
            make.height.equalTo(50)
        }
        
        bleImageView.snp.makeConstraints{(make) in
            make.left.top.equalTo(bleButton).offset(8)
            make.height.width.equalTo(34)
            
        }
        inputButton.snp.makeConstraints{(make) in
            make.left.right.height.equalTo(bleButton)
            make.top.equalTo(bleButton.snp.bottom).offset(38)
            
        }
        
        editImageView.snp.makeConstraints{(make) in
            make.left.top.equalTo(inputButton).offset(8)
            make.height.width.equalTo(34)
            
        }
    // 设置监听器，监听是否弹出插入成功r弹窗
        NotificationCenter.default.addObserver(self, selector: #selector(InsertSuccess), name: NSNotification.Name(rawValue: "InsertData"), object: nil)

    }

    @objc func InsertSuccess(){
        // 跳转到home界面
        self.tabBarController?.selectedIndex = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 设置导航栏为透明
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        // 设置滚动视图和表格视图不自动调整位移量
        self.automaticallyAdjustsScrollViewInsets = false
        // 隐藏 tabbar
        self.tabBarController?.tabBar.isHidden = true
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
