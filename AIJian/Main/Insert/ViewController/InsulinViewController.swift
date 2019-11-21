//
//  InsulinViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/17.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class InsulinViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    let InsulinType = ["Bolus Insulin","Basal Insulin","Other Insulin"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = InsulinType[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        
        let array = getInsulin.getInsArray()
        cell.detailTextLabel?.text = array[indexPath.row+1] as? String
        cell.detailTextLabel?.textColor = UIColor.white
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private lazy var Bolus:BolusInsulinView = {
        let view = BolusInsulinView()
        view.settupUI()
        return view
    }()
    
    private lazy var Basal:BasalInsulinView = {
        let view = BasalInsulinView()
        view.settupUI()
        return view
    }()
    
    private lazy var Other:OtherInsulinView = {
        let view = OtherInsulinView()
        view.settupUI()
        return view
    }()
    
    var View = UIView()
    let backView = UIButton()

    @objc func back(){
        for i in View.subviews{
            i.removeFromSuperview()
        }
        View.removeFromSuperview()
    }
    
    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    // 导航栏左按钮动作
    @objc func leftButtonClick(){
        // 设置返回原页面
        self.navigationController?.popViewController(animated: false)
    }

    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: AJScreenWidth, height: 120))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加导航栏左按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(120)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
//                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                // Fallback on earlier versions
            }

        }
//        self.view.backgroundColor = ThemeColor
        self.title = "Insulin Choose"
        
        backView.addTarget(self, action: #selector(back), for: .touchUpInside)
        backView.backgroundColor = UIColor.lightGray
        backView.alpha = 0.5


        // Do any additional setup after loading the view.
        // 设置监听器，监听是否要重新加载表格
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    @objc func reload(){
        // 重新加载视图
        self.tableView.reloadData()
        // 移除表格及其背景视图
        for i in View.subviews{
            i.removeFromSuperview()
        }
        View.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let View = UIView()

        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController!.view.addSubview(View)
        View.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        
        View.addSubview(backView)
        backView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }

        switch indexPath.row {
        case 0:
            View.addSubview(Bolus)
            Bolus.snp.makeConstraints{(make) in
                make.left.equalToSuperview().offset(AJScreenWidth/20)
                make.right.equalToSuperview().offset(-AJScreenWidth/20)
                make.top.equalToSuperview().offset(100)
                make.height.equalTo(320)
            }
        case 1:
            View.addSubview(Basal)
            Basal.snp.makeConstraints{(make) in
                make.left.equalToSuperview().offset(AJScreenWidth/20)
                make.right.equalToSuperview().offset(-AJScreenWidth/20)
                make.top.equalToSuperview().offset(100)
                make.height.equalTo(280)
            }
        default:
            View.addSubview(Other)
            Other.snp.makeConstraints{(make) in
//                make.left.equalToSuperview().offset(AJScreenWidth/20)
//                make.right.equalToSuperview().offset(-AJScreenWidth/20)
//                make.top.equalToSuperview().offset(AJScreenWidth/10)
//                make.height.equalTo(320)
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 100,left: 20,bottom: 100,right: 20))
            }
        }
        
        
        
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


//extension InsulinViewController{
//    // 点击表格外的视图，视图消失
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        if let touch = touches.first{
//            let location = touch.location(in: self.view)
//            var convertPoint:CGPoint?
//            if View.subviews.contains(Bolus){
//                convertPoint = self.view.convert(location, to: Bolus)
//                if !Bolus.bounds.contains(convertPoint!){
//                    Bolus.removeFromSuperview()
//                    View.removeFromSuperview()
//                }
//            }else if View.subviews.contains(Basal){
//                convertPoint = self.view.convert(location, to: Basal)
//                if !Basal.bounds.contains(convertPoint!){
//                    Basal.removeFromSuperview()
//                    View.removeFromSuperview()
//                }
//
//            }else{
//                convertPoint = self.view.convert(location, to: Other)
//                if !Other.bounds.contains(convertPoint!){
//                    Other.removeFromSuperview()
//                    View.removeFromSuperview()
//                }
//            }
//
//
//        }
//    }
//}
