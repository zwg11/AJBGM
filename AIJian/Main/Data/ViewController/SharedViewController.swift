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
    // 记录i姓名
    var name:String?
    
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
        self.view.addSubview(general)
    }
    // 将shareV视图生成为图片
    @objc func sendImage(){
        
        let name = shareV.nameTextField.text
        //设置名字和生日
        general.nameLabel.text = name
        //general.birthLabel.text = birth == "Please Select" ? "":birth
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm"
        // 时间范围
        general.rangeLabel.text = dateFormat.string(from: startD!) + " - " + dateFormat.string(from: endD!)
        // 将视图生成文件
        let image = viewToImage.getImageFromView(view: general)
        // 将图片放入相册
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.savedPhotosAlbum(_:didFinishSavingWithError:contextInfo:)), nil)
        // 要分享的内容封装成数组
        let activityItems = [image]
        // 创建
        let toVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(toVC, animated: true, completion: nil)
    }
    
    //保存图片
    @objc func savedPhotosAlbum(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        
        if error != nil {
            let alert = CustomAlertController()
            alert.custom(self, "", "图片生成失败")
            print("savw failed")
            
        } else {
            let alert = CustomAlertController()
            alert.custom(self, "", "图片生成成功")
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
        self.view.backgroundColor = ThemeColor
        self.view.clipsToBounds = true
        //general.setupUI()
        
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
