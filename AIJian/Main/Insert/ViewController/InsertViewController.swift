//
//  InsertViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController {

    private lazy var input:InputView = {
        let view = InputView()
        view.setupUI()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(input)
        input.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
        }
        
        // 实现点击屏幕键盘收回
        hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
        // 显示导航控制器的工具栏
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.tintColor = UIColor.gray
        
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: AJScreenWidth/2-AJScreenWidth/20, height: 40))
        leftButton.backgroundColor = UIColor.gray
        leftButton.setTitle("取消", for: .normal)
        leftButton.setTitleColor(UIColor.white, for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        leftButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        leftButton.layer.borderColor = UIColor.white.cgColor
        leftButton.layer.borderWidth = 1
        
        let item1 = UIBarButtonItem(customView: leftButton)
        
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: AJScreenWidth/2, height: 40))
        rightButton.backgroundColor = UIColor.gray
        rightButton.setTitle("保存", for: .normal)
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        rightButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        rightButton.layer.borderColor = UIColor.white.cgColor
        rightButton.layer.borderWidth = 1
        
        let item2 = UIBarButtonItem(customView: rightButton)
        self.toolbarItems = [item1,item2]
    }
    @objc func cancel(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func save(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func hideKeyboardWhenTappedAround(){
        // 添加手势，使得点击视图键盘收回
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    // 设置手势动作
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
        
    }

}
