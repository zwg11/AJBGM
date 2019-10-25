//
//  SharedViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class SharedViewController: UIViewController,UITextFieldDelegate {

    
    // 记录日期
    var date:String?
    // 记录姓名
    var name:String?
    // 记录电话
    var phone:String?
    private lazy var shareV:SharedView = {
        let view = SharedView()
        view.setupUI()
//        view.emailTextField.delegate = self
        view.nameTextField.delegate = self

        view.sendButton.addTarget(self, action: #selector(sendImage), for: .touchUpInside)
        return view
    }()
    private lazy var general:GeneralStatusView = {
       let view = GeneralStatusView()
        view.setupUI()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        // 刷新数据
        let userInfo = DBSQLiteManager.manager.selectUserRecord(userId: UserInfo.getUserId())
        shareV.nameTextField.text = userInfo.user_name
        shareV.phoneTextField.text = userInfo.phone_number
        general.test()
    }
    // 将shareV视图生成为图片
    @objc func sendImage(){
//        let indicator = CustomIndicatorView()
//        indicator.setupUI("正在生成图片...")
//        self.view.addSubview(indicator)
//        indicator.snp.makeConstraints{(make) in
//            make.edges.equalToSuperview()
//        }
//        indicator.startIndicator()
        let alert = CustomAlertController()
        let name = shareV.nameTextField.text
        let phone = shareV.phoneTextField.text
        if name == ""{
            alert.custom(self,"Attention", "Name Empty")
            return
        }
        if phone == ""{
            alert.custom(self,"Attention", "Phone Empty")
            return
        }
        if name?.count >= 50{
            return
        }
        if phone?.count >= 30{
            return
        }
        //设置名字和电话
        general.nameLabel.text = name?.removeHeadAndTailSpacePro
        general.phoneLabel.text = phone?.removeHeadAndTailSpacePro

        // 将视图生成文件
        let image = viewToImage.getImageFromView(view: general)
        // 将图片放入相册
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.savedPhotosAlbum(_:didFinishSavingWithError:contextInfo:)), nil)
        // 要分享的内容封装成数组
        let activityItems = [image]
        // 创建
        let toVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//        indicator.stopIndicator()
//        indicator.removeFromSuperview()
        self.present(toVC, animated: true, completion: nil)
    }
    
    //保存图片
    @objc func savedPhotosAlbum(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        
        if error != nil {
            let alert = UIAlertController(title: "", message: "Generate Order Failed", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            sleep(1)
            alert.dismiss(animated: true, completion: nil)
            print("savw failed")
            
        } else {
            let alert = UIAlertController(title: "", message: "Generate Order Successfully", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            sleep(1)
            alert.dismiss(animated: true, completion: nil)
            print("savw success")
            
        }
    }
    

    var topConstraint:Constraint?
    var bottomConstraint:Constraint?

    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
//        self.view.backgroundColor = ThemeColor
        self.view.clipsToBounds = true

        self.view.addSubview(general)
        
        let sharedScrollView = UIScrollView()
        // 设置内容高度为屏幕的3/2,显示滚动条，d能上下滚动，背景为白色
        sharedScrollView.contentSize = CGSize(width: AJScreenWidth, height: AJScreenWidth)
        sharedScrollView.alwaysBounceVertical = true
        sharedScrollView.showsVerticalScrollIndicator = true
        sharedScrollView.backgroundColor = UIColor.clear
        self.view.addSubview(sharedScrollView)
        sharedScrollView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            //*********************************
            // 可使底部与tabbar自动对齐
            // 注：不同版本对于顶部底部对齐不同，
            //iOS11推出了safeAreaLayoutGuide，而iOS11之前使用bottomLayoutGuide和topLayoutGuide
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
            //**********************************
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            
        }
    
        // sharedView 视图设置
        sharedScrollView.addSubview(shareV)
        
        shareV.snp.makeConstraints{(make) in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            //            make.height.equalTo(self.view.frame.size.height/2)
            // 这里设置顶部位置置顶，与未设置时一样
            //make.left.right.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            
        }

        // Do any additional setup after loading the view.

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "")
        
        // 将内容赋值给对应的字符串
        name = textField.text

        // 收起键盘
        textField.resignFirstResponder()
        return true
    }
}
